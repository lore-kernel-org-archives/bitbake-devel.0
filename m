Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 33DF860D9D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Dec 2013 02:19:35 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rBP2JZCG013096
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 18:19:35 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Tue, 24 Dec 2013 18:19:35 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 24 Dec 2013 21:19:28 -0500
Message-ID: <19fa3b23c5c4688e584a78af4d693d08b727ec7b.1387937195.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1387937195.git.liezhi.yang@windriver.com>
References: <cover.1387937195.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/4] bitbake: parse/ConfHander/BBHandler/utils: Fix cache dependency bugs
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
X-List-Received-Date: Wed, 25 Dec 2013 02:19:35 -0000
Content-Type: text/plain

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Currently bitbake only adds files to its dependency list if they exist.
If you add 'include foo.inc' to your recipe and the file doesn't exist,
then later you add the file, the cache will not be invalidated.

This leads to another bug which is that if files don't exist and then
you add them and they should be found first due to BBPATH, again the
cache won't invalidate.

This patch adds in tracking of files we check for the existence of so
that if they are added later, the cache correctly invalidates. This
necessitated a new version of bb.utils.which which returns a list of
files tested for.

The patch also adds in checks for duplicate file includes and for now
prints a warning about this. That will likely become a fatal error at
some point since its never usually desired to include a file twice.

The same issue is also fixed for class inheritance. Now when a class
is added which would be found in the usual search path, it will cause
the cache to be invalidated.

Unfortunately this is old code in bitbake and the patch isn't the
neatest since we have to work within that framework.

[YOCTO #5611]
[YOCTO #4425]

(Bitbake master rev: 78d285871e4b8c54ccc4602d571e85f922e37ccd)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/parse/__init__.py             |   19 +++++++++++++++----
 bitbake/lib/bb/parse/parse_py/BBHandler.py   |    5 ++++-
 bitbake/lib/bb/parse/parse_py/ConfHandler.py |    9 ++++++++-
 bitbake/lib/bb/utils.py                      |    8 +++++++-
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index c973f6f..97983c9 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -73,9 +73,17 @@ def update_mtime(f):
 def mark_dependency(d, f):
     if f.startswith('./'):
         f = "%s/%s" % (os.getcwd(), f[2:])
-    deps = (d.getVar('__depends') or []) + [(f, cached_mtime(f))]
-    d.setVar('__depends', deps)
-
+    deps = (d.getVar('__depends') or [])
+    s = (f, cached_mtime_noerror(f))
+    if s not in deps:
+        deps.append(s)
+        d.setVar('__depends', deps)
+
+def check_dependency(d, f):
+    s = (f, cached_mtime_noerror(f))
+    deps = (d.getVar('__depends') or [])
+    return s in deps
+   
 def supports(fn, data):
     """Returns true if we have a handler for this file, false otherwise"""
     for h in handlers:
@@ -102,11 +110,14 @@ def init_parser(d):
 def resolve_file(fn, d):
     if not os.path.isabs(fn):
         bbpath = d.getVar("BBPATH", True)
-        newfn = bb.utils.which(bbpath, fn)
+        newfn, attempts = bb.utils.which(bbpath, fn, history=True)
+        for af in attempts:
+            mark_dependency(d, af)
         if not newfn:
             raise IOError("file %s not found in %s" % (fn, bbpath))
         fn = newfn
 
+    mark_dependency(d, fn)
     if not os.path.isfile(fn):
         raise IOError("file %s not found" % fn)
 
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 01f22d3..7cba649 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -77,7 +77,10 @@ def inherit(files, fn, lineno, d):
         if not os.path.isabs(file):
             dname = os.path.dirname(fn)
             bbpath = "%s:%s" % (dname, d.getVar("BBPATH", True))
-            abs_fn = bb.utils.which(bbpath, file)
+            abs_fn, attempts = bb.utils.which(bbpath, file, history=True)
+            for af in attempts:
+                if af != abs_fn:
+                    bb.parse.mark_dependency(d, af)
             if abs_fn:
                 file = abs_fn
 
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 7b30c8a..f4fb2aa 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -82,9 +82,15 @@ def include(oldfn, fn, lineno, data, error_out):
     if not os.path.isabs(fn):
         dname = os.path.dirname(oldfn)
         bbpath = "%s:%s" % (dname, data.getVar("BBPATH", True))
-        abs_fn = bb.utils.which(bbpath, fn)
+        abs_fn, attempts = bb.utils.which(bbpath, fn, history=True)
+        if abs_fn and bb.parse.check_dependency(data, abs_fn):
+            bb.warn("Duplicate inclusion for %s in %s" % (abs_fn, data.getVar('FILE', True)))
+        for af in attempts:
+            bb.parse.mark_dependency(data, af)
         if abs_fn:
             fn = abs_fn
+    elif bb.parse.check_dependency(data, fn):
+        bb.warn("Duplicate inclusion for %s in %s" % (fn, data.getVar('FILE', True)))
 
     from bb.parse import handle
     try:
@@ -93,6 +99,7 @@ def include(oldfn, fn, lineno, data, error_out):
         if error_out:
             raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
         logger.debug(2, "CONF file '%s' not found", fn)
+        bb.parse.mark_dependency(data, fn)
 
 # We have an issue where a UI might want to enforce particular settings such as
 # an empty DISTRO variable. If configuration files do something like assigning
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index f9ee4f1..20dea64 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -793,22 +793,28 @@ def copyfile(src, dest, newmtime = None, sstat = None):
         newmtime = sstat[stat.ST_MTIME]
     return newmtime
 
-def which(path, item, direction = 0):
+def which(path, item, direction = 0, history = False):
     """
     Locate a file in a PATH
     """
 
+    hist = []
     paths = (path or "").split(':')
     if direction != 0:
         paths.reverse()
 
     for p in paths:
         next = os.path.join(p, item)
+        hist.append(next)
         if os.path.exists(next):
             if not os.path.isabs(next):
                 next = os.path.abspath(next)
+            if history:
+                return next, hist
             return next
 
+    if history:
+        return "", hist
     return ""
 
 def to_boolean(string, default=None):
-- 
1.7.10.4


