Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 42BF27FA78
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2019 08:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 786E89C0325;
	Fri, 25 Oct 2019 04:39:36 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id bp31Jc344mMx; Fri, 25 Oct 2019 04:39:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8985C9C02FE;
	Fri, 25 Oct 2019 04:39:34 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id XVhZ_ZdGx9ro; Fri, 25 Oct 2019 04:39:34 -0400 (EDT)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B596F9C0325;
	Fri, 25 Oct 2019 04:39:33 -0400 (EDT)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Oct 2019 10:39:24 +0200
Message-Id: <20191025083925.14535-3-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025083925.14535-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20191025083925.14535-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [RFC][PATCH v2 2/3] fetch2/npm.py: refactor the npm fetcher
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
X-List-Received-Date: Fri, 25 Oct 2019 08:39:35 -0000
Content-Transfer-Encoding: quoted-printable

This commit refactors the npm fetcher to improve some points and fix
others:

 - The big change is that the fetcher is only fetching the package
   source and no more the dependencies. Thus the npm fetcher act as the
   other fetchers e.g git, wget. The dependencies will now be fetched
   by the npm class.

 - This commit also fixes a lot of issues with the package names (exotic
   characters, scoped packages) which were badly handled.

 - The validation files - lockdown.json and npm-shrinkwrap.json - are no
   longer used by the fetcher. Instead, the downloaded tarball is
   validated with the 'integrity' and 'shasum' provided in the npm view
   of the package [1] [2].

 - The lockdown file had generation issues and is no longer relevant
   with the latest shrinkwrap files. The shrinkwrap file is now used
   by the npm class.

1: https://docs.npmjs.com/files/package-lock.json#integrity
2: https://w3c.github.io/webappsec/specs/subresourceintegrity

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/npm.py | 475 +++++++++++++++++++------------------------
 1 file changed, 211 insertions(+), 264 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 9700e610..854ee158 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -1,301 +1,248 @@
+# Copyright (C) 2019 Savoir-Faire Linux
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
+- name
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
+from bb.fetch2 import ChecksumError
+from bb.fetch2 import FetchError
+from bb.fetch2 import MissingParameterError
+from bb.fetch2 import ParameterError
+from bb.fetch2 import FetchMethod
+from bb.fetch2 import URI
+from bb.fetch2 import check_network_access
+from bb.fetch2 import logger
+from bb.fetch2 import runfetchcmd
+from bb.fetch2.wget import WgetProgressHandler
=20
 class Npm(FetchMethod):
-
-    """Class to fetch urls via 'npm'"""
-    def init(self, d):
-        pass
+    """
+        Class to fetch a package from a npm registry
+    """
=20
     def supports(self, ud, d):
         """
-        Check to see if a given url can be fetched with npm
+            Check if a given url can be fetched with npm
         """
-        return ud.type in ['npm']
-
-    def debug(self, msg):
-        logger.debug(1, "NpmFetch: %s", msg)
=20
-    def clean(self, ud, d):
-        logger.debug(2, "Calling cleanup %s" % ud.pkgname)
-        bb.utils.remove(ud.localpath, False)
-        bb.utils.remove(ud.pkgdatadir, True)
-        bb.utils.remove(ud.fullmirror, False)
+        return ud.type in ['npm']
=20
     def urldata_init(self, ud, d):
         """
-        init NPM specific variable within url data
+            Init npm specific variables within url data
         """
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
+
+        # Get the 'name' parameter
+        if "name" in ud.parm:
+            ud.name =3D ud.parm.get("name")
+
+        if not ud.name:
+            raise MissingParameterError("Parameter 'name' required", ud.=
url)
+
+        # Get the 'version' parameter
+        if "version" in ud.parm:
+            ud.version =3D ud.parm.get("version")
+
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
+
+        # Get the 'registry' part of the url
+        ud.registry =3D ud.url.replace("npm://", "http://", 1).split(";"=
)[0]
+
+        # Update the NPM_REGISTRY in the environment
+        d.setVar("NPM_REGISTRY", ud.registry)
+
+        # Using the 'downloadfilename' parameter as local filename or th=
e
+        # npm package name.
+        if "downloadfilename" in ud.parm:
+            ud.basename =3D ud.parm["downloadfilename"]
+        else:
+            # Scoped package names (with the @) use the same naming conv=
ention
+            # as the 'npm pack' command.
+            if ud.name.startswith("@"):
+                ud.basename =3D re.sub("/", "-", ud.name[1:])
+            else:
+                ud.basename =3D ud.name
+            ud.basename +=3D "-" + ud.version + ".tgz"
+
+        ud.localfile =3D d.expand(ud.basename)
+
+        ud.basecmd =3D d.getVar("FETCHCMD_wget")
+
+        if not ud.basecmd:
+            ud.basecmd =3D "wget"
+            ud.basecmd +=3D " --tries=3D2"
+            ud.basecmd +=3D " --timeout=3D30"
+            ud.basecmd +=3D " --passive-ftp"
+            ud.basecmd +=3D " --no-check-certificate"
+
+    @staticmethod
+    def _run_npm_view(ud, d):
+        """
+            Run the 'npm view' command to get informations about a npm p=
ackage.
+        """
+
+        cmd =3D "npm view"
+        cmd +=3D " --json"
+        cmd +=3D " --registry {}".format(ud.registry)
+        cmd +=3D " '{}@{}'".format(ud.name, ud.version)
+
+        check_network_access(d, cmd, ud.registry)
+
+        view_string =3D runfetchcmd(cmd, d)
+
+        if not view_string:
+            raise ParameterError("Parameter 'version' is invalid", ud.ur=
l)
+
+        view =3D json.loads(view_string)
+
+        if view.get("error") is not None:
+            raise ParameterError(view.get("error", {}).get("summary"), u=
d.url)
+
+        if isinstance(view, list):
+            return view[-1]
+
+        return view
=20
     def need_update(self, ud, d):
+        """
+            Force a fetch, even if localpath exists?
+        """
+
+        # Note that when using a version which does not exist on the reg=
istry
+        # (like 'version=3Dfoo') the local filename will use this versio=
n
+        # string (e.g 'my-package-foo.tgz') but the actual downloaded fi=
le
+        # will be the latest version available on the registry (e.g '1.2=
.3').
+        #
+        # This trick can be useful with devtool / recipetool to automati=
cally
+        # fetch the latest version, BUT these files (the ones with non-e=
xistent
+        # versions) must be updated every times. To reduce issues due to=
 this
+        # behavior, only the 'latest' keyword can be used. All the other
+        # non-existent versions are rejected.
+
+        view =3D self._run_npm_view(ud, d)
+
+        if ud.version !=3D view.get("version"):
+            if ud.version =3D=3D "latest":
+                return True
+            else:
+                raise ParameterError("Parameter 'version' is invalid", u=
d.url)
+
         if os.path.exists(ud.localpath):
             return False
+
         return True
=20
-    def _runpack(self, ud, d, pkgfullname: str, quiet=3DFalse) -> str:
+    @staticmethod
+    def _run_wget(ud, d, cmd):
         """
-        Runs npm pack on a full package name.
-        Returns the filename of the downloaded package
+            Run the 'wget' command with download progress status
         """
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
-        else:
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
-            else:
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
=20
-        if 'dependencies' in data:
-            for obj in data['dependencies']:
-                logger.debug(2, "Found dep is %s" % str(obj))
-                self._getshrinkeddependencies(obj, data['dependencies'][=
obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest[pkg=
]['deps'], False)
+        progresshandler =3D WgetProgressHandler(d)
+
+        check_network_access(d, cmd, ud.url)
+
+        cmd +=3D " --progress=3Ddot"
+        cmd +=3D " --verbose"
+
+        runfetchcmd(cmd, d, log=3Dprogresshandler)
+
+    @staticmethod
+    def _check_integrity(integrity, filename):
+        """
+            Check the subresource integrity.
+
+            https://w3c.github.io/webappsec-subresource-integrity
+            https://www.w3.org/TR/CSP2/#source-list-syntax
+        """
+        algo, value_b64 =3D integrity.split("-", maxsplit=3D1)
+        value_hex =3D base64.b64decode(value_b64).hex()
+
+        if algo =3D=3D "sha256":
+            return value_hex =3D=3D bb.utils.sha256_file(filename)
+        elif algo =3D=3D "sha384":
+            return value_hex =3D=3D bb.utils.sha384_file(filename)
+        elif algo =3D=3D "sha512":
+            return value_hex =3D=3D bb.utils.sha512_file(filename)
=20
     def download(self, ud, d):
-        """Fetch url"""
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
+        """
+            Fetch url
+        """
+
+        view =3D self._run_npm_view(ud, d)
+
+        uri =3D URI(view.get("dist", {}).get("tarball"))
+        integrity =3D view.get("dist", {}).get("integrity")
+        shasum =3D view.get("dist", {}).get("shasum")
+
+        # Check if version is valid
+        if ud.version !=3D view.get("version"):
+            if ud.version =3D=3D "latest":
+                logger.warning("The npm package '{}' is using the latest=
 " \
+                               "version available. This could lead to " =
\
+                               "non-reproducible builds.".format(ud.name=
))
+            else:
+                raise ParameterError("Parameter 'version' is invalid", u=
d.url)
+
+        cmd =3D ud.basecmd
+
+        bb.utils.mkdirhier(os.path.dirname(ud.localpath))
+        cmd +=3D " --output-document=3D'{}'".format(ud.localpath)
+
+        if os.path.exists(ud.localpath):
+            cmd +=3D " --continue"
+
+        cmd +=3D d.expand(" --directory-prefix=3D${DL_DIR}")
+        cmd +=3D " '{}'".format(uri)
+
+        self._run_wget(ud, d, cmd)
+
+        if not os.path.exists(ud.localpath):
+            raise FetchError("The fetched file does not exist")
+
+        if os.path.getsize(ud.localpath) =3D=3D 0:
+            os.remove(ud.localpath)
+            raise FetchError("The fetched file is empty")
+
+        if integrity is not None:
+            if not self._check_integrity(integrity, ud.localpath):
+                raise ChecksumError("The fetched file integrity mismatch=
")
+        elif shasum is not None:
+            if shasum !=3D bb.utils.sha1_file(ud.localpath):
+                raise ChecksumError("The fetched file shasum mismatch")
+
+    def unpack(self, ud, rootdir, d):
+        """
+            Unpack the downloaded archive to rootdir
+        """
+
+        cmd =3D "tar --extract --gzip"
+        cmd +=3D " --no-same-owner"
+        cmd +=3D " --transform 's:^package/:npm/:'"
+        cmd +=3D " --file=3D'{}'".format(ud.localpath)
+
+        runfetchcmd(cmd, d, workdir=3Drootdir)
--=20
2.20.1


