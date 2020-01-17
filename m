Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 146257FA21
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 16:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0BB119C0472;
	Fri, 17 Jan 2020 11:46:07 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id o8Rnd9Ev5BSz; Fri, 17 Jan 2020 11:46:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BF2399C046F;
	Fri, 17 Jan 2020 11:46:05 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id 7Z66GS01ERE1; Fri, 17 Jan 2020 11:46:05 -0500 (EST)
Received: from sulaco.example.com (40.73.12.109.rev.sfr.net [109.12.73.40])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D8CB79C046C;
	Fri, 17 Jan 2020 11:46:04 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jan 2020 17:45:47 +0100
Message-Id: <20200117164548.28453-12-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes-dev@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v4 11/12] bitbake: fetch2: add the npmsw fetcher
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

This commit adds a new npmsw fetcher that fetches every npm dependencies
described in a npm shrinkwrap file:

  https://docs.npmjs.com/files/shrinkwrap.json.html

The main package must be fetched separately:

  SRC_URI =3D "npm://registry.url;package=3Dfoobar;version=3D1.0.0 \
             npmsw://${THISDIR}/npm-shrinkwrap.json"

Since a separation has been created between the package and its
dependencies, the package can also be fetched with a non npm fetcher
without impacting the general behavior:

  SRC_URI =3D "git://github.com/foo/bar.git;protocol=3Dhttps \
             npmsw://${THISDIR}/npm-shrinkwrap.json"

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/__init__.py |   2 +
 lib/bb/fetch2/npmsw.py    | 255 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 257 insertions(+)
 create mode 100644 lib/bb/fetch2/npmsw.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5c89ef61..ded67dbc 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1894,6 +1894,7 @@ from . import osc
 from . import repo
 from . import clearcase
 from . import npm
+from . import npmsw
=20
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -1912,3 +1913,4 @@ methods.append(osc.Osc())
 methods.append(repo.Repo())
 methods.append(clearcase.ClearCase())
 methods.append(npm.Npm())
+methods.append(npmsw.NpmShrinkWrap())
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
new file mode 100644
index 00000000..0c3511d8
--- /dev/null
+++ b/lib/bb/fetch2/npmsw.py
@@ -0,0 +1,255 @@
+# Copyright (C) 2020 Savoir-Faire Linux
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+"""
+BitBake 'Fetch' npm shrinkwrap implementation
+
+npm fetcher support the SRC_URI with format of:
+SRC_URI =3D "npmsw://some.registry.url;OptionA=3Dxxx;OptionB=3Dxxx;..."
+
+Supported SRC_URI options are:
+
+- dev
+   Set to 1 to also install devDependencies.
+
+- destsuffix
+    Specifies the directory to use to unpack the dependencies (default: =
${S}).
+"""
+
+import json
+import os
+import re
+import bb
+from bb.fetch2 import Fetch
+from bb.fetch2 import FetchMethod
+from bb.fetch2 import ParameterError
+from bb.fetch2 import URI
+from bb.fetch2.npm import npm_integrity
+from bb.fetch2.npm import npm_localfile
+from bb.fetch2.npm import npm_unpack
+from bb.utils import is_semver
+
+def foreach_dependencies(shrinkwrap, callback=3DNone, dev=3DFalse):
+    """
+        Run a callback for each dependencies of a shrinkwrap file.
+        The callback is using the format:
+            callback(name, params, deptree)
+        with:
+            name =3D the package name (string)
+            params =3D the package parameters (dictionary)
+            deptree =3D the package dependency tree (array of strings)
+    """
+    def _walk_deps(deps, deptree):
+        for name in deps:
+            subtree =3D [*deptree, name]
+            _walk_deps(deps[name].get("dependencies", {}), subtree)
+            if callback is not None:
+                if deps[name].get("dev", False) and not dev:
+                    continue
+                elif deps[name].get("bundled", False):
+                    continue
+                callback(name, deps[name], subtree)
+
+    _walk_deps(shrinkwrap.get("dependencies", {}), [])
+
+class NpmShrinkWrap(FetchMethod):
+    """Class to fetch all package from a shrinkwrap file"""
+
+    def supports(self, ud, d):
+        """Check if a given url can be fetched with npmsw"""
+        return ud.type in ["npmsw"]
+
+    def urldata_init(self, ud, d):
+        """Init npmsw specific variables within url data"""
+
+        # Get the 'shrinkwrap' parameter
+        ud.shrinkwrap_file =3D re.sub(r"^npmsw://", "", ud.url.split(";"=
)[0])
+
+        # Get the 'dev' parameter
+        ud.dev =3D bb.utils.to_boolean(ud.parm.get("dev"), False)
+
+        # Resolve the dependencies
+        ud.deps =3D []
+
+        def _resolve_dependency(name, params, deptree):
+            url =3D None
+            localpath =3D None
+            extrapaths =3D []
+            destsubdirs =3D [os.path.join("node_modules", dep) for dep i=
n deptree]
+            destsuffix =3D os.path.join(*destsubdirs)
+
+            integrity =3D params.get("integrity", None)
+            resolved =3D params.get("resolved", None)
+            version =3D params.get("version", None)
+
+            # Handle registry sources
+            if is_semver(version) and resolved and integrity:
+                localfile =3D npm_localfile(name, version)
+
+                uri =3D URI(resolved)
+                uri.params["downloadfilename"] =3D localfile
+
+                checksum_name, checksum_expected =3D npm_integrity(integ=
rity)
+                uri.params[checksum_name] =3D checksum_expected
+
+                url =3D str(uri)
+
+                localpath =3D os.path.join(d.getVar("DL_DIR"), localfile=
)
+
+                # Create a resolve file to mimic the npm fetcher and all=
ow
+                # re-usability of the downloaded file.
+                resolvefile =3D localpath + ".resolved"
+
+                bb.utils.mkdirhier(os.path.dirname(resolvefile))
+                with open(resolvefile, "w") as f:
+                    f.write(url)
+
+                extrapaths.append(resolvefile)
+
+            # Handle http tarball sources
+            elif version.startswith("http") and integrity:
+                localfile =3D os.path.join("npm2", os.path.basename(vers=
ion))
+
+                uri =3D URI(version)
+                uri.params["downloadfilename"] =3D localfile
+
+                checksum_name, checksum_expected =3D npm_integrity(integ=
rity)
+                uri.params[checksum_name] =3D checksum_expected
+
+                url =3D str(uri)
+
+                localpath =3D os.path.join(d.getVar("DL_DIR"), localfile=
)
+
+            # Handle git sources
+            elif version.startswith("git"):
+                regex =3D re.compile(r"""
+                    ^
+                    git\+
+                    (?P<protocol>[a-z]+)
+                    ://
+                    (?P<url>[^#]+)
+                    \#
+                    (?P<rev>[0-9a-f]+)
+                    $
+                    """, re.VERBOSE)
+
+                match =3D regex.match(version)
+
+                if not match:
+                    raise ParameterError("Invalid git url: %s" % version=
, ud.url)
+
+                groups =3D match.groupdict()
+
+                uri =3D URI("git://" + str(groups["url"]))
+                uri.params["protocol"] =3D str(groups["protocol"])
+                uri.params["rev"] =3D str(groups["rev"])
+                uri.params["destsuffix"] =3D destsuffix
+
+                url =3D str(uri)
+
+            # local tarball sources and local link sources are unsupport=
ed
+            else:
+                raise ParameterError("Unsupported dependency: %s" % name=
, ud.url)
+
+            ud.deps.append({
+                "url": url,
+                "localpath": localpath,
+                "extrapaths": extrapaths,
+                "destsuffix": destsuffix,
+            })
+
+        try:
+            with open(ud.shrinkwrap_file, "r") as f:
+                shrinkwrap =3D json.load(f)
+        except Exception as e:
+            raise ParameterError("Invalid shrinkwrap file: %s" % str(e),=
 ud.url)
+
+        foreach_dependencies(shrinkwrap, _resolve_dependency, ud.dev)
+
+        # Avoid conflicts between the environment data and:
+        # - the proxy url revision
+        # - the proxy url checksum
+        data =3D bb.data.createCopy(d)
+        data.delVar("SRCREV")
+        data.delVarFlags("SRC_URI")
+
+        # This fetcher resolves multiple URIs from a shrinkwrap file and=
 then
+        # forwards it to a proxy fetcher. The management of the donestam=
p file,
+        # the lockfile and the checksums are forwarded to the proxy fetc=
her.
+        ud.proxy =3D Fetch([dep["url"] for dep in ud.deps], data)
+        ud.needdonestamp =3D False
+
+    @staticmethod
+    def _foreach_proxy_method(ud, handle):
+        returns =3D []
+        for proxy_url in ud.proxy.urls:
+            proxy_ud =3D ud.proxy.ud[proxy_url]
+            proxy_d =3D ud.proxy.d
+            proxy_ud.setup_localpath(proxy_d)
+            returns.append(handle(proxy_ud.method, proxy_ud, proxy_d))
+        return returns
+
+    def verify_donestamp(self, ud, d):
+        """Verify the donestamp file"""
+        def _handle(m, ud, d):
+            return m.verify_donestamp(ud, d)
+        return all(self._foreach_proxy_method(ud, _handle))
+
+    def update_donestamp(self, ud, d):
+        """Update the donestamp file"""
+        def _handle(m, ud, d):
+            m.update_donestamp(ud, d)
+        self._foreach_proxy_method(ud, _handle)
+
+    def need_update(self, ud, d):
+        """Force a fetch, even if localpath exists ?"""
+        def _handle(m, ud, d):
+            return m.need_update(ud, d)
+        return all(self._foreach_proxy_method(ud, _handle))
+
+    def try_mirrors(self, fetch, ud, d, mirrors):
+        """Try to use a mirror"""
+        def _handle(m, ud, d):
+            return m.try_mirrors(fetch, ud, d, mirrors)
+        return all(self._foreach_proxy_method(ud, _handle))
+
+    def download(self, ud, d):
+        """Fetch url"""
+        ud.proxy.download()
+
+    def unpack(self, ud, rootdir, d):
+        """Unpack the downloaded dependencies"""
+        destdir =3D d.getVar("S")
+        destsuffix =3D ud.parm.get("destsuffix")
+        if destsuffix:
+            destdir =3D os.path.join(rootdir, destsuffix)
+
+        bb.utils.mkdirhier(destdir)
+        bb.utils.copyfile(ud.shrinkwrap_file,
+                          os.path.join(destdir, "npm-shrinkwrap.json"))
+
+        auto =3D [dep["url"] for dep in ud.deps if not dep["localpath"]]
+        manual =3D [dep for dep in ud.deps if dep["localpath"]]
+
+        if auto:
+            ud.proxy.unpack(destdir, auto)
+
+        for dep in manual:
+            depdestdir =3D os.path.join(destdir, dep["destsuffix"])
+            npm_unpack(dep["localpath"], depdestdir, d)
+
+    def clean(self, ud, d):
+        """Clean any existing full or partial download"""
+        ud.proxy.clean()
+
+        # Clean extra files
+        for dep in ud.deps:
+            for path in dep["extrapaths"]:
+                bb.utils.remove(path)
+
+    def done(self, ud, d):
+        """Is the download done ?"""
+        def _handle(m, ud, d):
+            return m.done(ud, d)
+        return all(self._foreach_proxy_method(ud, _handle))
--=20
2.20.1


