module UsersHelper
  def get_gravator(user, options = {size: 80})
    email_address = user.email.downcase
    # create the md5 hash
    hash = Digest::MD5.hexdigest(email_address)
    
    # compile URL which can be used in <img src="RIGHT_HERE"...
    size = options[:size]
    image_src = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    
    image_tag(image_src, alt: user.username, class: 'rounded shadow mx-auto d-block')
  end
end

