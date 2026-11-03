class Emu198xAcornElectron < Formula
  desc "Acorn Electron headless runner with shell-backed script + MCP parity — 6502A + custom ULA"
  homepage "https://emu198x.github.io/"
  version "0.46.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-acorn-electron-aarch64-apple-darwin.tar.gz"
      sha256 "9a5f9e5833f13cc206c460dafe24afea181ddb9b4eaa157f8d797b50767187ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-acorn-electron-x86_64-apple-darwin.tar.gz"
      sha256 "2c18498b7c65eb2bd81a52fe2285a9da8fe7c9f34f07172b38781a17a5bf3157"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-acorn-electron-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "79c47cf90b667daf53d40174e15a26d82033aa0e541220abb70d85f39794f59f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-acorn-electron-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7c364ca17d057a15e19bbef541e0b1eb1bcc3c9b71d0f5503416b690a96a5635"
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
      bin.install "emu198x-acorn-electron"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-electron"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-acorn-electron"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-electron"
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
