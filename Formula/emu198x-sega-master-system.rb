class Emu198xSegaMasterSystem < Formula
  desc "Sega Master System headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-master-system-aarch64-apple-darwin.tar.gz"
      sha256 "62659b8fe604c27d498184c07ef4a66ab2d0b73d32b97755e3f825f17ab4d2e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-master-system-x86_64-apple-darwin.tar.gz"
      sha256 "8c1bad2d82c5b59351d2058f8b6816ed16d9ca8ba890a1a3e71f44f2b5a7ca88"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-master-system-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4b590cbd12039570ff564ccd7d48a1d4be4d032d4cc5a0c408e150f0dda334a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-master-system-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "abe71981a551d1a96a84d6b97acedb55d9169a61b89af90733628c16f85c133a"
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
      bin.install "emu198x-sega-master-system"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sega-master-system"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sega-master-system"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sega-master-system"
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
