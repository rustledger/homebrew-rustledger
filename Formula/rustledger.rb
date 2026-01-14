# Homebrew formula for rustledger
class Rustledger < Formula
  desc "Fast, pure Rust implementation of Beancount double-entry accounting"
  homepage "https://rustledger.github.io"
  version "0.1.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/rustledger/rustledger/releases/download/v0.1.0/rustledger-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "fc2d01ec90d188e8435a0ef0d941edc8375bfa7ea11cc59d7aeef745027e0e45"
    end
    on_intel do
      url "https://github.com/rustledger/rustledger/releases/download/v0.1.0/rustledger-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "c866d346dc5d62626e68214371ec8e7dc17c5353047503a170323d291ff5487a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rustledger/rustledger/releases/download/v0.1.0/rustledger-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fdeacb608b2bbc11b9ce5865bf79461e256235af451a01ce16edbf326790fb55"
    end
    on_intel do
      url "https://github.com/rustledger/rustledger/releases/download/v0.1.0/rustledger-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "43058e026e221336587a95d0dd8576ce54757f376435f7a2eb25ae2b8186656e"
    end
  end

  def install
    bin.install "rledger-check", "rledger-format", "rledger-query",
                "rledger-report", "rledger-doctor", "rledger-extract", "rledger-price"
    bin.install "bean-check", "bean-format", "bean-query",
                "bean-report", "bean-doctor", "bean-extract", "bean-price"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rledger-check --version")

    # Test basic validation
    (testpath/"test.beancount").write <<~EOS
      2024-01-01 open Assets:Bank:Checking USD
      2024-01-01 open Expenses:Food USD

      2024-01-15 * "Grocery Store" "Weekly groceries"
        Expenses:Food  50.00 USD
        Assets:Bank:Checking
    EOS
    system "#{bin}/rledger-check", testpath/"test.beancount"
  end
end
