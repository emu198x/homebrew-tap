class Emu198xMemotechMtx < Formula
  desc "Memotech MTX headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.39.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.2/emu198x-memotech-mtx-aarch64-apple-darwin.tar.gz"
      sha256 "b9b4f91746b4692b93ec3d7a953dcb1cd25f807ff42499d507e3a2061e209688"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.2/emu198x-memotech-mtx-x86_64-apple-darwin.tar.gz"
      sha256 "858ab3e770cac4f2b58e0af62ff432c9450abc1812c108a7a60386fd0ece2d88"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.2/emu198x-memotech-mtx-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3616f7ab1231c68d159630340bb2258b8e6e403814d02d5297a43effd6b75bd3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.2/emu198x-memotech-mtx-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "29f11cbb52f4349c3217298b2f1e306797b804b41d32bd3ad297927668e2dc45"
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
      bin.install "emu198x-memotech-mtx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-memotech-mtx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-memotech-mtx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-memotech-mtx"
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
