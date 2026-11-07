class Emu198xSegaMegaDrive < Formula
  desc "Sega Mega Drive / Genesis headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.48.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-sega-mega-drive-aarch64-apple-darwin.tar.gz"
      sha256 "662b8739d1da8db5f1b30d069d65052063fdf4c89f4f7f2ab841b58e7b628527"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-sega-mega-drive-x86_64-apple-darwin.tar.gz"
      sha256 "147d3cfdf980483cf938b384c7c7e8912f4577f6120baeec13fb24722ea73f10"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-sega-mega-drive-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "99b90db4169befab18dd673820227bc5c70e9d57e488aa2c033408778ff23ee0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-sega-mega-drive-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "255a9f7ddf8fa8d326b9e1040ee9d778d25d1e4771a7a87c2e9308ac1cccd245"
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
      bin.install "emu198x-sega-mega-drive"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sega-mega-drive"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sega-mega-drive"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sega-mega-drive"
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
