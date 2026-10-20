class Emu198xAmstradCpc < Formula
  desc "Amstrad CPC464 runner with shell-backed UI, script and MCP parity — Z80 + Gate Array + HD6845S + AY-3-8912"
  homepage "https://emu198x.github.io/"
  version "0.39.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-amstrad-cpc-aarch64-apple-darwin.tar.gz"
      sha256 "cccf26d42de784b15f9708d56f010686fc8419c454e47c1de4768728cee177fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-amstrad-cpc-x86_64-apple-darwin.tar.gz"
      sha256 "39ed491beb859f3668eea048dd41ba4f7bb5fc239da8ba820dec0581b8fd49f2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-amstrad-cpc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1e5cc6e4bc35b5e2c57418673be4e22e69c2732a6306b783b83d5881c05301d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-amstrad-cpc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f4514a540b8166af18d4d7dc18c8dcf31023c1b83b9023d903ae0b9e4f18bc0"
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
