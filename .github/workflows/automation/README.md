# Automation Workflows

This directory contains GitHub Actions workflows for automating repository maintenance.

## Workflows

### Version Bump (`version-bump.yml`)
- **Triggers:** Push to main with conventional commits, or manual dispatch.
- **Function:** Detects version changes based on commit messages, bumps the version in `VERSION` and `pubspec.yaml`, creates a pull request with timestamp.
- **Purpose:** Automates version management while complying with repository rules requiring PRs.

### Release (`release.yml`)
- **Triggers:** Push to main.
- **Function:** Checks if `VERSION` changed, creates a GitHub release, updates repository description.
- **Purpose:** Automates release creation and repo metadata updates after version bumps.

## Usage
- Version bumps are handled via PRs to ensure review.
- Releases are created automatically on merges.
- All workflows use `github-actions[bot]` for commits.
