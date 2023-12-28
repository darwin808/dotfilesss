# Darwin's Dotfiles

This repository contains my personal dotfiles managed using YADM (Yet Another Dotfiles Manager).

### YADM Installation

To use YADM, you'll need to install it on your system. Here's how to do it:

#### Linux (Debian/Ubuntu)

```bash
sudo apt-get update
sudo apt-get install yadm
```

#### macOS (Homebrew)

```bash
brew install yadm
```

#### Other Platforms

For other platforms, you can refer to the YADM [installation instructions](https://thelocehiliosan.github.io/yadm/docs/install) on the official website.

## Setup Instructions

### Clone Dotfiles Repository

1. Clone this repository:

   ```bash
   yadm clone <repository-url>
   ```

2. Initialize YADM in the cloned directory:
   ```bash
   yadm bootstrap
   ```

### Usage

- **Adding New Dotfiles**:

  - To add new dotfiles or update existing ones, use YADM's `yadm add` and `yadm commit` commands.

- **Pushing Changes**:

  - After making changes to your dotfiles, use YADM's `yadm commit` followed by `yadm push` to update the remote repository.

- **Deploying Dotfiles**:
  - To apply dotfiles to a new system, use YADM's `yadm clone <repository-url>` followed by `yadm bootstrap`.
