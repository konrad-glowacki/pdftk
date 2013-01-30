require 'logger'
require 'digest/md5'
require 'rbconfig'
require RbConfig::CONFIG['target_os'] == 'mingw32' && !(RUBY_VERSION =~ /1.9/) ? 'win32/open3' : 'open3'
require 'active_support/core_ext/class/attribute_accessors'

begin
  require 'active_support/core_ext/object/blank'
rescue LoadError
  require 'active_support/core_ext/blank'
end

class Pdftk
  EXE_NAME = "pdftk"
  @@config = {}
  cattr_accessor :config

  def initialize(execute_path = nil)
    @exe_path = execute_path || find_binary_path
    raise "Location of #{EXE_PATH} unknow" if @exe_path.empty?
    raise "Bad location of #{EXE_PATH}'s path" unless File.exists?(@exe_path)
    raise "#{EXE_PATH} is not executable" unless File.executable?(@exe_path)
  end

  def merge(source_array, destination_path)
    @source_files = source_array
    @merged_file_path =  destination_path

    command = "#{@exe_path} #{@source_files.join(' ')} cat output #{@merged_file_path}"
    err = Open3.popen3(command) do |stdin, stdout, stderr|
      stderr.read
    end
    pdf = @merged_file_path.read
    raise "PDF could not be generated!" if pdf and pdf.rstrip.length == 0
    pdf
  rescue Exception => e
    raise "Failed to execute:\n#{command}\nError: #{e}"
  end

  private

    def find_binary_path
      possible_locations = (ENV['PATH'].split(':')+%w[/usr/bin /usr/local/bin ~/bin]).uniq
      exe_path ||= Pdftk.config[:exe_path] unless Pdftk.config.empty?
      exe_path ||= possible_locations.map{|l| File.expand_path("#{l}/#{EXE_NAME}") }.find{|location| File.exists? location}
      exe_path || ''
    end
end
