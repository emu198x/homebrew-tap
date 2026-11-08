class Emu198xAtariSt < Formula
  desc "Atari ST headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.48.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-atari-st-aarch64-apple-darwin.tar.gz"
      sha256 "a7b1981bd58189f5218b792fa2a97727f76c264f5eeb3f0237eaf809bd5e694c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-atari-st-x86_64-apple-darwin.tar.gz"
      sha256 "53550c9caad014b99b4d1b31cfee600dd6bf0c459d85021f44732f1b9ba61bf2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-atari-st-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f8a8b40677364711bfd36b82fd76ec45a6bcb6ef7e3da843b20de90029f02584"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-atari-st-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4482f78685f120ca4b8f06b81276f63013dc296027259daf8528e80da237ed2d"
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
