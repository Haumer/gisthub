if Rails.env.development?

  Language.destroy_all

  User.all.destroy_all
  users = %w(barangerbenjamin roosce lucien-george julioeq ssaunier)
  users.each do |user|
    User.create(
      email: "#{user}@gmail.com",
      password: "123456",
      githubname: user
    )
  end
end

Language.create(name: "Ruby", img_url: "https://img.icons8.com/office/64/000000/ruby-programming-language.png")
Language.create(name: "JavaScript", img_url: "https://img.icons8.com/color/64/000000/javascript.png")
Language.create(name: "Python", img_url: "https://img.icons8.com/color/64/000000/python.png")
Language.create(name: "HTML", img_url: "https://img.icons8.com/color/64/000000/html-5.png")
Language.create(name: "Scss", img_url: "https://img.icons8.com/color/64/000000/css3.png")
Language.create(name: "Css", img_url: "https://img.icons8.com/color/64/000000/css3.png")
Language.create(name: "Text", img_url: "https://img.icons8.com/ios-glyphs/64/000000/text.png")
Language.create(name: "Markdown", img_url: "https://img.icons8.com/officel/64/000000/markdown.png")
Language.create(name: "CSV", img_url: "https://img.icons8.com/color/64/000000/csv.png")
Language.create(name: "JSON", img_url: "https://img.icons8.com/color/64/000000/json.png")
Language.create(name: "XML", img_url: "https://img.icons8.com/color/64/000000/xml.png")
Language.create(name: "SQL", img_url: "https://img.icons8.com/color/64/000000/sql.png")
Language.create(name: "HTML+ERB", img_url: "https://img.icons8.com/office/64/000000/ruby-programming-language.png")
