# YouTube Scripts

Here are a bash script, that you can use to download videos from YouTube direct not from third party services.

---

## Usage

To run these scripts you need to install these OS dependencies:

```
curl, jq, aria2, ffmpeg
```

For Mac, you can install them on using `brew`, or any other way you prefer.

Then you have to make sure that the script file executable, you can do it with this command:

```shell
chmod +x download_from_youtube.sh
```

After that, to run the script you have to pass the YouTube video URL to the script, by default it will install 
the highest quality available for this video and its audio, or if you want a specific quality you can pass it after 
the video link. Here are examples to run the script:

* This script will download the highest quality of the video:
```shell
./download_from_youtube.sh https://www.youtube.com/watch?v=L5E0L2I5lAU
```

* This script will download the lowest quality of the video:
```shell
./download_from_youtube.sh https://www.youtube.com/watch?v=L5E0L2I5lAU 144
```

---

This script wrote by: **Fares Abubaker**

@ 2023
