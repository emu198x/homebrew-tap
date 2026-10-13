class Emu198xCommodorePet < Formula
  desc "Commodore PET headless runner with shell-backed script + MCP parity — 6502 + 6845 CRTC + 6520 + 6522"
  homepage "https://emu198x.github.io/"
  version "0.32.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.4/emu198x-commodore-pet-aarch64-apple-darwin.tar.gz"
      sha256 "ca0c857d0be4e249da059d19081cad7820cd4297ecb1a42704a90676f736c771"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.4/emu198x-commodore-pet-x86_64-apple-darwin.tar.gz"
      sha256 "0c7a9c4f511ec18416728020f0700ac190222ea5e4fd0a6e9f1713dc0524b24b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.4/emu198x-commodore-pet-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "754a793e19141ddc4270410d1846bfd1ec4c103003d671dd75385f4429703196"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.4/emu198x-commodore-pet-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "948cb682d949a1ced3d0c726dc4802d972a7a0c84ca4207122b4b1ce78456388"
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
