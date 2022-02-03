# This software is a part of the A.O.D apprepo project
# Copyright 2015 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
PWD:=$(shell pwd)
SOURCE:="https://download.kde.org/unstable/kate/Kate-16.08-x86_64.AppImage"
OUTPUT:="JMeter.AppImage"

all: clean
	echo "Building: $(OUTPUT)"

	mkdir --parents $(PWD)/build
	wget --output-document=$(PWD)/build/build.zip --continue https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.4.3.zip
	unzip $(PWD)/build/build.zip -d $(PWD)/build/

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm --continue https://forensics.cert.org/centos/cert/8/x86_64/jdk-12.0.2_linux-x64_bin.rpm
	rpm2cpio $(PWD)/build/build.rpm | cpio -idmv

	mkdir --parents $(PWD)/AppDir/application
	mkdir --parents $(PWD)/AppDir/java

	cp -r $(PWD)/build/apache-jmeter-*/* $(PWD)/AppDir/application
	cp -r $(PWD)/usr/java*/jdk-*/* $(PWD)/AppDir/java

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage AppDir $(PWD)/$(OUTPUT)
	make clean

clean:
	rm -rf $(PWD)/build
	rm -rf $(PWD)/AppDir/application
	rm -rf $(PWD)/AppDir/java
	rm -rf $(PWD)/usr
