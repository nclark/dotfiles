file_cache_path File.expand_path(File.dirname(__FILE__) + '/../tmp/cache')
cookbook_path   File.expand_path(File.dirname(__FILE__) + '/../cookbooks')
data_bag_path   File.expand_path(File.dirname(__FILE__) + '/../data_bags')

file_backup_path File.expand_path(File.dirname(__FILE__) + '/../tmp/backup')

cache_options :path => File.expand_path(File.dirname(__FILE__) + '/../tmp/checksums'), :skip_expires => true
