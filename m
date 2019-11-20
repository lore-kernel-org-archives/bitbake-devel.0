Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 431727F867
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2019 09:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7EEB89C0422;
	Wed, 20 Nov 2019 04:34:38 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id L_FZlBZVifuO; Wed, 20 Nov 2019 04:34:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id ADB1B9C0423;
	Wed, 20 Nov 2019 04:34:37 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id Ohb4p5mcyvly; Wed, 20 Nov 2019 04:34:37 -0500 (EST)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CD3789C03AF;
	Wed, 20 Nov 2019 04:34:36 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Nov 2019 10:34:09 +0100
Message-Id: <20191120093412.11519-5-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v3 4/7] fetch2/npm.py: add utility functions to handle dependencies
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
X-List-Received-Date: Wed, 20 Nov 2019 09:34:37 -0000
Content-Transfer-Encoding: quoted-printable

These utility functions are used parse a shrinkwrap file and run actions
for each dependencies. Some actions are also provided like fetching and
unpacking. They will be useful in the class and recipetool.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/npm.py | 95 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index e253cf3e..bd6e32ca 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -243,3 +243,98 @@ class Npm(FetchMethod):
         cmd +=3D " --no-same-owner"
         cmd +=3D " --transform 's:^package/:npm/:'"
         runfetchcmd(cmd, d, workdir=3Drootdir)
+
+def _parse_shrinkwrap(d, shrinkwrap_file=3DNone):
+    """
+        Find and parse the shrinkwrap file to use.
+    """
+
+    def get_shrinkwrap_file(d):
+        src_shrinkwrap =3D d.expand("${S}/npm-shrinkwrap.json")
+        npm_shrinkwrap =3D d.getVar("NPM_SHRINKWRAP")
+
+        if os.path.exists(src_shrinkwrap):
+            bb.note("Using the npm-shrinkwrap.json provided in the sourc=
es")
+            return src_shrinkwrap
+        elif os.path.exists(npm_shrinkwrap):
+            return npm_shrinkwrap
+
+        bb.fatal("No mandatory NPM_SHRINKWRAP file found")
+
+    if shrinkwrap_file is None:
+        shrinkwrap_file =3D get_shrinkwrap_file(d)
+
+    with open(shrinkwrap_file, "r") as f:
+        shrinkwrap =3D json.load(f)
+
+    return shrinkwrap
+
+def foreach_dependencies(d, callback=3DNone, shrinkwrap_file=3DNone):
+    """
+        Run a callback for each dependencies of a shrinkwrap file.
+        The callback is using the format:
+            callback(name, version, deptree)
+        with:
+            name =3D the packet name (string)
+            version =3D the packet version (string)
+            deptree =3D the package dependency tree (array of strings)
+    """
+    shrinkwrap =3D _parse_shrinkwrap(d, shrinkwrap_file)
+
+    def walk_deps(deps, deptree):
+        out =3D []
+
+        for name in deps:
+            version =3D deps[name]["version"]
+            subtree =3D [*deptree, name]
+            out.extend(walk_deps(deps[name].get("dependencies", {}), sub=
tree))
+            if callback is not None:
+                out.append(callback(name, version, subtree))
+
+        return out
+
+    return walk_deps(shrinkwrap.get("dependencies", {}), [])
+
+def _get_url(d, name, version):
+    registry =3D re.sub(r"https?://", "npm://", d.getVar("NPM_REGISTRY")=
)
+    url =3D "{};name=3D{};version=3D{}".format(registry, name, version)
+    return url
+
+def fetch_dependency(d, name, version):
+    """
+        Fetch a dependency and return the tarball path.
+    """
+    url =3D _get_url(d, name, version)
+    fetcher =3D bb.fetch2.Fetch([url], d)
+    fetcher.download()
+    return fetcher.localpath(url)
+
+def fetch_dependencies(d, shrinkwrap_file=3DNone):
+    """
+        Fetch all dependencies of a shrinkwrap file.
+    """
+
+    def handle_dependency(name, version, *unused):
+        fetch_dependency(d, name, version)
+
+    foreach_dependencies(d, handle_dependency, shrinkwrap_file)
+
+def unpack_dependencies(d, shrinkwrap_file=3DNone):
+    """
+        Unpack all dependencies of a shrinkwrap file. The dependencies a=
re
+        unpacked in the source tree and added to the npm cache.
+    """
+    bb.utils.remove(d.getVar("NPM_CACHE_DIR"), recurse=3DTrue)
+
+    def cache_dependency(tarball):
+        cmd =3D "npm cache add '{}'".format(tarball)
+        cmd +=3D d.expand(" --cache=3D${NPM_CACHE_DIR}")
+        runfetchcmd(cmd, d)
+
+    def handle_dependency(name, version, *unused):
+        url =3D _get_url(d, name, version)
+        fetcher =3D bb.fetch2.Fetch([url], d)
+        tarball =3D fetcher.localpath(url)
+        cache_dependency(tarball)
+
+    foreach_dependencies(d, handle_dependency, shrinkwrap_file)
--=20
2.20.1


