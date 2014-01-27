#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "berkshelf3"
version "3.0.0.beta5"

dependency "libffi" unless platform == 'windows'
dependency "ruby-2.1"
dependency "rubygems-2.1"
dependency "nokogiri"

# nokogiri uses pkg-config, and on a mac that will find the system pkg-config
# which will find the system pkg-configs which will pull in libicucore from the
# libxml2 pkg-config spec.  override pkg-configs path here to point into our
# /opt/chef/embedded pkg-configs.  this should probably be done more generally,
# in core ominbus-ruby.
env = { "PKG_CONFIG_PATH" => "#{install_dir}/embedded/lib/pkgconfig" }

build do
  gem "install berkshelf -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}", :env => env
end