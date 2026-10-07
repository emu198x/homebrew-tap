class Emu198xColecovision < Formula
  desc "ColecoVision headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489AN"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-colecovision-aarch64-apple-darwin.tar.gz"
      sha256 "87c46394978a45f199b5681156ddf8b40d6357a249842c24991d06b66210d529"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-colecovision-x86_64-apple-darwin.tar.gz"
      sha256 "f116565dfaa057fd58d61222cf5d417f9b7652fd7f4a53a2100f0a19de69aec2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-colecovision-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1b97c7b0063353cecb4277ce4468df0b57627328a003287f36d369c355711769"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-colecovision-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "441e13337ee49ebd7adcd388e74433f61f8136852e11a99d61a76061dc5e5a7b"
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
      bin.install "emu198x-colecovision"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-colecovision"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-colecovision"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-colecovision"
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
