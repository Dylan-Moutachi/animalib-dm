class GetProfessionalFromYelp
  def initialize(profession_name: 'pet setting', location: 'Paris')
    @profession_name = profession_name
    @location = location
  end

  def call
    connection = Faraday.new(
      params: params,
      headers: headers
    )
    response = connection.get("https://api.yelp.com/v3/businesses/search")
    return unless response.success?

    @professionals_data = JSON.parse(response.body)['businesses']
    return @professionals_data.map { |professional_datum| clean_professional_data(professional_datum) }
  end

  private

  def clean_professional_data(professional_datum)
    company_name = professional_datum['name']
    address = professional_datum['location']['display_address'].join(', ')
    phone_number = professional_datum['phone']
    {
      company_name: company_name,
      address: address,
      phone_number: phone_number
    }
  end

  def params
    {
      location: @location,
      term: @profession_name,
      limit: 50
    }
  end

  def headers
    {
      'Authorization': "Bearer #{ENV["YELP_API_KEY"]}",
      'Accept': 'application/json'
    }
  end

end

GetProfessionalFromYelp.new(profession_name: "restaurant").call
