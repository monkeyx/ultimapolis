module GlyphHelper
	def glyph_check_or_cross(boolfield)
 		return glyph = (if boolfield
 			"<span class=\"glyphicon glyphicon-ok\" aria-hidden=\"true\"></span>"
 		else
 			"<span class=\"glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>"
 		end).html_safe
 	end
end