class Emu198xOricAtmos < Formula
  desc "Oric-1 / Atmos headless runner with shell-backed script + MCP parity — 6502 + ULA + VIA-6522 + AY-3-8910"
  homepage "https://emu198x.github.io/"
  version "0.32.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.4/emu198x-oric-atmos-aarch64-apple-darwin.tar.gz"
      sha256 "1a90a69ee170537dc59f0e075a4e81a2038ce259a01bee0e36c91c0633d447f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.4/emu198x-oric-atmos-x86_64-apple-darwin.tar.gz"
      sha256 "0b0f54e7c8a98d387bf3b09737f58bd0d2393f0e1e2c4aeb0b7ffeb3e0d9a871"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.4/emu198x-oric-atmos-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b605ab0feee6ecadff62b4de9d6ad56daef98bc9110fe242dee9f1f1699fe5f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.4/emu198x-oric-atmos-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f6e6326361c013049a16ed5bd6b78903ba80efc344073fcb0a538ec70f774d2f"
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
      bin.install "emu198x-oric-atmos"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-oric-atmos"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-oric-atmos"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-oric-atmos"
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
