project('gnome-backgrounds-macos',
  version: '43.0.0',
  meson_version: '>= 0.50.0'
)

i18n = import('i18n')

prefix = get_option('prefix')

datadir = join_paths(prefix, get_option('datadir'))
backgrounddir = join_paths(datadir, 'backgrounds', 'gnome-macos')
metadatadir = join_paths(datadir, 'gnome-background-properties')

subdir('backgrounds')
