class Emu198xSegaMegaDrive < Formula
  desc "Sega Mega Drive / Genesis headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.48.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-sega-mega-drive-aarch64-apple-darwin.tar.gz"
      sha256 "62266b101cbae3e5e061fec7617edc645c16660ad145bb863b9bf43c343a8714"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-sega-mega-drive-x86_64-apple-darwin.tar.gz"
      sha256 "5df31d344b240fa12456d61200ca827835dfeb75b323af9ab42ce9d551d3915e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-sega-mega-drive-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "74300575cb7a631421163dcadf2fbb007d0432b01a9aa9d07b2aaa190fc2cbe6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-sega-mega-drive-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "34bc01dbb24de7d36c4f1b3ae93e62d7bb8609b063282250a48cda06f2309fb6"
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
