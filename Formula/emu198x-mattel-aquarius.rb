class Emu198xMattelAquarius < Formula
  desc "Mattel Aquarius headless runner with shell-backed script + MCP parity — Z80 + memory-mapped char display"
  homepage "https://emu198x.github.io/"
  version "0.39.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-mattel-aquarius-aarch64-apple-darwin.tar.gz"
      sha256 "593692fc3fdeb52e31b635b53cea84cde4e52b6b2a796e29ce430473b73f2ea5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-mattel-aquarius-x86_64-apple-darwin.tar.gz"
      sha256 "9c15b25eb7699484a0ad4697838606047cbbd2ff039154877ef75dd179c7f5ba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-mattel-aquarius-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0d3b8420ca0299eab6c3a93b405f6fe1782592d78d69311ee9b4c0ec0b9a926c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-mattel-aquarius-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "54fc036554594a54f7a07b2c0d2ecde569c40db5a2d25c4d82e7eee696f1ff2a"
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
      bin.install "emu198x-mattel-aquarius"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-mattel-aquarius"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-mattel-aquarius"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-mattel-aquarius"
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
