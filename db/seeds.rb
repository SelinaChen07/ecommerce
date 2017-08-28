# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#https://world.taobao.com/item/543407581441.htm?fromSite=main&ali_refid=a3_430009_1006:1123056711:N:%E7%85%A7%E7%89%87%E7%9B%92%E5%AD%90:ab4d13acc02a9ad71f74817cf12382d9&ali_trackid=1_ab4d13acc02a9ad71f74817cf12382d9&spm=a230r.1.0.0.ebb2eb20JFcZJ
product1 = Product.create(title:"Memories All-in-one Photographic Film", abstract:"Put the moments to remember in one colored photographic film.", description: "Put the moments to remember in one colored photographic film.", price: 20.00)

#https://world.taobao.com/item/10259406708.htm?fromSite=main&ali_refid=a3_430582_1006:1103183911:N:%E8%BD%AF%E9%99%B6%E5%85%AC%E4%BB%94:747cf7159662d739e662c953865a6447&ali_trackid=1_747cf7159662d739e662c953865a6447&spm=a230r.1.14.6.ebb2eb2Leu1zL#detail
product2 = Product.create(title:"Your Own Design Colored Clay Figure", abstract:"You provide the photo, we make it to real.", description: "We make the colored clay figure based on the photo you provided. Every work is unique.", price: 80.00)

#https://world.taobao.com/item/543833763410.htm?fromSite=main&spm=a230r.1.14.13.ebb2eb20JFcZJ&ns=1&abbucket=10#detail
product3= Product.create(title:"Crystal Photo Frame", abstract:"Beautiful crystal photo frame is the one you deserve.", description: "Put your photo in this beautiful photo frame.", price: 40.00)
