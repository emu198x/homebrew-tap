class Emu198xAtari800xl < Formula
  desc "Atari 800XL headless runner with shell-backed script + MCP parity — 6502C Sally + ANTIC + GTIA + POKEY + PIA-6520"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-800xl-aarch64-apple-darwin.tar.gz"
      sha256 "83f56b042ddea864f1ed8d5a2686df10ca9c8f11d70da48b046c50d6faefa777"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-800xl-x86_64-apple-darwin.tar.gz"
      sha256 "b64fd2c9a76c72c3afe7c4b924deaf1339b12691800af4f6689da1fa0ffd00da"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-800xl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dd0e119cecbfde23d3d002fca51185b6b4077fada92ff9e2e5fbf715e2137a5b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-800xl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a79a42dbf4767696fe28c080172f0ce7a0007236b68fa8f0f46675c4ff6a3930"
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
      bin.install "emu198x-atari-800xl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-800xl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-800xl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-800xl"
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
