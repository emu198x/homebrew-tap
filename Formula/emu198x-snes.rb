class Emu198xSnes < Formula
  desc "Super NES / Super Famicom headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.48.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-snes-aarch64-apple-darwin.tar.gz"
      sha256 "1d0f845e42ec2e3c40dd4a24c5dd48b7aa239873d6f2891e848490445c752130"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-snes-x86_64-apple-darwin.tar.gz"
      sha256 "e5603c03d8e756da2e24e67032d29e6d324da4c855c3062f8fba0eec95a3168e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-snes-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "08b2e6dc27f65f8120789c0bcea215183c78e520f3f6652cf380a395ebd88973"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-snes-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fb222aa3081980d9b6413d63c0e825fe36860442ec5891f8e3993105064307e5"
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
      bin.install "emu198x-snes"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-snes"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-snes"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-snes"
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
