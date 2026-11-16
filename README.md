# OpenEnd

Native Mac chat app for local [Ollama](https://ollama.com) models. A dark WKWebView UI talks to a Swift host that can start Ollama, stream replies, edit a project folder, and run local tools. No account or API key is required.

Uses the local Ollama service at `127.0.0.1:11434`. If Ollama is installed but not running, the app starts it. Conversations, model settings, and workspace choice stay on this Mac.

## Build

Requires Xcode command line tools and Apple Silicon, macOS 13+:

```bash
./build.sh
```

This builds `Ollama OpenEnd.app` in this folder (bundle identifier `local.openend.app`). `Open Project.command` opens the project folder and the app if it has been built.

Source: `Sources/ChatHost.swift` and `Resources/index.html`.
