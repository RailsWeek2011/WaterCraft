#ENCODING: utf-8

module WC
	def self.getRaceName i

		case i
			when 0
				return "Kugelfisch"
			when 1
				return "Seestern"
			when 2
				return "Koralle"
			when 3
				return "Schwertfisch"
			when 4
				return "Piranha"
			when 5
				return "Schwamm"
			when 6
				return "Schildkröte"
			when 7
				return "Frosch"
			when 8
				return "Seepferd"
			when 9
				return "Seekuh"
			when 10
				return "Krabbe"
			when 11
				return "Muschel"
			when 12
				return "Tintenfisch"
			when 13
				return "Thunfisch"
			when 14
				return "Qualle"
			when 15
				return "Anglerfisch"
			when 16
			else
				return "Peter"
		end

	end
end
