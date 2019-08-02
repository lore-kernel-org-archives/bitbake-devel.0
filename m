Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
	[209.85.128.54])
	by mail.openembedded.org (Postfix) with ESMTP id B93D97F318
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:21:02 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 207so68359459wma.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=q9E9/9ipd9lOEE6qm35zbIWmSZHPo3nK5NYAAayOWTo=;
	b=fyMZtHlo8GhGwyU3xtn/zOHHAyuDyn2SI8t55kckZ3b8un2sTv/5d5e+6o7YXJFPfW
	sJAdIt2gY28hQc/wslHXjQFyeBEUlz5kB2nDtm7qUjQ82lQ4YnBrJkNGPU6zeE27Jrqr
	C2ssjg2KH0xoGpqMLn7rRTWRFrWwaPiwxmEL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=q9E9/9ipd9lOEE6qm35zbIWmSZHPo3nK5NYAAayOWTo=;
	b=TzFu276rI0YswAnWm/uhMJ+ILgIQs8TLf3SuaYwoR5sl4WVk37AoP0JOVgKErqb38d
	nxlPK4NsztK+7jtoi7ogSdsifxXPrDq9rxB9bo2Wu8TUuyNSBQVEnpeTf+KBaF+D8XHi
	lph6MZk7hfz2QD0Lk3fRf8W1Hd61Iq55Xy/ipqGp/I1VnWxlR3qcDSTak1GiV/JXG4mJ
	vQ9EMOeBGZkqdrD35xv8KOEikQHX2QmbgOiVrtHgQ1ally+GH9W7HAEdI4EwEer6swMr
	i003wwh9l2SS7IwIbEFjQIdYJXVUHvbRMIL/7cVGmW1DLoR1PN+Z07ZU4M0Pqvkn5Dou
	FAfQ==
X-Gm-Message-State: APjAAAV0V+pxAVUzZ/NtPqQmzYTaZwmpPayZRGYens9THS90EpHZv+j+
	NiIRJ8iRlYUsYlvCIPQgkrHt9Vf1j8c=
X-Google-Smtp-Source: APXvYqzCGxNQ5JQy6wNLRnvPa7k2/9m0q5USJb0HWeYrmtkEpN69roGgJfJ6Q92nV9Ja3uTCNUhvNA==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr4849193wmf.162.1564759263055; 
	Fri, 02 Aug 2019 08:21:03 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.21.02
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:21:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:47 +0100
Message-Id: <20190802152049.16529-14-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 14/16] build/utils: Drop bb.build.FuncFailed
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
X-List-Received-Date: Fri, 02 Aug 2019 15:21:03 -0000
Content-Transfer-Encoding: 8bit

Its hard to see what this exception adds in the current codebase. The logfile
attribute is effectively ignored, the exception doesn't serve a defined
purpose and mostly seems to be worked around.

Remove it entirely. If this does cause output problems, we'll figure
out better ways to address those.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 57 +++++++++----------------------------------------
 lib/bb/data.py  |  2 +-
 lib/bb/utils.py |  2 +-
 3 files changed, 12 insertions(+), 49 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index e2f91fa3b7..30a2ba236f 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -54,23 +54,6 @@ else:
 builtins['bb'] = bb
 builtins['os'] = os
 
-class FuncFailed(Exception):
-    def __init__(self, name = None, logfile = None):
-        self.logfile = logfile
-        self.name = name
-        if name:
-            self.msg = 'Function failed: %s' % name
-        else:
-            self.msg = "Function failed"
-
-    def __str__(self):
-        if self.logfile and os.path.exists(self.logfile):
-            msg = ("%s (log file is located at %s)" %
-                   (self.msg, self.logfile))
-        else:
-            msg = self.msg
-        return msg
-
 class TaskBase(event.Event):
     """Base class for task events"""
 
@@ -189,12 +172,7 @@ class StdoutNoopContextManager:
         return sys.stdout.name
 
 
-#
-# pythonexception allows the python exceptions generated to be raised
-# as the real exceptions (not FuncFailed) and without a backtrace at the
-# origin of the failure.
-#
-def exec_func(func, d, dirs = None, pythonexception=False):
+def exec_func(func, d, dirs = None):
     """Execute a BB 'function'"""
 
     try:
@@ -266,7 +244,7 @@ def exec_func(func, d, dirs = None, pythonexception=False):
 
     with bb.utils.fileslocked(lockfiles):
         if ispython:
-            exec_func_python(func, d, runfile, cwd=adir, pythonexception=pythonexception)
+            exec_func_python(func, d, runfile, cwd=adir)
         else:
             exec_func_shell(func, d, runfile, cwd=adir)
 
@@ -286,7 +264,7 @@ _functionfmt = """
 {function}(d)
 """
 logformatter = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
-def exec_func_python(func, d, runfile, cwd=None, pythonexception=False):
+def exec_func_python(func, d, runfile, cwd=None):
     """Execute a python BB 'function'"""
 
     code = _functionfmt.format(function=func)
@@ -311,14 +289,7 @@ def exec_func_python(func, d, runfile, cwd=None, pythonexception=False):
         bb.methodpool.insert_method(func, text, fn, lineno - 1)
 
         comp = utils.better_compile(code, func, "exec_python_func() autogenerated")
-        utils.better_exec(comp, {"d": d}, code, "exec_python_func() autogenerated", pythonexception=pythonexception)
-    except (bb.parse.SkipRecipe, bb.build.FuncFailed):
-        raise
-    except Exception as e:
-        if pythonexception:
-            raise
-        logger.error(str(e))
-        raise FuncFailed(func, None)
+        utils.better_exec(comp, {"d": d}, code, "exec_python_func() autogenerated")
     finally:
         bb.debug(2, "Python function %s finished" % func)
 
@@ -475,13 +446,8 @@ exit $ret
     with open(fifopath, 'r+b', buffering=0) as fifo:
         try:
             bb.debug(2, "Executing shell function %s" % func)
-
-            try:
-                with open(os.devnull, 'r+') as stdin, logfile:
-                    bb.process.run(cmd, shell=False, stdin=stdin, log=logfile, extrafiles=[(fifo,readfifo)])
-            except bb.process.CmdError:
-                logfn = d.getVar('BB_LOGFILE')
-                raise FuncFailed(func, logfn)
+            with open(os.devnull, 'r+') as stdin, logfile:
+                bb.process.run(cmd, shell=False, stdin=stdin, log=logfile, extrafiles=[(fifo,readfifo)])
         finally:
             os.unlink(fifopath)
 
@@ -609,9 +575,6 @@ def _exec_task(fn, task, d, quieterr):
             event.fire(TaskStarted(task, logfn, flags, localdata), localdata)
         except (bb.BBHandledException, SystemExit):
             return 1
-        except FuncFailed as exc:
-            logger.error(str(exc))
-            return 1
 
         try:
             for func in (prefuncs or '').split():
@@ -619,7 +582,10 @@ def _exec_task(fn, task, d, quieterr):
             exec_func(task, localdata)
             for func in (postfuncs or '').split():
                 exec_func(func, localdata)
-        except FuncFailed as exc:
+        except bb.BBHandledException:
+            event.fire(TaskFailed(task, logfn, localdata, True), localdata)
+            return 1
+        except Exception as exc:
             if quieterr:
                 event.fire(TaskFailedSilent(task, logfn, localdata), localdata)
             else:
@@ -627,9 +593,6 @@ def _exec_task(fn, task, d, quieterr):
                 logger.error(str(exc))
                 event.fire(TaskFailed(task, logfn, localdata, errprinted), localdata)
             return 1
-        except bb.BBHandledException:
-            event.fire(TaskFailed(task, logfn, localdata, True), localdata)
-            return 1
     finally:
         sys.stdout.flush()
         sys.stderr.flush()
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 443615b977..0d75d0c1a9 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -130,7 +130,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         if all:
             oval = d.getVar(var, False)
         val = d.getVar(var)
-    except (KeyboardInterrupt, bb.build.FuncFailed):
+    except (KeyboardInterrupt):
         raise
     except Exception as exc:
         o.write('# expansion of %s threw %s: %s\n' % (var, exc.__class__.__name__, str(exc)))
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ed19825faf..0618e46fe6 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -394,7 +394,7 @@ def better_exec(code, context, text = None, realfile = "<code>", pythonexception
         code = better_compile(code, realfile, realfile)
     try:
         exec(code, get_context(), context)
-    except (bb.BBHandledException, bb.parse.SkipRecipe, bb.build.FuncFailed, bb.data_smart.ExpansionError):
+    except (bb.BBHandledException, bb.parse.SkipRecipe, bb.data_smart.ExpansionError):
         # Error already shown so passthrough, no need for traceback
         raise
     except Exception as e:
-- 
2.20.1


