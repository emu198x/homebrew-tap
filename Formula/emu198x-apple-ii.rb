class Emu198xAppleIi < Formula
  desc "Original Apple II emulator with shared native UI, scripts and MCP"
  homepage "https://emu198x.github.io/"
  version "0.48.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-apple-ii-aarch64-apple-darwin.tar.gz"
      sha256 "fc1f6377a9f0e1d96f82aeb895df0cb10564b0109fcbcb10afdb6b236c62eee1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-apple-ii-x86_64-apple-darwin.tar.gz"
      sha256 "45d996b1650338d8a447936cd0d522978b10f45479d335b813b5eadbbeed5f18"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-apple-ii-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "15ad30c98c2cffdaba94e24e67745f44a87620c60905d8d0322474c8093828a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-apple-ii-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "815dbdadd26303d2fff2d6670cceb6d6659929fe416081701dfde3aa77e13746"
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
