Pdftk
=====

Pdftk is gem for merging pdf files with pdftk library for Rails.

### Installation

 Configure it in an initializer:
    Pdftk.config = {
      :exe_path => '/usr/local/bin/pdftk'
    }

Next:

    script/plugin install git://github.com/webkrak/pdftk.git
    script/generate pdftk

or add this to your Gemfile:

    gem 'pdftk'

### Basic Usage


pdftk  = Pdftk.new(array_with_files_path_to_merging, output_file)
result = pdftk.merge

