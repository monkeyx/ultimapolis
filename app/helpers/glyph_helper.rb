module GlyphHelper
	def glyph_check_or_cross(boolfield)
		if boolfield
			glyph_icon('ok')
		else
			glyph_icon('remove')
		end
 	end

 	def glyph_icon(icon, text=nil)
 		"<span class=\"glyphicon glyphicon-#{icon}\" aria-hidden=\"true\">#{text}</span>".html_safe
 	end
end