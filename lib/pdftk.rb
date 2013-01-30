class Pdftk
  EXE_NAME = "pdftk"
  @@config = {}
  cattr_accessor :config

  def initialize(source_array, destination_path)
    @source_files = source_array
    @merged_file_path =  destination_path
    raise "Location of #{EXE_PATH} unknow" if @exe_path.empty?
    raise "Bad location of #{EXE_PATH}'s path" unless File.exists?(@exe_path)
    raise "#{EXE_PATH} is not executable" unless File.executable?(@exe_path)
  end

  def merge
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
end
