class Emu198xGameBoy < Formula
  desc "Native Game Boy verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.48.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-game-boy-aarch64-apple-darwin.tar.gz"
      sha256 "56faa157bae30f7d51c8b5a75832f3f1529a2e01ca898a0259cf57b141ebe2d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-game-boy-x86_64-apple-darwin.tar.gz"
      sha256 "20f63a8d43351175e020a519dd7d329a1d23b04cefea13e8def1f33e6e6b0b6e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-game-boy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b07c85a3f4cf1e5b76d061138cc50855cf9a1d25fcc60894cda526c6277fb8ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-game-boy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "29e07e99e094588c773d39c063455c87ca03e51f13917c773b890df4af505d8a"
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
      bin.install "emu198x-game-boy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-game-boy"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-game-boy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-game-boy"
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
