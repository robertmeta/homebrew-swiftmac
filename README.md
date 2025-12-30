# Homebrew SwiftMac

Homebrew tap for [SwiftMac](https://github.com/robertmeta/swiftmac), an Emacspeak speech server for macOS.

## Installation

```bash
brew tap robertmeta/swiftmac
brew install swiftmac
```

## Requirements

- macOS with Apple Silicon (M1, M2, M3, M4, or newer)
- Emacspeak installed

## Usage

After installation, configure Emacs to use SwiftMac:

```emacs-lisp
(setenv "EMACSPEAK_DIR" "/path/to/.emacspeak")
(load-file "/opt/homebrew/share/emacs/site-lisp/swiftmac-voices.el")
(dtk-select-server "swiftmac")
```

## Variants

Three server variants are available:

- `swiftmac` - Standard speech server
- `log-swiftmac` - Server with debug logging
- `cloud-swiftmac` - Server with cloud-based voices

## Updating

```bash
brew update
brew upgrade swiftmac
```

## More Information

See the [SwiftMac repository](https://github.com/robertmeta/swiftmac) for full documentation.
