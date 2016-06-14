Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id A5AFB6FEF6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2016 14:09:39 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id m124so124968037wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2016 07:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=LJ4uyX85kMDKhHa71Q69FeshAaUd8alVETOuCrcPw7c=;
	b=QDMqlAvukBQsQSeWQrqTVd8AC+4FL86jy8hft1GiMJ0wUT0cAknAZ+8aEKehOue4Hk
	h6HlI+Q8MFNKathWsWHA8OfYWbLyZy7HlzpfhRBr/TrACre83vA1gA7woqLyv3DUFHdu
	SCOYDf/cK2eksIMpyLMZUEEAyKob3gzVgjVWB33dGtiExkb1ZgeUk0MsubTevThwkDIZ
	osKazr42c6na+DSQ2T/0k/TVg12kQme/4SJ4rSvmgpOMkj5ilmEqB+EmlpvXXgBQqgjp
	7pG5YgJxx0r7gDwk9dz0Fa4EZINjaUOiusEm/NfbMGyMaaeTBTBDds95Uyz9uMfMu3oL
	0sGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=LJ4uyX85kMDKhHa71Q69FeshAaUd8alVETOuCrcPw7c=;
	b=nENnCjOQVXLz94Ub5ArHiC6Kxar0NSSJSKt9wYlXYECdXnyoAjKJ4fFIbKW/Zh/RiQ
	xDBfN1m9g+jYzCOj7LfopLu6NVcWwgDFbJP9GsX4QE74l2QmGKLLfUoRNU3stUXxVFWU
	m6FjWTTHQkoYjESOtVO0UzwF9BI/SXhg5Z1O8uwxrQ1s4OIx05GVE8Y3wVcIEgzS6F+v
	kd3FYjEdQ1kyqGJH+oVMEkqMoSQ3DiThhqlF6c9ksGJIA71b1Fr2bfUl7hKF5jtXcR99
	s+QRgaLVD9H1qxU5d3mbi1CBRAJNueZSNnMooSLDjA6XJgw+VVC5dwyCT0QarONBGFQm
	KG8A==
X-Gm-Message-State: ALyK8tK331hZFtEJ5qHtgfCtGzaLx0bwYWYWDe3K7bFPmBh96OeFFo/BRBa5yx3TQJM3HVnO
X-Received: by 10.28.25.129 with SMTP id 123mr5098577wmz.10.1465913379112;
	Tue, 14 Jun 2016 07:09:39 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	t198sm4337682wmt.16.2016.06.14.07.09.38
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 14 Jun 2016 07:09:38 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jun 2016 15:09:34 +0100
Message-Id: <1465913374-17700-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.0.rc3
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
X-List-Received-Date: Tue, 14 Jun 2016 14:09:40 -0000

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
 bitbake/lib/bb/build.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index e016ae3..43d9ebf 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -168,6 +168,7 @@ class LogTee(object):
 def exec_func(func, d, dirs = None, pythonexception=False):
     """Execute a BB 'function'"""
 
+    oldcwd = os.getcwd()
     body = d.getVar(func, False)
     if not body:
         if body is None:
@@ -191,9 +192,7 @@ def exec_func(func, d, dirs = None, pythonexception=False):
             bb.utils.mkdirhier(adir)
         adir = dirs[-1]
     else:
-        adir = d.getVar('B', True)
-        bb.utils.mkdirhier(adir)
-
+        adir = None
     ispython = flags.get('python')
 
     lockflag = flags.get('lockfiles')
@@ -237,6 +236,10 @@ def exec_func(func, d, dirs = None, pythonexception=False):
         else:
             exec_func_shell(func, d, runfile, cwd=adir)
 
+    if os.getcwd() != oldcwd:
+        bb.warn("Task %s changed cwd to %s" % (func, os.getcwd()))
+        os.chdir(oldcwd)
+
 _functionfmt = """
 {function}(d)
 """
@@ -252,7 +255,8 @@ def exec_func_python(func, d, runfile, cwd=None, pythonexception=False):
     if cwd:
         try:
             olddir = os.getcwd()
-        except OSError:
+        except OSError as e:
+            bb.warn("%s: Cannot get cwd: %s" % (func, e))
             olddir = None
         os.chdir(cwd)
 
@@ -278,8 +282,8 @@ def exec_func_python(func, d, runfile, cwd=None, pythonexception=False):
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
2.8.0.rc3


