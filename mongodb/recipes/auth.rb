execute "create-mongodb-root-user" do
  command "/usr/bin/mongo admin --eval \"db.addUser({user: '#{node['mongodb]['auth']['root']['name']}', pwd: '#{node['mongodb]['auth']['root']['password']}', roles: [ 'userAdminAnyDatabase', 'dbAdminAnyDatabase', 'clusterAdmin', 'readWriteAnyDatabase' ]});\"
  action :run
  not_if "/usr/bin/mongo admin --eval 'db.auth(\"#{node['mongodb]['auth']['root']['name']}\",\"#{node['mongodb]['auth']['root']['password']}\")' | grep -q ^1$"
end

execute "create-mongodb-lms-user" do
  command "/usr/bin/mongo admin --eval \"db.addUser({user: '#{node['mongodb]['auth']['user']['name']}', pwd: '#{node['mongodb]['auth']['user']['password']}', roles: [ 'readWriteAnyDatabase' ]});\"
  action :run
  not_if "/usr/bin/mongo admin --eval 'db.auth(\"#{node['mongodb]['auth']['user']['name']}\",\"#{node['mongodb]['auth']['user']['password']}\")' | grep -q ^1$"
end
