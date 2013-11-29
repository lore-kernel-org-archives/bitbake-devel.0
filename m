Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id B3CE46C72F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2013 18:12:00 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rATIBsVN018620 for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2013 18:11:54 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LneK6xlGVMOB for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2013 18:11:54 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rATIBpi5018612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2013 18:11:53 GMT
Message-ID: <1385748708.11222.76.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 29 Nov 2013 18:11:48 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] parse/ConfHander/utils: Fix cache dependency bugs
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
X-List-Received-Date: Fri, 29 Nov 2013 18:12:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

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

Unfortunately this is old code in bitbake and the patch isn't the
neatest since we have to work within that framework.

[YOCTO #5611]
[YOCTO #4425]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index c973f6f..d45b583 100644
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
+        newfn, attempts = bb.utils.which_hist(bbpath, fn)
+        for af in attempts:
+            mark_dependency(d, af)
         if not newfn:
             raise IOError("file %s not found in %s" % (fn, bbpath))
         fn = newfn
 
+    mark_dependency(d, fn)
     if not os.path.isfile(fn):
         raise IOError("file %s not found" % fn)
 
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index c28f18b..6355c19 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -82,12 +82,15 @@ def include(oldfn, fn, lineno, data, error_out):
     if not os.path.isabs(fn):
         dname = os.path.dirname(oldfn)
         bbpath = "%s:%s" % (dname, data.getVar("BBPATH", True))
-        abs_fn = bb.utils.which(bbpath, fn)
+        abs_fn, attempts = bb.utils.which_hist(bbpath, fn)
+        if abs_fn and bb.parse.check_dependency(data, abs_fn):
+            bb.warn("Duplicate inclusion for %s in %s" % (abs_fn, data.getVar('FILE', True)))
+        for af in attempts:
+            bb.parse.mark_dependency(data, af)
         if abs_fn:
             fn = abs_fn
-
-    if fn in (data.getVar("__depends", False) or ""):
-        bb.warn("Duplicate inclusion for %s" % fn)
+    elif bb.parse.check_dependency(data, fn):
+        bb.warn("Duplicate inclusion for %s in %s" % (fn, data.getVar('FILE', True)))
 
     from bb.parse import handle
     try:
@@ -96,6 +99,7 @@ def include(oldfn, fn, lineno, data, error_out):
         if error_out:
             raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
         logger.debug(2, "CONF file '%s' not found", fn)
+        bb.parse.mark_dependency(data, fn)
 
 # We have an issue where a UI might want to enforce particular settings such as
 # an empty DISTRO variable. If configuration files do something like assigning
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 560f55a..af33a69 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -814,6 +814,26 @@ def which(path, item, direction = 0):
 
     return ""
 
+def which_hist(path, item, direction = 0):
+    """
+    Locate a file in a PATH
+    """
+
+    hist = []
+    paths = (path or "").split(':')
+    if direction != 0:
+        paths.reverse()
+
+    for p in paths:
+        next = os.path.join(p, item)
+        hist.append(next)
+        if os.path.exists(next):
+            if not os.path.isabs(next):
+                next = os.path.abspath(next)
+            return next, hist
+
+    return "", hist
+
 def to_boolean(string, default=None):
     if not string:
         return default



