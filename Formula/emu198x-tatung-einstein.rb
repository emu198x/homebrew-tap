class Emu198xTatungEinstein < Formula
  desc "Tatung Einstein TC-01 headless runner with shell-backed script + MCP parity — Z80 + TMS9929A + AY-3-8910"
  homepage "https://emu198x.github.io/"
  version "0.35.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-tatung-einstein-aarch64-apple-darwin.tar.gz"
      sha256 "0bb2887cddff51740444277d2acf7f50ae48fd07b0ec410d273d4329813202cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-tatung-einstein-x86_64-apple-darwin.tar.gz"
      sha256 "561d2ffdaa1260790e021082ba77aa6d94638006cbe1e384f5117cbfb706947d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-tatung-einstein-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a03115921f859d098108d24b7edf2cb4dc8bd561546d0bd56bc50d55c38a186c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-tatung-einstein-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9056f3e787d3038ff65711f72c06b1bbde4a0525aac6a9202490b3049deed9ad"
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
