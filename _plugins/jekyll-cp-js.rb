require 'fileutils'

def get_filename(fullpath)
  path_arr = fullpath.split('/')
  if !path_arr || !path_arr.size
    path_arr = fullpath.split('\\')
  end
  file_name = path_arr[path_arr.size - 1]

  return file_name
end

def copy_files(plugin_config)
  to_dir = plugin_config["to_dir"]

  FileUtils.mkdir_p to_dir

  from_files = plugin_config["from_files"]

  if !from_files 
    return
  end

  for index in 0 ... from_files.size
    from = from_files[index]

    file_name = get_filename from

    FileUtils.cp from, "#{to_dir}/#{file_name}"
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  # code to call after Jekyll builds and writes a site to disk
  plugin_config = site.config['copy_files_plugin']

  if plugin_config 
    copy_files plugin_config
  end
  # FileUtils.cp './node_modules/bootstrap/js/bootstrap.bundle.js', '_site/assets/js/bootstrap.bundle.js'
end