use std::process::Command;

#[test]
fn test_help_command() {
    let output = Command::new("cargo")
        .args(&["run", "--", "--help"])
        .current_dir(env!("CARGO_MANIFEST_DIR"))
        .output()
        .expect("Failed to run help command");

    let stdout = String::from_utf8_lossy(&output.stdout);
    assert!(output.status.success());
    assert!(stdout.contains("Commands:"));
    assert!(stdout.contains("list"));
    assert!(stdout.contains("installed"));
}

#[test]
fn test_installed_command() {
    let output = Command::new("cargo")
        .args(&["run", "--", "installed"])
        .current_dir(env!("CARGO_MANIFEST_DIR"))
        .output()
        .expect("Failed to run installed command");

    // Check that the command runs without unrecognized error
    let stderr = String::from_utf8_lossy(&output.stderr);
    assert!(!stderr.contains("unrecognized subcommand"));
    // Allow success or failure if Ollama not running
    assert!(output.status.success() || stderr.contains("ollama") || stderr.contains("connection"));
}

#[test]
fn test_list_command() {
    let output = Command::new("cargo")
        .args(&["run", "--", "list"])
        .current_dir(env!("CARGO_MANIFEST_DIR"))
        .output()
        .expect("Failed to run list command");

    let stderr = String::from_utf8_lossy(&output.stderr);
    assert!(!stderr.contains("unrecognized subcommand"));
    // May fail if no internet, but check it attempts
    let stdout = String::from_utf8_lossy(&output.stdout);
    assert!(output.status.success() || stdout.contains("NAME") || stderr.contains("network") || stderr.contains("ollama"));
}

#[test]
fn test_pull_command() {
    // Test with invalid model to avoid downloading
    let output = Command::new("cargo")
        .args(&["run", "--", "pull", "invalid-model-name"])
        .current_dir(env!("CARGO_MANIFEST_DIR"))
        .output()
        .expect("Failed to run pull command");

    let stderr = String::from_utf8_lossy(&output.stderr);
    assert!(!stderr.contains("unrecognized subcommand"));
    // Should fail with error about model
    assert!(!output.status.success());
    assert!(stderr.contains("pull") || stderr.contains("model") || stderr.contains("ollama"));
}

#[test]
fn test_run_command() {
    // Test run without model
    let output = Command::new("cargo")
        .args(&["run", "--", "run", "nonexistent-model"])
        .current_dir(env!("CARGO_MANIFEST_DIR"))
        .output()
        .expect("Failed to run run command");

    let stderr = String::from_utf8_lossy(&output.stderr);
    assert!(!stderr.contains("unrecognized subcommand"));
    // Should fail
    assert!(!output.status.success());
}

#[test]
fn test_remove_command() {
    let output = Command::new("cargo")
        .args(&["run", "--", "remove", "nonexistent-model"])
        .current_dir(env!("CARGO_MANIFEST_DIR"))
        .output()
        .expect("Failed to run remove command");

    let stderr = String::from_utf8_lossy(&output.stderr);
    assert!(!stderr.contains("unrecognized subcommand"));
    // May succeed or fail
}

#[test]
fn test_generate_command() {
    // Test generate with minimal args
    let output = Command::new("cargo")
        .args(&["run", "--", "generate", "tinyllama:latest", "Hello"])
        .current_dir(env!("CARGO_MANIFEST_DIR"))
        .output()
        .expect("Failed to run generate command");

    let stderr = String::from_utf8_lossy(&output.stderr);
    assert!(!stderr.contains("unrecognized subcommand"));
    // May fail if model not available, but check it attempts
    assert!(output.status.success() || stderr.contains("model") || stderr.contains("ollama"));
}
