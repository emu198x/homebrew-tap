class Emu198xGameBoy < Formula
  desc "Native Game Boy verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.38.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-game-boy-aarch64-apple-darwin.tar.gz"
      sha256 "ed5985c28f545a333c623b0e51d943c660207f796a3ee7b2eb622223af98e75f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-game-boy-x86_64-apple-darwin.tar.gz"
      sha256 "6fe9f974f43ea62d698f0353eb0a76767653cdc418b945497c0b6a4faa693517"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-game-boy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6bed4c11a0244f384bfa413b71c2b86f2aa230d05b8fc3b5f492ee48b6387f99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-game-boy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0cdf106fa0e6b32724cbee4b48534e10051c8dbcf5f0246e274852ca259a563d"
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
      bin.install "emu198x-game-boy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-game-boy"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-game-boy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-game-boy"
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
