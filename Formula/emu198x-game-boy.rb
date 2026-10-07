class Emu198xGameBoy < Formula
  desc "Native Game Boy verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-game-boy-aarch64-apple-darwin.tar.gz"
      sha256 "0ea6c847b3347767ff40d76ad2b5a90379ab07f9669cb75db8fda551c7e1efda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-game-boy-x86_64-apple-darwin.tar.gz"
      sha256 "2f6aaf4cab18788e20bf7ead597b9f29a19ba08426b97ac258fe090ff78fe5a6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-game-boy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "141ce3d2a53bca8953777cdeace81dadf46e49a51530f3e567c1ec14f6df05fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-game-boy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8a732d3c0ef300d5063750f620057d233155886b2e23405c5ee6c683631d5b0d"
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
