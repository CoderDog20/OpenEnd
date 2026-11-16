# OpenEnd

A native Mac app for chatting with local [Ollama](https://ollama.com) models, with a built-in agent harness that can work on a project folder, chase long-running goals, and check its own work. No account or API key is needed, and everything stays on your Mac.

## Harness features

- **Project agent.** Pick a workspace folder and the model can list, read, and write files there and run terminal commands, all confined to that folder.
- **Persistent goals.** `/goal` keeps the model working toward a goal across turns. A goal checker reviews progress every 60 seconds, and a goal only counts as complete after a checker review and a passing verification command.
- **Verification command.** You can set an optional test command (for example `npm test`) that runs in the project folder when the model says it's done, with a 120-second limit. Without one, completion stays marked unverified.
- **Claude and Codex as reviewers.** If you're signed in to the Claude Code or Codex CLI, either one can review project snapshots when the checker needs help or a goal is being finished, and its advice goes back to the local model.
- **Fact checker.** `/checker` asks a second model for a short True, False, or Unverified judgment. On Automatic, it uses your largest installed model.
- **Conversation compactor.** Older messages get summarized by a compactor model once the chat nears a token limit you set. Your original messages stay in the chat.
- **Pinned files.** `/file` keeps a file in full context so the model always sees it.
- **Offline Wikipedia.** `/wiki` searches a local Wikipedia archive with no internet needed.
- **Model manager.** Lets you list, switch, download, and set a default Ollama model. It shows each model's thinking output and performance stats.
- **Settings.** You can change the system prompt, generation options, stop sequences, and appearance.

## Commands

| Command | What it does |
| --- | --- |
| `/goal <goal>` | Start a persistent goal |
| `/pause` | Pause the current goal |
| `/resume` | Resume the current goal |
| `/status` | Show model and goal status |
| `/checker <claim>` | Ask the checker model to fact-check a claim |
| `/file <path>` | Keep a file in full context (`/file auto` resets) |
| `/! <command>` | Run a terminal command in the project folder |
| `/model <name>` | List installed models, or switch to one |
| `/wiki <query>` | Search offline Wikipedia (separate phrases with `\|`) |
| `/compact` | Summarize older conversation |
| `/retry` | Regenerate the last answer |
| `/stop` | Stop generation and pause goals |
| `/help` | Show all commands |

## Requirements

You'll need an Apple Silicon Mac on macOS 13 or later, the Xcode command line tools, and [Ollama](https://ollama.com). OpenEnd uses the local Ollama service at `127.0.0.1:11434` and starts it automatically if it's installed but not running.

## Build

```bash
./build.sh
```

This builds `Ollama OpenEnd.app` in this folder. `Open Project.command` opens the project folder, and the app too if it's been built.

The source is in `Sources/ChatHost.swift` (the Swift host, Ollama client, and agent tools) and `Resources/index.html` (the UI).
