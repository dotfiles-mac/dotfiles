# Ollama Tool

A Rust-based CLI tool for managing Ollama models. It fetches the latest available models from Ollama's online library, enables downloading specific models, and provides an interface to run them interactively.

## Prerequisites
- Rust installed (via setup script)
- Ollama installed and running (`brew services start ollama`)

## Building
```bash
cd ollama-tool
cargo build --release
```

## Usage
```bash
# Show help
./target/release/ollama-tool --help

# List all available models from Ollama's library
./target/release/ollama-tool list

# Download a model (e.g., tinyllama)
./target/release/ollama-tool pull tinyllama

# Run a downloaded model interactively
./target/release/ollama-tool run tinyllama
```

## Features
- **Model Discovery**: Dynamically fetches model list from ollama.ai/library
- **Seamless Download**: Integrates with Ollama CLI for reliable model pulling
- **Interactive Running**: Launches models in chat mode
- **Error Handling**: Provides clear feedback for failed operations

## Example Workflow
1. List models: `./target/release/ollama-tool list`
2. Choose a model (e.g., `llama2`)
3. Pull it: `./target/release/ollama-tool pull llama2`
4. Run it: `./target/release/ollama-tool run llama2`