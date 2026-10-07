class Emu198xDragon < Formula
  desc "Native Dragon 32/64 verifier with interactive UI, headless harness, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-dragon-aarch64-apple-darwin.tar.gz"
      sha256 "9bf3331493c471bad3f3f3a03ce462b3bff4fb8fae634a8e5d2c7ecac606e0f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-dragon-x86_64-apple-darwin.tar.gz"
      sha256 "89627000bff21c871e421bd2239b9dff6c4bc62bbfa4d963c4621b8b8f9e7427"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-dragon-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eb215727e9c69b85117115dfb428f5d96b6cce04b8bbb92af30ac8f82917d010"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-dragon-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "477fda097c0f3915fb9ae9751ddce03810dbe83f3b2e1d104d43f3fb497deab1"
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
