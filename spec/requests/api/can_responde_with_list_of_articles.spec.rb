RSpec.describe 'GET /api/articles', type: :request do
  describe 'successfully' do
    let!(:article1) { create(:article, title: 'Second Article', created_at: Time.now-100000) }
    let!(:article2) { create(:article, title: 'First Article', created_at: Time.now-200000) }
    let!(:article3) { create(:article, title: 'Third Article', created_at: Time.now) }
    before do
      get '/api/articles'
    end

    it 'is expected to return 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to have lenght of 3 articles' do
      expect(response_json['articles'].count).to eq 3
    end

    it 'is expected to have a title' do
      expect(response_json['articles'].first['title']).to eq 'First title'
    end

    it 'is expected that the article has a teaser text' do
      expect(response_json['articles'].first['teaser']).to eq 'some text'
    end

    it 'is expected to contain dates' do
      expect(response_json['articles'].first['created_at']).to eq '2021-05-11'
    end

    it 'is expected to return lists with newest articles first' do
      expect(response_json['articles'].first['title']).to eq 'Third article'
    end
  end
end
