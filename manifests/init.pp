# Public: Installs Pentaho Kettle
#
# Usage:
#
#   include pentahokettle
class pentahokettle {
  $version = '5.3.0.0-213'
  $mySqlConnector = 'mysql-connector-java-5.1.34-bin.jar'
  #$subVersion = regsubst($version, '/^[0-9]+\.[0-9]+(.*)/', '')
  ## regsubst seems buggy. Overriding
  $subVersion = '5.3'
  $url = "http://sourceforge.net/projects/pentaho/files/Data%20Integration/${subVersion}/pdi-ce-${version}.zip/download"
  $tmpDest = '/tmp/pdi-ce.zip'
  $destDir = '/opt'

  exec { 'wget':
    command  => "wget ${url} -O ${tmpDest}",
    unless   => "test -f ${destDir}/data-integration",
  } ->

  file { $destDir:
    ensure   => directory,
    mode     => '0755',
  } ->

  exec { 'unzip':
    command  => "unzip ${tmpDest} -d ${destDir}",
    unless   => "test -d ${destDir}/data-integration",
    require  => Exec['wget']
  } ->

  file { "${destDir}//data-integration/lib/${mySqlConnector}":
    source   => "puppet:///modules/pentahokettle/${mySqlConnector}",
    mode     => '0664',
  }
  
  if ! defined(Package['unzip']) {
    package { 'unzip':
        ensure => installed,
    }
  }  
  
}