class Emu198xMsx < Formula
  desc "MSX1 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + AY-3-8910 + 8255 PPI"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-msx-aarch64-apple-darwin.tar.gz"
      sha256 "aedba46dce8e6650be069e3276b689ea8e943314b54996a9a2c468dd57e67249"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-msx-x86_64-apple-darwin.tar.gz"
      sha256 "79d4612519b1efc52a86d8c520b16a6fc62db4f5fc3a13521d394c1f67d39618"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-msx-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "09940dbf9f78286e08823a9c104a003a49fd8dc7abe6d0ca66c9db4d3f72d6ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-msx-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6d2bea9bb223e7bb8cd4ee33d04647376ae7193aac00c19717f4ed4d81c96201"
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
      bin.install "emu198x-msx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-msx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-msx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-msx"
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
