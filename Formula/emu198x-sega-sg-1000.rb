class Emu198xSegaSg1000 < Formula
  desc "Sega SG-1000 / SC-3000 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489A"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-sg-1000-aarch64-apple-darwin.tar.gz"
      sha256 "b78c2a53b97807f87c943f53095d2daf11beff38c58601059cb1e58c819f9370"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-sg-1000-x86_64-apple-darwin.tar.gz"
      sha256 "c8d43816d1e637adb43d17727e6082977a6990d2760f1a3d8db0956f70ee240c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-sg-1000-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee978b9e8d94e8d817421cc79a27a71ad03a4e062ab71a4c17cec08ec154c729"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-sg-1000-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "48eb903a4357a2867845bb08d5cc22b50018bac0f9d6ec75848e15a52500e151"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "emu198x-sega-sg-1000"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sega-sg-1000"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sega-sg-1000"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sega-sg-1000"
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
