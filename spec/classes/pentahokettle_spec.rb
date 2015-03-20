require 'spec_helper'

describe 'pentahokettle' do
  it do
    should contain_file('/opt/data-integration')
    should contain_file('/opt/data-integration/lib/mysql-connector-java-5.1.34-bin.jar')
  end
end
