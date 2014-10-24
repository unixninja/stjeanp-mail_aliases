require 'rspec-puppet'
require 'spec_helper'

describe 'mail_aliases', :type => :class do
  context 'Unsupported OS' do
    let(:facts) { {:osfamily => 'Solaris'} }

    it do
      expect {
        should compile
      }.to raise_error(Puppet::Error, /OS family 'Solaris' is not supported by this module/)
    end
  end

  context 'RedHat OS and no hiera data' do
    let(:facts) { {:osfamily => 'RedHat'} }

    it { should compile }
  end

  context 'Debian OS and no hiera data' do
    let(:facts) { {:osfamily => 'Debian'} }

    it { should compile }
  end

  context 'Suse OS and no hiera data' do
    let(:facts) { {:osfamily => 'Suse'} }

    it { should compile }
  end

  context 'RedHat OS and hiera data' do
    let(:facts) { {:osfamily => 'RedHat'} }

    it { should compile }
    it { should contain_mailalias('root').with(
      'recipient' => 'admin@mailbox.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'present',
    ) }
    it { should contain_mailalias('puppet').with(
      'recipient' => 'puppetmaster@mailbox.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'present',
    ) }
    it { should contain_mailalias('olduser').with(
      'recipient' => 'movedto@another.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'absent',
    ) }
  end

  context 'Debian OS and hiera data' do
    let(:facts) { {:osfamily => 'Debian'} }

    it { should compile }
    it { should contain_mailalias('root').with(
      'recipient' => 'admin@mailbox.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'present',
    ) }
    it { should contain_mailalias('puppet').with(
      'recipient' => 'puppetmaster@mailbox.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'present',
    ) }
    it { should contain_mailalias('olduser').with(
      'recipient' => 'movedto@another.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'absent',
    ) }
  end

  context 'Suse OS and hiera data' do
    let(:facts) { {:osfamily => 'Suse'} }

    it { should compile }
    it { should contain_mailalias('root').with(
      'recipient' => 'admin@mailbox.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'present',
    ) }
    it { should contain_mailalias('puppet').with(
      'recipient' => 'puppetmaster@mailbox.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'present',
    ) }
    it { should contain_mailalias('olduser').with(
      'recipient' => 'movedto@another.com',
      'notify'    => 'Exec[newaliases]',
      'ensure'    => 'absent',
    ) }
  end
end
