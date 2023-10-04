#!/bin/bash
# Written by: Fares Abubaker @ 2023

# This script can download any YouTube video with any quality you want

# be sure to install this OS dependencies:
# curl, jq, aria2, ffmpeg

# Check if URL is passed as arguments
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <youtube_video_url> [quality]"
    exit 1
fi

# Extract video ID from the URL
if echo "$1" | grep -q "youtu.be"; then
    VIDEO_ID=$(echo "$1" | sed -n "s#.*youtu.be/\([^?]*\)?.*#\1#p")
else
    VIDEO_ID=$(echo "$1" | sed -n "s#.*watch\\?v\\=\([^&]*\)#\1#p")
fi
QUALITY=${2:-"highest"}

echo "VIDEO_ID: $VIDEO_ID"

# Fetch video details using YouTube API
RESPONSE=$(curl -s --location 'https://www.youtube.com/youtubei/v1/player' \
    --header 'content-type: application/json' \
    --data '{
        "context":{
          "client":{
             "clientName":"WEB",
             "clientVersion":"2.20230824"
          }
       },
       "videoId":"'$VIDEO_ID'"
    }')

# Get video URL for the specific quality and highest quality audio
if [ "$QUALITY" == "highest" ]; then
    # Get video URL for the highest bitrate
    VIDEO_URL=$(echo "$RESPONSE" | jq -r '.streamingData.adaptiveFormats | sort_by(.bitrate) | reverse | .[] | select(.mimeType | startswith("video/")) | .url' | head -1)
else
    # Get video URL for the specific quality
    VIDEO_URL=$(echo "$RESPONSE" | jq -r --arg quality "${QUALITY}p" '.streamingData.adaptiveFormats | .[] | select(.qualityLabel == $quality) | .url' | head -1)
fi
AUDIO_URL=$(echo "$RESPONSE" | jq -r '.streamingData.adaptiveFormats | sort_by(.bitrate) | reverse | .[] | select(.mimeType | startswith("audio/")) | .url' | head -1)

echo "VIDEO_URL: $VIDEO_URL"
echo "AUDIO_URL: $AUDIO_URL"

# Download video of specified quality and highest bitrate audio using aria2c
aria2c -x 16 -s 16 -k 1M "$VIDEO_URL" -o "${VIDEO_ID}_${QUALITY}_video.mp4"
aria2c -x 16 -s 16 -k 1M "$AUDIO_URL" -o "${VIDEO_ID}_audio.mp4"

# Merge video and audio
ffmpeg -i "${VIDEO_ID}_${QUALITY}_video.mp4" -i "${VIDEO_ID}_audio.mp4" -c:v copy -c:a aac "${VIDEO_ID}_${QUALITY}.mp4"

# Optional: remove the separate audio and video files
rm "${VIDEO_ID}_${QUALITY}_video.mp4" || echo "Error deleting video file"
rm "${VIDEO_ID}_audio.mp4" || echo "Error deleting audio file"


echo "Video downloaded as ${VIDEO_ID}_${QUALITY}.mp4"

