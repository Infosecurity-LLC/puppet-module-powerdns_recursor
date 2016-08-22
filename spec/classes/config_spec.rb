describe 'powerdns_recursor::config' do
  shared_examples 'a Linux distribution' do |osfamily, config_directory|
    context "on #{osfamily}" do
      let (:facts) do
        {
          :operatingsystem => osfamily,
          :osfamily        => osfamily,
        }
      end

      let (:config_file) { config_directory + '/recursor.conf' }

      describe "with default parameters" do
        let (:pre_condition) { 'include ::powerdns_recursor' }

        let (:default_params) do
          {
            'ensure' => 'directory',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0755',
          }
        end

        it { should compile.with_all_deps }
        it { should create_class('powerdns_recursor::config') }

        it { should contain_file(config_directory).with(default_params) }

        it do
          should contain_concat(config_file).with({
            'path'   => config_file,
            'ensure' => 'present',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0600',
          })
        end

        it { should contain_powerdns_recursor__setting('config-dir').with_value(config_directory) }
        it { should contain_concat__fragment('config-dir').with_content("config-dir=#{config_directory}\n") }

        it { should contain_powerdns_recursor__setting('local-address') }
        it { should contain_concat__fragment('local-address') }

        it { should contain_powerdns_recursor__setting('setuid') }
        it { should contain_concat__fragment('setuid') }

        it { should contain_powerdns_recursor__setting('setgid') }
        it { should contain_concat__fragment('setgid') }

        it { should contain_powerdns_recursor__setting('quiet') }
        it { should contain_concat__fragment('quiet') }
      end

    end
  end

  it_behaves_like "a Linux distribution", 'RedHat', '/etc/pdns'
  it_behaves_like "a Linux distribution", 'Debian', '/etc/powerdns'
end
