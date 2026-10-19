class Emu198xMattelAquarius < Formula
  desc "Mattel Aquarius headless runner with shell-backed script + MCP parity — Z80 + memory-mapped char display"
  homepage "https://emu198x.github.io/"
  version "0.38.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-mattel-aquarius-aarch64-apple-darwin.tar.gz"
      sha256 "8286905567c60e225448bf6386d731c3669e04fd96c4fddc72e2ca72c42bcf39"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-mattel-aquarius-x86_64-apple-darwin.tar.gz"
      sha256 "6c537a69283b1d190e89ef0eaedcf6b6c7f9b017d8ae81a3514be68c2a0bbbfb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-mattel-aquarius-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6de85d450e909a5a25c4c090a37c6153de1442c4abe42cc2542be45f89fd21cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-mattel-aquarius-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fa70c477c86b2334d755779630ac03b4b0c465f88c56a012d9e05c273d73d92e"
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
