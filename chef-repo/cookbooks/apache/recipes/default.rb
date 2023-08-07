#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

apt_update 'Update the apt cache daily' do
    frequency 86400
    action :periodic
end

package 'apache2'

service 'apache2' do
    supports :status => true
    action :nothing
end

file '/etc/apache2/sites-enabled/000-default.conf' do
    action :delete
end

template '/etc/apache2/sites-enabled/vagrant.conf' do
    source 'virtual-hosts.conf.erb'
    notifies :restart, resources(:service => 'apache2')
end

link '/etc/apache2/sites-enabled/vagrant.conf' do
    to '/etc/apache2/sites-available/vagrant.conf'
    notifies :restart, resources(:service => 'apache2')
end

cookbook_file "#{node['apache']['document_root']}/index.html" do
    source 'index.html'
    only_if do
        File.exists?('/etc/apache2/sites-enabled/vagrant.conf')
    end
end
