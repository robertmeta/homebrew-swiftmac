class Swiftmac < Formula
  desc "Emacspeak speech server for macOS using native speech synthesis"
  homepage "https://github.com/robertmeta/swiftmac"
  url "https://github.com/robertmeta/swiftmac/releases/download/v4.3.6/swiftmac-4.3.6.tar.gz"
  sha256 "84c17893d504ae32e23043fa756e7574ac779b81171a6a28f31938afcd3982f9"
  version "4.3.6"
  license "MIT"

  depends_on :macos
  depends_on arch: :arm64

  def install
    # Install binary and frameworks to libexec
    libexec.install "swiftmac"
    libexec.install "ogg.framework"
    libexec.install "vorbis.framework"

    # Install support scripts
    libexec.install "cloud-swiftmac"
    libexec.install "log-swiftmac"

    # Install Emacs Lisp file
    (share/"emacs/site-lisp").install "swiftmac-voices.el"

    # Create wrapper script that sets up proper paths
    (bin/"swiftmac").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/swiftmac" "$@"
    EOS

    (bin/"cloud-swiftmac").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/cloud-swiftmac" "$@"
    EOS

    (bin/"log-swiftmac").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/log-swiftmac" "$@"
    EOS
  end

  def caveats
    <<~EOS
      SwiftMac has been installed to #{opt_libexec}

      To use with Emacspeak, add to your Emacs init file:

        (setenv "EMACSPEAK_DIR" "/path/to/.emacspeak")
        (load-file "#{HOMEBREW_PREFIX}/share/emacs/site-lisp/swiftmac-voices.el")
        (dtk-select-server "swiftmac")

      The server binaries are available as:
        - swiftmac
        - log-swiftmac
        - cloud-swiftmac

      For manual Emacspeak integration, symlink to $EMACSPEAK_DIR/servers:
        ln -sf #{opt_libexec}/swiftmac $EMACSPEAK_DIR/servers/
        ln -sf #{opt_libexec}/log-swiftmac $EMACSPEAK_DIR/servers/
        ln -sf #{opt_libexec}/cloud-swiftmac $EMACSPEAK_DIR/servers/
        ln -sf #{opt_libexec}/ogg.framework $EMACSPEAK_DIR/servers/
        ln -sf #{opt_libexec}/vorbis.framework $EMACSPEAK_DIR/servers/
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/swiftmac --version 2>&1", 1)
  end
end
