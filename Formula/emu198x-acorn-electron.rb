class Emu198xAcornElectron < Formula
  desc "Acorn Electron headless runner with shell-backed script + MCP parity — 6502A + custom ULA"
  homepage "https://emu198x.github.io/"
  version "0.48.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-acorn-electron-aarch64-apple-darwin.tar.gz"
      sha256 "ca4a6897afc5926da058f5123a95621c9f877e3d3b23524b975c82e8da7a9eb0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-acorn-electron-x86_64-apple-darwin.tar.gz"
      sha256 "41316f2ef7d11f0303ebe70fad33c411546261c9421f9b8345b2ea7788b2b1f9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-acorn-electron-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3a200431f68a4255ff3c2ecfaabdcd9f38e798cb6c1465e6dce6773bb9187f0f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-acorn-electron-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "99802ef9742fc3bc4ddd6aa60e1d61b054aab00ca4e6307ed8c2d51e09bac4d7"
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
