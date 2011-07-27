#ENCODING: utf-8
module ApplicationHelper

	def getRaceName i

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
			else
				return "Peter"
		end

	end
	
	def getHP lvl, con, str, dex
		return 2 * lvl + 2 * con + str + dex
	end
	
	def getQ user
		i = 0
		if 0 < (user.lose + user.win)
			i = (user.win.to_f / (user.win + user.lose)).round_to(3)
		end
		return i
	end
	
	def nextLvl lvl
		exp = 0
		lvl.times do
			exp += 90
		end
		return exp
	end
	
end

class Float
    def round_to(i)
        f = (10 ** i).to_f
        nr = self * f
        return nr.round / f
    end
end
