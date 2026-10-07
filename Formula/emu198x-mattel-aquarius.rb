class Emu198xMattelAquarius < Formula
  desc "Mattel Aquarius headless runner with shell-backed script + MCP parity — Z80 + memory-mapped char display"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-mattel-aquarius-aarch64-apple-darwin.tar.gz"
      sha256 "fac76d23ec1cc72d4c07069f69f8ba4425d5c5c105a50abbddd439e63aa97809"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-mattel-aquarius-x86_64-apple-darwin.tar.gz"
      sha256 "3fd5ca5dfce9a7caeab30634596d4fbe66ba0f8c0d9736727ab443dc478f7367"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-mattel-aquarius-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "16e6e45c00520cd1d0755c1016e73efc99c1757ec59ffb946a1a7921c713c422"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-mattel-aquarius-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ff6dc8b4083803b418ef7b21c8daa5842c660fc9d9e58f47a1c3d5e352a15e3d"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
