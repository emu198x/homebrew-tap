class Emu198xCommodoreVic20 < Formula
  desc "Commodore VIC-20 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.32.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-commodore-vic-20-aarch64-apple-darwin.tar.gz"
      sha256 "03647cb12a99550b11f26e5fadb3362d79c44a37a327552f9456a0d28669d04a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-commodore-vic-20-x86_64-apple-darwin.tar.gz"
      sha256 "0a39969cf7aad08bde99ad3501fa4ab7cc13cb2118a832db2e9e1878ee1a6c3e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-commodore-vic-20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e57f3d00a95e5867a6471d0f7ee9c4c37b01087041af6babd07edbf1868fc0ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-commodore-vic-20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cecf3e01ae5d487741e81e42aefb79a772456e28ab3f6ae892e84af5d090c075"
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
      bin.install "emu198x-commodore-vic-20"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-commodore-vic-20"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-commodore-vic-20"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-commodore-vic-20"
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
