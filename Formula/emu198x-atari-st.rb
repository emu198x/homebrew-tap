class Emu198xAtariSt < Formula
  desc "Atari ST headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.46.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-atari-st-aarch64-apple-darwin.tar.gz"
      sha256 "009857c06fb2461d89b151ad045a6652db013b3f5d1d02d1c2a56e91d5791422"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-atari-st-x86_64-apple-darwin.tar.gz"
      sha256 "950527bf3eee4c6fe15aae5af092ef97051c0ddcb4b7eba78da3eaff484a8bee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-atari-st-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "92fdaa73c551e846394a866199c36e0ee4190b679c192819e0b12b280b6265fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-atari-st-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "714977d6eaec8ddcd42128fa58a30f14e3e8a8f17fdaf617ef1ba2d32b6f7551"
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
      bin.install "emu198x-atari-st"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-st"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-st"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-st"
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
