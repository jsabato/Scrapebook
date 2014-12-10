require 'nokogiri'
require 'open-uri'
enable :sessions

get '/' do
  if logged_in?
    erb :index
  else
    redirect '/login'
  end
end

get '/looking' do
  return params['item']
end

get '/login' do
  erb :login
end

post '/login' do
  p params[:email].length
  if params[:email] != "" && params[:password] != ""
    user = User.find_by(email: params[:email])
    if user.password == BCrypt::Engine.hash_secret(params[:password], user[:salt])
      session[:user_id] = user.email
      redirect '/'
    else
      redirect '/login'
    end
  else
    redirect '/login'
  end
end

get '/register' do
  erb :register
end

post '/register' do
  if params[:password].length >= 6
    @password_salt = BCrypt::Engine.generate_salt
    @password_hash = BCrypt::Engine.hash_secret(params[:password], @password_salt)
    @user = User.create(password: @password_hash, email: params[:email], salt: @password_salt)
    if @user.errors.size > 0
      erb :create_error
    else
      session[:user_id] = @user.email
      redirect '/'
    end
  else
    @user = User.create(params)
    erb :create_error
  end
end

post '/found' do
  @link = []
  @image = []
  @price = []
  @name = []
  @item = params[:key]
  page = Nokogiri::HTML(open("http://www.newegg.com/Product/ProductList.aspx?Submit=ENE&DEPA=0&Order=BESTMATCH&Description=#{@item}&N=-1&isNodeId=1"))

  @item_page_link = page.css(".itemCell").css(".itemImage")
  @item_page_link.each{|link| @link << link['href']}

  @item_image = page.css(".itemCell").css(".itemImage").css("img")
  @item_image.each{|link| @image << link['src']}

  @item_price = page.css(".itemAction").css('input[name="priceBefore"]')
  @item_price.each{|link| @price << link['value']}

  @item_name = page.css(".itemCell").css(".itemImage")
  @item_name.each{|link| @name << link['title']}

  content_type 'json'
 { link: @link, image: @image, price: @price, name: @name }.to_json
end

get '/logOut' do
  session[:user_id] = nil
  redirect '/'
end