class Emu198xSpectravideoSvi328 < Formula
  desc "Spectravideo SVI-328 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + AY-3-8910 + 8255 PPI"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-spectravideo-svi-328-aarch64-apple-darwin.tar.gz"
      sha256 "06855f72be57337dcd3ee530121843409ffec04473894a9d964e2eef27ace863"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-spectravideo-svi-328-x86_64-apple-darwin.tar.gz"
      sha256 "5f8ce847dfa7a7ca9dcc982832b787094f634c895635ddeb25eff44c730fe415"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-spectravideo-svi-328-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "71bb9cf3c4855792b34a37a14a3844c38d6b9efab057244c275d47cd1d6477cd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-spectravideo-svi-328-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "40d2c536bdadfa393e2c01f635a9b39bb1e188332de22543aefec3fc3327a394"
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
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-spectravideo-svi-328"
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
