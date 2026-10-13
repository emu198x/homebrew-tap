class Emu198xDragon < Formula
  desc "Native Dragon 32/64 verifier with interactive UI, headless harness, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.32.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-dragon-aarch64-apple-darwin.tar.gz"
      sha256 "1408f15f33ed53523514dbb758da59f81936be5c4d29bb851138d498202d9ebb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-dragon-x86_64-apple-darwin.tar.gz"
      sha256 "10f8abbce4e67a54672935aba7ca2b0ddc8c174d079203a9ac82e410ef5b561f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-dragon-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "856e122143da204751ba6bd8cce66b7a011ad72b73bee320e013e689320436c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-dragon-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f3a7e147839e752573b0654be39b0021484419ba5d14ed108a1b7326889a6a37"
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
      bin.install "emu198x-dragon"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-dragon"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-dragon"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-dragon"
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
