class Emu198xSegaSg1000 < Formula
  desc "Sega SG-1000 / SC-3000 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489A"
  homepage "https://emu198x.github.io/"
  version "0.42.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-sega-sg-1000-aarch64-apple-darwin.tar.gz"
      sha256 "46180a0bf226242e3c429ae520dac6dbed549234cbd031ef98c73a38daf2b936"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-sega-sg-1000-x86_64-apple-darwin.tar.gz"
      sha256 "48750bb0b9cb63d7fa5acc06a04dcc50a434cdc63ca680499a3fffd247ba51fc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-sega-sg-1000-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eccf554b31c6c8e7ded78356173f81b2e5317472bbac34986891a95c2f75a76e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-sega-sg-1000-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ddd4546ec066d79da9e539d1fc2727a54b6b5d0f6932271ea4d041200d10a4ef"
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
