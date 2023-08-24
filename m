Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176F3C6FA8F
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 15:57:06 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.897.1692892622382159128
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Aug 2023 08:57:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@pianon.eu header.s=mail20151219 header.b=uQ1nBU0Y;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 3F47B5C0097;
	Thu, 24 Aug 2023 17:57:00 +0200 (CEST)
Authentication-Results: server3.justice4all.it (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=pianon.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from; s=mail20151219; t=1692892619;
	 x=1694707020; bh=CLZ8LXaR6gkTv92UDsdxxP6f9YleTQnFv0Ycf+kttL8=; b=
	uQ1nBU0Y43n0hSniQQT5fN5byJKkrTT62onHYgP/Lhon4TX0A5KABDAYPBZ3Hhk8
	FkpC+HL9YtJzazW0RYpHK9KIYkrIsqyMSg8vTeHB6jVVWWw2Azjhe7rxYFoIb5Y4
	121/XNwegBKYoB3Xd5pagEKrbJWobG1yLDkVKzsrcJk=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aTpgi8mjJ991; Thu, 24 Aug 2023 17:56:59 +0200 (CEST)
Received: from alberto-L140CU.lan (host-62-211-185-238.pool62211.interbusiness.it [62.211.185.238])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPSA id 847E25C0095;
	Thu, 24 Aug 2023 17:56:58 +0200 (CEST)
From: alberto@pianon.eu
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org,
	jpewhacker@gmail.com,
	carlo@piana.eu,
	luca.ceresoli@bootlin.com,
	peter.kjellerstedt@axis.com,
	Alberto Pianon <alberto@pianon.eu>
Subject: [PATCH v4 1/3] fetch2: Add support for upstream source tracing
Date: Thu, 24 Aug 2023 17:56:54 +0200
Message-Id: <20230824155655.448755-1-alberto@pianon.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 15:57:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14976

From: Alberto Pianon <alberto@pianon.eu>

License compliance and SBoM generation require to be able to trace each
source file back to its corresponding upstream source. The current
implementation of bb.fetch2 makes it difficult, especially when multiple
upstream sources are combined together.

This patch provides an interface to solve the issue by implementing a
process that unpacks each SRC_URI element into a temporary directory,
creates an entrypoint to collect relevant provenance metadata on each
source file, moves everything to the recipe rootdir, and saves metadata
in a JSON file.

This patch contains required modifications to fetchers' code plus a
TraceUnpackBase class that implements the above described process. Data
collection logic should be separately implemented by subclassing
TraceUnpackBase, implementing _collect_data() and _process_data()
methods.

Splitting the above described solution in multiple patches and in
multiple modules/classes aims at easing review and merge process, and
also at decoupling the development of the data collection logic from the
process that enables it.

Signed-off-by: Alberto Pianon <alberto@pianon.eu>
---
 bin/bitbake-selftest        |   1 +
 lib/bb/fetch2/__init__.py   |  55 +++++++-
 lib/bb/fetch2/crate.py      |   2 +
 lib/bb/fetch2/gitsm.py      |  24 +++-
 lib/bb/fetch2/hg.py         |   1 +
 lib/bb/fetch2/npm.py        |   1 +
 lib/bb/fetch2/npmsw.py      |  25 +++-
 lib/bb/fetch2/trace_base.py | 256 ++++++++++++++++++++++++++++++++++++
 lib/bb/tests/trace_base.py  | 227 ++++++++++++++++++++++++++++++++
 9 files changed, 583 insertions(+), 9 deletions(-)
 create mode 100644 lib/bb/fetch2/trace_base.py
 create mode 100644 lib/bb/tests/trace_base.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index f25f23b1..6d60a5d2 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -31,6 +31,7 @@ tests =3D ["bb.tests.codeparser",
          "bb.tests.runqueue",
          "bb.tests.siggen",
          "bb.tests.utils",
+         "bb.tests.trace_base",
          "bb.tests.compression",
          "hashserv.tests",
          "layerindexlib.tests.layerindexobj",
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e4c1d206..aef5fcb4 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -28,6 +28,8 @@ import bb.checksum
 import bb.process
 import bb.event
=20
+from .trace_base import TraceUnpackBase
+
 __version__ =3D "2"
 _checksum_cache =3D bb.checksum.FileChecksumCache()
=20
@@ -1279,6 +1281,7 @@ class FetchData(object):
         if not self.pswd and "pswd" in self.parm:
             self.pswd =3D self.parm["pswd"]
         self.setup =3D False
+        self.destdir =3D None
=20
         def configure_checksum(checksum_id):
             if "name" in self.parm:
@@ -1557,6 +1560,8 @@ class FetchMethod(object):
             bb.utils.mkdirhier(unpackdir)
         else:
             unpackdir =3D rootdir
+        urldata.destdir =3D unpackdir
+        urldata.is_unpacked_archive =3D unpack and cmd
=20
         if not unpack or not cmd:
             # If file =3D=3D dest, then avoid any copies, as we already =
put the file into dest!
@@ -1572,6 +1577,7 @@ class FetchMethod(object):
                     if urlpath.find("/") !=3D -1:
                         destdir =3D urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir=
))
+                        urldata.destdir =3D "%s/%s" % (unpackdir, destdi=
r)
                 cmd =3D 'cp -fpPRH "%s" "%s"' % (file, destdir)
=20
         if not cmd:
@@ -1855,26 +1861,69 @@ class Fetch(object):
             if not ret:
                 raise FetchError("URL %s doesn't work" % u, u)
=20
-    def unpack(self, root, urls=3DNone):
+    def unpack(self, root, urls=3DNone, is_module=3DFalse, checkout_dest=
dir=3DNone):
         """
-        Unpack urls to root
+        Unpack urls to a tmp dir, trace, and then move everything to roo=
t
+
+        is_module needs to be set to true when this method is recursivel=
y called
+        by a fetcher's unpack method to unpack (sub)modules (gitsm, npms=
w)
+
+        checkout_destdir needs to be passed when this method is recursiv=
ely
+        called by gitsm fetcher
         """
=20
         if not urls:
             urls =3D self.urls
+        if is_module:
+            destdir =3D root
+        else:
+            trace =3D TraceUnpackBase(root, self.d)
+            destdir =3D trace.tmpdir
=20
         for u in urls:
             ud =3D self.ud[u]
+            # absolute subdir, destsuffix and subpath params wouldn't wo=
rk when
+            # unpacking in the tmp dir, convert them to relative paths
+            realroot =3D os.path.realpath(root)
+            params =3D [ 'subdir', 'destsuffix', 'subpath' ]
+            for p in params:
+                if not ud.parm.get(p):
+                    continue
+                if os.path.isabs(ud.parm[p]):
+                    realpath =3D os.path.realpath(ud.parm[p])
+                    if realpath.startswith(realroot):
+                        ud.parm[p] =3D os.path.relpath(realpath, realroo=
t)
             ud.setup_localpath(self.d)
+            ud.rootdir =3D root
+
+            if hasattr(ud, "checkout_destdir"):
+                ud.checkout_destdir =3D checkout_destdir
=20
             if ud.lockfile:
                 lf =3D bb.utils.lockfile(ud.lockfile)
=20
-            ud.method.unpack(ud, root, self.d)
+            ud.method.unpack(ud, destdir, self.d)
=20
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
=20
+            if is_module:
+                continue
+
+            if hasattr(ud, "nocheckout") and ud.nocheckout:
+                logger.warning(
+                    "Can't trace sources for"
+                    " %s because repo has not been checked out" % u)
+            else:
+                trace.commit(u, ud)
+
+            trace.move2root()
+
+        if is_module:
+            return
+        trace.write_data()
+        trace.close()
+
     def clean(self, urls=3DNone):
         """
         Clean files that the fetcher gets or places
diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index 3310ed00..68250974 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -101,8 +101,10 @@ class Crate(Wget):
         bp =3D d.getVar('BP')
         if bp =3D=3D ud.parm.get('name'):
             cmd =3D "tar -xz --no-same-owner -f %s" % thefile
+            ud.destdir =3D rootdir
         else:
             cargo_bitbake =3D self._cargo_bitbake_path(rootdir)
+            ud.destdir =3D cargo_bitbake
=20
             cmd =3D "tar -xz --no-same-owner -f %s -C %s" % (thefile, ca=
rgo_bitbake)
=20
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 47225b97..ed7ad39e 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -34,6 +34,11 @@ class GitSM(Git):
         """
         return ud.type in ['gitsm']
=20
+    def urldata_init(self, ud, d):
+        super(GitSM, self).urldata_init(ud, d)
+        ud.module_data =3D []
+        ud.checkout_destdir =3D None
+
     def process_submodules(self, ud, workdir, function, d):
         """
         Iterate over all of the submodules in this repository and execut=
e
@@ -144,6 +149,15 @@ class GitSM(Git):
=20
             function(ud, url, module, paths[module], workdir, ld)
=20
+            if function.__name__ =3D=3D "unpack_submodules":
+                destdir =3D os.path.join(ud.checkout_destdir, paths[modu=
le])
+                ud.module_data.append({
+                    "url": url,
+                    "destdir": destdir.rstrip("/"),
+                    "parent_destdir": ud.checkout_destdir.rstrip("/"),
+                    "revision": subrevision[module]
+                })
+
         return submodules !=3D []
=20
     def need_update(self, ud, d):
@@ -215,9 +229,13 @@ class GitSM(Git):
             else:
                 repo_conf =3D os.path.join(ud.destdir, '.git')
=20
+            checkout_destdir =3D os.path.join(ud.checkout_destdir, modpa=
th)
+
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
-                newfetch.unpack(root=3Dos.path.dirname(os.path.join(repo=
_conf, 'modules', module)))
+                newfetch.unpack(root=3Dos.path.dirname(os.path.join(repo=
_conf, 'modules', module)), is_module=3DTrue, checkout_destdir=3Dcheckout=
_destdir)
+                # add nested submodules' data
+                ud.module_data +=3D newfetch.ud[url].module_data
             except Exception as e:
                 logger.error('gitsm: submodule unpack failed: %s %s' % (=
type(e).__name__, str(e)))
                 raise
@@ -239,6 +257,10 @@ class GitSM(Git):
=20
         Git.unpack(self, ud, destdir, d)
=20
+        if not ud.checkout_destdir:
+            # for main git repo, checkout destdir corresponds with unpac=
k destdir
+            ud.checkout_destdir =3D ud.destdir
+
         ret =3D self.process_submodules(ud, ud.destdir, unpack_submodule=
s, d)
=20
         if not ud.bareclone and ret:
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 063e1300..0fd69db7 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -242,6 +242,7 @@ class Hg(FetchMethod):
         revflag =3D "-r %s" % ud.revision
         subdir =3D ud.parm.get("destsuffix", ud.module)
         codir =3D "%s/%s" % (destdir, subdir)
+        ud.destdir =3D codir
=20
         scmdata =3D ud.parm.get("scmdata", "")
         if scmdata !=3D "nokeep":
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index f83485ad..4ddb53e7 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -298,6 +298,7 @@ class Npm(FetchMethod):
         destsuffix =3D ud.parm.get("destsuffix", "npm")
         destdir =3D os.path.join(rootdir, destsuffix)
         npm_unpack(ud.localpath, destdir, d)
+        ud.destdir =3D destdir
=20
     def clean(self, ud, d):
         """Clean any existing full or partial download"""
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 4ff2c8ff..2516aef4 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -80,6 +80,9 @@ class NpmShrinkWrap(FetchMethod):
     def urldata_init(self, ud, d):
         """Init npmsw specific variables within url data"""
=20
+        # initialize module_data (for module source tracing)
+        ud.module_data =3D []
+
         # Get the 'shrinkwrap' parameter
         ud.shrinkwrap_file =3D re.sub(r"^npmsw://", "", ud.url.split(";"=
)[0])
=20
@@ -192,6 +195,7 @@ class NpmShrinkWrap(FetchMethod):
                 raise ParameterError("Unsupported dependency: %s" % name=
, ud.url)
=20
             ud.deps.append({
+                "name": name,
                 "url": url,
                 "localpath": localpath,
                 "extrapaths": extrapaths,
@@ -266,20 +270,31 @@ class NpmShrinkWrap(FetchMethod):
=20
     def unpack(self, ud, rootdir, d):
         """Unpack the downloaded dependencies"""
-        destdir =3D d.getVar("S")
-        destsuffix =3D ud.parm.get("destsuffix")
-        if destsuffix:
-            destdir =3D os.path.join(rootdir, destsuffix)
+        # rootdir param is a temporary dir. The real rootdir, where sour=
ces are
+        # moved after being traced, is stored in ud.rootdir.
+        destsuffix =3D ud.parm.get("destsuffix") or os.path.relpath(d.ge=
tVar("S"), ud.rootdir)
+        destdir =3D os.path.join(rootdir, destsuffix)
+        ud.destdir =3D destdir
=20
         bb.utils.mkdirhier(destdir)
         bb.utils.copyfile(ud.shrinkwrap_file,
                           os.path.join(destdir, "npm-shrinkwrap.json"))
=20
+        for dep in ud.deps:
+            dep_destdir =3D os.path.join(destdir, dep["destsuffix"])
+            dep_parent_destdir =3D re.sub("/node_modules/"+dep["name"]+"=
$", "", dep_destdir) # this works also with scoped package names, like @f=
oo/bar
+            ud.module_data.append({
+                "url": dep["url"] or dep["localpath"],
+                "destdir": dep_destdir.rstrip("/"),
+                "parent_destdir": dep_parent_destdir.rstrip("/"),
+                "revision": None
+            })
+
         auto =3D [dep["url"] for dep in ud.deps if not dep["localpath"]]
         manual =3D [dep for dep in ud.deps if dep["localpath"]]
=20
         if auto:
-            ud.proxy.unpack(destdir, auto)
+            ud.proxy.unpack(destdir, auto, is_module=3DTrue)
=20
         for dep in manual:
             depdestdir =3D os.path.join(destdir, dep["destsuffix"])
diff --git a/lib/bb/fetch2/trace_base.py b/lib/bb/fetch2/trace_base.py
new file mode 100644
index 00000000..49823f84
--- /dev/null
+++ b/lib/bb/fetch2/trace_base.py
@@ -0,0 +1,256 @@
+"""Module implementing a base process for upstream source tracing
+for bb.fetch2.Fetch.unpack()
+
+The process consists of:
+
+- creating a temporary directory where each SRC_URI element is unpacked
+
+- collecting relevant metadata (provenance) for each source file and for=
 every
+  upstream source component, that can be used later on for Software Comp=
osition
+  Analysis, SBoM generation, etc.;
+
+- moving everything from the temporary directory to root, and iterate wi=
th the
+  next SRC_URI element;
+
+- saving metadata in a json file after all elements have been processed.
+
+It assumes that:
+
+- fetchers store unpack destination dir in urldata.destdir;
+- gitsm and npmsw fetchers store module metadata in urldata.module_data,=
 as a
+  list of dict elements in the following format:
+    [
+        {
+            "url": "<module url>",
+            "destdir": "<module destination path>",
+            "parent_destdir": "<parent module destination path>"
+            "revision": "<git submodule revision (only for gitsm, else N=
one)>"
+        }, ...
+    ]
+- urldata.is_unpacked_archive (boolean) is set to True or False for "fil=
e"
+  SRC_URI entries.
+"""
+
+# Copyright (C) 2023 Alberto Pianon <pianon@array.eu>
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import os
+import json
+import tempfile
+
+import bb.utils
+import bb.compress.zstd
+
+class TraceException(Exception):
+    pass
+
+def scandir(path):
+    with os.scandir(path) as scan:
+        return { e.name: e for e in scan }
+
+def is_real_dir(e):
+    return e.is_dir() and not e.is_symlink()
+
+def is_real_and_nonempty_dir(e):
+    return is_real_dir(e) and scandir(e.path)
+
+def is_file_or_symlink(e):
+    return e.is_file() or e.is_symlink()
+
+def is_git_dir(e):
+    path_scandir =3D scandir(e.path)
+    if ".git" in path_scandir:
+        try:
+            bb.process.run(
+                ["git", "rev-parse", "--is-inside-work-tree"], cwd=3De.p=
ath)
+            return True
+        except bb.process.ExecutionError:
+            return False
+    return False
+
+def check_is_real_dir(path, name):
+    if not os.path.exists(path) or os.path.islink(path) or os.path.isfil=
e(path):
+        raise TraceException(
+            "%s path %s is not a directory" % (name, path))
+
+def move_contents(src_dir, dst_dir):
+    """Move and merge contents from src_dir to dst_dir
+
+    Conflict resolution criteria are explained in bb.tests.trace_base
+
+    It's optimized for fast execution time by using os.scandir and os.re=
name, so
+    it requires that both src_dir and dst_dir reside in the same filesys=
tem.
+    """
+
+    check_is_real_dir(src_dir, "Source")
+    check_is_real_dir(dst_dir, "Destination")
+
+    if os.lstat(src_dir).st_dev !=3D os.lstat(dst_dir).st_dev:
+        raise TraceException(
+            "Source %s and destination %s must be in the same filesystem=
" %
+            (src_dir, dst_dir)
+        )
+
+    src_scandir =3D scandir(src_dir)
+    dst_scandir =3D scandir(dst_dir)
+
+    for src_name, src in src_scandir.items():
+        dst =3D dst_scandir.get(src_name)
+        if dst:
+            # handle conflicts
+            if is_real_dir(src) and is_real_and_nonempty_dir(dst):
+                if is_git_dir(src):
+                    bb.utils.prunedir(dst.path)
+                else:
+                    move_contents(src.path, dst.path)
+                    os.rmdir(src.path)
+                    continue
+            elif is_real_dir(src) and is_file_or_symlink(dst):
+                os.remove(dst.path)
+            elif is_file_or_symlink(src) and is_real_dir(dst):
+                try:
+                    os.rmdir(dst.path)
+                except OSError as e:
+                    if e.errno =3D=3D 39:
+                        raise TraceException(
+                            "Error while moving %s contents to %s, canno=
t move"
+                            " %s to %s: source is a file or a symlink, w=
hile"
+                            " destination is a non-empty directory."
+                            % (src_dir, dst_dir, src.path, dst.path)
+                        )
+                    else:
+                        raise e
+        dst_path =3D dst.path if dst else os.path.join(dst_dir, src_name=
)
+        os.rename(src.path, dst_path)
+
+def findall_files_and_links(path, exclude=3D[], skip_git_submodules=3DFa=
lse):
+    """recusively find all files and links in path, excluding dir and fi=
le names
+    in exclude, and excluding git dirs if skip_git_submodules is set to =
True.
+
+    Returns tuple of sorted lists of file and link paths (sorting is for
+    reproducibility in tests)
+    """
+    files =3D []
+    links =3D []
+    with os.scandir(path) as scan:
+        for e in scan:
+            if e.name in exclude:
+                continue
+            if e.is_symlink():
+                links.append(e.path)
+            elif e.is_file():
+                files.append(e.path)
+            elif e.is_dir():
+                if skip_git_submodules and is_git_dir(e):
+                    continue
+                _files, _links =3D findall_files_and_links(
+                        e.path, exclude, skip_git_submodules)
+                files +=3D _files
+                links +=3D _links
+    return sorted(files), sorted(links)
+
+class TraceUnpackBase:
+    """base class for implementing a process for upstream source tracing
+    See this module's help for more details on the process.
+
+    This base class implements the process but does not collect any data=
. It is
+    intended to be subclassed in a separate 'trace' module, implementing
+    _collect_data() and _process_data() methods.
+
+    Method call order:
+        - __init__(): initialize tmpdir and td (trace data)
+        - for each SRC_URI entry unpack:
+          - commit(): go through all files in tmpdir (and in each module=
 subdir
+            in case of gitsm and npmsw fecthers) and commit collected me=
tadata
+            to td
+          - move2root(): moves all files from tmpdir to root
+        - write_data()
+        - close(): delete tmpdir and cache
+    """
+
+    def __init__(self, root, d):
+        """initialize properties and create temporary directory in root
+
+        Temporary unpack dir is created in 'root' to ensure they are in =
the
+        same filesystem, so files can be quickly moved to 'root' after t=
racing
+        """
+
+        self.root =3D root
+        self.d =3D d
+        self.td =3D {}
+        if not os.path.exists(root):
+            bb.utils.mkdirhier(root)
+        self.tmpdir =3D tempfile.mkdtemp(dir=3Droot)
+
+    def commit(self, u, ud):
+        """go through all files in tmpdir and commit collected metadata =
to td.
+        dive into module subdirs in case of gitsm and npmsw fecthers
+
+        Params are:
+        - u -> str: src uri of the upstream repo/package that is being p=
rocessed
+        - ud -> bb.fetch2.FetchData: src uri fetch data object; ud.url a=
nd u do not correspond when git/npm modules are being processed, so we ne=
ed both
+        """
+
+        exclude=3D['.git', '.hg', '.svn']
+
+        # exclude node_modules subdirs (will be separately parsed)
+        if ud.type in ['npm', 'npmsw']:
+            exclude.append('node_modules')
+        # exclude git submodules (will be separately parsed)
+        skip_git_submodules =3D (ud.type =3D=3D 'gitsm')
+
+        files, links =3D findall_files_and_links(
+            ud.destdir, exclude, skip_git_submodules)
+        self._collect_data(u, ud, files, links, ud.destdir)
+
+        if ud.type in ['gitsm', 'npmsw'] and ud.module_data:
+            self._process_module_data(ud)
+            for md in ud.module_data:
+                files, links =3D findall_files_and_links(
+                   md["destdir"], exclude, skip_git_submodules)
+                self._collect_data(
+                    md["url"], ud, files, links, md["destdir"], md)
+
+    def _process_module_data(self, ud):
+        """add parent module data to each module data item, to map depen=
dencies
+        """
+        revision =3D ud.revisions[ud.names[0]] if ud.type =3D=3D 'gitsm'=
 else None
+        indexed_md =3D { md["destdir"]: md for md in ud.module_data }
+        # add main git repo (gitsm) or npm-shrinkwrap.json (npmsw)
+        indexed_md.update({
+                ud.destdir.rstrip("/"): {"url": ud.url, "revision": revi=
sion}
+        })
+        for md in ud.module_data:
+            md["parent_md"] =3D indexed_md[md["parent_destdir"]]
+
+    def move2root(self):
+        """move all files from temporary directory to root"""
+        move_contents(self.tmpdir, self.root)
+
+    def write_data(self):
+        self._process_data()
+        if not self.d.getVar("PN"):
+            return
+        if not os.path.exists("%s/temp" % self.root):
+            bb.utils.mkdirhier("%s/temp" % self.root)
+        path =3D "%s/temp/%s-%s.unpack.trace.json.zst" % (
+            self.root, self.d.getVar("PN"), self.d.getVar("PV"))
+        with bb.compress.zstd.open(path, "wt", encoding=3D"utf-8") as f:
+            json.dump(self.td, f)
+            f.flush()
+
+    def close(self):
+        os.rmdir(self.tmpdir)
+        del self.td
+
+    def _collect_data(self, u, ud, files, links, destdir, md=3DNone):
+        """
+        collect provenance metadata on the committed files. Not implemen=
ted
+        """
+        pass
+
+    def _process_data(self):
+        """post-process self.td. Not implemented"""
+        pass
\ No newline at end of file
diff --git a/lib/bb/tests/trace_base.py b/lib/bb/tests/trace_base.py
new file mode 100644
index 00000000..d96fb2c7
--- /dev/null
+++ b/lib/bb/tests/trace_base.py
@@ -0,0 +1,227 @@
+
+# Copyright (C) 2023 Alberto Pianon <pianon@array.eu>
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import os
+import re
+import unittest
+import tempfile
+from pathlib import Path
+import subprocess
+
+import bb
+
+def create_src_dst(tmpdir):
+    src_dir =3D os.path.join(tmpdir, "src/")
+    dst_dir =3D os.path.join(tmpdir, "dst/")
+    os.makedirs(src_dir)
+    os.makedirs(dst_dir)
+    return Path(src_dir), Path(dst_dir)
+
+def make_dirname(path):
+    dirname =3D os.path.dirname(path)
+    if dirname:
+        os.makedirs(dirname, exist_ok=3DTrue)
+
+def create_file(path, content):
+    make_dirname(path)
+    with open(path, "w") as f:
+        f.write(content)
+
+def create_link(path, target):
+    make_dirname(path)
+    os.symlink(target, path)
+
+def get_tree(path):
+    curdir =3D os.getcwd()
+    os.chdir(path)
+    tree =3D []
+    for root, dirs, files in os.walk("."):
+        for f in dirs + files:
+            tree.append(re.sub(r"^\.\/", "", os.path.join(root, f)))
+    os.chdir(curdir)
+    return sorted(tree)
+
+def read_file(path):
+    with open(path) as f:
+        return f.read()
+
+class MoveContentsTest(unittest.TestCase):
+    """
+    Test the following conflict resolution criteria:
+
+    - if a file (or symlink) exists both in src_dir and in dst_dir, the
+      file/symlink in dst_dir will be overwritten;
+
+    - if a subdirectory exists both in src_dir and in dst_dir, their con=
tents
+      will be merged, and in case of file/symlink conflicts, files/symli=
nks in
+      dst_dir will be overwritten - unless src_dir is a git repo; in  su=
ch a
+      case, dst_dir will be pruned and src_dir will be moved to dst_dir,=
 for
+      consistency with bb.fetch2.git.Git.unpack method's behavior (which=
 prunes
+      clone dir if already existing, before cloning)
+
+    - if the same relative path exists both in src_dir and in dst_dir, b=
ut the
+      path in src_dir is a directory and the path in dst_dir is a file/s=
ymlink,
+      the latter will be overwritten;
+
+    - if instead the path in src_dir is a file and the path in dst_dir i=
s a
+      directory, the latter will be overwritten only if it is empty, oth=
erwise
+      an exception will be raised.
+    """
+
+    def test_dir_merge_and_file_overwrite(self):
+        with tempfile.TemporaryDirectory() as tmpdir:
+            src_dir, dst_dir =3D create_src_dst(tmpdir)
+            create_file(src_dir / "dir/subdir/file.txt", "new")
+            create_file(dst_dir / "dir/subdir/file.txt", "old")
+            create_file(dst_dir / "dir/subdir/file1.txt", "old")
+            bb.fetch2.trace_base.move_contents(src_dir, dst_dir)
+            expected_dst_tree =3D [
+                "dir",
+                "dir/subdir",
+                "dir/subdir/file.txt",
+                "dir/subdir/file1.txt"
+            ]
+            self.assertEqual(get_tree(src_dir), [])
+            self.assertEqual(get_tree(dst_dir), expected_dst_tree)
+            self.assertEqual(read_file(dst_dir / "dir/subdir/file.txt"),=
 "new")
+            self.assertEqual(read_file(dst_dir / "dir/subdir/file1.txt")=
, "old")
+
+    def test_file_vs_symlink_conflicts(self):
+        with tempfile.TemporaryDirectory() as tmpdir:
+            src_dir, dst_dir =3D create_src_dst(tmpdir)
+
+            create_file(src_dir / "dir/subdir/fileA.txt", "new")
+            create_file(src_dir / "dir/fileB.txt", "new")
+            create_link(src_dir / "file.txt", "dir/subdir/fileA.txt")
+
+            create_file(dst_dir / "dir/subdir/fileA.txt", "old")
+            create_link(dst_dir / "dir/fileB.txt", "subdir/fileA.txt")
+            create_file(dst_dir / "file.txt", "old")
+
+            bb.fetch2.trace_base.move_contents(src_dir, dst_dir)
+            self.assertEqual(get_tree(src_dir), [])
+            self.assertTrue(os.path.islink(dst_dir / "file.txt"))
+            self.assertEqual(
+                os.readlink(dst_dir / "file.txt"),
+                "dir/subdir/fileA.txt"
+            )
+            self.assertFalse(os.path.islink(dst_dir / "dir/fileB.txt"))
+            self.assertEqual(read_file(dst_dir / "dir/fileB.txt"), "new"=
)
+
+    def test_dir_vs_file_conflict(self):
+        with tempfile.TemporaryDirectory() as tmpdir:
+            src_dir, dst_dir =3D create_src_dst(tmpdir)
+            create_file(src_dir / "items/item0/content.txt", "hello")
+            create_file(dst_dir / "items/item0", "there")
+            bb.fetch2.trace_base.move_contents(src_dir, dst_dir)
+            self.assertEqual(get_tree(src_dir), [])
+            self.assertTrue(os.path.isdir(dst_dir / "items/item0"))
+            self.assertEqual(
+                read_file(dst_dir / "items/item0/content.txt"), "hello")
+
+    def test_dir_vs_symlink_conflict(self):
+        with tempfile.TemporaryDirectory() as tmpdir:
+            src_dir, dst_dir =3D create_src_dst(tmpdir)
+            create_file(src_dir / "items/item0/content.txt", "hello")
+            create_file(dst_dir / "items/item1/content.txt", "there")
+            create_link(dst_dir / "items/item0", "item1")
+            bb.fetch2.trace_base.move_contents(src_dir, dst_dir)
+            self.assertEqual(get_tree(src_dir), [])
+            self.assertFalse(os.path.islink(dst_dir / "items/item0"))
+            self.assertEqual(
+                read_file(dst_dir / "items/item0/content.txt"), "hello")
+            self.assertEqual(
+                read_file(dst_dir / "items/item1/content.txt"), "there")
+
+    def test_symlink_vs_empty_dir_conflict(self):
+        with tempfile.TemporaryDirectory() as tmpdir:
+            src_dir, dst_dir =3D create_src_dst(tmpdir)
+            create_file(src_dir / "items/item1/content.txt", "there")
+            create_link(src_dir / "items/item0", "item1")
+            os.makedirs(dst_dir / "items/item0")
+            bb.fetch2.trace_base.move_contents(src_dir, dst_dir)
+            self.assertEqual(get_tree(src_dir), [])
+            self.assertTrue(os.path.islink(dst_dir / "items/item0"))
+            self.assertEqual(read_file(dst_dir / "items/item0/content.tx=
t"), "there")
+
+    def test_symlink_vs_nonempty_dir_conflict(self):
+        with tempfile.TemporaryDirectory() as tmpdir:
+            src_dir, dst_dir =3D create_src_dst(tmpdir)
+            create_file(src_dir / "items/item1/content.txt", "there")
+            create_link(src_dir / "items/item0", "item1")
+            create_file(dst_dir / "items/item0/content.txt", "hello")
+            with self.assertRaises(bb.fetch2.trace_base.TraceException) =
as context:
+                bb.fetch2.trace_base.move_contents(src_dir, dst_dir)
+
+    def test_file_vs_empty_dir_conflict(self):
+        with tempfile.TemporaryDirectory() as tmpdir:
+            src_dir, dst_dir =3D create_src_dst(tmpdir)
+            create_file(src_dir / "items/item0", "test")
+            os.makedirs(dst_dir / "items/item0")
+            bb.fetch2.trace_base.move_contents(src_dir, dst_dir)
+            self.assertEqual(get_tree(src_dir), [])
+            self.assertTrue(os.path.isfile(dst_dir/ "items/item0"))
+
+    def test_file_vs_nonempty_dir_conflict(self):
+        with tempfile.TemporaryDirectory() as tmpdir:
+            src_dir, dst_dir =3D create_src_dst(tmpdir)
+            create_file(src_dir / "items/item0", "test")
+            create_file(dst_dir / "items/item0/content.txt", "test")
+            with self.assertRaises(bb.fetch2.trace_base.TraceException) =
as context:
+                bb.fetch2.trace_base.move_contents(src_dir, dst_dir)
+
+    def test_git_dir(self):
+        with tempfile.TemporaryDirectory() as tmpdir:
+            src_dir, dst_dir =3D create_src_dst(tmpdir)
+            git_repo =3D src_dir / "src/my_git_repo"
+            create_file(git_repo / "foo.txt", "hello")
+            subprocess.check_output(["git", "init"], cwd=3Dgit_repo)
+            create_file(dst_dir / "src/my_git_repo/content.txt", "there"=
)
+            bb.fetch2.trace_base.move_contents(src_dir, dst_dir)
+            self.assertFalse(
+                os.path.exists(dst_dir / "src/my_git_repo/content.txt"))
+                # git clone dir should be pruned if already existing
+            self.assertEqual(
+                read_file(dst_dir / "src/my_git_repo/foo.txt"), "hello")
+            self.assertTrue(os.path.isdir(dst_dir / "src/my_git_repo/.gi=
t"))
+
+
+class FindAllFilesAndLinksTest(unittest.TestCase):
+    """test if all files and links are correctly returned, and if specif=
ic
+    file/dir names and git subdirs are correctly excluded"""
+
+    def test_findall_files_and_links(self):
+        with tempfile.TemporaryDirectory() as tmpdir:
+            tmpdir =3D Path(tmpdir)
+            files =3D {
+                str(tmpdir/"foo/example/example.txt"): "example",
+                str(tmpdir/"foo/foo.txt"): "foo",
+                str(tmpdir/"foo/foo2.txt"): "foo2",
+                str(tmpdir/"README"): "hello",
+            }
+            ignored =3D {
+                str(tmpdir/".git"): "fake",
+                str(tmpdir/"foo2/dummy"): "dummy"
+            }
+            allfiles =3D files.copy()
+            allfiles.update(ignored)
+            links =3D {
+                str(tmpdir/"example"): "foo/example", # link to dir
+                str(tmpdir/"example.txt"): "foo/example/example.txt", # =
link to file
+            }
+            for path, content in allfiles.items():
+                create_file(path, content)
+            for path, target in links.items():
+                create_link(path, target)
+            subprocess.check_output(["git", "init"], cwd=3Dtmpdir/"foo2"=
)
+            res_files, res_links =3D bb.fetch2.trace_base.findall_files_=
and_links(
+                    tmpdir, exclude=3D['.git'], skip_git_submodules=3DTr=
ue)
+            self.assertEqual(res_files, sorted(list(files.keys())))
+            self.assertEqual(res_links, sorted(list(links.keys())))
+
+
+if __name__ =3D=3D '__main__':
+    unittest.main()
--=20
2.34.1


