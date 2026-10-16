class Emu198xCommodoreVic20 < Formula
  desc "Commodore VIC-20 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.35.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-commodore-vic-20-aarch64-apple-darwin.tar.gz"
      sha256 "ec96bf9e5ec23a9657c3e01ebe28a7609f405e1a1b515640614ea44ed5514636"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-commodore-vic-20-x86_64-apple-darwin.tar.gz"
      sha256 "c52857b36cc02f23c0e2a55dda556f76497eb34864a7ec9277ee18695cf17504"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-commodore-vic-20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "142f6f5168a57deeef6a2af901e19d8234f6dd93fc32a8b5369c35462f7b7299"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-commodore-vic-20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9b9effaa97d91d6e2b21e1dfc6151637fa2aa8dcd76662532e009b8cfa7429aa"
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
