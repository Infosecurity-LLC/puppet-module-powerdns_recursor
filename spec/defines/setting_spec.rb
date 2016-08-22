describe 'powerdns_recursor::setting' do
  shared_examples 'a Linux distribution' do |osfamily, config|
    let (:pre_condition) { 'include ::powerdns_recursor' }

    let (:facts) do
      {
        :operatingsystem => osfamily,
        :osfamily        => osfamily,
      }
    end

  end

  it_behaves_like 'a Linux distribution', 'RedHat', '/etc/pdns/recursor.conf'
  it_behaves_like 'a Linux distribution', 'Debian', '/etc/powerdns/recursor.conf'
end
