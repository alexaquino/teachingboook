import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRXmlDataSource;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRRtfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

public class JasperInterface {

	private static final String TYPE_PDF = "pdf";
	private static final String TYPE_XML = "xml";
	private static final String TYPE_RTF = "rtf";
	private static final String TYPE_XLS = "xls";
	private static final String TYPE_CSV = "csv";
	private static final String TYPE_HTML= "html";

	private String outputType;
	private String compiledDesign;
	private String selectCriteria;
	private static Connection connection;
	private static Map<String, Object> params = new HashMap<String, Object>();

	public static void main(String[] args) {
		String outputType = null;
		String compiledDesign = null;
		String selectCriteria = null;

		if (args.length < 2 ) {
			printUsage();
			return;
		}
		
		System.out.println(args);

		for (int k = 0; k < args.length; ++k) {
			if (args[k].startsWith("-o"))
				outputType = args[k].substring(2);
			else if (args[k].startsWith("-f"))
				compiledDesign = args[k].substring(2);
			else if (args[k].startsWith("-x"))
				selectCriteria = args[k].substring(2);
			else if (args[k].startsWith("-c")){
				 try {
					 System.out.println(">>>>>>>>>>>>>>>>>>>>>" + args[k].substring(2));
			            Class.forName("com.mysql.jdbc.Driver").newInstance();
			            connection = DriverManager.getConnection(args[k].substring(2));
			        } catch( SQLException e ) {
			            e.printStackTrace();
			            System.out.println(e.getMessage());
			        } catch ( ClassNotFoundException e ) {
			            e.printStackTrace();
			            System.out.println(e.getMessage());
			        } catch ( InstantiationException e ) {
			            e.printStackTrace();
			            System.out.println(e.getMessage());
			        } catch ( IllegalAccessException e ) {
			            e.printStackTrace();
			            System.out.println(e.getMessage());
			        }
				
			} else if (args[k].startsWith("-p")){
				String fullParams = args[k].substring(2);
				String partParams[] = fullParams.split("|");
				for(int i = 0; i < partParams.length; i++){
					String param[] = partParams[i].split("-");
					Object aux = null;
					if(param[2].equals("Fixnum")){
						aux = new Integer(param[1]);
					} else if(param[2].equals("Long")){
						aux = new Long(param[1]);
					} else if(param[2].equals("Boolean")){
						aux = new Boolean(param[1]);
					} else if(param[2].equals("String")){
						aux = param[1];
					}
					params.put(param[0], aux);
				}
			}
		}

		JasperInterface jasperInterface = null;

		if(selectCriteria == null){
			jasperInterface = new JasperInterface(outputType, compiledDesign);
		} else {
			jasperInterface = new JasperInterface(outputType, compiledDesign, selectCriteria);
		}

		if (!jasperInterface.report()) {
			System.exit(1);
		}
	}

	public JasperInterface(String outputType, String compiledDesign, String selectCriteria) {
		this.outputType = outputType;
		this.compiledDesign = compiledDesign;
		this.selectCriteria = selectCriteria;
	}

	public JasperInterface(String outputType, String compiledDesign) {
		this.outputType = outputType;
		this.compiledDesign = compiledDesign;
	}

	public boolean report() {
		try {
			JasperPrint jasperPrint = (this.selectCriteria !=null) ?
					JasperFillManager.fillReport(compiledDesign, this.params, this.connection) :
						JasperFillManager.fillReport(compiledDesign, this.params, this.connection);

			if (TYPE_PDF.equals(outputType)) {
				JasperExportManager.exportReportToPdfStream(jasperPrint, System.out);
			}
			else if (TYPE_XML.equals(outputType)) {
				JasperExportManager.exportReportToXmlStream(jasperPrint, System.out);
			}
			else if (TYPE_RTF.equals(outputType)) {
				JRRtfExporter rtfExporter = new JRRtfExporter();
				rtfExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
				rtfExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, System.out);
				rtfExporter.exportReport();
			}
			else if (TYPE_XLS.equals(outputType)) {
				JRXlsExporter xlsExporter = new JRXlsExporter();
				xlsExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
				xlsExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, System.out);
				xlsExporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
				xlsExporter.exportReport();
			}
			else if (TYPE_CSV.equals(outputType)) {
				JRCsvExporter csvExporter = new JRCsvExporter();
				csvExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
				csvExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, System.out);
				csvExporter.exportReport();
			} 
			else if (TYPE_HTML.equals(outputType)) {
				JRHtmlExporter htmlExporter = new JRHtmlExporter();
				htmlExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
				htmlExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, System.out);
				htmlExporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, false);
				htmlExporter.exportReport();	    
			} else {
				printUsage();
			}
		} catch (JRException e) {
			e.printStackTrace();
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	private static void printUsage() {
		System.out.println("JasperInterface usage:");
		System.out.println("\tjava JasperInterface -oOutputType -fCompiledDesign -xSelectExpression < input.xml > report\n");
		System.out.println("\tOutput types:\t\tpdf | xml | rtf | xls | csv | html");
		System.out.println("\tCompiled design:\tFilename of the compiled Jasper design");
		System.out.println("\tSelect expression:\tXPath expression that specifies the select criteria");
		System.out.println("\t\t\t\t(See net.sf.jasperreports.engine.data.JRXmlDataSource for further information)");
		System.out.println("\tStandard input:\t\tXML input data");
		System.out.println("\tStandard output:\tReport generated by Jasper");
	}

}
