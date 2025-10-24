
puts "Criando categorias padrão..."

categories_names = [ "Ação", "Comédia", "Drama", "Ficção Científica", "Terror", "Suspense", "Animação", "Aventura", "Romance" ]

categories_names.each do |name|
  Category.find_or_create_by!(name: name)
end

puts "Categorias criadas com sucesso!"
