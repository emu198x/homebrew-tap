class Emu198xNes < Formula
  desc "Native NES verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.32.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-nes-aarch64-apple-darwin.tar.gz"
      sha256 "3d837a8ba7841fb64fc40e86dba5e36bfdbb8acfc13a0cfe045812f64e4eb5e2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-nes-x86_64-apple-darwin.tar.gz"
      sha256 "4312402e47aac186b996d77f51fb53fd43112f443c6c7bfbb13678e34449b3d8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-nes-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9b6fcb73ff0f1aaad3cfbb3292ff20652b789d42fd8675a8fd9542a6aad6e77f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-nes-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "09af05b19f12fa52b04faaa0b3489dfa9944271ee66f5846636eb0c3f7912fe8"
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
      bin.install "emu198x-nes"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-nes"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-nes"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-nes"
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
