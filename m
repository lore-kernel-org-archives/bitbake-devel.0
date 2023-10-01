Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DB1E748ED
	for <webhook@archiver.kernel.org>; Sun,  1 Oct 2023 07:53:11 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.55827.1696146781558603697
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 01 Oct 2023 00:53:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@pianon.eu header.s=mail20151219 header.b=xuc+um93;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id CFB255C0096;
	Sun,  1 Oct 2023 09:52:58 +0200 (CEST)
Authentication-Results: server3.justice4all.it (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=pianon.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from; s=mail20151219; t=1696146777;
	 x=1697961178; bh=5nutX3BQ6ubt5K9Dv98rl9AhQvapR6Crhsst/u6r2YU=; b=
	xuc+um93ySjQNRpgDbFBL066hOhbL4ZWpKU7s/4Yz/ec9oXjnRYoMjJIX0eVmW60
	lVVeWHkeLQveOFPPVcO0FJC5la3vQkogKt6YkSiHd5yUEDRUmW1rFpDD8wBcRhFC
	VLWBg2UWtuvPT/b5LsMltOyr7KOtZeDTyutI8i4V6zM=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WL5P_0EaeDW1; Sun,  1 Oct 2023 09:52:57 +0200 (CEST)
Received: from alberto-L140CU.lan (host-79-45-112-8.retail.telecomitalia.it [79.45.112.8])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPSA id 43C245C0095;
	Sun,  1 Oct 2023 09:52:57 +0200 (CEST)
From: alberto@pianon.eu
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org,
	jpewhacker@gmail.com,
	carlo@piana.eu,
	luca.ceresoli@bootlin.com,
	peter.kjellerstedt@axis.com,
	Alberto Pianon <alberto@pianon.eu>
Subject: [PATCH v5] fetch2: Add API for upstream source tracing
Date: Sun,  1 Oct 2023 09:52:25 +0200
Message-Id: <20231001075225.1054512-1-alberto@pianon.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 01 Oct 2023 07:53:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15152

From: Alberto Pianon <alberto@pianon.eu>

This patch adds an API to bb.fetch2 to enable users to plug in an unpack
tracer that can trace each source file back to its corresponding
upstream source url, even when multiple upstream sources are combined
together in the same unpack directory. This may be required for software
composition analysis, license compliance, and detailed SBoM generation.

This patch provides only the needed hooks in bb.fetch2 code and a dummy
abstract class defining the API; users may load their own unpack tracer
class by setting the BB_UNPACK_TRACER_CLASS config parameter.

Signed-off-by: Alberto Pianon <alberto@pianon.eu>
---
 lib/bb/fetch2/__init__.py | 78 +++++++++++++++++++++++++++++++++++++++
 lib/bb/fetch2/crate.py    |  2 +
 lib/bb/fetch2/git.py      |  2 +
 lib/bb/fetch2/gitsm.py    |  4 ++
 lib/bb/fetch2/hg.py       |  1 +
 lib/bb/fetch2/npm.py      |  1 +
 lib/bb/fetch2/npmsw.py    |  3 ++
 7 files changed, 91 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ffb1a92b..35e9ca96 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1579,6 +1579,7 @@ class FetchMethod(object):
             unpackdir =3D rootdir
=20
         if not unpack or not cmd:
+            urldata.unpack_tracer.unpack("file-copy", unpackdir)
             # If file =3D=3D dest, then avoid any copies, as we already =
put the file into dest!
             dest =3D os.path.join(unpackdir, os.path.basename(file))
             if file !=3D dest and not (os.path.exists(dest) and os.path.=
samefile(file, dest)):
@@ -1593,6 +1594,8 @@ class FetchMethod(object):
                         destdir =3D urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir=
))
                 cmd =3D 'cp -fpPRH "%s" "%s"' % (file, destdir)
+        else:
+            urldata.unpack_tracer.unpack("archive-extract", unpackdir)
=20
         if not cmd:
             return
@@ -1684,6 +1687,55 @@ class FetchMethod(object):
         """
         return []
=20
+
+class DummyUnpackTracer(object):
+    """
+    Abstract API definition for a class that traces unpacked source file=
s back
+    to their respective upstream SRC_URI entries, for software compositi=
on
+    analysis, license compliance and detailed SBOM generation purposes.
+    User may load their own unpack tracer class (instead of the dummy
+    one) by setting the BB_UNPACK_TRACER_CLASS config parameter.
+    """
+    def start(self, unpackdir, urldata_dict, d):
+        """
+        Start tracing the core Fetch.unpack process, using an index to m=
ap
+        unpacked files to each SRC_URI entry.
+        This method is called by Fetch.unpack and it may receive nested =
calls by
+        gitsm and npmsw fetchers, that expand SRC_URI entries by adding =
implicit
+        URLs and by recursively calling Fetch.unpack from new (nested) F=
etch
+        instances.
+        """
+        return
+    def start_url(self, url):
+        """Start tracing url unpack process.
+        This method is called by Fetch.unpack before the fetcher-specifi=
c unpack
+        method starts, and it may receive nested calls by gitsm and npms=
w
+        fetchers.
+        """
+        return
+    def unpack(self, unpack_type, destdir):
+        """
+        Set unpack_type and destdir for current url.
+        This method is called by the fetcher-specific unpack method afte=
r url
+        tracing started.
+        """
+        return
+    def finish_url(self, url):
+        """Finish tracing url unpack process and update the file index.
+        This method is called by Fetch.unpack after the fetcher-specific=
 unpack
+        method finished its job, and it may receive nested calls by gits=
m
+        and npmsw fetchers.
+        """
+        return
+    def complete(self):
+        """
+        Finish tracing the Fetch.unpack process, and check if all nested
+        Fecth.unpack calls (if any) have been completed; if so, save col=
lected
+        metadata.
+        """
+        return
+
+
 class Fetch(object):
     def __init__(self, urls, d, cache =3D True, localonly =3D False, con=
nection_cache =3D None):
         if localonly and cache:
@@ -1704,10 +1756,30 @@ class Fetch(object):
         if key in urldata_cache:
             self.ud =3D urldata_cache[key]
=20
+        # the unpack_tracer object needs to be made available to possibl=
e nested
+        # Fetch instances (when those are created by gitsm and npmsw fet=
chers)
+        # so we set it as a global variable
+        global unpack_tracer
+        try:
+            unpack_tracer
+        except NameError:
+            class_path =3D d.getVar("BB_UNPACK_TRACER_CLASS")
+            if class_path:
+                # use user-defined unpack tracer class
+                import importlib
+                module_name, _, class_name =3D class_path.rpartition("."=
)
+                module =3D importlib.import_module(module_name)
+                class_ =3D getattr(module, class_name)
+                unpack_tracer =3D class_()
+            else:
+                # fall back to the dummy/abstract class
+                unpack_tracer =3D DummyUnpackTracer()
+
         for url in urls:
             if url not in self.ud:
                 try:
                     self.ud[url] =3D FetchData(url, d, localonly)
+                    self.ud[url].unpack_tracer =3D unpack_tracer
                 except NonLocalMethod:
                     if localonly:
                         self.ud[url] =3D None
@@ -1883,6 +1955,8 @@ class Fetch(object):
         if not urls:
             urls =3D self.urls
=20
+        unpack_tracer.start(root, self.ud, self.d)
+
         for u in urls:
             ud =3D self.ud[u]
             ud.setup_localpath(self.d)
@@ -1890,11 +1964,15 @@ class Fetch(object):
             if ud.lockfile:
                 lf =3D bb.utils.lockfile(ud.lockfile)
=20
+            unpack_tracer.start_url(u)
             ud.method.unpack(ud, root, self.d)
+            unpack_tracer.finish_url(u)
=20
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
=20
+        unpack_tracer.complete()
+
     def clean(self, urls=3DNone):
         """
         Clean files that the fetcher gets or places
diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index 3310ed00..01d49435 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -101,8 +101,10 @@ class Crate(Wget):
         bp =3D d.getVar('BP')
         if bp =3D=3D ud.parm.get('name'):
             cmd =3D "tar -xz --no-same-owner -f %s" % thefile
+            ud.unpack_tracer.unpack("crate-extract", rootdir)
         else:
             cargo_bitbake =3D self._cargo_bitbake_path(rootdir)
+            ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)
=20
             cmd =3D "tar -xz --no-same-owner -f %s -C %s" % (thefile, ca=
rgo_bitbake)
=20
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4385d0b3..c7ed1f03 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -589,6 +589,8 @@ class Git(FetchMethod):
         destdir =3D ud.destdir =3D os.path.join(destdir, destsuffix)
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
+        if not ud.bareclone:
+            ud.unpack_tracer.unpack("git", destdir)
=20
         need_lfs =3D self._need_lfs(ud)
=20
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index a87361cc..f7f3af72 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -218,6 +218,10 @@ class GitSM(Git):
=20
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
+                # modpath is needed by unpack tracer to calculate submod=
ule
+                # checkout dir
+                new_ud =3D newfetch.ud[url]
+                new_ud.modpath =3D modpath
                 newfetch.unpack(root=3Dos.path.dirname(os.path.join(repo=
_conf, 'modules', module)))
             except Exception as e:
                 logger.error('gitsm: submodule unpack failed: %s %s' % (=
type(e).__name__, str(e)))
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 063e1300..cbff8c49 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -242,6 +242,7 @@ class Hg(FetchMethod):
         revflag =3D "-r %s" % ud.revision
         subdir =3D ud.parm.get("destsuffix", ud.module)
         codir =3D "%s/%s" % (destdir, subdir)
+        ud.unpack_tracer.unpack("hg", codir)
=20
         scmdata =3D ud.parm.get("scmdata", "")
         if scmdata !=3D "nokeep":
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index f83485ad..15f3f19b 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -298,6 +298,7 @@ class Npm(FetchMethod):
         destsuffix =3D ud.parm.get("destsuffix", "npm")
         destdir =3D os.path.join(rootdir, destsuffix)
         npm_unpack(ud.localpath, destdir, d)
+        ud.unpack_tracer.unpack("npm", destdir)
=20
     def clean(self, ud, d):
         """Clean any existing full or partial download"""
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 4ff2c8ff..ff5f8dc7 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -191,7 +191,9 @@ class NpmShrinkWrap(FetchMethod):
             else:
                 raise ParameterError("Unsupported dependency: %s" % name=
, ud.url)
=20
+            # name is needed by unpack tracer for module mapping
             ud.deps.append({
+                "name": name,
                 "url": url,
                 "localpath": localpath,
                 "extrapaths": extrapaths,
@@ -270,6 +272,7 @@ class NpmShrinkWrap(FetchMethod):
         destsuffix =3D ud.parm.get("destsuffix")
         if destsuffix:
             destdir =3D os.path.join(rootdir, destsuffix)
+        ud.unpack_tracer.unpack("npm-shrinkwrap", destdir)
=20
         bb.utils.mkdirhier(destdir)
         bb.utils.copyfile(ud.shrinkwrap_file,
--=20
2.34.1


