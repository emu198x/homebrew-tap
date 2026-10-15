class Emu198xMattelAquarius < Formula
  desc "Mattel Aquarius headless runner with shell-backed script + MCP parity — Z80 + memory-mapped char display"
  homepage "https://emu198x.github.io/"
  version "0.34.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-mattel-aquarius-aarch64-apple-darwin.tar.gz"
      sha256 "ec1035320b14b802e66cfc365919c4eb3512b99951626e28ae1e8d4fa08fd6a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-mattel-aquarius-x86_64-apple-darwin.tar.gz"
      sha256 "62cb64aea0e4f95acb0b506eac534af83c364ece91cde10bc1abe7f6f54e281f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-mattel-aquarius-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3166bd042a06f25299cb539bd3ff3016e00f113352774ceb893b11b1d24abb92"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-mattel-aquarius-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7e5588e8f1afa0eb0a47ee403f9401512d79ac09608e26b9a1c4d20c8836b8c7"
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
