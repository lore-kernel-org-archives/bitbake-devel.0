Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 9ED006AC4B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jul 2016 18:56:26 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id f126so310177wma.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jul 2016 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=Nyr1FLiggmrIq4dshUuR8AmbeA2Y2+rmm3X5knfXvrU=;
	b=QS+JF1WtCcnffsdc8GQe70sgiWmAACK3ED7EZGU3NF060jvfb89xaHdduUlZ/dTBkO
	/W6D0Ub0PZneZNENqRROOU9vKrSxHfgTyy771t0Lh9q2JQ3kL3cYX7SyZCgP75xjEu6M
	m5T5ZGZk6j7Utk2fvEatomY7dnxFhFjpWLFSNSSwNwlu7KyxU5aF6Xkn6b0tT/AqqyTs
	sEa5y4k9jYwP9A2PT4CAmYy6MQ23r6y+kpdQ3E5yaViKE1XMF04l6dsWwcu3xXGW6sxD
	8nn7RwaZyMTKyEMamypoYp5udL0Org/tvRAwjktwXYhIriaIzkvxXvZP0I091WwraY3H
	H1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=Nyr1FLiggmrIq4dshUuR8AmbeA2Y2+rmm3X5knfXvrU=;
	b=aQ/RicOS9sj5fvRGuf3IXsptMY6xcIBS66dT0tEvn7iXw2P+D5iEaZAVs8DwpgPUYM
	sQdCfp7qyKIYDTV3yrCuNdYm3drTtqiDcxy4j7sZ+es9RXRtUvCSOcOyBAQOfOAyTLP1
	RFjwv00vTzDWeUXLVy8PT80Qh58wU8iVrgOWI5BrpRalgFlnXjKpmeAu9CYsM26EW/rq
	R5Z4+n+gh65S0g+pS/3yfgwRDrhwQ4f+tnci7VizbPpxoffEfTCS7U8iPuZoCp6LPWUl
	VxsEEpDBkR/F6Xsw3Vi2zxskqfGHLhPvrCufLvFC4WcYLYYJuufXF8g1bJ0ccO92/k6n
	8KEw==
X-Gm-Message-State: ALyK8tLEPv9Cgk6JTjm9BLHwG5flkmbvk1U2gq2hycB6QRPf//1sBDzOcwdgZpjJJMcsghM1
X-Received: by 10.28.158.87 with SMTP id h84mr34163302wme.43.1468522586004;
	Thu, 14 Jul 2016 11:56:26 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id z5sm3837268wme.5.2016.07.14.11.56.24
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 14 Jul 2016 11:56:25 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Jul 2016 19:56:22 +0100
Message-Id: <1468522582-25301-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] build: don't use $B as the default cwd for functions
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
X-List-Received-Date: Thu, 14 Jul 2016 18:56:27 -0000

When bitbake executes a shell or Python function it can cd/chdir() into a
directory before executing the task. If no directory is specified then the
default of $B is used.  However $B is an OpenEmbedded variable and BitBake
shouldn't be aware of it.

To solve this change the semantics slightly so that if no directory is
specified, the current working directory isn't changed.  There's also a sanity
check that emits a warning if a Python task does os.chdir() without restoring
the old path, and the previous working directory is restored.

This does change semantics: whereas before a function in OE would have $B as the
working directory unless specified, now the working directory is the top of the
build tree.  Any breakage this causes can be solved by either adding
do_some_task[dirs] = "${B}" or by using absolute paths in the task.

[ YOCTO #4634 ]

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/build.py | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 4fb2a77..4f01d66 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -188,6 +188,11 @@ class LogTee(object):
 def exec_func(func, d, dirs = None, pythonexception=False):
     """Execute a BB 'function'"""
 
+    try:
+        oldcwd = os.getcwd()
+    except:
+        oldcwd = None
+
     body = d.getVar(func, False)
     if not body:
         if body is None:
@@ -211,9 +216,7 @@ def exec_func(func, d, dirs = None, pythonexception=False):
             bb.utils.mkdirhier(adir)
         adir = dirs[-1]
     else:
-        adir = d.getVar('B', True)
-        bb.utils.mkdirhier(adir)
-
+        adir = None
     ispython = flags.get('python')
 
     lockflag = flags.get('lockfiles')
@@ -257,6 +260,13 @@ def exec_func(func, d, dirs = None, pythonexception=False):
         else:
             exec_func_shell(func, d, runfile, cwd=adir)
 
+    if oldcwd and os.getcwd() != oldcwd:
+        try:
+            bb.warn("Task %s changed cwd to %s" % (func, os.getcwd()))
+            os.chdir(oldcwd)
+        except:
+            pass
+
 _functionfmt = """
 {function}(d)
 """
@@ -272,7 +282,8 @@ def exec_func_python(func, d, runfile, cwd=None, pythonexception=False):
     if cwd:
         try:
             olddir = os.getcwd()
-        except OSError:
+        except OSError as e:
+            bb.warn("%s: Cannot get cwd: %s" % (func, e))
             olddir = None
         os.chdir(cwd)
 
@@ -298,8 +309,8 @@ def exec_func_python(func, d, runfile, cwd=None, pythonexception=False):
         if cwd and olddir:
             try:
                 os.chdir(olddir)
-            except OSError:
-                pass
+            except OSError as e:
+                bb.warn("%s: Cannot restore cwd %s: %s" % (func, olddir, e))
 
 def shell_trap_code():
     return '''#!/bin/sh\n
-- 
2.8.1


