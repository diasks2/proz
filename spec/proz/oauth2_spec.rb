require 'spec_helper'

RSpec.describe Proz::OAuth2 do

  it 'sets the client_id' do
    oauth2 = Proz::OAuth2.new(client_id: 'abcdef', client_secret: 'xyz123', redirect_uri: 'https://www.example.com')
    expect(oauth2.client_id).to eq('abcdef')
  end

  it 'sets the client_secret' do
    oauth2 = Proz::OAuth2.new(client_id: 'abcdef', client_secret: 'xyz123', redirect_uri: 'https://www.example.com')
    expect(oauth2.client_secret).to eq('xyz123')
  end

  it 'sets the redirect_uri' do
    oauth2 = Proz::OAuth2.new(client_id: 'abcdef', client_secret: 'xyz123', redirect_uri: 'https://www.example.com')
    expect(oauth2.redirect_uri).to eq('https://www.example.com')
  end

  it 'returns a response' do
    proz = Proz::Profile.new(token: '9d2ecb46da86049b8305575cb9b1d94111eb9ed')
    expect(proz.profile).to eq({"uuid"=>"7bbfdd74-a2a4-484f-8dbc-215a67026ce1", "site_name"=>"Kevin Dias", "profile_url"=>"http://www.proz.com/profile/1979687", "contact_info"=>{"first_name"=>"Kevin", "middle_name"=>nil, "last_name"=>"Dias"}, "skills"=>{"language_pairs"=>[], "general_disciplines"=>[{"disc_gen_id"=>1, "disc_gen_name"=>"Tech/Engineering"}, {"disc_gen_id"=>2, "disc_gen_name"=>"Art/Literary"}, {"disc_gen_id"=>3, "disc_gen_name"=>"Medical"}, {"disc_gen_id"=>4, "disc_gen_name"=>"Law/Patents"}, {"disc_gen_id"=>5, "disc_gen_name"=>"Science"}, {"disc_gen_id"=>6, "disc_gen_name"=>"Bus/Financial"}, {"disc_gen_id"=>7, "disc_gen_name"=>"Marketing"}, {"disc_gen_id"=>8, "disc_gen_name"=>"Other"}, {"disc_gen_id"=>9, "disc_gen_name"=>"Social Sciences"}], "specific_disciplines"=>[]}})
  end
end
