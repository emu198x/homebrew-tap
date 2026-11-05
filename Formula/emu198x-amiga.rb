class Emu198xAmiga < Formula
  desc "Native Amiga verifier with interactive UI, headless script, and MCP debugging modes"
  homepage "https://emu198x.github.io/"
  version "0.48.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-amiga-aarch64-apple-darwin.tar.gz"
      sha256 "8b9843909dbc00fdeb3c1964ae15d80f334122b3931adcd1ddde4efdedeab34f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-amiga-x86_64-apple-darwin.tar.gz"
      sha256 "b5d3f11522c634f905433852dba1a7983a55174a8b34cda7ff202eeb8c5ebfb4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-amiga-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "664eb610b5d012882bd3e5c2e4e01043bf189bd66e40563155077de33e2fb44a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-amiga-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "852036ca58dbe98ebd3122da67af4664b028347eac44e3788a3a1b2aab43a03f"
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
      bin.install "emu198x-amiga"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-amiga"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-amiga"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-amiga"
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
