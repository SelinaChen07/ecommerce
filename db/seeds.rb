# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#https://world.taobao.com/item/543407581441.htm?fromSite=main&ali_refid=a3_430009_1006:1123056711:N:%E7%85%A7%E7%89%87%E7%9B%92%E5%AD%90:ab4d13acc02a9ad71f74817cf12382d9&ali_trackid=1_ab4d13acc02a9ad71f74817cf12382d9&spm=a230r.1.0.0.ebb2eb20JFcZJ
product1 = Product.create(title:"Memories All-in-one Photographic Film", abstract:"Put the moments to remember in one colored photographic film.", description: "Put the moments to remember in one colored photographic film.", price: 20.00)
photo11 = product1.photos.new
photo11.remote_image_url="https://gd2.alicdn.com/bao/uploaded/i2/1063365086/TB27g0eXwUc61BjSZFoXXac1FXa_!!1063365086.jpg"
photo11.save

photo12 = product1.photos.new
photo12.remote_image_url="https://gd2.alicdn.com/bao/uploaded/i2/1063365086/TB27g0eXwUc61BjSZFoXXac1FXa_!!1063365086.jpg"
photo12.save

photo13 = product1.photos.new
photo13.remote_image_url="https://gd3.alicdn.com/bao/uploaded/i3/1063365086/TB2ba5haSFjpuFjSszhXXaBuVXa_!!1063365086.jpg"
photo13.save

photo14 = product1.photos.new
photo14.remote_image_url="https://gd4.alicdn.com/bao/uploaded/i4/1063365086/TB2K.swXaryQeBjSszdXXaL.XXa_!!1063365086.jpg"
photo14.save


#https://world.taobao.com/item/10259406708.htm?fromSite=main&ali_refid=a3_430582_1006:1103183911:N:%E8%BD%AF%E9%99%B6%E5%85%AC%E4%BB%94:747cf7159662d739e662c953865a6447&ali_trackid=1_747cf7159662d739e662c953865a6447&spm=a230r.1.14.6.ebb2eb2Leu1zL#detail
product2 = Product.create(title:"Your Own Design Colored Clay Figure", abstract:"You provide the photo, we make it to real.", description: "We make the colored clay figure based on the photo you provided. Every work is unique.", price: 80.00)

photo21 = product2.photos.new
photo21.remote_image_url="https://img.alicdn.com/bao/uploaded/i3/440726740/TB2AUdJnwJlpuFjSspjXXcT.pXa_!!440726740.jpg"
photo21.save

photo22 = product2.photos.new
photo22.remote_image_url="https://gd3.alicdn.com/bao/uploaded/i3/440726740/TB2.5WFfH_0UKFjy1XaXXbKfXXa_!!440726740.jpg"
photo22.save

photo23 = product2.photos.new
photo23.remote_image_url="https://gd2.alicdn.com/bao/uploaded/i2/440726740/TB2N2A9nbXlpuFjSszfXXcSGXXa_!!440726740.jpg"
photo23.save


#https://world.taobao.com/item/543833763410.htm?fromSite=main&spm=a230r.1.14.13.ebb2eb20JFcZJ&ns=1&abbucket=10#detail
product3= Product.create(title:"Crystal Photo Frame", abstract:"Beautiful crystal photo frame is the one you deserve.", description: "Put your photo in this beautiful photo frame.", price: 40.00)

photo31 = product3.photos.new
photo31.remote_image_url="https://gd4.alicdn.com/bao/uploaded/i4/2886982684/TB2sD8WbYJmpuFjSZFBXXXaZXXa_!!2886982684.jpg"
photo31.save

photo32 = product3.photos.new
photo32.remote_image_url="https://gd3.alicdn.com/bao/uploaded/i3/2886982684/TB2_aJObYJmpuFjSZFwXXaE4VXa_!!2886982684.jpg"
photo32.save

photo33 = product3.photos.new
photo33.remote_image_url="https://gd1.alicdn.com/bao/uploaded/i1/2886982684/TB2Ty98brplpuFjSspiXXcdfFXa_!!2886982684.jpg"
photo33.save

photo34 = product3.photos.new
photo34.remote_image_url="https://gd1.alicdn.com/bao/uploaded/i1/2886982684/TB2Dq0Mb4tmpuFjSZFqXXbHFpXa_!!2886982684.jpg"
photo34.save

category1 = Category.create(name: "Photo Products")
category2 = Category.create(name: "Jewelry")
category3 = Category.create(name: "For Him")
category4 = Category.create(name: "For Her")
category5 = Category.create(name: "For the Bubs")
category6 = Category.create(name: "On Sale")
