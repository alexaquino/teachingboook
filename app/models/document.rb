class Document
  include Config
  
  def self.generate_report(xml_data, report_design, params, output_type)
    report_design << '.jasper' if !report_design.match(/\.jasper$/)
    interface_classpath = Dir.getwd+"/app/jasper/bin/" 
    
    case CONFIG['host']
      when /mingw32/
        mode = "w+b" #windows requires binary mode
        Dir.foreach(Dir.getwd+"/app/jasper/lib") do |file|
          interface_classpath << ";#{Dir.getwd}/app/jasper/lib/" + file if (file != '.' and file != '..' and file.match(/.jar/))
        end
      else
        mode = "w+b"
        Dir.foreach(Dir.getwd+"/app/jasper/lib") do |file|
          interface_classpath << ":#{Dir.getwd}/app/jasper/lib/" + file if (file != '.' and file != '..' and file.match(/.jar/))
        end
    end
    result = nil
    
    output = ''
    params.each do |key, value|
      output << key + '-' + value.to_s + '-' +value.class.to_s + ' | '
    end
    output = output.slice(0,output.length-3)
    
    puts "java -Djava.awt.headless=true -classpath #{interface_classpath}: JasperInterface -o#{output_type} -f#{Dir.getwd}/app/reports/#{report_design} -cjdbc:mysql://localhost:3306/teachingboook_development?user=root&password= -p#{output}"
    
    IO.popen "java -Djava.awt.headless=true -classpath #{interface_classpath}: JasperInterface -o#{output_type} -f#{Dir.getwd}/app/reports/#{report_design} -cjdbc:mysql://localhost:3306/teachingboook_development?user=root&password= -p#{output}", mode do |pipe|
      pipe.write xml_data 
      pipe.close_write
      result = pipe.read
      pipe.close
    end
    puts result
    return result
  end
  
  private
  
  def params_to_s params
    output = ''
    params.each do |key, value|
      output << key + ';' + value.to_s + ';' +value.class.to_s + '|'
    end
    return output.slice(0,output.length-1)
  end
end