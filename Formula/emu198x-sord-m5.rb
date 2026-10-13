class Emu198xSordM5 < Formula
  desc "Sord M5 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489A"
  homepage "https://emu198x.github.io/"
  version "0.32.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.1/emu198x-sord-m5-aarch64-apple-darwin.tar.gz"
      sha256 "70bf80abf61b580f8ad7a15fd38d697258f213c659fcb533f449e233cce21c64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.1/emu198x-sord-m5-x86_64-apple-darwin.tar.gz"
      sha256 "4a2c36d4ee7822e0839150f0580f4f7938578ac4102ba5177bed0c85d55835ee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.1/emu198x-sord-m5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "906331511740751e7c01d9ab6a9b1e1841c1aa84a9bdddef8db9f5fb696a3808"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.1/emu198x-sord-m5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "91900ca3cd447e43926710e2bc13d5bc62045f28f5953a4c76d5c2f388a5593d"
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
      bin.install "emu198x-sord-m5"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sord-m5"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sord-m5"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sord-m5"
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
