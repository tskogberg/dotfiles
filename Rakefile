DO_NOT_SYMLINK = %w[
  .gitignore
  extras
  Rakefile
  README.markdown
]


def error(text)
  STDERR.puts "!  #{text}"
end

def info(text)
  STDOUT.puts "*  #{text}"
end

def info_rm(text)
  STDOUT.puts "x  #{text}"
end

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "found ~/.oh-my-zsh"
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing oh-my-zsh"
      system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
    when 'q'
      exit
    else
      puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
end

task :default => :install

desc "Install dotfiles."
task :install do
  install_oh_my_zsh
  switch_to_zsh
  Dir["*"].each do |file|
    source = File.join(Dir.pwd, file)
    basename = File.basename(source)
    next if DO_NOT_SYMLINK.include?(basename)

    target = File.expand_path("~/.#{basename}")

    if File.symlink?(target)
      symlink_to = File.readlink(target)
      info_rm "Removing symlink #{target} --> #{symlink_to}" if symlink_to != source
      FileUtils.rm(target)
    elsif File.exist?(target)
      error "#{target} exists. Will not automatically overwrite a non-symlink. Overwrite (y/n)?"
      print "? "
      if STDIN.gets.match(/^y/i)
        info_rm "Removing #{target}."
        FileUtils.rm_rf(target)
      else
        next
      end
    end

    FileUtils.ln_s(source, target)
    info "Creating symlink: #{target} --> #{source}"
  end

  system "git submodule update --init"
  system "cp -r ~/.dotfiles/oh-my-zsh-custom/ ~/.oh-my-zsh/"
end
