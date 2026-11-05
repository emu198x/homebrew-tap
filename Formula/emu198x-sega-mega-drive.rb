class Emu198xSegaMegaDrive < Formula
  desc "Sega Mega Drive / Genesis headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.48.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-sega-mega-drive-aarch64-apple-darwin.tar.gz"
      sha256 "fea9fb789eb80feae9a30700b758bba5cc71b32d900466b6ad1795559d791e4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-sega-mega-drive-x86_64-apple-darwin.tar.gz"
      sha256 "788b968f83dbd35f602c709baca00eb5a0ab73502272f7d71f0a8f9a5f096c59"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-sega-mega-drive-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b5a1925ebb76ffa448f8fd5cc9c77dbe5f7a9bb89a1d7f3a0f064961618ec2c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-sega-mega-drive-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7e0aa329f932407d600876e79b8ce2118fba5af8da3e5a6e0f0b49b876be9833"
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
      bin.install "emu198x-sega-mega-drive"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sega-mega-drive"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sega-mega-drive"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sega-mega-drive"
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
