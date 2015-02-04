require 'spec_helper'

RSpec.describe Proz::Profile do

  it 'should return the full profile of a user given an access token' do
    VCR.use_cassette 'profile_query' do
      profile = Proz::Profile.new(token: 'q76470e1fb5e5c0347c3a7393f6312fd980096ae')
      expect(profile.profile).to eq({"uuid"=>"7bbfdd74-a2a4-484f-8dbc-215a67026ce1", "site_name"=>"Kevin Dias", "profile_url"=>"http://www.proz.com/profile/1979687", "contact_info"=>{"first_name"=>"Kevin", "middle_name"=>nil, "last_name"=>"Dias"}, "skills"=>{"language_pairs"=>[], "general_disciplines"=>[{"disc_gen_id"=>1, "disc_gen_name"=>"Tech/Engineering"}, {"disc_gen_id"=>2, "disc_gen_name"=>"Art/Literary"}, {"disc_gen_id"=>3, "disc_gen_name"=>"Medical"}, {"disc_gen_id"=>4, "disc_gen_name"=>"Law/Patents"}, {"disc_gen_id"=>5, "disc_gen_name"=>"Science"}, {"disc_gen_id"=>6, "disc_gen_name"=>"Bus/Financial"}, {"disc_gen_id"=>7, "disc_gen_name"=>"Marketing"}, {"disc_gen_id"=>8, "disc_gen_name"=>"Other"}, {"disc_gen_id"=>9, "disc_gen_name"=>"Social Sciences"}], "specific_disciplines"=>[]}})
    end
  end

  it 'should return the uuid of a user given an access token' do
    VCR.use_cassette 'profile_query' do
      profile = Proz::Profile.new(token: 'q76470e1fb5e5c0347c3a7393f6312fd980096ae')
      expect(profile.uuid).to eq('7bbfdd74-a2a4-484f-8dbc-215a67026ce1')
    end
  end

  it 'should return the site_name of a user given an access token' do
    VCR.use_cassette 'profile_query' do
      profile = Proz::Profile.new(token: 'q76470e1fb5e5c0347c3a7393f6312fd980096ae')
      expect(profile.site_name).to eq('Kevin Dias')
    end
  end

  it 'should return the profile_url of a user given an access token' do
    VCR.use_cassette 'profile_query' do
      profile = Proz::Profile.new(token: 'q76470e1fb5e5c0347c3a7393f6312fd980096ae')
      expect(profile.profile_url).to eq('http://www.proz.com/profile/1979687')
    end
  end

  it 'should return an error is the access token is invalid' do
    VCR.use_cassette 'profile_query_invalid_access_token' do
      profile = Proz::Profile.new(token: 'q76470e1fb5e5c0347c3a7393f6312fd980096ae')
      expect { profile.profile_url }.to raise_error('Invalid Token')
    end
  end

  it 'should return an error is the access token is expired' do
    VCR.use_cassette 'profile_query_access_token_expired' do
      profile = Proz::Profile.new(token: '4b89e678e8670bca496c9bd80d8b09b87c10d605')
      expect { profile.profile_url }.to raise_error('Access Token Expired')
    end
  end
end