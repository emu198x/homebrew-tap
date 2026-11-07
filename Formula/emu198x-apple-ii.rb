class Emu198xAppleIi < Formula
  desc "Original Apple II emulator with shared native UI, scripts and MCP"
  homepage "https://emu198x.github.io/"
  version "0.48.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-apple-ii-aarch64-apple-darwin.tar.gz"
      sha256 "6d9a92c5d91c61448dfccb6bc767c817e622fe2ecbbff11613c7ce1a8d69c8c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-apple-ii-x86_64-apple-darwin.tar.gz"
      sha256 "6c0aabf8317fd71dbe02d4b29e1e2475028e1ee4ae723d4c6bf01a9995b24c68"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-apple-ii-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b75620793be89898ae3f720060d3af163e641522515ed6cc37a69bff493f1245"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-apple-ii-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1eede1aac0925f00f7c4acd5cba8470cd67ab1af674d17c26a5a9662a4d056fc"
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
      bin.install "emu198x-apple-ii"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-apple-ii"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-apple-ii"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-apple-ii"
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
