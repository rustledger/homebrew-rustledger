# Homebrew Tap for rustledger

This tap provides **prerelease** versions of [rustledger](https://github.com/rustledger/rustledger), a fast, pure Rust implementation of Beancount.

> **Note:** When rustledger reaches stable (1.0.0), it will be submitted to homebrew-core. This tap will continue to serve prerelease/RC versions.

## Installation

```bash
brew tap rustledger/rustledger
brew install rustledger
```

Or directly:

```bash
brew install rustledger/rustledger/rustledger
```

## Upgrading

```bash
brew update
brew upgrade rustledger
```

## Commands

After installation, you'll have access to:

| Command | Description |
|---------|-------------|
| `rledger-check` | Validate ledger files |
| `rledger-format` | Auto-format beancount files |
| `rledger-query` | Run BQL queries |
| `rledger-report` | Generate reports |
| `rledger-doctor` | Debugging tools |
| `rledger-extract` | Import from CSV/OFX |
| `rledger-price` | Fetch commodity prices |

Python beancount compatibility aliases (`bean-*`) are also included.

## Links

- [Documentation](https://rustledger.github.io)
- [GitHub](https://github.com/rustledger/rustledger)
- [Releases](https://github.com/rustledger/rustledger/releases)
