require './class_pars.rb'
require './class_get.rb'
require'./class_save'
url = ARGV[0]

pars = OZ.new
zapros = Requests_zapros.new
save = Save.new

content = []
name = ''
def save_content(content)
    save = Save.new
    save.save_file(content)
end

1.times do
    html = zapros.get_requsts(url)
    url, content_arr, name_category = pars.go(html.body_str)
    content = content_arr
    name = name_category    
end
save.save_file(content, name)


