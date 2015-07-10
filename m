Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 20E036017E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 13:51:54 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 10 Jul 2015 06:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,446,1432623600"; d="scan'208";a="759832537"
Received: from dawalker-mobl3.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.7.62])
	by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2015 06:51:53 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jul 2015 14:51:40 +0100
Message-Id: <3af66ef31aef8f92109610e547267ac99a63de8e.1436536203.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1436536203.git.paul.eggleton@linux.intel.com>
References: <cover.1436536203.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1436536203.git.paul.eggleton@linux.intel.com>
References: <cover.1436536203.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] lib/bb: set up infrastructure for shell message functions
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
X-List-Received-Date: Fri, 10 Jul 2015 13:51:54 -0000

Create a fifo under ${T} for each running task that can be used by the
task to send events back to BitBake. The purpose of this is to allow
OpenEmbedded's logging.bbclass (which provides shell function
equivalents for bb.warn(), bb.note() etc.) to have those functions
trigger the appropriate events within BitBake so that messages are shown
through the BitBake UI rather than just in the task log; to do that we
just call the python functions.

Part of the fix for [YOCTO #5275].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/build.py   | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 lib/bb/process.py | 25 ++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 14dc5e0..cce01fe 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -329,14 +329,50 @@ exit $?
     else:
         logfile = sys.stdout
 
-    bb.debug(2, "Executing shell function %s" % func)
+    def readfifo(data):
+        lines = data.split('\0')
+        for line in lines:
+            splitval = line.split(' ', 1)
+            cmd = splitval[0]
+            if len(splitval) > 1:
+                value = splitval[1]
+            else:
+                value = ''
+            if cmd == 'bbplain':
+                bb.plain(value)
+            elif cmd == 'bbnote':
+                bb.note(value)
+            elif cmd == 'bbwarn':
+                bb.warn(value)
+            elif cmd == 'bberror':
+                bb.error(value)
+            elif cmd == 'bbfatal':
+                # The caller will call exit themselves, so bb.error() is
+                # what we want here rather than bb.fatal()
+                bb.error(value)
+            elif cmd == 'bbdebug':
+                splitval = value.split(' ', 1)
+                level = int(splitval[0])
+                value = splitval[1]
+                bb.debug(level, value)
 
-    try:
-        with open(os.devnull, 'r+') as stdin:
-            bb.process.run(cmd, shell=False, stdin=stdin, log=logfile)
-    except bb.process.CmdError:
-        logfn = d.getVar('BB_LOGFILE', True)
-        raise FuncFailed(func, logfn)
+    tempdir = d.getVar('T', True)
+    fifopath = os.path.join(tempdir, 'fifo.%s' % os.getpid())
+    if os.path.exists(fifopath):
+        os.unlink(fifopath)
+    os.mkfifo(fifopath)
+    with open(fifopath, 'r+') as fifo:
+        try:
+            bb.debug(2, "Executing shell function %s" % func)
+
+            try:
+                with open(os.devnull, 'r+') as stdin:
+                    bb.process.run(cmd, shell=False, stdin=stdin, log=logfile, extrafiles=[(fifo,readfifo)])
+            except bb.process.CmdError:
+                logfn = d.getVar('BB_LOGFILE', True)
+                raise FuncFailed(func, logfn)
+        finally:
+            os.unlink(fifopath)
 
     bb.debug(2, "Shell function %s finished" % func)
 
diff --git a/lib/bb/process.py b/lib/bb/process.py
index 8b1aea9..d95a03d 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -64,7 +64,7 @@ class Popen(subprocess.Popen):
         options.update(kwargs)
         subprocess.Popen.__init__(self, *args, **options)
 
-def _logged_communicate(pipe, log, input):
+def _logged_communicate(pipe, log, input, extrafiles):
     if pipe.stdin:
         if input is not None:
             pipe.stdin.write(input)
@@ -79,6 +79,19 @@ def _logged_communicate(pipe, log, input):
     if pipe.stderr is not None:
         bb.utils.nonblockingfd(pipe.stderr.fileno())
         rin.append(pipe.stderr)
+    for fobj, _ in extrafiles:
+        bb.utils.nonblockingfd(fobj.fileno())
+        rin.append(fobj)
+
+    def readextras():
+        for fobj, func in extrafiles:
+            try:
+                data = fobj.read()
+            except IOError as err:
+                if err.errno == errno.EAGAIN or err.errno == errno.EWOULDBLOCK:
+                    data = None
+            if data is not None:
+                func(data)
 
     try:
         while pipe.poll() is None:
@@ -100,15 +113,21 @@ def _logged_communicate(pipe, log, input):
                 if data is not None:
                     errdata.append(data)
                     log.write(data)
+
+            readextras()
+
     finally:    
         log.flush()
+
+    readextras()
+
     if pipe.stdout is not None:
         pipe.stdout.close()
     if pipe.stderr is not None:
         pipe.stderr.close()
     return ''.join(outdata), ''.join(errdata)
 
-def run(cmd, input=None, log=None, **options):
+def run(cmd, input=None, log=None, extrafiles=[], **options):
     """Convenience function to run a command and return its output, raising an
     exception when the command fails"""
 
@@ -124,7 +143,7 @@ def run(cmd, input=None, log=None, **options):
             raise CmdError(cmd, exc)
 
     if log:
-        stdout, stderr = _logged_communicate(pipe, log, input)
+        stdout, stderr = _logged_communicate(pipe, log, input, extrafiles)
     else:
         stdout, stderr = pipe.communicate(input)
 
-- 
2.1.0


