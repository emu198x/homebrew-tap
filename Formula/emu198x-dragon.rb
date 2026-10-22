class Emu198xDragon < Formula
  desc "Native Dragon 32/64 verifier with interactive UI, headless harness, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.44.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-dragon-aarch64-apple-darwin.tar.gz"
      sha256 "f6fe61a63e25e2f45ceb28002e633730b073e26e3d96ddb92aaa42b13a4a3fb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-dragon-x86_64-apple-darwin.tar.gz"
      sha256 "c066f8c63cdf8c0e701ff0b5da0099a6608859721283e18aca129374454954a8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-dragon-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "88fff7e96600e656757eaf082e0fe6eb308be1fde9755dcb507e1526155903f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-dragon-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5636a221be92f713bf4056f16633e2e4f5860ddeda6eeebaf3e384e0af3a7e01"
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
