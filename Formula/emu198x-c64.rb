class Emu198xC64 < Formula
  desc "Native Commodore 64 verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.34.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-c64-aarch64-apple-darwin.tar.gz"
      sha256 "8730c4050b1e5ffa5406864901fee67dfdf262f4a720f187a734f8f4746e59fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-c64-x86_64-apple-darwin.tar.gz"
      sha256 "52c868b7af6455ce968352f31e069d476d1a2ec0a20572b7e5b1da0cf440838b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-c64-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "384d3bf61e168a6b312f167580d15a85b53dc87ba9a040df164bda4c1ca474a9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-c64-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2735b2ece9aaa32274af8448afc4b818465215f3f2735d8b75106d7655f8b6b3"
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
      bin.install "emu198x-c64"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-c64"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-c64"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-c64"
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
