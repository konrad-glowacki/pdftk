class PdftkGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file "pdftk.rb", "config/initializers/pdftk.rb"
    end
  end
end
