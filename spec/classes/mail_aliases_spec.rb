require 'rspec-puppet'
require 'spec_helper'

describe 'mail_aliases', :type => :class do
  context 'Unsupported OS' do
    let(:facts) { {:osfamily => 'Debian'} }

    it do
      expect {
        should compile
      }.to raise_error(Puppet::Error, /OS family 'Debian' is not supported by this module/)
    end
  end

  context 'RedHat OS and no hiera data' do
    let(:facts) { {:osfamily => 'RedHat'} }

    it { should compile }
  end

  context 'RedHat OS and hiera data' do
    let(:facts) { {:osfamily => 'RedHat'} }

    it { should compile }
    it { should contain_mailalias('root').with(
      'recipient' => 'stjeanp@pat-st-jean.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'present',
    ) }
    it { should contain_mailalias('puppet').with(
      'recipient' => 'stjeanp@pat-st-jean.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'present',
    ) }
    it { should contain_mailalias('olduser').with(
      'recipient' => 'stjeanp@pat-st-jean.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'absent',
    ) }
  end
end
