# coding: utf-8
class Associater
  def build(url, tag=nil)
    code = get_product_code(url)
    if tag.blank?
      get_product_association_url(code)
    else
      get_product_association_url_with_tag(code, tag)
    end
  end
  
  private
  def get_product_code(url)
    url.split('/').last
  end

  def get_product_association_url(product_code)
    Googl.shorten('http://www.amazon.co.jp/gp/product/' +
                  product_code
                 ).short_url
  end
  
  def get_product_association_url_with_tag(product_code, associate_tag)
    Googl.shorten('http://www.amazon.co.jp/gp/product/' +
                  product_code +
                  '?tag=' +
                  associate_tag
                 ).short_url    
  end 
end
