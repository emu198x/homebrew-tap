class Emu198xAmstradCpc < Formula
  desc "Amstrad CPC464 runner with shell-backed UI, script and MCP parity — Z80 + Gate Array + HD6845S + AY-3-8912"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-amstrad-cpc-aarch64-apple-darwin.tar.gz"
      sha256 "37a508372cc737be28de577f4f0a738ad6faed4fbce71c78cb6628a0bbbd2218"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-amstrad-cpc-x86_64-apple-darwin.tar.gz"
      sha256 "e5621a816e66b8befadf596c00094df91b099980e0fefe30e1378e4b85823f28"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-amstrad-cpc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "55f76e44a653c7b8030f274a176ba472c6f0cf23b2ba10b90fb8e99361fc194d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-amstrad-cpc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f9586302f14a51c3c751909fadad5cc9bd0b6bcd9b7017384d3d68bf3672e7fa"
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
      bin.install "emu198x-amstrad-cpc"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-amstrad-cpc"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-amstrad-cpc"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-amstrad-cpc"
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
