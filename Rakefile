def success text
  puts "\e[1;32m#{text}\e[0m"
end

def info text
  puts "\e[1;34m#{text}\e[0m"
end

def installed? name
  verbose(false) do
    info "Looking for #{name}..."
    sh "which #{name}" do |ok, exit_code|
      puts
      return ok
    end
  end
end

def package_installed? name
  verbose(false) do
    info "Looking for OCaml package #{name}..."
    sh "ocamlfind query #{name}" do |ok, exit_code|
      puts
      return ok
    end
  end
end

task :deps do
  info "Resolving dependencies."
  puts

  unless installed?("ocaml")
    info "Attempting to install OCaml via homebrew."
    puts
    sh "brew install ocaml"
  end

  unless installed?("opam")
    info "Attempting to install opam via homebrew."
    puts
    sh "brew install opam"
    puts

    info "Initializing and configuring opam."
    sh "opam init"
    sh "eval `opam config env`"
  end

  unless package_installed?("oUnit")
    puts "Attempting to install oUnit test library."
    puts
    sh "opam install ounit"
  end
  puts
end

task :clean => [:deps] do
  info "Cleaning up build artifacts."
  puts
  sh "ocamlbuild -clean"
  puts
  puts
end

task :spec => [:deps] do
  info "Building Spec binary."
  puts
  verbose(false) do
      sh "ocamlbuild Spec.native -pkg ounit -pkg Str -Is src,spec -use-ocamlfind"
      puts "It worked! Run ./Spec.native to run the tests."
      puts
      info "Running tests..."
      sh "./Spec.native"
  end
end

task :build => [:clean, :spec] do
  info "Building TTT binary."
  puts
  sh "ocamlbuild TTT.native -Is src -pkg Str -use-ocamlfind"
  puts
  success "It worked! Run ./TTT.native to play the game."
end

task :default => [:build] do
  sh "./TTT.native"
end
