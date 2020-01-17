Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 152967FA2D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 16:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0BEC09C046A;
	Fri, 17 Jan 2020 11:46:06 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id mfV_efgrAXwC; Fri, 17 Jan 2020 11:46:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CEEC49C046B;
	Fri, 17 Jan 2020 11:46:03 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id Z4yVuk-2Qy1V; Fri, 17 Jan 2020 11:46:03 -0500 (EST)
Received: from sulaco.example.com (40.73.12.109.rev.sfr.net [109.12.73.40])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D0E579C046A;
	Fri, 17 Jan 2020 11:46:02 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jan 2020 17:45:45 +0100
Message-Id: <20200117164548.28453-10-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes-dev@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v4 09/12] bitbake: fetch2/npm: refactor the npm fetcher
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
X-List-Received-Date: Fri, 17 Jan 2020 16:52:10 -0000
Content-Transfer-Encoding: quoted-printable

This commit refactors the npm fetcher to improve some points and fix
others:

 - The big change is that the fetcher is only fetching the package
   source and no more the dependencies. Thus the npm fetcher act as the
   other fetchers e.g git, wget. The dependencies will be handled later.

 - The fetcher only resolves the url of the package using 'npm view' and
   then forwards it to a proxy fetcher.

 - This commit also fixes a lot of issues with the package names (exotic
   characters, scoped packages) which were badly handled.

 - The validation files - lockdown.json and npm-shrinkwrap.json - are no
   longer used by the fetcher. Instead, the downloaded tarball is
   verified with the 'integrity' and 'shasum' provided in the 'npm view'
   of the package [1][2].

1: https://docs.npmjs.com/files/package-lock.json#integrity
2: https://www.w3.org/TR/SRI

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/npm.py | 538 +++++++++++++++++++++----------------------
 1 file changed, 266 insertions(+), 272 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 9700e610..15cdfefb 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -1,301 +1,295 @@
+# Copyright (C) 2020 Savoir-Faire Linux
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
 """
-BitBake 'Fetch' NPM implementation
+BitBake 'Fetch' npm implementation
=20
-The NPM fetcher is used to retrieve files from the npmjs repository
+npm fetcher support the SRC_URI with format of:
+SRC_URI =3D "npm://some.registry.url;OptionA=3Dxxx;OptionB=3Dxxx;..."
=20
-Usage in the recipe:
+Supported SRC_URI options are:
=20
-    SRC_URI =3D "npm://registry.npmjs.org/;name=3D${PN};version=3D${PV}"
-    Suported SRC_URI options are:
+- package
+   The npm package name. This is a mandatory parameter.
=20
-    - name
-    - version
+- version
+    The npm package version. This is a mandatory parameter.
=20
-    npm://registry.npmjs.org/${PN}/-/${PN}-${PV}.tgz  would become npm:/=
/registry.npmjs.org;name=3D${PN};version=3D${PV}
-    The fetcher all triggers off the existence of ud.localpath. If that =
exists and has the ".done" stamp, its assumed the fetch is good/done
+- downloadfilename
+    Specifies the filename used when storing the downloaded file.
=20
+- destsuffix
+    Specifies the directory to use to unpack the package (default: npm).
 """
=20
-import os
-import sys
-import urllib.request, urllib.parse, urllib.error
+import base64
 import json
-import subprocess
-import signal
+import os
+import re
+import tempfile
 import bb
-from   bb.fetch2 import FetchMethod
-from   bb.fetch2 import FetchError
-from   bb.fetch2 import ChecksumError
-from   bb.fetch2 import runfetchcmd
-from   bb.fetch2 import logger
-from   bb.fetch2 import UnpackError
-from   bb.fetch2 import ParameterError
-
-def subprocess_setup():
-    # Python installs a SIGPIPE handler by default. This is usually not =
what
-    # non-Python subprocesses expect.
-    # SIGPIPE errors are known issues with gzip/bash
-    signal.signal(signal.SIGPIPE, signal.SIG_DFL)
+from bb.fetch2 import Fetch
+from bb.fetch2 import FetchError
+from bb.fetch2 import FetchMethod
+from bb.fetch2 import MissingParameterError
+from bb.fetch2 import ParameterError
+from bb.fetch2 import URI
+from bb.fetch2 import check_network_access
+from bb.fetch2 import runfetchcmd
+from bb.utils import is_semver
+
+def npm_package(package):
+    """Convert the npm package name to remove unsupported character"""
+    # Scoped package names (with the @) use the same naming convention
+    # as the 'npm pack' command.
+    if package.startswith("@"):
+        return re.sub("/", "-", package[1:])
+    return package
+
+def npm_filename(package, version):
+    """Get the filename of a npm package"""
+    return npm_package(package) + "-" + version + ".tgz"
+
+def npm_localfile(package, version):
+    """Get the local filename of a npm package"""
+    return os.path.join("npm2", npm_filename(package, version))
+
+def npm_integrity(integrity):
+    """
+    Get the checksum name and expected value from the subresource integr=
ity
+        https://www.w3.org/TR/SRI/
+    """
+    algo, value =3D integrity.split("-", maxsplit=3D1)
+    return "%ssum" % algo, base64.b64decode(value).hex()
+
+def npm_unpack(tarball, destdir, d):
+    """Unpack a npm tarball"""
+    bb.utils.mkdirhier(destdir)
+    cmd =3D "tar --extract --gzip --file=3D'%s'" % tarball
+    cmd +=3D " --no-same-owner"
+    cmd +=3D " --strip-components=3D1"
+    runfetchcmd(cmd, d, workdir=3Ddestdir)
+
+class NpmEnvironment(object):
+    """
+    Using a npm config file seems more reliable than using cli arguments=
.
+    This class allows to create a controlled environment for npm command=
s.
+    """
+    def __init__(self, d, configs=3DNone):
+        self.d =3D d
+        self.configs =3D configs
+
+    def run(self, cmd, args=3DNone, configs=3DNone, workdir=3DNone):
+        """Run npm command in a controlled environment"""
+        with tempfile.TemporaryDirectory() as tmpdir:
+            d =3D bb.data.createCopy(self.d)
+            d.setVar("HOME", tmpdir)
+
+            cfgfile =3D os.path.join(tmpdir, "npmrc")
+
+            if not workdir:
+                workdir =3D tmpdir
+
+            def _run(cmd):
+                cmd =3D "NPM_CONFIG_USERCONFIG=3D%s " % cfgfile + cmd
+                cmd =3D "NPM_CONFIG_GLOBALCONFIG=3D%s " % cfgfile + cmd
+                return runfetchcmd(cmd, d, workdir=3Dworkdir)
+
+            if self.configs:
+                for key, value in self.configs:
+                    _run("npm config set '%s' '%s'" % (key, value))
+
+            if configs:
+                for key, value in configs:
+                    _run("npm config set '%s' '%s'" % (key, value))
+
+            if args:
+                for key, value in args:
+                    cmd +=3D " --%s=3D'%s'" % (key, value)
+
+            return _run(cmd)
=20
 class Npm(FetchMethod):
-
-    """Class to fetch urls via 'npm'"""
-    def init(self, d):
-        pass
+    """Class to fetch a package from a npm registry"""
=20
     def supports(self, ud, d):
-        """
-        Check to see if a given url can be fetched with npm
-        """
-        return ud.type in ['npm']
+        """Check if a given url can be fetched with npm"""
+        return ud.type in ["npm"]
+
+    def urldata_init(self, ud, d):
+        """Init npm specific variables within url data"""
+        ud.package =3D None
+        ud.version =3D None
+        ud.registry =3D None
=20
-    def debug(self, msg):
-        logger.debug(1, "NpmFetch: %s", msg)
+        # Get the 'package' parameter
+        if "package" in ud.parm:
+            ud.package =3D ud.parm.get("package")
=20
-    def clean(self, ud, d):
-        logger.debug(2, "Calling cleanup %s" % ud.pkgname)
-        bb.utils.remove(ud.localpath, False)
-        bb.utils.remove(ud.pkgdatadir, True)
-        bb.utils.remove(ud.fullmirror, False)
+        if not ud.package:
+            raise MissingParameterError("Parameter 'package' required", =
ud.url)
+
+        # Get the 'version' parameter
+        if "version" in ud.parm:
+            ud.version =3D ud.parm.get("version")
=20
-    def urldata_init(self, ud, d):
-        """
-        init NPM specific variable within url data
-        """
-        if 'downloadfilename' in ud.parm:
-            ud.basename =3D ud.parm['downloadfilename']
-        else:
-            ud.basename =3D os.path.basename(ud.path)
-
-        # can't call it ud.name otherwise fetcher base class will start =
doing sha1stuff
-        # TODO: find a way to get an sha1/sha256 manifest of pkg & all d=
eps
-        ud.pkgname =3D ud.parm.get("name", None)
-        if not ud.pkgname:
-            raise ParameterError("NPM fetcher requires a name parameter"=
, ud.url)
-        ud.version =3D ud.parm.get("version", None)
         if not ud.version:
-            raise ParameterError("NPM fetcher requires a version paramet=
er", ud.url)
-        ud.bbnpmmanifest =3D "%s-%s.deps.json" % (ud.pkgname, ud.version=
)
-        ud.bbnpmmanifest =3D ud.bbnpmmanifest.replace('/', '-')
-        ud.registry =3D "http://%s" % (ud.url.replace('npm://', '', 1).s=
plit(';'))[0]
-        prefixdir =3D "npm/%s" % ud.pkgname
-        ud.pkgdatadir =3D d.expand("${DL_DIR}/%s" % prefixdir)
-        if not os.path.exists(ud.pkgdatadir):
-            bb.utils.mkdirhier(ud.pkgdatadir)
-        ud.localpath =3D d.expand("${DL_DIR}/npm/%s" % ud.bbnpmmanifest)
-
-        self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget=
 -O -t 2 -T 30 -nv --passive-ftp --no-check-certificate "
-        ud.prefixdir =3D prefixdir
-
-        ud.write_tarballs =3D ((d.getVar("BB_GENERATE_MIRROR_TARBALLS") =
or "0") !=3D "0")
-        mirrortarball =3D 'npm_%s-%s.tar.xz' % (ud.pkgname, ud.version)
-        mirrortarball =3D mirrortarball.replace('/', '-')
-        ud.fullmirror =3D os.path.join(d.getVar("DL_DIR"), mirrortarball=
)
-        ud.mirrortarballs =3D [mirrortarball]
+            raise MissingParameterError("Parameter 'version' required", =
ud.url)
=20
-    def need_update(self, ud, d):
-        if os.path.exists(ud.localpath):
-            return False
-        return True
-
-    def _runpack(self, ud, d, pkgfullname: str, quiet=3DFalse) -> str:
-        """
-        Runs npm pack on a full package name.
-        Returns the filename of the downloaded package
-        """
-        bb.fetch2.check_network_access(d, pkgfullname, ud.registry)
-        dldir =3D d.getVar("DL_DIR")
-        dldir =3D os.path.join(dldir, ud.prefixdir)
-
-        command =3D "npm pack {} --registry {}".format(pkgfullname, ud.r=
egistry)
-        logger.debug(2, "Fetching {} using command '{}' in {}".format(pk=
gfullname, command, dldir))
-        filename =3D runfetchcmd(command, d, quiet, workdir=3Ddldir)
-        return filename.rstrip()
-
-    def _unpackdep(self, ud, pkg, data, destdir, dldir, d):
-        file =3D data[pkg]['tgz']
-        logger.debug(2, "file to extract is %s" % file)
-        if file.endswith('.tgz') or file.endswith('.tar.gz') or file.end=
swith('.tar.Z'):
-            cmd =3D 'tar xz --strip 1 --no-same-owner --warning=3Dno-unk=
nown-keyword -f %s/%s' % (dldir, file)
-        else:
-            bb.fatal("NPM package %s downloaded not a tarball!" % file)
-
-        # Change to subdir before executing command
-        if not os.path.exists(destdir):
-            os.makedirs(destdir)
-        path =3D d.getVar('PATH')
-        if path:
-            cmd =3D "PATH=3D\"%s\" %s" % (path, cmd)
-        bb.note("Unpacking %s to %s/" % (file, destdir))
-        ret =3D subprocess.call(cmd, preexec_fn=3Dsubprocess_setup, shel=
l=3DTrue, cwd=3Ddestdir)
-
-        if ret !=3D 0:
-            raise UnpackError("Unpack command %s failed with return valu=
e %s" % (cmd, ret), ud.url)
-
-        if 'deps' not in data[pkg]:
-            return
-        for dep in data[pkg]['deps']:
-            self._unpackdep(ud, dep, data[pkg]['deps'], "%s/node_modules=
/%s" % (destdir, dep), dldir, d)
-
-
-    def unpack(self, ud, destdir, d):
-        dldir =3D d.getVar("DL_DIR")
-        with open("%s/npm/%s" % (dldir, ud.bbnpmmanifest)) as datafile:
-            workobj =3D json.load(datafile)
-        dldir =3D "%s/%s" % (os.path.dirname(ud.localpath), ud.pkgname)
-
-        if 'subdir' in ud.parm:
-            unpackdir =3D '%s/%s' % (destdir, ud.parm.get('subdir'))
+        if not is_semver(ud.version) and not ud.version =3D=3D "latest":
+            raise ParameterError("Invalid 'version' parameter", ud.url)
+
+        # Extract the 'registry' part of the url
+        ud.registry =3D re.sub(r"^npm://", "http://", ud.url.split(";")[=
0])
+
+        # Using the 'downloadfilename' parameter as local filename
+        # or the npm package name.
+        if "downloadfilename" in ud.parm:
+            ud.localfile =3D d.expand(ud.parm["downloadfilename"])
         else:
-            unpackdir =3D '%s/npmpkg' % destdir
-
-        self._unpackdep(ud, ud.pkgname, workobj, unpackdir, dldir, d)
-
-    def _parse_view(self, output):
-        '''
-        Parse the output of npm view --json; the last JSON result
-        is assumed to be the one that we're interested in.
-        '''
-        pdata =3D json.loads(output);
-        try:
-            return pdata[-1]
-        except:
-            return pdata
-
-    def _getdependencies(self, pkg, data, version, d, ud, optional=3DFal=
se, fetchedlist=3DNone):
-        if fetchedlist is None:
-            fetchedlist =3D []
-        pkgfullname =3D pkg
-        if version !=3D '*' and not '/' in version:
-            pkgfullname +=3D "@'%s'" % version
-        if pkgfullname in fetchedlist:
-            return
-
-        logger.debug(2, "Calling getdeps on %s" % pkg)
-        fetchcmd =3D "npm view %s --json --registry %s" % (pkgfullname, =
ud.registry)
-        output =3D runfetchcmd(fetchcmd, d, True)
-        pdata =3D self._parse_view(output)
-        if not pdata:
-            raise FetchError("The command '%s' returned no output" % fet=
chcmd)
-        if optional:
-            pkg_os =3D pdata.get('os', None)
-            if pkg_os:
-                if not isinstance(pkg_os, list):
-                    pkg_os =3D [pkg_os]
-                blacklist =3D False
-                for item in pkg_os:
-                    if item.startswith('!'):
-                        blacklist =3D True
-                        break
-                if (not blacklist and 'linux' not in pkg_os) or '!linux'=
 in pkg_os:
-                    logger.debug(2, "Skipping %s since it's incompatible=
 with Linux" % pkg)
-                    return
-        filename =3D self._runpack(ud, d, pkgfullname)
-        data[pkg] =3D {}
-        data[pkg]['tgz'] =3D filename
-        fetchedlist.append(pkgfullname)
-
-        dependencies =3D pdata.get('dependencies', {})
-        optionalDependencies =3D pdata.get('optionalDependencies', {})
-        dependencies.update(optionalDependencies)
-        depsfound =3D {}
-        optdepsfound =3D {}
-        data[pkg]['deps'] =3D {}
-        for dep in dependencies:
-            if dep in optionalDependencies:
-                optdepsfound[dep] =3D dependencies[dep]
+            ud.localfile =3D npm_localfile(ud.package, ud.version)
+
+        # Get the base 'npm' command
+        ud.basecmd =3D d.getVar("FETCHCMD_npm") or "npm"
+
+        # This fetcher resolves a URI from a npm package name and versio=
n and
+        # then forwards it to a proxy fetcher. A resolve file containing=
 the
+        # resolved URI is created to avoid unwanted network access (if t=
he file
+        # already exists). The management of the donestamp file, the loc=
kfile
+        # and the checksums are forwarded to the proxy fetcher.
+        ud.proxy =3D None
+        ud.needdonestamp =3D False
+        ud.resolvefile =3D self.localpath(ud, d) + ".resolved"
+
+    def _resolve_proxy_url(self, ud, d):
+        def _npm_view():
+            configs =3D []
+            configs.append(("json", "true"))
+            configs.append(("registry", ud.registry))
+            cmd =3D ud.basecmd + " view '%s@%s'" % (ud.package, ud.versi=
on)
+            env =3D NpmEnvironment(d)
+            check_network_access(d, cmd, ud.registry)
+            view_string =3D env.run(cmd, configs=3Dconfigs)
+
+            if not view_string:
+                raise FetchError("Unavailable package '%s@%s'" % \
+                                 ud.package, ud.version, ud.registry, ud=
.url)
+
+            try:
+                view =3D json.loads(view_string)
+
+                error =3D view.get("error")
+                if error is not None:
+                    raise FetchError(error.get("summary"), ud.url)
+
+                if ud.version =3D=3D "latest":
+                    bb.warn("The npm package '%s' is using the latest " =
\
+                            "version available. This could lead to " \
+                            "non-reproducible builds." % ud.package)
+                elif ud.version !=3D view.get("version"):
+                    raise ParameterError("Invalid 'version' parameter", =
ud.url)
+
+                return view
+
+            except Exception as e:
+                raise FetchError("Invalid view from npm: %s" % str(e), u=
d.url)
+
+        def _get_url(view):
+            tarball_url =3D view.get("dist", {}).get("tarball")
+
+            if tarball_url is None:
+                raise FetchError("Invalid 'dist.tarball' in view", ud.ur=
l)
+
+            uri =3D URI(tarball_url)
+            uri.params["downloadfilename"] =3D ud.localfile
+
+            integrity =3D view.get("dist", {}).get("integrity")
+            shasum =3D view.get("dist", {}).get("shasum")
+
+            if integrity is not None:
+                checksum_name, checksum_expected =3D npm_integrity(integ=
rity)
+                uri.params[checksum_name] =3D checksum_expected
+            elif shasum is not None:
+                uri.params["sha1sum"] =3D shasum
             else:
-                depsfound[dep] =3D dependencies[dep]
-        for dep, version in optdepsfound.items():
-            self._getdependencies(dep, data[pkg]['deps'], version, d, ud=
, optional=3DTrue, fetchedlist=3Dfetchedlist)
-        for dep, version in depsfound.items():
-            self._getdependencies(dep, data[pkg]['deps'], version, d, ud=
, fetchedlist=3Dfetchedlist)
-
-    def _getshrinkeddependencies(self, pkg, data, version, d, ud, lockdo=
wn, manifest, toplevel=3DTrue):
-        logger.debug(2, "NPM shrinkwrap file is %s" % data)
-        if toplevel:
-            name =3D data.get('name', None)
-            if name and name !=3D pkg:
-                for obj in data.get('dependencies', []):
-                    if obj =3D=3D pkg:
-                        self._getshrinkeddependencies(obj, data['depende=
ncies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, mani=
fest, False)
-                        return
-
-        pkgnameWithVersion =3D "{}@{}".format(pkg, version)
-        logger.debug(2, "Get dependencies for {}".format(pkgnameWithVers=
ion))
-        filename =3D self._runpack(ud, d, pkgnameWithVersion)
-        manifest[pkg] =3D {}
-        manifest[pkg]['tgz'] =3D filename
-        manifest[pkg]['deps'] =3D {}
-
-        if pkg in lockdown:
-            sha1_expected =3D lockdown[pkg][version]
-            sha1_data =3D bb.utils.sha1_file("npm/%s/%s" % (ud.pkgname, =
manifest[pkg]['tgz']))
-            if sha1_expected !=3D sha1_data:
-                msg =3D "\nFile: '%s' has %s checksum %s when %s was exp=
ected" % (manifest[pkg]['tgz'], 'sha1', sha1_data, sha1_expected)
-                raise ChecksumError('Checksum mismatch!%s' % msg)
-        else:
-            logger.debug(2, "No lockdown data for %s@%s" % (pkg, version=
))
+                raise FetchError("Invalid 'dist.integrity' in view", ud.=
url)
=20
-        if 'dependencies' in data:
-            for obj in data['dependencies']:
-                logger.debug(2, "Found dep is %s" % str(obj))
-                self._getshrinkeddependencies(obj, data['dependencies'][=
obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest[pkg=
]['deps'], False)
+            return str(uri)
+
+        url =3D _get_url(_npm_view())
+
+        bb.utils.mkdirhier(os.path.dirname(ud.resolvefile))
+        with open(ud.resolvefile, "w") as f:
+            f.write(url)
+
+    def _setup_proxy(self, ud, d):
+        if ud.proxy is None:
+            if not os.path.exists(ud.resolvefile):
+                self._resolve_proxy_url(ud, d)
+
+            with open(ud.resolvefile, "r") as f:
+                url =3D f.read()
+
+            # Avoid conflicts between the environment data and:
+            # - the proxy url checksum
+            data =3D bb.data.createCopy(d)
+            data.delVarFlags("SRC_URI")
+            ud.proxy =3D Fetch([url], data)
+
+    def _get_proxy_method(self, ud, d):
+        self._setup_proxy(ud, d)
+        proxy_url =3D ud.proxy.urls[0]
+        proxy_ud =3D ud.proxy.ud[proxy_url]
+        proxy_d =3D ud.proxy.d
+        proxy_ud.setup_localpath(proxy_d)
+        return proxy_ud.method, proxy_ud, proxy_d
+
+    def verify_donestamp(self, ud, d):
+        """Verify the donestamp file"""
+        proxy_m, proxy_ud, proxy_d =3D self._get_proxy_method(ud, d)
+        return proxy_m.verify_donestamp(proxy_ud, proxy_d)
+
+    def update_donestamp(self, ud, d):
+        """Update the donestamp file"""
+        proxy_m, proxy_ud, proxy_d =3D self._get_proxy_method(ud, d)
+        proxy_m.update_donestamp(proxy_ud, proxy_d)
+
+    def need_update(self, ud, d):
+        """Force a fetch, even if localpath exists ?"""
+        if not os.path.exists(ud.resolvefile):
+            return True
+        if ud.version =3D=3D "latest":
+            return True
+        proxy_m, proxy_ud, proxy_d =3D self._get_proxy_method(ud, d)
+        return proxy_m.need_update(proxy_ud, proxy_d)
+
+    def try_mirrors(self, fetch, ud, d, mirrors):
+        """Try to use a mirror"""
+        proxy_m, proxy_ud, proxy_d =3D self._get_proxy_method(ud, d)
+        return proxy_m.try_mirrors(fetch, proxy_ud, proxy_d, mirrors)
=20
     def download(self, ud, d):
         """Fetch url"""
-        jsondepobj =3D {}
-        shrinkobj =3D {}
-        lockdown =3D {}
-
-        if not os.listdir(ud.pkgdatadir) and os.path.exists(ud.fullmirro=
r):
-            dest =3D d.getVar("DL_DIR")
-            bb.utils.mkdirhier(dest)
-            runfetchcmd("tar -xJf %s" % (ud.fullmirror), d, workdir=3Dde=
st)
-            return
-
-        if ud.parm.get("noverify", None) !=3D '1':
-            shwrf =3D d.getVar('NPM_SHRINKWRAP')
-            logger.debug(2, "NPM shrinkwrap file is %s" % shwrf)
-            if shwrf:
-                try:
-                    with open(shwrf) as datafile:
-                        shrinkobj =3D json.load(datafile)
-                except Exception as e:
-                    raise FetchError('Error loading NPM_SHRINKWRAP file =
"%s" for %s: %s' % (shwrf, ud.pkgname, str(e)))
-            elif not ud.ignore_checksums:
-                logger.warning('Missing shrinkwrap file in NPM_SHRINKWRA=
P for %s, this will lead to unreliable builds!' % ud.pkgname)
-            lckdf =3D d.getVar('NPM_LOCKDOWN')
-            logger.debug(2, "NPM lockdown file is %s" % lckdf)
-            if lckdf:
-                try:
-                    with open(lckdf) as datafile:
-                        lockdown =3D json.load(datafile)
-                except Exception as e:
-                    raise FetchError('Error loading NPM_LOCKDOWN file "%=
s" for %s: %s' % (lckdf, ud.pkgname, str(e)))
-            elif not ud.ignore_checksums:
-                logger.warning('Missing lockdown file in NPM_LOCKDOWN fo=
r %s, this will lead to unreproducible builds!' % ud.pkgname)
-
-        if ('name' not in shrinkobj):
-            self._getdependencies(ud.pkgname, jsondepobj, ud.version, d,=
 ud)
-        else:
-            self._getshrinkeddependencies(ud.pkgname, shrinkobj, ud.vers=
ion, d, ud, lockdown, jsondepobj)
-
-        with open(ud.localpath, 'w') as outfile:
-            json.dump(jsondepobj, outfile)
-
-    def build_mirror_data(self, ud, d):
-        # Generate a mirror tarball if needed
-        if ud.write_tarballs and not os.path.exists(ud.fullmirror):
-            # it's possible that this symlink points to read-only filesy=
stem with PREMIRROR
-            if os.path.islink(ud.fullmirror):
-                os.unlink(ud.fullmirror)
-
-            dldir =3D d.getVar("DL_DIR")
-            logger.info("Creating tarball of npm data")
-            runfetchcmd("tar -cJf %s npm/%s npm/%s" % (ud.fullmirror, ud=
.bbnpmmanifest, ud.pkgname), d,
-                        workdir=3Ddldir)
-            runfetchcmd("touch %s.done" % (ud.fullmirror), d, workdir=3D=
dldir)
+        self._setup_proxy(ud, d)
+        ud.proxy.download()
+
+    def unpack(self, ud, rootdir, d):
+        """Unpack the downloaded archive"""
+        destsuffix =3D ud.parm.get("destsuffix", "npm")
+        destdir =3D os.path.join(rootdir, destsuffix)
+        npm_unpack(ud.localpath, destdir, d)
+
+    def clean(self, ud, d):
+        """Clean any existing full or partial download"""
+        if os.path.exists(ud.resolvefile):
+            self._setup_proxy(ud, d)
+            ud.proxy.clean()
+            bb.utils.remove(ud.resolvefile)
+
+    def done(self, ud, d):
+        """Is the download done ?"""
+        if not os.path.exists(ud.resolvefile):
+            return False
+        proxy_m, proxy_ud, proxy_d =3D self._get_proxy_method(ud, d)
+        return proxy_m.done(proxy_ud, proxy_d)
--=20
2.20.1


