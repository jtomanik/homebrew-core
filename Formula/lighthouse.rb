class Lighthouse < Formula
  desc "Rust Ethereum 2.0 Client"
  homepage "https://github.com/sigp/lighthouse"

  url "https://github.com/sigp/lighthouse.git",
      tag:      "v1.4.0",
      revision: "3b600acdc5bf9726367c18277a22486573b8b457"
  license "Apache-2.0"

  depends_on "cmake" => :build
  depends_on "rustup-init" => :build

  # Update the Rust toolchain version whenever lighthouse is updated.
  def rust_toolchain
    "1.52.1"
  end

  # Update the version string whenever lighthouse is updated.
  def lighthouse_version_string
    "v1.4.0-3b600ac"
  end

  def install
    # This will install a rust toolchain to be used with lighthouse.
    system Formula["rustup-init"].bin/"rustup-init", "-qy", "--no-modify-path",
           "--default-toolchain", rust_toolchain, "--profile", "minimal"
    ENV.prepend_path "PATH", HOMEBREW_CACHE/"cargo_cache/bin"
    system "make"
    bin.install "target/release/lighthouse"
  end

  test do
    assert_match "Lighthouse #{lighthouse_version_string}", shell_output("#{bin}/lighthouse --version")
  end
end
