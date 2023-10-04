# YouTube Video Downloader Script

A bash script to directly download videos from YouTube without relying on third-party services.

---

## Dependencies

Install the following OS dependencies:

- curl
- jq
- aria2
- ffmpeg

For Mac users, you can install them using `brew` or any other package manager you prefer.

---

## Setup

1. Clone this repository:
   ```shell
   git clone https://github.com/Fares-Abubaker/scripts.git
   cd scripts/youtube
   chmod +x download_from_youtube.sh
   ```

---

## Usage

To download a YouTube video, pass the video URL as an argument to the script. By default, it will download the highest
quality available for the video and its associated audio. To specify a different quality, provide the desired 
resolution (e.g., 144 for 144p) as a second argument.

* Download in highest quality::
    ```shell
    ./download_from_youtube.sh https://www.youtube.com/watch?v=L5E0L2I5lAU
    ```

* Download in 144p quality:
    ```shell
    ./download_from_youtube.sh https://www.youtube.com/watch?v=L5E0L2I5lAU 144
    ```

---
Written by: **Fares Abubaker** | 2023
