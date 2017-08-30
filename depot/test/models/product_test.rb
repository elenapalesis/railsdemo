require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
	test "product attributes must not be empty" do
		product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:price].any?
		assert product.errors[:image_url].any?
	end

	test "product price must be positive" do
		product = Product.new(title: "My Book Title",
							  description: "<p>Here we describe</p>",
							  image_url: "img.jpg")

		product.price = -1
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

		product.price = 0
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

		product.price = 1
		assert product.valid?
	end

	def new_product(image_url)
		Product.new(title: "My Book Title",
					description: "<p>This is quite the book!</p>",
					price: 1,
					image_url: image_url)
	end

	test "image url must be in correct format" do
		ok = %w{ elena.gif elena.jpg elena.png ELENA.JPG ELENA.Jpg http://abc.com/elena.jpg}
		bad = %w{ elena.doc elena.gif/more elena.gif.more }

		ok.each do |name|
			assert new_product(name).valid?, "#{name} should be valid"
		end

		bad.each do |name|
			assert new_product(name).invalid?, "#{name} should be invalid"
		end
	end

	test "product is not valid without a unique title - i18n" do
		product = Product.new(title: products(:ruby).title,
							  description: "i describe",
							  price: 1,
							  image_url: "fred.gif")
		assert product.invalid?
		assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
	end
end
