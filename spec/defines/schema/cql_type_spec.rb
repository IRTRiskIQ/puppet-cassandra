require 'spec_helper'

describe 'cassandra::schema::cql_type' do
  context 'CQL TYPE (fullname)' do
    let :facts do
      {
        operatingsystemmajrelease: 7,
        osfamily: 'RedHat'
      }
    end

    let(:title) { 'fullname' }

    let(:params) do
      {
        'keyspace' => 'Excelsior',
        fields:
          {
            'firstname' => 'text',
            'lastname'  => 'text'
          }
      }
    end

    it do
      is_expected.to compile
      is_expected.to contain_class('cassandra::schema')
      is_expected.to contain_cassandra__schema__cql_type('fullname')
      is_expected.to contain_exec('/usr/bin/cqlsh   -e "CREATE TYPE IF NOT EXISTS Excelsior.fullname (firstname text, lastname text)" localhost 9042')
    end
  end

  context 'Set ensure to absent' do
    let :facts do
      {
        operatingsystemmajrelease: 7,
        osfamily: 'RedHat'
      }
    end

    let(:title) { 'address' }
    let(:params) do
      {
        'ensure'   => 'absent',
        'keyspace' => 'Excalibur'
      }
    end

    it do
      is_expected.to compile
      is_expected.to contain_cassandra__schema__cql_type('address')
      is_expected.to contain_exec('/usr/bin/cqlsh   -e "DROP type Excalibur.address" localhost 9042')
    end
  end

  context 'Set ensure to latest' do
    let :facts do
      {
        operatingsystemmajrelease: 7,
        osfamily: 'RedHat'
      }
    end

    let(:title) { 'foobar' }
    let(:params) do
      {
        ensure: 'latest'
      }
    end

    it { is_expected.to raise_error(Puppet::Error) }
  end
end
