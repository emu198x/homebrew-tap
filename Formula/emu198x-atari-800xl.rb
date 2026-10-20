class Emu198xAtari800xl < Formula
  desc "Atari 800XL headless runner with shell-backed script + MCP parity — 6502C Sally + ANTIC + GTIA + POKEY + PIA-6520"
  homepage "https://emu198x.github.io/"
  version "0.40.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-atari-800xl-aarch64-apple-darwin.tar.gz"
      sha256 "55fe6f1fd351b46812feeb4257806e765dbb5a6a38943a48ead5a0afed8570f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-atari-800xl-x86_64-apple-darwin.tar.gz"
      sha256 "4eba692822d58150a183b5b187fd54d84b685cd60f230eb4356738f4ad98cf0a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-atari-800xl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a5310590b17423034646024720a7602e56a01e54f24773047b4e6a8c7a1f3cb3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-atari-800xl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "97219ec31223e6270fee4e10b71385bc4b11fc2f16b8f5f426c09cfb2ce0bccc"
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
      bin.install "emu198x-atari-800xl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-800xl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-800xl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-800xl"
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
