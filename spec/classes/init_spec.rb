describe 'powerdns_recursor' do
  shared_examples 'a Linux distribution' do |osfamily|
    context 'with Puppet <= 3.7.0' do
      let (:facts) do
        {
          :puppetversion => '3.6.0'
        }
      end

      it { should raise_error(Puppet::Error, /This module requires the use of Puppet v3.7.0 or newer./) }
    end

    context "with default parameters on #{osfamily}" do
      let (:facts) do
        {
          :operatingsystem => osfamily,
          :osfamily        => osfamily,
        }
      end

      it { should compile.with_all_deps }
      it { should create_class('powerdns_recursor') }
      it { should contain_class('powerdns_recursor::install').that_comes_before('Class[powerdns_recursor::config]') }
      it { should contain_class('powerdns_recursor::config').that_requires('Class[powerdns_recursor::install]') }
      it { should contain_class('powerdns_recursor::config').that_notifies('Class[powerdns_recursor::service]') }
      it { should contain_class('powerdns_recursor::service').that_subscribes_to('Class[powerdns_recursor::config]') }
    end
  end

  it_behaves_like 'a Linux distribution', 'RedHat'
  it_behaves_like 'a Linux distribution', 'Debian'
end
