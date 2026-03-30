# AGENTS.md

This file provides guidance to agents when working with code in this repository.

- Runtime is plain Python (no `pyproject.toml`/`setup.cfg`/CI config); install only from [`requirements.txt`](requirements.txt).
- There are no configured lint/build/test commands in-repo; current validation path is runtime smoke test via [`python main.py`](main.py).
- Single-test command is currently unavailable because no test files/framework are present (repo search shows no pytest/unittest tests).
- Required env vars are loaded in [`main.py`](main.py): `BOT_TOKEN` (hard-required), optional Spotify + Last.fm keys gate feature branches at startup.
- Persistent state is file/SQLite based in project root: [`music_bot.db`](bot.py) and [`banned_users.txt`](utils/ban_system.py); avoid changing working directory assumptions.
- DB access convention is async wrapper methods on bot (`execute_db_query`/`fetch_db_query`) in [`MusicBot`](bot.py); don’t open ad-hoc sqlite connections in cogs/services.
- Guild state contract comes from [`MusicBot.get_guild_data()`](bot.py); services/cogs rely on exact keys (`queue`, `loop_backup`, `history_position`, `play_lock`, `seeking`, etc.).
- Queue identity semantics are URL-based (`song.webpage_url`) across dedupe/history/loop backup in [`QueueService`](services/queue_service.py).
- Use [`Song`](models/song.py) (`to_dict()`/`from_dict()`) when persisting or cloning songs; raw dict mutation causes cross-feature inconsistency.
- For slash commands, use shared ban gate [`interaction_check()`](utils/helpers.py) and consistent embeds via [`create_embed()`](utils/helpers.py) instead of direct `discord.Embed`.
- If a command calls [`interaction.response.defer()`](cogs/playlist_commands.py), subsequent replies must use followups (`interaction.followup.send`).
- Playback expects fresh stream URL extraction before play/replay (see [`PlaybackService._extract_and_play_song()`](services/playback_service.py)); reusing stale URLs is unreliable.

