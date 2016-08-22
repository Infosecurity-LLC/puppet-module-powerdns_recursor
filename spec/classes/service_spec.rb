describe 'powerdns_recursor::service' do
  shared_examples 'a Linux distribution' do |osfamily|
    let (:pre_condition) { 'include ::powerdns_recursor' }

    let (:facts) do
      {
        :operatingsystem => osfamily,
        :osfamily        => osfamily,
      }
    end

    let (:default_params) do
      {
        :ensure => 'running',
        :enable => true
      }
    end

    it { should compile.with_all_deps }
    it { should create_class('powerdns_recursor::service') }
    it { should contain_service('pdns-recursor').with(default_params) }
  end

  it_behaves_like 'a Linux distribution', 'RedHat'
  it_behaves_like 'a Linux distribution', 'Debian'
end
