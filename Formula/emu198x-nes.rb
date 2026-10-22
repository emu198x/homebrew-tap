class Emu198xNes < Formula
  desc "Native NES verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.44.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-nes-aarch64-apple-darwin.tar.gz"
      sha256 "5f39c996b2ce0dfff93048f36889848319c0f6849db6605b93648d30c7779da1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-nes-x86_64-apple-darwin.tar.gz"
      sha256 "fd758685a245abbf40a8b7312f6f6a3d76123157bf3333ee5c3075d818c45a81"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-nes-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "93903fbc89406c19e30fd7fb7700e693dc8afbf6c2c867c53f471f4a6e825394"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-nes-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7998a3c6881ac5b843c0c1d8c7e5c029c454e1076da425ef5e162f31c084da5"
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
