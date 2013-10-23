def installed? name
  verbose(false) do
    puts "Looking for #{name}..."
    sh "which #{name}"
  end
end

def package_installed? name
  verbose(false) do
    puts "Looking for OCaml package #{name}..."
    sh "ocamlfind query #{name}"
  end
end

task :deps do
  unless installed?("ocaml")
    sh "brew install ocaml"
  end

  unless installed?("opam")
    sh "brew install opam"
  end

  unless package_installed?("oUnit")
    sh "opam install oUnit"
  end
end

task :clean => [:deps] do
  sh "ocamlbuild -clean"
end

task :build => [:clean] do
    caml_files = FileList.new("*.ml")
    caml_files.each do |f|
      unless f.include? "Test.ml"
        name = File.basename(f, File.extname(f))
        sh "ocamlbuild #{name}.native -pkg Str -use-ocamlfind"
        puts
      end
    end
end

task :test => [:build, :clean] do
  verbose(false) do
    caml_files = FileList.new("*Test.ml")
    caml_files.exclude("TTT.ml").each do |f|
      name = File.basename(f, File.extname(f))
      sh "ocamlbuild #{name}.native -pkg oUnit -pkg Str -use-ocamlfind"
      puts
      puts "Running tests for #{f} module:"
      sh "./#{name}.native"
    end
  end
end
