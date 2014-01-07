require 'bovespa-prices'

module Business

	class Bovespa

		# Download the file with the Bovespa ISIN codes from 
		# http://www.bmfbovespa.com.br/consulta-isin/BuscaCodigosIsin.aspx?idioma=pt-br
		def download_isin_file
		end

		# Extract file NUMERACA.TXT and put in {root_path}/public/
		def extract_file
		end

		# === Extract all ISIN Bovespa codes
    # OBS: Use the last codes file downloading in Bovespa site
		def self.extract_codes
			@converter = Encoding::Converter.new("ISO-8859-1", "UTF-8")
			@codes = []

			begin
				if File.file?("/Users/marcosserpa/Desktop/Angel/Desenvolvimento/polarinvest/public/NUMERACA.TXT")
					File.open("/Users/marcosserpa/Desktop/Angel/Desenvolvimento/polarinvest/public/NUMERACA.TXT", "r").each_line do |line|
						line = @converter.convert(line)

						unless !line.present?
							if line.match(/OPCAO DE VENDA DE ACOES/) || line.match(/OPCAO DE COMPRA DE ACOES/)
								code = line.match(/BR[^\,]*/)[0].chop.slice(2, 5).to_sym

								unless @codes.include?(code)
									@codes << code
								end
							end
						end
					end

					puts " ====================== "
					puts "ISIN codes file read"
					puts " ====================== "
				else
					puts "There is no file in path {root_path}/public/NUMERACA.TXT"
				end
			rescue Exception => e
				puts "Error converting the file"
			end

			return @codes
		end

		# Returns the fifteen minutes ago share market situation
		def self.fetch_codes
			# TODO Make a way of use this method to get the codes from the file. 
			# We can't pass this way below, EXPLICIT. That make me sick!
			#extract_codes

			bovespa = ::Bovespa.new
			bovespa.get(:ABEV3, :AEDU3, :ALLL3, :ALPA4, :ALSC3, :AMAR3, :AMBV3, :AMBV4, :ARTR3, :BBAS3, :BBDC3, :BBDC4, :BBRK3, 
									:BBSE3, :BEEF3, :BISA3, :BRAP4, :BRFS3, :BRIN3, :BRKM5, :BRML3, :BRPR3, :BRSR6, :BSEV3, :BTOW3, :BVMF3,
									:CCRO3, :CCXC3, :CESP6, :CIEL3, :CMIG4, :CPFE3, :CPLE6, :CRUZ3, :CSAN3, :CSMG3, :CSNA3, :CTIP3, :CYRE3,
									:DASA3, :DIRR3, :DTEX3, :ECOR3, :ELET3, :ELET6, :ELPL4, :EMBR3, :ENBR3, :ENEV3, :EQTL3, :ESTC3, :EVEN3,
									:EZTC3, :FIBR3, :FLRY3, :GETI4, :GFSA3, :GGBR4, :GOAU4, :GOLL4, :GRND3, :HGTX3, :HRTP3, :HYPE3, :IGTA3,
									:ITSA4, :ITUB3, :ITUB4, :JBSS3, :JFEN3, :JHSF3, :KLBN4, :KROT3, :LAME4, :LIGT3, :LLIS3, :LLXL3, :LPSB3,
									:LREN3, :MDIA3, :MILS3, :MMXM3, :MPLU3, :MRFG3, :MRVE3, :MULT3, :MYPK3, :NATU3, :ODPV3, :OGXP3, :OIBR3,
									:OIBR4, :OSXB3, :PCAR4, :PDGR3, :PETR3, :PETR4, :POMO4, :PSSA3, :QGEP3, :QUAL3, :RADL3, :RAPT4, :RENT3,
									:RSID3, :SBSP3, :SLCE3, :SUZB5, :TBLE3, :TCSA3, :TIMP3, :TOTS3, :TRPL4, :UGPA3, :USIM3, :USIM5, :VAGR3,
									:VALE3, :VALE5, :VIVT4, :VLID3, :WEGE3)
		end

		# Returns the share values history of one year (in the file's name) and save in DB
		def self.fetch_history_values
			# TODO Fix the folder location with the real files folder location on server
			File.open("/Users/marcosserpa/Desktop/Angel/COTAHIST_A2012.TXT", "r") do |file_handle|
			 	file_handle.each do |line|
			  	if line[0..1] == "01" and line[24..26].strip == '010'
			  		# Find or create the share
			  		asset = find_share(line[12..23].strip, line[27..38].strip)

			  		# Creates the asset
			     	asset = AssetTypes::Share.find_or_create_by(ticker: line[12..23].strip, name: line[27..38].strip)

			  		# Find or create the share
			  		asset = find_share(line[12..23].strip, line[27..38].strip)

						save_history_values(line, asset)
			   	end
			 	end
			end

			puts " ================ "
			puts "Historic values saved"
			puts " ================ "
		end

		def self.find_share(ticker, name)
			AssetTypes::Share.find_or_create_by(ticker: ticker, name: name)
		end

		def self.save_history_values(line, asset)
			percentage_delta = ((line[108..120].strip.to_f / 100) / (line[56..68].strip.to_f / 100) - 1) * 100
			value_delta = (line[108..120].strip.to_f / 100) / (line[56..68].strip.to_f / 100)
			value = ((line[108..120].strip.to_f)/1000000).round(2) # HOUSTON: WE HAVE A PROBLEM!

			# if asset.ticker == "BFRE11" && Date.strptime(line[2..9].strip, '%Y%m%d').to_s.eql?("2012-07-16")
			# 	binding.pry
			# end

			RecordTypes::Share.create(asset_id: asset.id, date: Date.strptime(line[2..9].strip, '%Y%m%d'), 
																percentage_delta: percentage_delta.round(5), value_delta: value_delta.round(5), 
																value: value.round(5))
		end

		def self.save_daily_values
		end
	end

end
