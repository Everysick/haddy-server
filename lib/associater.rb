# coding: utf-8
class Associater
  def build(url, tag)
    code = get_product_code(url)
    get_product_association_url(code, tag)
  end

  private
  def get_product_code(url)
    url.split('/').last
  end

  def get_product_association_url(product_code, associate_tag)
    Googl.shorten('http://www.amazon.co.jp/gp/product/' +
                  product_code +
                  '?tag=' +
                  associate_tag
                 ).short_url    
  end 
end
