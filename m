Return-Path: <brendan.le.foll@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id B9F4E7736C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Feb 2016 15:07:09 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga104.fm.intel.com with ESMTP; 25 Feb 2016 07:06:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,498,1449561600"; d="scan'208";a="923777774"
Received: from jupiter.iwi.intel.com ([172.28.33.51])
	by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2016 07:06:50 -0800
From: brendan.le.foll@intel.com
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Feb 2016 15:07:07 +0000
Message-Id: <1456412828-11343-3-git-send-email-brendan.le.foll@intel.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456412828-11343-1-git-send-email-brendan.le.foll@intel.com>
References: <1456412828-11343-1-git-send-email-brendan.le.foll@intel.com>
Subject: [PATCH 2/3] npm: Add npm fetcher
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
X-List-Received-Date: Thu, 25 Feb 2016 15:07:10 -0000

From: Brendan Le Foll <brendan.le.foll@intel.com>

npm fetcher with support for shrinkwrap files and lockdown files to easily
download and install an npm package with strict dependency resolution.

The SRC_URI should be in the format of:
SRC_URI = "npm://registry.npmjs.org/;name=${PN};version=${PV}"

To add a shrinkwrap and lockdown file use:
NPM_SHRINKWRAP := "${THISDIR}/${PN}/npm-shrinkwrap.json"
NPM_LOCKDOWN := "${THISDIR}/${PN}/lockdown.json"

Signed-off-by: Brendan Le Foll <brendan.le.foll@intel.com>
---
 lib/bb/fetch2/npm.py | 226 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)
 create mode 100644 lib/bb/fetch2/npm.py

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
new file mode 100644
index 0000000..6a4f467
--- /dev/null
+++ b/lib/bb/fetch2/npm.py
@@ -0,0 +1,226 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+"""
+BitBake 'Fetch' NPM implementation
+
+The NPM fetcher is used to retrieve files from the npmjs repository
+
+Usage in the recipe:
+
+    SRC_URI = "npm://registry.npmjs.org/;name=${PN};version=${PV}"
+    Suported SRC_URI options are:
+
+    - name
+    - version
+
+    npm://registry.npmjs.org/${PN}/-/${PN}-${PV}.tgz  would become npm://registry.npmjs.org;name=${PN};ver=${PV}
+    The fetcher all triggers off the existence of ud.localpath. If that exists and has the ".done" stamp, its assumed the fetch is good/done
+
+"""
+
+import os
+import sys
+import urllib
+import json
+import subprocess
+import signal
+import bb
+from   bb import data
+from   bb.fetch2 import FetchMethod
+from   bb.fetch2 import FetchError
+from   bb.fetch2 import ChecksumError
+from   bb.fetch2 import runfetchcmd
+from   bb.fetch2 import logger
+from   bb.fetch2 import UnpackError
+from   distutils import spawn
+
+def subprocess_setup():
+    # Python installs a SIGPIPE handler by default. This is usually not what
+    # non-Python subprocesses expect.
+    # SIGPIPE errors are known issues with gzip/bash
+    signal.signal(signal.SIGPIPE, signal.SIG_DFL)
+
+class Npm(FetchMethod):
+
+    """Class to fetch urls via 'npm'"""
+    def init(self, d):
+        pass
+
+    def supports(self, ud, d):
+        """
+        Check to see if a given url can be fetched with npm
+        """
+        return ud.type in ['npm']
+
+    def debug(self, msg):
+        logger.debug(1, "NpmFetch: %s", msg)
+
+    def clean(self, ud, d):
+         logger.debug(2, "Calling cleanup %s" % ud.pkgname)
+         bb.utils.remove(ud.localpath, False)
+         bb.utils.remove(ud.pkgdatadir, True)
+
+    def urldata_init(self, ud, d):
+        """
+        init NPM specific variable within url data
+        """
+        if 'downloadfilename' in ud.parm:
+            ud.basename = ud.parm['downloadfilename']
+        else:
+            ud.basename = os.path.basename(ud.path)
+
+        # can't call it ud.name otherwise fetcher base class will start doing sha1stuff
+        # TODO: find a way to get an sha1/sha256 manifest of pkg & all deps
+        ud.pkgname = ud.parm.get("name", None)
+        if not ud.pkgname:
+            raise ParameterError("NPM fetcher requires a name parameter")
+        ud.version = ud.parm.get("version", None)
+        if not ud.version:
+            raise ParameterError("NPM fetcher requires a version parameter")
+        ud.bbnpmmanifest = "%s-%s.deps.json" % (ud.pkgname, ud.version)
+        ud.registry = "http://%s" % ud.basename
+        prefixdir = "npm/%s" % ud.pkgname
+        ud.pkgdatadir = d.expand("${DL_DIR}/%s" % prefixdir)
+        if not os.path.exists(ud.pkgdatadir):
+            bb.utils.mkdirhiet(ud.pkgdatadir)
+        ud.localpath = d.expand("${DL_DIR}/npm/%s" % ud.bbnpmmanifest)
+
+        self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -O -t 2 -T 30 -nv --passive-ftp --no-check-certificate "
+        self.basecmd += " --directory-prefix=%s " % prefixdir
+
+    def need_update(self, ud, d):
+        if os.path.exists(ud.localpath):
+            return False
+        return True
+
+    def _runwget(self, ud, d, command, quiet):
+        logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
+        bb.fetch2.check_network_access(d, command)
+        runfetchcmd(command, d, quiet)
+
+    def _unpackdep(self, ud, pkg, data, destdir, dldir, d):
+       file = data[pkg]['tgz']
+       logger.debug(2, "file to extract is %s" % file)
+       if file.endswith('.tgz') or file.endswith('.tar.gz') or file.endswith('.tar.Z'):
+            cmd = 'tar xz --strip 1 --no-same-owner -f %s/%s' % (dldir, file)
+       else:
+            bb.fatal("NPM package %s downloaded not a tarball!" % file)
+
+       # Change to subdir before executing command
+       save_cwd = os.getcwd()
+       if not os.path.exists(destdir):
+           os.makedirs(destdir)
+       os.chdir(destdir)
+       path = d.getVar('PATH', True)
+       if path:
+            cmd = "PATH=\"%s\" %s" % (path, cmd)
+       bb.note("Unpacking %s to %s/" % (file, os.getcwd()))
+       ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
+       os.chdir(save_cwd)
+
+       if ret != 0:
+            raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), ud.url)
+
+       if 'deps' not in data[pkg]:
+            return
+       for dep in data[pkg]['deps']:
+           self._unpackdep(dep, data[pkg]['deps'], "%s/node_modules/%s" % (destdir, dep), dldir, d)
+
+
+    def unpack(self, ud, destdir, d):
+        dldir = d.getVar("DL_DIR", True)
+        depdumpfile = "%s-%s.deps.json" % (ud.pkgname, ud.version)
+        with open("%s/%s" % (dldir, depdumpfile)) as datafile:
+            workobj = json.load(datafile)
+        dldir = "%s/%s" % (os.path.dirname(ud.localpath), ud.pkgname)
+
+        self._unpackdep(ud, ud.pkgname, workobj,  "%s/npmpkg" % destdir, dldir, d)
+
+    def _getdependencies(self, pkg, data, version, d, ud):
+        pkgfullname = pkg
+        if version:
+            pkgfullname += "@%s" % version
+        logger.debug(2, "Calling getdeps on %s" % pkg)
+        fetchcmd = "npm view %s dist.tarball --registry %s" % (pkgfullname, ud.registry)
+        output = runfetchcmd(fetchcmd, d, True)
+        # npm may resolve multiple versions
+        outputarray = output.strip().splitlines()
+        # we just take the latest version npm resolved
+        #logger.debug(2, "Output URL is %s - %s - %s" % (ud.basepath, ud.basename, ud.localfile))
+        outputurl = outputarray[len(outputarray)-1].rstrip()
+        if (len(outputarray) > 1):
+            # remove the preceding version/name from npm output and then the
+            # first and last quotes
+            outputurl = outputurl.split(" ")[1][1:-1]
+        data[pkg] = {}
+        data[pkg]['tgz'] = os.path.basename(outputurl)
+        self._runwget(ud, d, "%s %s" % (self.basecmd, outputurl), False)
+        #fetchcmd = "npm view %s@%s dependencies --json" % (pkg, version)
+        fetchcmd = "npm view %s dependencies --json --registry %s" % (pkgfullname, ud.registry)
+        output = runfetchcmd(fetchcmd, d, True)
+        try:
+          depsfound = json.loads(output)
+        except:
+            # just assume there is no deps to be loaded here
+            return
+        data[pkg]['deps'] = {}
+        for dep, version in depsfound.iteritems():
+            self._getdependencies(dep, data[pkg]['deps'], version, d, ud)
+
+    def _getshrinkeddependencies(self, pkg, data, version, d, ud, lockdown, manifest):
+        logger.debug(2, "NPM shrinkwrap file is %s" % data)
+        outputurl = "invalid"
+        if ('resolved' not in data):
+            # will be the case for ${PN}
+            fetchcmd = "npm view %s@%s dist.tarball --registry %s" % (pkg, version, ud.registry)
+            logger.debug(2, "Found this matching URL: %s" % str(fetchcmd))
+            outputurl = runfetchcmd(fetchcmd, d, True)
+        else:
+            outputurl = data['resolved']
+        self._runwget(ud, d, "%s %s" % (self.basecmd, outputurl), False)
+        manifest[pkg] = {}
+        manifest[pkg]['tgz'] = os.path.basename(outputurl).rstrip()
+        manifest[pkg]['deps'] = {}
+
+        if pkg in lockdown:
+            sha1_expected = lockdown[pkg][version]
+            sha1_data = bb.utils.sha1_file("npm/%s/%s" % (ud.pkgname, manifest[pkg]['tgz']))
+            if sha1_expected != sha1_data:
+                msg = "\nFile: '%s' has %s checksum %s when %s was expected" % (manifest[pkg]['tgz'], 'sha1', sha1_data, sha1_expected)
+                raise ChecksumError('Checksum mismatch!%s' % msg)
+        else:
+            logger.debug(2, "No lockdown data for %s@%s" % (pkg, version))
+
+        if 'dependencies' in data:
+            for obj in data['dependencies']:
+                logger.debug(2, "Found dep is %s" % str(obj))
+                self._getshrinkeddependencies(obj, data['dependencies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest[pkg]['deps'])
+
+    def download(self, ud, d):
+        """Fetch url"""
+        jsondepobj = {}
+        shrinkobj = {}
+        lockdown = {}
+
+        shwrf = d.getVar('NPM_SHRINKWRAP', True)
+        logger.debug(2, "NPM shrinkwrap file is %s" % shwrf)
+        try:
+            with open(shwrf) as datafile:
+                shrinkobj = json.load(datafile)
+        except:
+            logger.warn('Missing shrinkwrap file in NPM_SHRINKWRAP for %s, this will lead to unreliable builds!' % ud.pkgname)
+        lckdf = d.getVar('NPM_LOCKDOWN', True)
+        logger.debug(2, "NPM lockdown file is %s" % lckdf)
+        try:
+            with open(lckdf) as datafile:
+                lockdown = json.load(datafile)
+        except:
+            logger.warn('Missing lockdown file in NPM_LOCKDOWN for %s, this will lead to unreproducible builds!' % ud.pkgname)
+
+        if ('name' not in shrinkobj):
+            self._getdependencies(ud.pkgname, jsondepobj, ud.version, d, ud)
+        else:
+            self._getshrinkeddependencies(ud.pkgname, shrinkobj, ud.version, d, ud, lockdown, jsondepobj)
+
+        with open(ud.localpath, 'w') as outfile:
+            json.dump(jsondepobj, outfile)
-- 
2.7.1


