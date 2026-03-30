# Discord Music Bot

A **modular Discord music bot** written in Python using `discord.py`.  
This bot supports music playback, queue and playlist management, and more.

## Features

- Play music from supported sources, also with a normal search, instead of a link
- Queue, history, and playlist management
- Skip, pause, resume, and stop playback
- Autoplay mode using Last.fm (similar tracks, artist top tracks, similar artists)
- Modular command system

# Configuration

This bot uses **environment variables** for secrets:

1. Create a `.env` file in the root directory.
2. Add your Discord token:
    - BOT_TOKEN=your_token

3. For spotify, you will have to go to the website and get the spotify client id and secret, then put in the .env
   like this:
    - SPOTIFY_CLIENT_ID=client_id
    - SPOTIFY_CLIENT_SECRET=client_secret

4. For Last.fm (required for autoplay feature), get your API credentials from https://www.last.fm/api/account/create
   and add them to the .env:
    - LASTFM_API_KEY=your_api_key
    - LASTFM_API_SECRET=your_api_secret

5. Make sure `.env` remains in `.gitignore` so it is **never committed**.

# Python version (pyenv)

This project is standardized on **Python 3.11**.

For reproducible local setups, use `pyenv`:

1. Install pyenv: https://github.com/pyenv/pyenv
2. Install Python 3.11 (latest patch managed by pyenv):
   - `pyenv install 3.11`
3. This repository includes a `.python-version` file set to `3.11`.
   - When you are in this project directory, pyenv will automatically select Python 3.11.
4. Verify interpreter version:
   - `python --version`

> Contributor note: keep `.python-version` tracked in git so all contributors use the same major/minor runtime line (`3.11`) while pyenv handles patch updates.

# How to run

1. ffmpeg must be installed on your PC. Download from -> https://www.ffmpeg.org/download.html
2. Initialize local development environment:
   - `make bootstrap`
3. Run the bot:
   - `make run`

## Makefile targets

- `make help` - show available targets
- `make check-python` - verify active interpreter is Python 3.11
- `make bootstrap` - create `.venv`, upgrade pip, install `requirements.txt`
- `make install` - refresh dependencies in existing `.venv`
- `make run` - start bot using `.venv/bin/python`
- `make clean` - remove local virtual environment and caches

> Manual setup remains valid if needed: create `.venv`, install from `requirements.txt`, then run `python main.py`.

# License

This bot is only for personal use
