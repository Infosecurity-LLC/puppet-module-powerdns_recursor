describe 'powerdns_recursor::install' do
  shared_examples 'a Linux distribution' do |osfamily, package|
    let (:pre_condition) { 'include ::powerdns_recursor' }

    let (:facts) do
      {
        :operatingsystem => osfamily,
        :osfamily        => osfamily,
      }
    end

    let (:default_params) do
      {
        :ensure => 'installed',
      }
    end

    context "on #{osfamily}" do
      it { should compile.with_all_deps }
      it { should create_class('powerdns_recursor::install') }
      it { should contain_package(package).with(default_params) }
    end
  end

  it_behaves_like 'a Linux distribution', 'RedHat', 'pdns-recursor'
  it_behaves_like 'a Linux distribution', 'Debian', 'pdns-recursor'
end
