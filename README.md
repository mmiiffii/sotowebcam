# Sotogrande Timelapse

This repo captures frames from the Sotogrande Puerto webcam and lets you build timelapse videos from the stored images.

- Scheduled GitHub Action grabs frames every 5 minutes and commits them into `frames/`.
- A manual GitHub Action generates a timelapse MP4 from all frames and uploads it as an artifact.
- You can also run the scripts manually in a GitHub Codespace.

## Stream URL

The scripts use this HLS URL (update if needed):

```text
https://webcam.meteo365.es/hls_live/sotograndepuerto.m3u8
```

---

## Setup steps

### 1. Create a new GitHub repo

1. On GitHub, create a new empty repository (no template).
2. Download this project zip and extract it.
3. Initialize git, add, commit, and push to your new GitHub repo:

   ```bash
   git init
   git add .
   git commit -m "Initial timelapse setup"
   git branch -M main
   git remote add origin <your-repo-url>
   git push -u origin main
   ```

### 2. Open in a GitHub Codespace

1. Go to your repo on GitHub.
2. Click the green **Code** button → **Codespaces** → **Create codespace on main**.
3. Wait for the Codespace to boot; you’ll land in a VS Code-like editor in the browser.

### 3. Make scripts executable (once)

In the Codespace terminal:

```bash
chmod +x scripts/capture_frame.sh
chmod +x scripts/generate_timelapse.sh
```

### 4. Test capture script in Codespace

In the Codespace terminal:

```bash
# Install ffmpeg in the Codespace container
sudo apt-get update
sudo apt-get install -y ffmpeg

# Run a single capture test
./scripts/capture_frame.sh
```

You should see a new JPG in `frames/`, named like:

```text
frames/sotogrande_2025-11-18_14-30-00.jpg
```

Commit and push if you want these test frames saved:

```bash
git add frames/*.jpg
git commit -m "Add test frame"
git push
```

---

## Automated capture with GitHub Actions

The workflow `.github/workflows/capture.yml` runs on a schedule:

- Every 5 minutes (GitHub Actions minimum granularity).
- Each run captures one frame and commits it to the repo.

You don’t need a Codespace running for this; Actions run on GitHub’s runners.

To check it:

1. Go to **Actions** tab in your repo.
2. Look for “Capture webcam frame” workflow runs.
3. Open a run → check the logs → verify frames were added.
4. Pull changes locally or refresh GitHub web UI to see new images in `frames/`.

---

## On-demand timelapse generation

The workflow `.github/workflows/timelapse.yml` creates a timelapse MP4 using all images in `frames/`.

In your repo on GitHub:

1. Go to the **Actions** tab.
2. Click **Generate timelapse**.
3. Click **Run workflow** → **Run workflow**.
4. When it finishes, open the workflow run; you’ll see an artifact named `timelapse-video`.
5. Download it to get your `timelapse_YYYY-MM-DD_HH-MM-SS.mp4` file.

---

## Running timelapse generation inside Codespace

You can also generate timelapses manually in the Codespace:

```bash
sudo apt-get update
sudo apt-get install -y ffmpeg

./scripts/generate_timelapse.sh
```

The script writes a file like:

```text
timelapses/timelapse_2025-11-18_15-00-00.mp4
```

You can download it from the Codespace file tree (right-click → Download).

---

## Notes

- If the webcam URL changes, update `STREAM_URL` in `scripts/capture_frame.sh`.
- For longer-term storage, consider Git LFS or periodically archiving old frames.
- Codespaces are great for manual runs and development; long-term unattended capture is handled by GitHub Actions.
