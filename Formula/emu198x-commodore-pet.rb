class Emu198xCommodorePet < Formula
  desc "Commodore PET headless runner with shell-backed script + MCP parity — 6502 + 6845 CRTC + 6520 + 6522"
  homepage "https://emu198x.github.io/"
  version "0.32.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-commodore-pet-aarch64-apple-darwin.tar.gz"
      sha256 "93b4ff53bdb3cb1928038ed0cc4e763c329c9bbca0eac62a2a149667331969f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-commodore-pet-x86_64-apple-darwin.tar.gz"
      sha256 "701e5df6a9be638f5b765aa60259173726ab9a8c76209159c2f16c4801317c6e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-commodore-pet-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "24953344521a4773ac0ec17403c94acdb4709b7e66827d31c8d2f0826fea6819"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-commodore-pet-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "28e01768217794b34d89cd1f17ae7091e9de3059cefcba2cfe618adb3616ce07"
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
      bin.install "emu198x-commodore-pet"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-commodore-pet"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-commodore-pet"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-commodore-pet"
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
