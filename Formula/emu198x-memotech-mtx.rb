class Emu198xMemotechMtx < Formula
  desc "Memotech MTX headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.37.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-memotech-mtx-aarch64-apple-darwin.tar.gz"
      sha256 "d336190a380171b7388592bfeec0dd1eee829291e9c03e79574c694fa5af5112"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-memotech-mtx-x86_64-apple-darwin.tar.gz"
      sha256 "f2d9e77ae0cee3fc727eabd06100c888a0acd3a6f97fda3ca154864350bc9383"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-memotech-mtx-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e3dd3d1af6690184c206e6f2cb666ea050d3d05752a3531cdb18419de339a0df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-memotech-mtx-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7d69ef5288c02260055148aafe7bac63b67aead61465d30f753001a53aba69d3"
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
