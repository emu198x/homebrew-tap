class Emu198xSinclairZx80 < Formula
  desc "Sinclair ZX80 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.45.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-sinclair-zx80-aarch64-apple-darwin.tar.gz"
      sha256 "7c22b2433ca0a448e7dfdbf1e718ba7f55335cec6d67de78f8afeeb9717966e9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-sinclair-zx80-x86_64-apple-darwin.tar.gz"
      sha256 "b547160fbaa881d1ec7bd1505b69ff282fe1b7497caa12397510e5ac68ee87ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-sinclair-zx80-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7978c2b2abdb55c909ef0ea272444cea3acf153e5f3f4ae1749f22e95599b7e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-sinclair-zx80-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bb19b59cc5772a83966deddafafc41c8e9c4ff99a72dc42523b3d80eda91efd8"
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
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx80"
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
