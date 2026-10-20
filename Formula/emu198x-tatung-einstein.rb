class Emu198xTatungEinstein < Formula
  desc "Tatung Einstein TC-01 headless runner with shell-backed script + MCP parity — Z80 + TMS9929A + AY-3-8910"
  homepage "https://emu198x.github.io/"
  version "0.41.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.41.0/emu198x-tatung-einstein-aarch64-apple-darwin.tar.gz"
      sha256 "2b3d37e8945f70fd83718935a7b2f4cbd173d3b62aade438b58163f0d9a173dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.41.0/emu198x-tatung-einstein-x86_64-apple-darwin.tar.gz"
      sha256 "7a4b813540e32d9f73fc928d7a7c2e47450bf7cb11334c14c93ba90c9cbd87f0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.41.0/emu198x-tatung-einstein-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed20a35ee1dc84769c90614af6edaa150caa4c6bcefaec707e78a2f0056fb6d8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.41.0/emu198x-tatung-einstein-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "66e94bc4e6cd5445d796d010bb3e950df7fd49ea9558b4b71919289eb6cb64c0"
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
      bin.install "emu198x-tatung-einstein"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-tatung-einstein"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-tatung-einstein"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-tatung-einstein"
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
