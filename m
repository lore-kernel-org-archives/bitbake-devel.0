Return-Path: <andreas@gazonk.org>
Received: from gazonk.org (foo.gazonk.org [212.247.24.42])
	by mail.openembedded.org (Postfix) with SMTP id 41429601A0
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 May 2014 04:30:09 +0000 (UTC)
Received: (qmail 29331 invoked from network); 7 May 2014 04:30:06 -0000
Received: from localhost (HELO minimuffin.kakfat.se) (127.0.0.1)
	by localhost with SMTP; 7 May 2014 04:30:06 -0000
From: Andreas Bofjall <andreas@gazonk.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 May 2014 06:29:24 +0200
Message-Id: <1399436964-10270-1-git-send-email-andreas@gazonk.org>
X-Mailer: git-send-email 2.0.0.rc0
Subject: [PATCH] setup.py: fix documentation build
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
X-List-Received-Date: Wed, 07 May 2014 04:30:13 -0000

setup.py currently aborts when building the documentation:

> ./setup.py build
[..]
error: [Errno 2] No such file or directory:
'/home/jab/src/x/bitbake/doc/manual'

because the doc/manual directory has been renamed to
doc/bitbake-user-manual since commit 452a62a ("doc: Rename user-manual
-> bitbake-user-manual") and its Makefile has been removed as of commit
d419907 ("user-manual: Import YP Docs templates for usermanual
improvements").

Update setup.py to reflect the new name and usage.

Signed-off-by: Andreas Bofjall <andreas@gazonk.org>
---
 setup.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/setup.py b/setup.py
index 8c26a9b..02de77b 100755
--- a/setup.py
+++ b/setup.py
@@ -33,17 +33,17 @@ class Clean(clean):
     def run(self):
         clean.run(self)
         origpath = os.path.abspath(os.curdir)
-        os.chdir(os.path.join(origpath, 'doc', 'manual'))
+        os.chdir(os.path.join(origpath, 'doc'))
         make = os.environ.get('MAKE') or 'make'
-        os.system('%s clean-%s' % (make, doctype))
+        os.system('%s clean-%s DOC=bitbake-user-manual' % (make, doctype))
 
 class Build(build):
     def run(self):
         build.run(self)
         origpath = os.path.abspath(os.curdir)
-        os.chdir(os.path.join(origpath, 'doc', 'manual'))
+        os.chdir(os.path.join(origpath, 'doc'))
         make = os.environ.get('MAKE') or 'make'
-        ret = os.system('%s %s' % (make, doctype))
+        ret = os.system('%s %s DOC=bitbake-user-manual' % (make, doctype))
         if ret != 0:
             print("ERROR: Unable to generate html documentation.")
             sys.exit(ret)
@@ -58,7 +58,7 @@ setup(name='bitbake',
       py_modules = ["codegen"],
       scripts = ["bin/bitbake", "bin/bitbake-layers", "bin/bitbake-diffsigs", "bin/bitbake-prserv", "bin/bitbake-selftest", "bin/image-writer"],
       data_files = [("share/bitbake", glob("conf/*") + glob("classes/*")),
-                  ("share/doc/bitbake-%s/manual" % __version__, glob("doc/manual/html/*"))],
+                  ("share/doc/bitbake-%s/bitbake-user-manual" % __version__, glob("doc/bitbake-user-manual/html/*"))],
       cmdclass = {
           "build": Build,
           "clean": Clean,
-- 
2.0.0.rc0


