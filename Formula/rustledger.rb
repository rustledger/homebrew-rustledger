# Homebrew formula for rustledger (prerelease channel)
# For stable releases, use homebrew-core when available
class Rustledger < Formula
  desc "Fast, pure Rust implementation of Beancount double-entry accounting"
  homepage "https://rustledger.github.io"
  version "1.0.0-rc.18"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/rustledger/rustledger/releases/download/v1.0.0-rc.18/rustledger-v1.0.0-rc.18-aarch64-apple-darwin.tar.gz"
      sha256 "3caacf8352eb8bd65ec8d0614a8e6fa1a2535c19d6d14e80393ee8185b1d91d6"
    end
    on_intel do
      url "https://github.com/rustledger/rustledger/releases/download/v1.0.0-rc.18/rustledger-v1.0.0-rc.18-x86_64-apple-darwin.tar.gz"
      sha256 "cab86a041e3e70678b3f9deba0fa614880e19da8d337efe11b1be82c253d2084"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rustledger/rustledger/releases/download/v1.0.0-rc.18/rustledger-v1.0.0-rc.18-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cec68f53c14a126811027ffaad2d1d8d1bbea683ac91698d5f5227364dcaa6f8"
    end
    on_intel do
      url "https://github.com/rustledger/rustledger/releases/download/v1.0.0-rc.18/rustledger-v1.0.0-rc.18-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bee40ac1bc93f2df36eae0bb4a17666822771deba4bf31952bd8bc7386412a84"
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
