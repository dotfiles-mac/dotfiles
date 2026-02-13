# Contributing to GitHub Dotfiles

First off, thank you for considering contributing to GitHub Dotfiles! It's people like you that make this project great.

## Getting Started

Before you begin:
- Explore the repository to understand the project structure
- Try running the setup script to get familiar with the functionality
- Read the README for an overview of features

## How to Contribute

### Reporting Bugs

This section guides you through submitting a bug report.

- Use a clear and descriptive title for the issue
- Describe the exact steps to reproduce the problem
- Include any relevant error messages or logs

### Suggesting Enhancements

This section guides you through submitting enhancement suggestions.

- Use a clear and descriptive title
- Provide a detailed description of the suggested enhancement
- Explain why this enhancement would be useful

### Pull Requests

- Fill in the required template
- Do not include issue numbers in the PR title
- Follow the existing code style and conventions
- Ensure all pre-commit checks pass
- Test your changes thoroughly

## Styleguides

### Git Commit Messages

- Use the present tense ("add feature" not "added feature")
- Use the imperative mood ("move cursor to..." not "moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line
- Follow conventional commit format: `type(scope): description`

### Shell Script Styleguide

- Use `set -euo pipefail` for error handling
- Add descriptive comments for complex logic
- Use meaningful variable names
- Keep functions small and focused

### Code Quality

- Follow existing code patterns in the repository
- Ensure shell scripts pass shellcheck
- Keep files focused and modular

## Pre-commit Checks

Before submitting a pull request, ensure all checks pass:

```bash
./bin/lint.sh
```

This runs:
- yamllint
- actionlint
- shellcheck
- cargo fmt
- clippy

## Local Development

### Running Tests

```bash
# Run shell script tests
shellcheck your-script.sh

# Run pre-commit manually
pre-commit run --all-files
```

### Adding New Scripts

1. Create the script in the appropriate directory
2. Make it executable: `chmod +x script.sh`
3. Add shellcheck compliance
4. Update README if it's a user-facing tool

## Project Structure

- `bin/` - Executable scripts and tools
- `git-hooks/` - Global Git hooks
- `setup/` - Installation and setup scripts
- `sync/` - Dotfiles synchronization
- `auth/` - Authentication scripts
- `ollama/` - Rust-based Ollama manager
- `dart/` - Dart CLI tool

## Additional Notes

### Principles

- **Simplicity**: Write code that is easy for humans to read
- **Reliability**: Focus on robust error handling and logging
- **Compatibility**: Support macOS and common developer tools
- **Automation**: Reduce manual steps wherever possible

### Issue Labels

- `bug` - Issues that are bugs
- `enhancement` - Issues that are feature requests
- `documentation` - Issues related to documentation
- `good first issue` - Good for newcomers

## Questions?

If you have questions, feel free to open an issue or start a discussion.

Thank you for contributing!
