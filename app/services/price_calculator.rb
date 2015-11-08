class PriceCalculator

  def calculation_result(urls)
    grouped_urls = urls.group_by { |url| url.created_at.to_date }
    grouped_urls.map do |date, urls|
      count = urls.length
      {
        :date => date,
        :count => count,
        :price => calculate_price(count)
      }
    end
  end

  def calculate_price(count)
    daily_rate = count < 10 ? 0.1 : 0.05
    count * daily_rate
  end
end