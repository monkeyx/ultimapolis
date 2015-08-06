# Initial Admin
admin = User.create(email: 'admin@ultimapolis.com', password: 'password', password_confirmation: 'password', role: 'admin')
admin.skip_confirmation!
admin.save!

# Global

# Districts

