// SPDX-License-Identifier: MIT

//! # Ollama Tool Library
//!
//! A Rust library for interacting with Ollama AI models through their API.
//!
//! ## Quick Start
//!
//! ```no_run
//! use github_dotfiles_ollama::generate_response;
//!
//! #[tokio::main]
//! async fn main() -> Result<(), Box<dyn std::error::Error>> {
//!     generate_response("llama2", "Hello", "You are helpful").await?;
//!     Ok(())
//! }
//! ```

use serde::{Deserialize, Serialize};
use thiserror::Error;

fn get_ollama_api_base() -> String {
    std::env::var("OLLAMA_API_BASE").unwrap_or_else(|_| "http://localhost:11434".to_string())
}

/// Request payload for Ollama generate API.
#[derive(Serialize, Debug, Clone, PartialEq)]
pub struct GenerateRequest {
    /// The model name to use for generation.
    pub model: String,
    /// The prompt text.
    pub prompt: String,
    /// The system prompt.
    pub system: String,
    /// Whether to stream the response.
    pub stream: bool,
}

impl GenerateRequest {
    /// Creates a new generate request.
    pub fn new(
        model: impl Into<String>,
        prompt: impl Into<String>,
        system: impl Into<String>,
    ) -> Self {
        Self {
            model: model.into(),
            prompt: prompt.into(),
            system: system.into(),
            stream: false,
        }
    }
}

/// Response payload from Ollama generate API.
#[derive(Deserialize, Debug, Clone, PartialEq)]
pub struct GenerateResponse {
    /// The generated response text.
    pub response: String,
}

/// Represents errors that can occur within the application.
#[derive(Debug, Error)]
pub enum Error {
    /// An error from the `reqwest` crate during an HTTP request.
    #[error("HTTP request failed: {0}")]
    Reqwest(#[from] reqwest::Error),
    /// An I/O error occurred.
    #[error("IO error: {0}")]
    Io(#[from] std::io::Error),
    /// An error occurred during JSON serialization or deserialization.
    #[error("JSON parsing error: {0}")]
    Serde(#[from] serde_json::Error),
    /// An external `ollama` command returned a non-zero exit status.
    #[error("Ollama command failed: {0}")]
    Command(String),
}

/// Generates a response from the Ollama API using the specified model and prompts.
///
/// # Examples
///
/// ```no_run
/// use github_dotfiles_ollama::generate_response;
///
/// #[tokio::main]
/// async fn main() -> Result<(), Box<dyn std::error::Error>> {
///     generate_response("llama2", "What is Rust?", "You are helpful").await?;
///     Ok(())
/// }
/// ```
///
/// # Arguments
///
/// * `model` - The name of the model to use.
/// * `prompt` - The user prompt.
/// * `system` - The system prompt.
///
/// # Errors
///
/// This function will return an error if:
/// - The HTTP request to Ollama API fails
/// - The response cannot be parsed as JSON
/// - Network connectivity issues occur
pub async fn generate_response(model: &str, prompt: &str, system: &str) -> Result<(), Error> {
    let client = reqwest::Client::new();
    let request = GenerateRequest::new(model, prompt, system);

    let response = client
        .post(format!("{}/api/generate", get_ollama_api_base()))
        .json(&request)
        .send()
        .await?;

    let result: GenerateResponse = response.json().await?;
    println!("{}", result.response);
    Ok(())
}
