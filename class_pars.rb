require 'nokogiri'

class OZ
    
    @@content_arr = []
    @@arr_xpath = {
        url: ".//a[@class='g-pagination__list__item']//@href",
        items: "//div[@class='item-type-card__item']",
        promo: ".//span[@class='product-label product-label_chance']",
        link: ".//a[@class='item-type-card__link']//@href",
        title: ".//p[@class='item-type-card__title']",
        brend: ".//p[@class='item-type-card__info']",
        url_img: ".//img[@class='viewer-type-list__img']//@src",
        price: ".//span[@class='item-type-card__btn']",
        brodcram: "//div[@class='breadcrumbs__inner']//span"
    }

    def object(html)
        @soup = Nokogiri::HTML(html)
    end

    def parse(brodcram)
        url_domen = 'https://oz.by'
        url = url_domen + @soup.at(@@arr_xpath[:url])
        @soup.xpath(@@arr_xpath[:items]).each do |element|
            if element.at(@@arr_xpath[:promo])
                promo = element.at(@@arr_xpath[:promo]).content  
            else
                promo = '-'
            end
            @@content_arr.push({
                brodcrams: brodcram,
                link: url_domen + element.at(@@arr_xpath[:link]).to_s,
                title: element.at(@@arr_xpath[:title]).text.strip, 
                brend: element.at(@@arr_xpath[:brend]).text.strip,
                promo: promo,
                url_img: element.at(@@arr_xpath[:url_img]).to_s,
                price: element.at(@@arr_xpath[:price]).text.strip
            })    
        end
        return url, @@content_arr
    end

    def breadcrumbs()
        name_category = @soup.at("//h1[@class='breadcrumbs__list__item']//span").text.strip
        arr_brodcrams = []
        @soup.xpath(@@arr_xpath[:brodcram]).each do |element|
            arr_brodcrams.push(element.text)
        end
        str_brodcram = arr_brodcrams.join(">")
        return str_brodcram, name_category
    end


    def go(html)
        object(html)
        brodcram, name_category = breadcrumbs()
        url, arry_content = parse(brodcram)
        return url, arry_content, name_category
    end
end