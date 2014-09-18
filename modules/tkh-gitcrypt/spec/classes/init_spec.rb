require 'spec_helper'
describe 'gitcrypt' do

  context 'with defaults for all parameters' do
    it { should contain_class('gitcrypt') }
  end
end
