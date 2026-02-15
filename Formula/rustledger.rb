# Homebrew formula for rustledger
# https://github.com/rustledger/rustledger
class Rustledger < Formula
  desc "Fast, pure Rust implementation of Beancount double-entry accounting"
  homepage "https://rustledger.github.io"
  version "0.8.8"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/rustledger/rustledger/releases/download/v0.8.8/rustledger-v0.8.8-aarch64-apple-darwin.tar.gz"
      sha256 "11bcf76dda1679d3861ffadb458d945f7f287e97047d133a286e0c5bd04342ee"
    end
    on_intel do
      url "https://github.com/rustledger/rustledger/releases/download/v0.8.8/rustledger-v0.8.8-x86_64-apple-darwin.tar.gz"
      sha256 "1db4fb0ac8656eb2e963cc1b2f521b00e9f29803f3c927750156ff78a426359c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rustledger/rustledger/releases/download/v0.8.8/rustledger-v0.8.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d6062b9fbf2175fccb9c03e1b4d89000ca7ee68e013bd160dff369f3de799a89"
    end
    on_intel do
      url "https://github.com/rustledger/rustledger/releases/download/v0.8.8/rustledger-v0.8.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2f1503a1d05ba0638882a697ca567230a9aaac2df227c7e6244207a88b31abf4"
    end
  end

  def install
    # Main CLI
    bin.install "rledger"
    bin.install "rledger-lsp"

    # Bean-compatible aliases
    bin.install "bean-check", "bean-format", "bean-query",
                "bean-report", "bean-doctor", "bean-extract", "bean-price"

    # Generate and install shell completions
    generate_completions_from_executable(bin/"rledger", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rledger --version")

    # Test basic validation
    (testpath/"test.beancount").write <<~BEANCOUNT
      2024-01-01 open Assets:Bank:Checking USD
      2024-01-01 open Expenses:Food USD

      2024-01-15 * "Grocery Store" "Weekly groceries"
        Expenses:Food  50.00 USD
        Assets:Bank:Checking
    BEANCOUNT
    system bin/"rledger", "check", testpath/"test.beancount"
  end
end
