require 'spec_helper'

RSpec.describe Proz::Freelancer do

  it 'must have the base url set to the ProZ API endpoint' do
    expect(Proz::Freelancer.base_uri).to eq('https://api.proz.com/v2')
  end

  it 'returns an error if the key is invalid' do
    VCR.use_cassette 'invalid_key' do
      freelancer = Proz::Freelancer.new(key: 'yyyyyyyyy', uuid: '663e4488-58a1-4713-992c-c6d90aafa3cb')
      expect { freelancer.freelancer }.to raise_error("Invalid API Key")
    end
  end

  it 'returns a freelancer' do
    VCR.use_cassette 'freelancer' do
      freelancer = Proz::Freelancer.new(key: 'xxxxxxxxxx', uuid: '663e4488-58a1-4713-992c-c6d90aafa3cb')
      expect(freelancer.freelancer).to eq({"uuid"=>"663e4488-58a1-4713-992c-c6d90aafa3cb", "site_name"=>"Smartranslators", "profile_url"=>"http://www.proz.com/profile/76374", "contact_info"=>{}, "skills"=>{"language_pairs"=>[{"pair_code"=>"eng_esl", "pair_name"=>"English to Spanish", "services"=>[{"service_id"=>1, "service_name"=>"Translation"}, {"service_id"=>2, "service_name"=>"Checking/editing"}, {"service_id"=>3, "service_name"=>"Interpreting, Consecutive"}, {"service_id"=>4, "service_name"=>"Interpreting, Simultaneous"}, {"service_id"=>5, "service_name"=>"Voiceover"}, {"service_id"=>6, "service_name"=>"Summarization"}, {"service_id"=>7, "service_name"=>"Education"}, {"service_id"=>8, "service_name"=>"Interpreting, Chuchotage/Whispering"}]}, {"pair_code"=>"esl_eng", "pair_name"=>"Spanish to English", "services"=>[{"service_id"=>1, "service_name"=>"Translation"}, {"service_id"=>2, "service_name"=>"Checking/editing"}]}, {"pair_code"=>"fra_esl", "pair_name"=>"French to Spanish", "services"=>[{"service_id"=>1, "service_name"=>"Translation"}, {"service_id"=>2, "service_name"=>"Checking/editing"}]}], "general_disciplines"=>[{"disc_gen_id"=>1, "disc_gen_name"=>"Tech/Engineering"}, {"disc_gen_id"=>4, "disc_gen_name"=>"Law/Patents"}, {"disc_gen_id"=>6, "disc_gen_name"=>"Bus/Financial"}, {"disc_gen_id"=>7, "disc_gen_name"=>"Marketing"}, {"disc_gen_id"=>8, "disc_gen_name"=>"Other"}], "specific_disciplines"=>[{"disc_spec_id"=>159, "disc_spec_name"=>"Automation & Robotics", "expertise_level"=>"specialty"}, {"disc_spec_id"=>32, "disc_spec_name"=>"Economics", "expertise_level"=>"specialty"}, {"disc_spec_id"=>26, "disc_spec_name"=>"Construction / Civil Engineering", "expertise_level"=>"specialty"}, {"disc_spec_id"=>25, "disc_spec_name"=>"Computers: Systems, Networks", "expertise_level"=>"specialty"}, {"disc_spec_id"=>24, "disc_spec_name"=>"Computers: Software", "expertise_level"=>"specialty"}, {"disc_spec_id"=>23, "disc_spec_name"=>"Computers: Hardware", "expertise_level"=>"specialty"}, {"disc_spec_id"=>77, "disc_spec_name"=>"Law (general)", "expertise_level"=>"specialty"}, {"disc_spec_id"=>15, "disc_spec_name"=>"Business/Commerce (general)", "expertise_level"=>"specialty"}, {"disc_spec_id"=>147, "disc_spec_name"=>"Computers (general)", "expertise_level"=>"specialty"}, {"disc_spec_id"=>48, "disc_spec_name"=>"Finance (general)", "expertise_level"=>"specialty"}, {"disc_spec_id"=>68, "disc_spec_name"=>"IT (Information Technology)", "expertise_level"=>"working"}, {"disc_spec_id"=>75, "disc_spec_name"=>"Law: Contract(s)", "expertise_level"=>"working"}, {"disc_spec_id"=>1, "disc_spec_name"=>"Accounting", "expertise_level"=>"working"}, {"disc_spec_id"=>6, "disc_spec_name"=>"Architecture", "expertise_level"=>"working"}, {"disc_spec_id"=>34, "disc_spec_name"=>"Electronics / Elect Eng", "expertise_level"=>"working"}]}})
    end
  end

  it 'returns an error if the uuid is invalid' do
    VCR.use_cassette 'invalid_uuid' do
      freelancer = Proz::Freelancer.new(key: 'xxxxxxxxx', uuid: 'xxxxx')
      expect { freelancer.site_name }.to raise_error("No freelancer was found with that UUID")
    end
  end

  it "returns a freelancer's uuid" do
    VCR.use_cassette 'freelancer' do
      freelancer = Proz::Freelancer.new(key: 'xxxxxxxxxx', uuid: '663e4488-58a1-4713-992c-c6d90aafa3cb')
      expect(freelancer.uuid).to eq('663e4488-58a1-4713-992c-c6d90aafa3cb')
    end
  end

  it "returns a freelancer's site_name" do
    VCR.use_cassette 'freelancer' do
      freelancer = Proz::Freelancer.new(key: 'xxxxxxxxxx', uuid: '663e4488-58a1-4713-992c-c6d90aafa3cb')
      expect(freelancer.site_name).to eq('Smartranslators')
    end
  end

  it "returns a freelancer's language_pairs" do
    VCR.use_cassette 'freelancer' do
      freelancer = Proz::Freelancer.new(key: 'xxxxxxxxxx', uuid: '663e4488-58a1-4713-992c-c6d90aafa3cb')
      expect(freelancer.skills['language_pairs']).to eq([{"pair_code"=>"eng_esl", "pair_name"=>"English to Spanish", "services"=>[{"service_id"=>1, "service_name"=>"Translation"}, {"service_id"=>2, "service_name"=>"Checking/editing"}, {"service_id"=>3, "service_name"=>"Interpreting, Consecutive"}, {"service_id"=>4, "service_name"=>"Interpreting, Simultaneous"}, {"service_id"=>5, "service_name"=>"Voiceover"}, {"service_id"=>6, "service_name"=>"Summarization"}, {"service_id"=>7, "service_name"=>"Education"}, {"service_id"=>8, "service_name"=>"Interpreting, Chuchotage/Whispering"}]}, {"pair_code"=>"esl_eng", "pair_name"=>"Spanish to English", "services"=>[{"service_id"=>1, "service_name"=>"Translation"}, {"service_id"=>2, "service_name"=>"Checking/editing"}]}, {"pair_code"=>"fra_esl", "pair_name"=>"French to Spanish", "services"=>[{"service_id"=>1, "service_name"=>"Translation"}, {"service_id"=>2, "service_name"=>"Checking/editing"}]}])
    end
  end
end
