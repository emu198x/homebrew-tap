class Emu198xSordM5 < Formula
  desc "Sord M5 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489A"
  homepage "https://emu198x.github.io/"
  version "0.32.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-sord-m5-aarch64-apple-darwin.tar.gz"
      sha256 "222ffc2b56e8add03ea3295806ef6344e47475784ed46ae2ed6849d9a7e9a76c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-sord-m5-x86_64-apple-darwin.tar.gz"
      sha256 "8291ec108199a522b362aba852ec8e85a372b07f6ef9a97dc71c1170674174b2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-sord-m5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5279f965f4b7237fa313d34e45dbfaeb20fe1fa9f18ab4f1630628b98be29ff5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-sord-m5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4312651f685112f2cfca05e9bbda479aa370360a7138211c0d595ddec39fc73a"
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
