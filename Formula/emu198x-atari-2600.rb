class Emu198xAtari2600 < Formula
  desc "Atari 2600 (VCS) headless runner with shell-backed script + MCP parity — 6507 + TIA + RIOT"
  homepage "https://emu198x.github.io/"
  version "0.35.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-atari-2600-aarch64-apple-darwin.tar.gz"
      sha256 "775b78e0a814a4edb7ab9a2b0b350c943935c3da281cca6a9385a219b6ee7350"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-atari-2600-x86_64-apple-darwin.tar.gz"
      sha256 "ced1fa8a2ecf8341d602042856200b4bfa0147bec0510a849b16453be4067838"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-atari-2600-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "405d410654642368b3d5b48ff5be8a5f496eb7c13eca1dd632069161d9a22050"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-atari-2600-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7ed52d1c310da4a8f2175a81cba9a825cf9860ad98b45122f57e13953af1b68c"
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
      bin.install "emu198x-atari-2600"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-2600"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-2600"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-2600"
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
