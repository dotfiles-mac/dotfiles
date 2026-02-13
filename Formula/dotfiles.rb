class Dotfiles < Formula
  desc "Developer toolkit with Mac setup, Git hooks, and CLI tools"
  homepage "https://github.com/dotfiles-mac/dotfiles"
  url "https://github.com/dotfiles-mac/dotfiles.git"
  version "1.0.0"
  license "MIT"

  depends_on "dart-sdk" => :recommended

  def install
    bin.install "setup-mac.sh" => "dotfiles-setup"
  end

  def post_install
    puts "\nRun 'dotfiles-setup' to set up your Mac with all development tools."
  end
end
