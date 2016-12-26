require 'rails_helper'
require 'spec_helper'


describe LinksController, :type => :request do
  it 'check the index page' do
    get '/'
    expect(response).to render_template(:index)
    expect(response.body).to include("Please enter your link")
    expect(response.status).to eql 200
  end

  it 'create short link' do
    post '/', params: { link: { origin: "blablabla.com" } }
    expect(response).to render_template(:index)
    expect(response.body).to include('Short link has been successfully generated')
    expect(response.body).to include('Please, copy the link below and put it into the address browser bar')
  end

  it 'check redirecting' do
    post '/', params: { link: { origin: "google.com" } }
    expect(response.status).to eql 200
    get "/#{Link.last.shorten}"
    expect(response.status).to eql 302
    expect(response).to redirect_to 'http://google.com'
  end


  context 'negative tests' do
    it 'create link with empty param' do
      post '/', params: { link: { origin: "" } }
      expect(response.status).to eql 200
      expect(response.body).to include('Invalid input')
      expect(response.body).to include('Please review the problem(s) below:')
      expect(response.body).to include('can&#39;t be blank')
    end

    it 'create link with short param' do
      post '/', params: { link: { origin: "olx" } }
      expect(response.status).to eql 200
      expect(response.body).to include('Invalid input')
      expect(response.body).to include('Please review the problem(s) below:')
      expect(response.body).to include('is too short (minimum is 4 characters)')
    end

    it 'get incorrect short link' do
      get "/test_no_exist_link"
      expect(response.status).to eql 302
    end
  end
end