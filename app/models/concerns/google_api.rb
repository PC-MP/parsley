module GoogleApi
  FetchError = Class.new(RuntimeError)

  def self.fetch_and_map_book_info(isbn, mapping = {})
    info = fetch_book_info(isbn)
    json = info.to_json
    default_mapper.merge(mapping).inject({}) do |hash, (key, path)|
      value = JsonPath.new(path).on(json)
      hash[key] = value.is_a?(Array) ? value.first : value
      hash
    end.merge(json: json)
  end

  def self.fetch_book_info(isbn)
    res = client.get('https://www.googleapis.com/books/v1/volumes', q: "isbn:#{isbn}")
    raise FetchError, 'ISBN error.' if res.body['totalItems'] != 1
    res.body['items'].first
  rescue Faraday::Error => e
    raise FetchError, e.message
  end

  def self.client
    Faraday.new do |conn|
      conn.response :json, :content_type => /\bjson$/
      conn.response :raise_error
      conn.adapter Faraday.default_adapter
    end
  end

  def self.default_mapper
    {
      isbn10:    '$.volumeInfo.industryIdentifiers[?(@["type"] == "ISBN_10")].identifier',
      isbn13:    '$.volumeInfo.industryIdentifiers[?(@["type"] == "ISBN_13")].identifier',
      title:     '$.volumeInfo.title',
      image_url: '$.volumeInfo.imageLinks.thumbnail'
    }
  end
end