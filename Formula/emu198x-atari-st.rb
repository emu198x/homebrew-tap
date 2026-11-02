class Emu198xAtariSt < Formula
  desc "Atari ST headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.46.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-atari-st-aarch64-apple-darwin.tar.gz"
      sha256 "a7eef4ca0dbc0ffb19d5ccf6033289c7e79f8b38533cb3a4fc9a43cfb8cafc31"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-atari-st-x86_64-apple-darwin.tar.gz"
      sha256 "5bce702b87e6b676fa7ec67b73514db6ccf5c39ee2f021d3c9f811edd9a4c3a2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-atari-st-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7338cdd16e457870f92a25f01863513421fd9d3529f91c8855e220d33ea36c58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-atari-st-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6ba5f12d0d79f33b214c74a31cebe13336ab378addef2f035bccf7b5429a8ad5"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "emu198x-atari-st"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-st"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-st"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-st"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
