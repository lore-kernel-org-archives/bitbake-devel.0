Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id A1B2F70620
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 18:12:46 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 03 Nov 2014 10:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,691,1406617200"; d="scan'208";a="484151881"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.154])
	by orsmga003.jf.intel.com with ESMTP; 03 Nov 2014 10:11:10 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Nov 2014 12:12:53 -0600
Message-Id: <1415038373-12763-3-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1415038373-12763-1-git-send-email-anibal.limon@linux.intel.com>
References: <1415038373-12763-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] fetch/wget: change print sentences to bb.debug
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 03 Nov 2014 18:12:46 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>

tests/fetch: improve unittest for wget method latest_versionstring

Changed version searching comparision from == to >= this makes
the test less fragile.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>

fetch/wget: Rename _latest_versionstring to latest_versionstring.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>

fetch/wget: check_latest_version fix version searching

When search over HTML using custom REGEX take into account
name of the package because is needed to match the new version.

Now if custom REGEX is specified only search using it instead
of generic REGEX.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>

tests/fetch.py: unittest for wget method latest_versionstring

Signed-off-by: Irina Patru <irina.patru@intel.com>
Signed-off-by: Saul Wold <sgw@linux.intel.com>

wget: Add support for upstream version searching

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Saul Wold <sgw@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 239 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py |  35 ++++++++
 2 files changed, 274 insertions(+)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 0456490..2f88332 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -25,6 +25,9 @@ BitBake build tools.
 #
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
+import re
+import tempfile
+import subprocess
 import os
 import logging
 import bb
@@ -34,6 +37,7 @@ from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
+from   bs4 import BeautifulSoup
 
 class Wget(FetchMethod):
     """Class to fetch urls via 'wget'"""
@@ -104,3 +108,238 @@ class Wget(FetchMethod):
         self._runwget(ud, d, fetchcmd, True)
 
         return True
+
+
+    def _parse_path(self, regex, s):
+        """
+        Find and group name, version and archive type in the given string s
+        """
+        bb.debug("parse_path(%s, %s)" % (regex.pattern, s))
+        m = regex.search(s)
+        if m:
+            bb.debug("%s, %s, %s" % (m.group('name'), m.group('ver'), m.group('type')))
+            return (m.group('name'), m.group('ver'), m.group('type'))
+        return None
+
+    def _modelate_version(self, version):
+        if version[0] in ['.', '-']:
+            if version[1].isdigit():
+                version = version[1] + version[0] + version[2:len(version)]
+            else:
+                version = version[1:len(version)]
+
+        version = re.sub('\-', '.', version)
+        version = re.sub('_', '.', version)
+        version = re.sub('(rc)+', '.-1.', version)
+        version = re.sub('(alpha)+', '.-3.', version)
+        version = re.sub('(beta)+', '.-2.', version)
+        if version[0] == 'v':
+            version = version[1:len(version)]
+        return version
+
+    def _vercmp(self, old, new):
+        """
+        Check whether 'new' is newer than 'old' version. We use existing vercmp() for the
+        purpose. PE is cleared in comparison as it's not for build, and PR is cleared too
+        for simplicity as it's somehow difficult to get from various upstream format
+        """
+
+        (oldpn, oldpv, oldsuffix) = old
+        (newpn, newpv, newsuffix) = new
+
+        """
+        Check for a new suffix type that we have never heard of before
+        """
+        if (newsuffix):
+            m = self.suffixregex.search(newsuffix)
+            if not m:
+                bb.warn("%s has a possible unknown suffix: %s" % (newpn, newsuffix))
+                return False
+
+        """
+        Not our package so ignore it
+        """
+        if oldpn != newpn:
+            return False
+
+        oldpv = self._modelate_version(oldpv)
+        newpv = self._modelate_version(newpv)
+
+        if bb.utils.vercmp(("0", oldpv, ""), ("0", newpv, "")) < 0:
+            return True
+        else:
+            return False
+
+    def _fetch_index(self, uri, ud, d):
+        """
+        Run fetch checkstatus to get directory information
+        """
+        f = tempfile.NamedTemporaryFile(dir="/tmp/s/", delete=False)
+
+        agent = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12"
+        fetchcmd = self.basecmd
+        fetchcmd += " -O " + f.name + " --user-agent='" + agent + "' '" + uri + "'"
+        try:
+            self._runwget(ud, d, fetchcmd, True)
+            fetchresult = f.read()
+        except bb.fetch2.BBFetchException:
+            fetchresult = ""
+
+        f.close()
+        # os.unlink(f.name)
+        return fetchresult
+
+    def _check_latest_dir(self, url, versionstring, ud, d):
+        """
+        Return the name of the directory with the greatest package version
+        If error or no version, return ""
+        """
+        bb.debug("DirURL: %s, %s" % (url, versionstring))
+        soup = BeautifulSoup(self._fetch_index(url, ud, d))
+        if not soup:
+            return ""
+
+        valid = 0
+        prefix = ''
+        regex = re.compile("(\D*)((\d+[\.\-_])+(\d+))")
+        m = regex.search(versionstring)
+        if m:
+            version = ('', m.group(2), '')
+            prefix = m.group(1)
+            bb.debug("version: %s, prefix: %s" % (version, prefix))
+        else:
+            version = ('', versionstring, '')
+
+        for href in soup.find_all('a', href=True):
+            bb.debug("href: %s" % (href['href']))
+            if href['href'].find(versionstring) >= 0:
+                valid = 1
+            m = regex.search(href['href'].strip("/"))
+            if m:
+                thisversion = ('', m.group(2), '')
+                if thisversion and self._vercmp(version, thisversion) == True:
+                    version = thisversion
+
+        if valid:
+            bb.debug("Would return %s" % (prefix+version[1]))
+            return prefix+version[1]
+        else:
+            bb.debug("Not Valid")
+            return ""
+
+    def _check_latest_version(self, url, packagename, ud, d):
+        """
+        Return the latest version of a package inside a given directory path
+        If error or no version, return ""
+        """
+        valid = 0
+        version = self._parse_path(self.name_version_type_regex, packagename)
+
+        bb.debug("VersionURL: %s" % (url))
+        soup = BeautifulSoup(self._fetch_index(url, ud, d))
+        if not soup:
+            bb.debug("*** %s NO SOUP" % (packagename))
+            return ""
+
+        pn_regex = d.getVar('REGEX', True)
+        if pn_regex:
+            testversion = version
+            pn_regex = re.compile(pn_regex)
+            bb.debug("pn_regex = '%s'" % (pn_regex.pattern))
+            
+        for line in soup.find_all('a', href=True):
+            newver = ('', '', '')
+            bb.debug("line = '%s'" % (line['href']))
+            if pn_regex:
+                m = pn_regex.search(line['href'])
+                if m:
+                    bb.debug("Name = '%s', Pver = '%s'" % (m.group('name'), m.group('pver')))
+                    newver = (m.group('name'), m.group('pver'), '')
+                else:
+                    continue
+            else:
+                newver = self._parse_path(self.name_version_type_regex, line['href'])
+            valid = 1
+            if newver and self._vercmp(version, newver) == True:
+                version = newver
+                
+        # check whether a valid package and version were found
+
+        if not valid:
+            version = ('', '', '')
+        if not pn_regex:
+            testversion = ('', '', '')
+        bb.debug("*** %s -> %s (TestVersion = %s)" % (packagename, version[1], testversion[1]))
+        if valid and version:
+            return re.sub('_', '.', version[1])
+
+    def latest_versionstring(self, ud, d):
+        """
+        Manipulate the URL and try to obtain the latest package version
+
+        sanity check to ensure same name and type. Match as many patterns as possible
+        such as:
+                gnome-common-2.20.0.tar.gz (most common format)
+                gtk+-2.90.1.tar.gz
+                xf86-input-synaptics-12.6.9.tar.gz
+                dri2proto-2.3.tar.gz
+                blktool_4.orig.tar.gz
+                libid3tag-0.15.1b.tar.gz
+                unzip552.tar.gz
+                icu4c-3_6-src.tgz
+                genext2fs_1.3.orig.tar.gz
+                gst-fluendo-mp3
+        """
+        # match most patterns which uses "-" as separator to version digits
+        pn_prefix1 = "[a-zA-Z][a-zA-Z0-9]*([\-_][a-zA-Z]\w+)*\+?[\-_]"
+        # a loose pattern such as for unzip552.tar.gz
+        pn_prefix2 = "[a-zA-Z]+"
+        # a loose pattern such as for 80325-quicky-0.4.tar.gz
+        pn_prefix3 = "[0-9]+[\-]?[a-zA-Z]+"
+        # Save the Package Name (pn) Regex for use later
+        self.pn_regex = "(%s|%s|%s)" % (pn_prefix1, pn_prefix2, pn_prefix3)
+
+        # match version
+        version_regex = "(([A-Z]*\d+[a-zA-Z]*[\.\-_]*)+)"
+
+        # src.rpm extension was added only for rpm package. Can be removed if the rpm
+        # packaged will always be considered as having to be manually upgraded
+        suffixlist = "(tar\.gz|tgz|tar\.bz2|zip|xz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
+        self.suffixregex = re.compile(suffixlist)
+
+        # match name, version and archive type of a package
+        self.name_version_type_regex = re.compile("(?P<name>%s?)\.?v?(?P<ver>%s)(\-source)?[\.\-](?P<type>%s$)" % (self.pn_regex, version_regex, suffixlist))
+
+        regex_uri = d.getVar("REGEX_URI", True)
+        newpath = ud.path
+        pupver = ""
+
+        # search for version matches on folders inside the path, like:
+        # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
+        m = re.search("(?P<dirver>[^/]*(\d+\.)*\d+([\-_]r\d+)*)/", ud.path)
+        bb.debug("path = %s" % (ud.path))
+        bb.debug("Regex: %s" % (self.name_version_type_regex.pattern))
+        if m and not regex_uri:
+            dirver = m.group('dirver')
+            # generate the new uri after removing version directory name
+            newuri = bb.fetch.encodeurl([ud.type, ud.host, ud.path.split(dirver)[0], ud.user, ud.pswd, {}])
+            newversion = self._check_latest_dir(newuri, dirver, ud, d)
+            if newversion and dirver != newversion:
+                newpath = ud.path.replace(dirver, newversion, True)
+
+        # try to acquire all remote files in current directory
+        packagename = newpath.split("/")[-1]            # current package name
+        newpath = newpath.split(packagename)[0] or "/"  # path to directory
+
+        # generate the new uri with the appropriate latest directory
+        newuri = regex_uri or bb.fetch.encodeurl([ud.type, ud.host, newpath, ud.user, ud.pswd, {}])
+        newversion = self._check_latest_version(newuri, packagename, ud, d)
+        while not newversion:
+            # maybe it's hiding in a download directory so try there
+            newuri = "/".join(newuri.split("/")[0:-2]) + "/download"
+            if newuri == "/download" or newuri == "http://download":
+                break
+            newversion = self._check_latest_version(newuri, packagename, ud, d)
+
+        return newversion
+
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e0eefd3..f059d87 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -593,6 +593,31 @@ class FetchMethodTest(FetcherTest):
             : "3.82+dbg0.9",
     }
 
+    test_wget_uris = {
+        # packages with versions inside directory name
+        ("util-linux", "http://kernel.org/pub/linux/utils/util-linux/v2.23/util-linux-2.24.2.tar.bz2", "", "")
+            : "2.24.2",
+        ("enchant", "http://www.abisource.com/downloads/enchant/1.6.0/enchant-1.6.0.tar.gz", "", "")
+            : "1.6.0",
+        ("cmake", "http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz", "", "")
+            : "2.8.12.1",
+        # packages with versions only in current directory
+        ("eglic", "http://downloads.yoctoproject.org/releases/eglibc/eglibc-2.18-svnr23787.tar.bz2", "", "")
+            : "2.19",
+        ("gnu-config", "http://downloads.yoctoproject.org/releases/gnu-config/gnu-config-20120814.tar.bz2", "", "")
+            : "20120814",
+        # packages with "99" in the name of possible version
+        ("pulseaudio", "http://freedesktop.org/software/pulseaudio/releases/pulseaudio-4.0.tar.xz", "", "")
+            : "5.0",
+        ("xserver-xorg", "http://xorg.freedesktop.org/releases/individual/xserver/xorg-server-1.15.1.tar.bz2", "", "")
+            : "1.15.1",
+        # packages with valid REGEX_URI and REGEX
+        ("cups", "http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2", "http://www.cups.org/software.php", "/software\.php\?VERSION=2\.0\.0&FILE=2\.0\.0/(?P<name>cups\-)(?P<pver>((\d+[\.\-_]*)+))\-source\.tar\.gz")
+            : "2.0.0",
+        ("db", "http://download.oracle.com/berkeley-db/db-5.3.21.tar.gz", "http://www.oracle.com/technetwork/products/berkeleydb/downloads/index-082944.html", "http://download.oracle.com/otn/berkeley-db/(?P<name>db-)(?P<pver>((\d+[\.\-_]*)+))\.tar\.gz")
+            : "6.1.19",
+    }
+
     def test_git_latest_versionstring(self):
         for k, v in self.test_git_uris.items():
             self.d.setVar("SRCREV", k[2])
@@ -602,3 +627,13 @@ class FetchMethodTest(FetcherTest):
             print("Package %s, version: %s <= %s" % (k[0], v, verstring))
             r = bb.utils.vercmp_string(v, verstring)
             self.assertTrue(r == -1 or r == 0)
+
+    def test_wget_latest_versionstring(self):
+        for k, v in self.test_wget_uris.items():
+            self.d.setVar("REGEX_URI", k[2])
+            self.d.setVar("REGEX", k[3])
+            ud = bb.fetch2.FetchData(k[1], self.d)
+            verstring = ud.method.latest_versionstring(ud, self.d)
+            print("Package %s, version: %s <= %s" % (k[0], v, verstring))
+            r = bb.utils.vercmp_string(v, verstring)
+            self.assertTrue(r == -1 or r == 0)
-- 
1.9.1


