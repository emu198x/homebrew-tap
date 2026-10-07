class Emu198xAcornElectron < Formula
  desc "Acorn Electron headless runner with shell-backed script + MCP parity — 6502A + custom ULA"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-electron-aarch64-apple-darwin.tar.gz"
      sha256 "dad7a4239649a3e9ea923592bbcada0f613624cf7981dbda569911e7ec668efd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-electron-x86_64-apple-darwin.tar.gz"
      sha256 "5a919726bb86f8cf7fe2018685de1ca726d3822dd40276a9526af50dd52d16c1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-electron-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a4bb3ef08d25286ff84dc73adfe1a2c4f9152848202919ab34eb71a3eb454b40"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-electron-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4c5ec82131a1ae1fb74eaaa83260450f4e70ed0818a985a32f3271e78a2986f5"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
