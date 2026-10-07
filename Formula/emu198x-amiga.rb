class Emu198xAmiga < Formula
  desc "Native Amiga verifier with interactive UI, headless script, and MCP debugging modes"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-amiga-aarch64-apple-darwin.tar.gz"
      sha256 "4e9ef44a12fdd9b641a1d72e55b19e8583d275c4cdace7bb554fc8559d5dc73b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-amiga-x86_64-apple-darwin.tar.gz"
      sha256 "5316919549c5abb91f4fbb334ec3e03ac94a049965467aab02f23c3527676c79"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-amiga-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4e6037ae1921fc3a1c2439bdda7816781186072a1d6c64fc122fe4193e2d1f42"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-amiga-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d611acb50353cdcd25bedf20f7b7795b09c76d75142f6c876cafa68d05582c75"
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
      bin.install "emu198x-amiga"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-amiga"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-amiga"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-amiga"
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
