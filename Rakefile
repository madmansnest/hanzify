task :sync do
  system 'rsync -avz -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress app/* infusias@infusiastic.me:/home/infusias/apps/hanzify/'
end