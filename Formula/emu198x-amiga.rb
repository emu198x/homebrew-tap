class Emu198xAmiga < Formula
  desc "Native Amiga verifier with interactive UI, headless script, and MCP debugging modes"
  homepage "https://emu198x.github.io/"
  version "0.34.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-amiga-aarch64-apple-darwin.tar.gz"
      sha256 "27be6b39fd183d13e92d4580970ee1e487b01639f9d4a61de24bd515eec2f9d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-amiga-x86_64-apple-darwin.tar.gz"
      sha256 "8b48f329af67a6a5afb5df313388c4035fc9d36f4df612ff53a6409afab0b207"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-amiga-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8dd0a20b75879f0342cbddda906ec2dda0770ad288f6e6806fb60d0c0b6ac7ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-amiga-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0af55d2a0775fb89d43d626f9cffa9241042e6f2362d9f2018d8301ad3d93645"
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
