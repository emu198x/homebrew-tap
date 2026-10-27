class Emu198xAtariSt < Formula
  desc "Atari ST headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.45.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-atari-st-aarch64-apple-darwin.tar.gz"
      sha256 "44b9239d24b841ba1c7e7c2e62a61c118d71d55356633f5ec3faaad963800967"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-atari-st-x86_64-apple-darwin.tar.gz"
      sha256 "a7db63238ed0232bb417993fec49962cb8caae8c993cc8845a6574da0597a95b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-atari-st-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee4cb5c2dedad93b90bbc039b612f858a37a47abdb6f2eb955afeb22ba8e748c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-atari-st-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f2875d7540686f8b210256dc0da21cd1e0668a72b44a88c291807251b5a4adaf"
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
      bin.install "emu198x-atari-st"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-st"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-st"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-st"
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
