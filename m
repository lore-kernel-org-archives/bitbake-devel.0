Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D3A6971A23
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uAGBJ6up013756 for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:19:06 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5xpP3KnoTIgL for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:19:06 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uAGBJ1HZ013752
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:19:02 GMT
Message-ID: <1479295141.28508.6.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Nov 2016 11:19:01 +0000
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] lib/bb: Don't use deprecated bb.data.getVar/setVar API
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
X-List-Received-Date: Wed, 16 Nov 2016 11:19:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The old style bb.data.getVar/setVar API is obsolete. Most of bitbake
doesn't use it but there were some pieces that escaped conversion. This
patch fixes the remaining users mostly in the fetchers.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index cd7362c..5c76b22 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1282,7 +1282,7 @@ class FetchMethod(object):
         Can also setup variables in urldata for use in go (saving code duplication
         and duplicate code execution)
         """
-        return os.path.join(data.getVar("DL_DIR", d, True), urldata.localfile)
+        return os.path.join(d.getVar("DL_DIR", True), urldata.localfile)
 
     def supports_checksum(self, urldata):
         """
diff --git a/bitbake/lib/bb/fetch2/clearcase.py b/bitbake/lib/bb/fetch2/clearcase.py
index 70e280a..d35b2da 100644
--- a/bitbake/lib/bb/fetch2/clearcase.py
+++ b/bitbake/lib/bb/fetch2/clearcase.py
@@ -110,7 +110,7 @@ class ClearCase(FetchMethod):
 
         ud.basecmd = d.getVar("FETCHCMD_ccrc", True) or spawn.find_executable("cleartool") or spawn.find_executable("rcleartool")
 
-        if data.getVar("SRCREV", d, True) == "INVALID":
+        if d.getVar("SRCREV", True) == "INVALID":
           raise FetchError("Set a valid SRCREV for the clearcase fetcher in your recipe, e.g. SRCREV = \"/main/LATEST\" or any other label of your choice.")
 
         ud.label = d.getVar("SRCREV", False)
@@ -124,7 +124,7 @@ class ClearCase(FetchMethod):
 
         ud.viewname         = "%s-view%s" % (ud.identifier, d.getVar("DATETIME", d, True))
         ud.csname           = "%s-config-spec" % (ud.identifier)
-        ud.ccasedir         = os.path.join(data.getVar("DL_DIR", d, True), ud.type)
+        ud.ccasedir         = os.path.join(d.getVar("DL_DIR", True), ud.type)
         ud.viewdir          = os.path.join(ud.ccasedir, ud.viewname)
         ud.configspecfile   = os.path.join(ud.ccasedir, ud.csname)
         ud.localfile        = "%s.tar.gz" % (ud.identifier)
@@ -144,7 +144,7 @@ class ClearCase(FetchMethod):
         self.debug("configspecfile  = %s" % ud.configspecfile)
         self.debug("localfile       = %s" % ud.localfile)
 
-        ud.localfile = os.path.join(data.getVar("DL_DIR", d, True), ud.localfile)
+        ud.localfile = os.path.join(d.getVar("DL_DIR", True), ud.localfile)
 
     def _build_ccase_command(self, ud, command):
         """
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 1bec60a..6b61834 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -182,9 +182,9 @@ class Git(FetchMethod):
         if ud.usehead:
             ud.unresolvedrev['default'] = 'HEAD'
 
-        ud.basecmd = data.getVar("FETCHCMD_git", d, True) or "git -c core.fsyncobjectfiles=0"
+        ud.basecmd = d.getVar("FETCHCMD_git", True) or "git -c core.fsyncobjectfiles=0"
 
-        ud.write_tarballs = ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") != "0") or ud.rebaseable
+        ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS", True) or "0") != "0") or ud.rebaseable
 
         ud.setup_revisons(d)
 
diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index 20df801..a1419aa 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -84,7 +84,7 @@ class Hg(FetchMethod):
         ud.pkgdir = os.path.join(hgdir, hgsrcname)
         ud.moddir = os.path.join(ud.pkgdir, ud.module)
         ud.localfile = ud.moddir
-        ud.basecmd = data.getVar("FETCHCMD_hg", d, True) or "/usr/bin/env hg"
+        ud.basecmd = d.getVar("FETCHCMD_hg", True) or "/usr/bin/env hg"
 
         ud.write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS", True)
 
diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index 51ca78d..5adfd5d 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -63,13 +63,13 @@ class Local(FetchMethod):
         newpath = path
         if path[0] == "/":
             return [path]
-        filespath = data.getVar('FILESPATH', d, True)
+        filespath = d.getVar('FILESPATH', True)
         if filespath:
             logger.debug(2, "Searching for %s in paths:\n    %s" % (path, "\n    ".join(filespath.split(":"))))
             newpath, hist = bb.utils.which(filespath, path, history=True)
             searched.extend(hist)
         if not newpath:
-            filesdir = data.getVar('FILESDIR', d, True)
+            filesdir = d.getVar('FILESDIR', True)
             if filesdir:
                 logger.debug(2, "Searching for %s in path: %s" % (path, filesdir))
                 newpath = os.path.join(filesdir, path)
@@ -100,10 +100,10 @@ class Local(FetchMethod):
         # no need to fetch local files, we'll deal with them in place.
         if self.supports_checksum(urldata) and not os.path.exists(urldata.localpath):
             locations = []
-            filespath = data.getVar('FILESPATH', d, True)
+            filespath = d.getVar('FILESPATH', True)
             if filespath:
                 locations = filespath.split(":")
-            filesdir = data.getVar('FILESDIR', d, True)
+            filesdir = d.getVar('FILESDIR', True)
             if filesdir:
                 locations.append(filesdir)
             locations.append(d.getVar("DL_DIR", True))
diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
index 699ae72..9711b98 100644
--- a/bitbake/lib/bb/fetch2/npm.py
+++ b/bitbake/lib/bb/fetch2/npm.py
@@ -90,7 +90,7 @@ class Npm(FetchMethod):
         self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -O -t 2 -T 30 -nv --passive-ftp --no-check-certificate "
         ud.prefixdir = prefixdir
 
-        ud.write_tarballs = ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") != "0")
+        ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS", True) or "0") != "0")
         ud.mirrortarball = 'npm_%s-%s.tar.xz' % (ud.pkgname, ud.version)
         ud.fullmirror = os.path.join(d.getVar("DL_DIR", True), ud.mirrortarball)
 
diff --git a/bitbake/lib/bb/fetch2/repo.py b/bitbake/lib/bb/fetch2/repo.py
index ecc6e68..bfd4ae1 100644
--- a/bitbake/lib/bb/fetch2/repo.py
+++ b/bitbake/lib/bb/fetch2/repo.py
@@ -51,17 +51,17 @@ class Repo(FetchMethod):
         if not ud.manifest.endswith('.xml'):
             ud.manifest += '.xml'
 
-        ud.localfile = data.expand("repo_%s%s_%s_%s.tar.gz" % (ud.host, ud.path.replace("/", "."), ud.manifest, ud.branch), d)
+        ud.localfile = d.expand("repo_%s%s_%s_%s.tar.gz" % (ud.host, ud.path.replace("/", "."), ud.manifest, ud.branch))
 
     def download(self, ud, d):
         """Fetch url"""
 
-        if os.access(os.path.join(data.getVar("DL_DIR", d, True), ud.localfile), os.R_OK):
+        if os.access(os.path.join(d.getVar("DL_DIR", True), ud.localfile), os.R_OK):
             logger.debug(1, "%s already exists (or was stashed). Skipping repo init / sync.", ud.localpath)
             return
 
         gitsrcname = "%s%s" % (ud.host, ud.path.replace("/", "."))
-        repodir = data.getVar("REPODIR", d, True) or os.path.join(data.getVar("DL_DIR", d, True), "repo")
+        repodir = d.getVar("REPODIR", True) or os.path.join(d.getVar("DL_DIR", True), "repo")
         codir = os.path.join(repodir, gitsrcname, ud.manifest)
 
         if ud.user:
diff --git a/bitbake/lib/bb/fetch2/sftp.py b/bitbake/lib/bb/fetch2/sftp.py
index 7989fcc..48ddfc1 100644
--- a/bitbake/lib/bb/fetch2/sftp.py
+++ b/bitbake/lib/bb/fetch2/sftp.py
@@ -92,7 +92,7 @@ class SFTP(FetchMethod):
         else:
             ud.basename = os.path.basename(ud.path)
 
-        ud.localfile = data.expand(urllib.parse.unquote(ud.basename), d)
+        ud.localfile = d.expand(urllib.parse.unquote(ud.basename))
 
     def download(self, ud, d):
         """Fetch urls"""
@@ -104,7 +104,7 @@ class SFTP(FetchMethod):
             port = '-P %d' % urlo.port
             urlo.port = None
 
-        dldir = data.getVar('DL_DIR', d, True)
+        dldir = d.getVar('DL_DIR', True)
         lpath = os.path.join(dldir, ud.localfile)
 
         user = ''
diff --git a/bitbake/lib/bb/tests/codeparser.py b/bitbake/lib/bb/tests/codeparser.py
index 14f0e25..b80c315 100644
--- a/bitbake/lib/bb/tests/codeparser.py
+++ b/bitbake/lib/bb/tests/codeparser.py
@@ -68,7 +68,7 @@ class VariableReferenceTest(ReferenceTest):
 
     def test_python_reference(self):
         self.setEmptyVars(["BAR"])
-        self.parseExpression("${@bb.data.getVar('BAR', d, True) + 'foo'}")
+        self.parseExpression("${@d.getVar('BAR', True) + 'foo'}")
         self.assertReferences(set(["BAR"]))
 
 class ShellReferenceTest(ReferenceTest):
@@ -209,17 +209,17 @@ be. These unit tests are testing snippets."""
         return " " + value
 
     def test_getvar_reference(self):
-        self.parseExpression("bb.data.getVar('foo', d, True)")
+        self.parseExpression("d.getVar('foo', True)")
         self.assertReferences(set(["foo"]))
         self.assertExecs(set())
 
     def test_getvar_computed_reference(self):
-        self.parseExpression("bb.data.getVar('f' + 'o' + 'o', d, True)")
+        self.parseExpression("d.getVar('f' + 'o' + 'o', True)")
         self.assertReferences(set())
         self.assertExecs(set())
 
     def test_getvar_exec_reference(self):
-        self.parseExpression("eval('bb.data.getVar(\"foo\", d, True)')")
+        self.parseExpression("eval('d.getVar(\"foo\", True)')")
         self.assertReferences(set())
         self.assertExecs(set(["eval"]))
 
@@ -269,7 +269,7 @@ be. These unit tests are testing snippets."""
 class DependencyReferenceTest(ReferenceTest):
 
     pydata = """
-bb.data.getVar('somevar', d, True)
+d.getVar('somevar', True)
 def test(d):
     foo = 'bar %s' % 'foo'
 def test2(d):
@@ -285,9 +285,9 @@ def a():
 
 test(d)
 
-bb.data.expand(bb.data.getVar("something", False, d), d)
+bb.data.expand(d.getVar("something", False), d)
 bb.data.expand("${inexpand} somethingelse", d)
-bb.data.getVar(a(), d, False)
+d.getVar(a(), False)
 """
 
     def test_python(self):



