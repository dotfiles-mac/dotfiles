use github_dotfiles_ollama::generate_response;
use httpmock::prelude::*;

#[tokio::test]
async fn test_generate_response_integration() {
    // Start a mock server
    let server = MockServer::start();

    // Set the API base to the mock server URL
    std::env::set_var("OLLAMA_API_BASE", server.base_url());

    let mock = server.mock(|when, then| {
        when.method(POST).path("/api/generate");
        then.status(200).body(r#"{"response":"Hi there!"}"#);
    });

    // Test success case with mock
    let client = reqwest::Client::new();
    let result = generate_response(&client, "test-model", "Hello", "You are helpful").await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap().response, "Hi there!");

    mock.assert();
}
