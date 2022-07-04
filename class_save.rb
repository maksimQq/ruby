class Save
    def save_file(data, name)
        file = File.new("#{name}.csv", 'a')
        file.puts "|link | title | brodcrams | brend | promo | url_img | price|"
        data.each do |item|
            file.puts("|#{item[:link]} | #{item[:title]} | #{item[:brodcrams]} | #{item[:brend]} | #{item[:promo]} | #{item[:url_img]} | #{item[:price]}|")
        end
        file.close
    end
end