dataconf = configuration_data()
dataconf.set('BACKGROUNDDIR', backgrounddir)
dataconf.set('datadir', datadir)

backgrounds = [
  'bigsur-d.jpg',
  'bigsur-l.jpg',
  'bigsur-color-d.jpg',
  'bigsur-color-l.jpg',
  'catalina-d.jpg',
  'catalina-l.jpg',
  'mojave-d.jpg',
  'mojave-l.jpg',
  'monterey-d.jpg',
  'monterey-l.jpg',  
]

install_data(backgrounds, install_dir: backgrounddir)

foreach metadata : [
  'bigsur.xml',
  'bigsur-color.xml',
  'catalina.xml',
  'mojave.xml',
  'monterey.xml']
  configure_file(
    input: metadata + '.in',
    output: metadata,
    configuration: dataconf,
    install: true,
    install_dir: metadatadir
  )
endforeach
