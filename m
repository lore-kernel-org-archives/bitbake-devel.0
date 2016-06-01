Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A256477190
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb3B4007479; Wed, 1 Jun 2016 13:37:04 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Mg5WVTdcNIqB; Wed,  1 Jun 2016 13:37:04 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Caxjn007446
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000nU-7R; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:23 +0100
Message-Id: <1464784607-2985-4-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailman-Approved-At: Wed, 01 Jun 2016 14:17:24 +0000
Subject: [PATCH 04/28] bitbake: Convert to python 3 megacommit This needs breaking up into smaller changes.
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:12 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake                      |   5 +-
 bin/bitbake-diffsigs             |   4 +-
 bin/bitbake-dumpsig              |   4 +-
 bin/bitbake-layers               |   5 +-
 bin/bitbake-prserv               |   2 +-
 bin/bitbake-selftest             |   2 +-
 bin/bitbake-worker               |  60 ++++++++++----------
 bin/bitdoc                       |   2 +-
 bin/image-writer                 |   8 ++-
 bin/toaster-eventreplay          |   2 +-
 contrib/dump_cache.py            |   2 +-
 lib/bb/COW.py                    |  44 +++++++--------
 lib/bb/__init__.py               |   2 +-
 lib/bb/build.py                  |  13 ++---
 lib/bb/cache.py                  |  18 ++----
 lib/bb/checksum.py               |   9 +--
 lib/bb/codeparser.py             |  15 ++---
 lib/bb/command.py                |   2 +-
 lib/bb/cooker.py                 |  38 ++++++-------
 lib/bb/data_smart.py             |   4 +-
 lib/bb/event.py                  |   9 +--
 lib/bb/exceptions.py             |   2 +-
 lib/bb/fetch2/__init__.py        |  36 ++++++------
 lib/bb/fetch2/local.py           |   4 +-
 lib/bb/fetch2/npm.py             |   6 +-
 lib/bb/fetch2/perforce.py        |   2 +-
 lib/bb/fetch2/sftp.py            |   8 +--
 lib/bb/fetch2/ssh.py             |   6 +-
 lib/bb/fetch2/wget.py            |  48 ++++++++--------
 lib/bb/main.py                   |  11 ++--
 lib/bb/msg.py                    |   2 +-
 lib/bb/parse/ast.py              |  18 +++---
 lib/bb/persist_data.py           |  10 ++--
 lib/bb/process.py                |  36 ++++++++----
 lib/bb/providers.py              |   2 +-
 lib/bb/pysh/builtin.py           |   2 +-
 lib/bb/pysh/interp.py            |   4 +-
 lib/bb/pysh/pyshlex.py           |   2 +-
 lib/bb/pysh/pyshyacc.py          |   4 +-
 lib/bb/runqueue.py               | 117 +++++++++++++++++++--------------------
 lib/bb/server/process.py         |   8 +--
 lib/bb/server/xmlrpc.py          |  48 ++++++++--------
 lib/bb/siggen.py                 |  19 +++----
 lib/bb/taskdata.py               |  12 ++--
 lib/bb/tests/codeparser.py       |   4 +-
 lib/bb/tests/data.py             |  12 ++--
 lib/bb/tests/parse.py            |   2 +-
 lib/bb/ui/crumbs/hobwidget.py    |   2 +-
 lib/bb/ui/crumbs/progressbar.py  |   6 +-
 lib/bb/ui/crumbs/runningbuild.py |  12 ++--
 lib/bb/ui/goggle.py              |  11 +++-
 lib/bb/ui/knotty.py              |   6 +-
 lib/bb/ui/ncurses.py             |   8 +--
 lib/bb/ui/uievent.py             |   4 +-
 lib/bb/utils.py                  |  20 +++----
 lib/bblayers/action.py           |   2 +-
 lib/bblayers/common.py           |   2 +-
 lib/bblayers/layerindex.py       |  12 ++--
 lib/bblayers/query.py            |   4 +-
 lib/codegen.py                   |   8 +--
 lib/ply/yacc.py                  |   2 +
 lib/prserv/db.py                 |   2 +-
 lib/prserv/serv.py               |  14 ++---
 63 files changed, 390 insertions(+), 400 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index bba87b0..9813a08 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
@@ -35,6 +35,9 @@ except RuntimeError as exc:
 from bb import cookerdata
 from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
+if sys.getfilesystemencoding() != "utf-8":
+    sys.exit("Please use a locale setting which supports utf-8.\nPython can't change the filesystem locale after loading so we need a utf-8 when python starts or things won't work.")
+
 __version__ = "1.31.0"
 
 if __name__ == "__main__":
diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 67c60db..3b6ef88 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 
 # bitbake-diffsigs
 # BitBake task signature data comparison utility
@@ -24,6 +24,7 @@ import warnings
 import fnmatch
 import optparse
 import logging
+import pickle
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
@@ -121,7 +122,6 @@ else:
     if len(args) == 1:
         parser.print_help()
     else:
-        import cPickle
         try:
             if len(args) == 2:
                 output = bb.siggen.dump_sigfile(sys.argv[1])
diff --git a/bin/bitbake-dumpsig b/bin/bitbake-dumpsig
index ffaed1f..58ba1ca 100755
--- a/bin/bitbake-dumpsig
+++ b/bin/bitbake-dumpsig
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 
 # bitbake-dumpsig
 # BitBake task signature dump utility
@@ -23,6 +23,7 @@ import sys
 import warnings
 import optparse
 import logging
+import pickle
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
@@ -51,7 +52,6 @@ options, args = parser.parse_args(sys.argv)
 if len(args) == 1:
     parser.print_help()
 else:
-    import cPickle
     try:
         output = bb.siggen.dump_sigfile(args[1])
     except IOError as e:
diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index d8ffa95..0c973df 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 
 # This script has subcommands which operate against your bitbake layers, either
 # displaying useful information, or acting against them.
@@ -48,7 +48,6 @@ def logger_create(name, output=sys.stderr):
     logger.setLevel(logging.INFO)
     return logger
 
-
 def logger_setup_color(logger, color='auto'):
     from bb.msg import BBLogFormatter
     console = logging.StreamHandler(sys.stdout)
@@ -61,7 +60,6 @@ def logger_setup_color(logger, color='auto'):
 
 logger = logger_create('bitbake-layers', sys.stdout)
 
-
 def main():
     parser = argparse.ArgumentParser(
         description="BitBake layers utility",
@@ -78,6 +76,7 @@ def main():
     parser.add_argument('-h', '--help', action='help', default=argparse.SUPPRESS,
                         help='show this help message and exit')
     subparsers = parser.add_subparsers(title='subcommands', metavar='<subcommand>')
+    subparsers.required = True
 
     if global_args.debug:
         logger.setLevel(logging.DEBUG)
diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index 0382144..f38d2dd 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 import os
 import sys,logging
 import optparse
diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 462eb1b..1e6f35e 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copyright (C) 2012 Richard Purdie
 #
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 6a6b26b..5d062a2 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 
 import os
 import sys
@@ -10,8 +10,12 @@ import bb
 import select
 import errno
 import signal
+import pickle
 from multiprocessing import Lock
 
+if sys.getfilesystemencoding() != "utf-8":
+    sys.exit("Please use a locale setting which supports utf-8.\nPython can't change the filesystem locale after loading so we need a utf-8 when python starts or things won't work.")
+
 # Users shouldn't be running this code directly
 if len(sys.argv) != 2 or not sys.argv[1].startswith("decafbad"):
     print("bitbake-worker is meant for internal execution by bitbake itself, please don't use it standalone.")
@@ -30,19 +34,16 @@ if sys.argv[1].startswith("decafbadbad"):
 # updates to log files for use with tail
 try:
     if sys.stdout.name == '<stdout>':
-        sys.stdout = os.fdopen(sys.stdout.fileno(), 'w', 0)
+        import fcntl
+        fl = fcntl.fcntl(sys.stdout.fileno(), fcntl.F_GETFL)
+        fl |= os.O_SYNC 
+        fcntl.fcntl(sys.stdout.fileno(), fcntl.F_SETFL, fl)
+        #sys.stdout = os.fdopen(sys.stdout.fileno(), 'w', 0)
 except:
     pass
 
 logger = logging.getLogger("BitBake")
 
-try:
-    import cPickle as pickle
-except ImportError:
-    import pickle
-    bb.msg.note(1, bb.msg.domain.Cache, "Importing cPickle failed. Falling back to a very slow implementation.")
-
-
 worker_pipe = sys.stdout.fileno()
 bb.utils.nonblockingfd(worker_pipe)
 # Need to guard against multiprocessing being used in child processes
@@ -62,10 +63,10 @@ if 0:
     consolelog.setFormatter(conlogformat)
     logger.addHandler(consolelog)
 
-worker_queue = ""
+worker_queue = b""
 
 def worker_fire(event, d):
-    data = "<event>" + pickle.dumps(event) + "</event>"
+    data = b"<event>" + pickle.dumps(event) + b"</event>"
     worker_fire_prepickled(data)
 
 def worker_fire_prepickled(event):
@@ -91,7 +92,7 @@ def worker_child_fire(event, d):
     global worker_pipe
     global worker_pipe_lock
 
-    data = "<event>" + pickle.dumps(event) + "</event>"
+    data = b"<event>" + pickle.dumps(event) + b"</event>"
     try:
         worker_pipe_lock.acquire()
         worker_pipe.write(data)
@@ -251,7 +252,7 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
                 bb.utils.process_profilelog(profname)
                 os._exit(ret)
     else:
-        for key, value in envbackup.iteritems():
+        for key, value in iter(envbackup.items()):
             if value is None:
                 del os.environ[key]
             else:
@@ -268,22 +269,22 @@ class runQueueWorkerPipe():
         if pipeout:
             pipeout.close()
         bb.utils.nonblockingfd(self.input)
-        self.queue = ""
+        self.queue = b""
 
     def read(self):
         start = len(self.queue)
         try:
-            self.queue = self.queue + self.input.read(102400)
+            self.queue = self.queue + (self.input.read(102400) or b"")
         except (OSError, IOError) as e:
             if e.errno != errno.EAGAIN:
                 raise
 
         end = len(self.queue)
-        index = self.queue.find("</event>")
+        index = self.queue.find(b"</event>")
         while index != -1:
             worker_fire_prepickled(self.queue[:index+8])
             self.queue = self.queue[index+8:]
-            index = self.queue.find("</event>")
+            index = self.queue.find(b"</event>")
         return (end > start)
 
     def close(self):
@@ -299,7 +300,7 @@ class BitbakeWorker(object):
     def __init__(self, din):
         self.input = din
         bb.utils.nonblockingfd(self.input)
-        self.queue = ""
+        self.queue = b""
         self.cookercfg = None
         self.databuilder = None
         self.data = None
@@ -336,12 +337,12 @@ class BitbakeWorker(object):
                 except (OSError, IOError):
                     pass
             if len(self.queue):
-                self.handle_item("cookerconfig", self.handle_cookercfg)
-                self.handle_item("workerdata", self.handle_workerdata)
-                self.handle_item("runtask", self.handle_runtask)
-                self.handle_item("finishnow", self.handle_finishnow)
-                self.handle_item("ping", self.handle_ping)
-                self.handle_item("quit", self.handle_quit)
+                self.handle_item(b"cookerconfig", self.handle_cookercfg)
+                self.handle_item(b"workerdata", self.handle_workerdata)
+                self.handle_item(b"runtask", self.handle_runtask)
+                self.handle_item(b"finishnow", self.handle_finishnow)
+                self.handle_item(b"ping", self.handle_ping)
+                self.handle_item(b"quit", self.handle_quit)
 
             for pipe in self.build_pipes:
                 self.build_pipes[pipe].read()
@@ -351,12 +352,12 @@ class BitbakeWorker(object):
 
 
     def handle_item(self, item, func):
-        if self.queue.startswith("<" + item + ">"):
-            index = self.queue.find("</" + item + ">")
+        if self.queue.startswith(b"<" + item + b">"):
+            index = self.queue.find(b"</" + item + b">")
             while index != -1:
                 func(self.queue[(len(item) + 2):index])
                 self.queue = self.queue[(index + len(item) + 3):]
-                index = self.queue.find("</" + item + ">")
+                index = self.queue.find(b"</" + item + b">")
 
     def handle_cookercfg(self, data):
         self.cookercfg = pickle.loads(data)
@@ -420,12 +421,12 @@ class BitbakeWorker(object):
         self.build_pipes[pid].close()
         del self.build_pipes[pid]
 
-        worker_fire_prepickled("<exitcode>" + pickle.dumps((task, status)) + "</exitcode>")
+        worker_fire_prepickled(b"<exitcode>" + pickle.dumps((task, status)) + b"</exitcode>")
 
     def handle_finishnow(self, _):
         if self.build_pids:
             logger.info("Sending SIGTERM to remaining %s tasks", len(self.build_pids))
-            for k, v in self.build_pids.iteritems():
+            for k, v in iter(self.build_pids.items()):
                 try:
                     os.kill(-k, signal.SIGTERM)
                     os.waitpid(-1, 0)
@@ -435,6 +436,7 @@ class BitbakeWorker(object):
             self.build_pipes[pipe].read()
 
 try:
+    sys.stdin = sys.stdin.detach()
     worker = BitbakeWorker(sys.stdin)
     if not profiling:
         worker.serve()
diff --git a/bin/bitdoc b/bin/bitdoc
index defb3dd..2744678 100755
--- a/bin/bitdoc
+++ b/bin/bitdoc
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
diff --git a/bin/image-writer b/bin/image-writer
index e30ab45..7ab1d8c 100755
--- a/bin/image-writer
+++ b/bin/image-writer
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 
 # Copyright (c) 2012 Wind River Systems, Inc.
 #
@@ -24,9 +24,13 @@ try:
 except RuntimeError as exc:
     sys.exit(str(exc))
 
+from gi import pygtkcompat
+
+pygtkcompat.enable()
+pygtkcompat.enable_gtk(version='3.0')
+
 import gtk
 import optparse
-import pygtk
 
 from bb.ui.crumbs.hobwidget import HobAltButton, HobButton
 from bb.ui.crumbs.hig.crumbsmessagedialog import CrumbsMessageDialog
diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index 615a7ae..bdddb90 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
diff --git a/contrib/dump_cache.py b/contrib/dump_cache.py
index 97c5463..a1f09b4 100755
--- a/contrib/dump_cache.py
+++ b/contrib/dump_cache.py
@@ -29,7 +29,7 @@ import warnings
 sys.path.insert(0, os.path.join(os.path.abspath(os.path.dirname(sys.argv[0])), '../lib'))
 from bb.cache import CoreRecipeInfo
 
-import cPickle as pickle
+import pickle as pickle
 
 def main(argv=None):
     """
diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index 6917ec3..77a05cf 100644
--- a/lib/bb/COW.py
+++ b/lib/bb/COW.py
@@ -23,19 +23,17 @@
 # Assign a file to __warn__ to get warnings about slow operations.
 #
 
-from __future__ import print_function
+
 import copy
 import types
 ImmutableTypes = (
-    types.NoneType,
     bool,
     complex,
     float,
     int,
-    long,
     tuple,
     frozenset,
-    basestring
+    str
 )
 
 MUTABLE = "__mutable__"
@@ -61,7 +59,7 @@ class COWDictMeta(COWMeta):
     __call__ = cow
 
     def __setitem__(cls, key, value):
-        if not isinstance(value, ImmutableTypes):
+        if value is not None and not isinstance(value, ImmutableTypes):
             if not isinstance(value, COWMeta):
                 cls.__hasmutable__ = True
             key += MUTABLE
@@ -116,7 +114,7 @@ class COWDictMeta(COWMeta):
         cls.__setitem__(key, cls.__marker__)
 
     def __revertitem__(cls, key):
-        if not cls.__dict__.has_key(key):
+        if key not in cls.__dict__:
             key += MUTABLE
         delattr(cls, key)
 
@@ -183,7 +181,7 @@ class COWSetMeta(COWDictMeta):
         COWDictMeta.__delitem__(cls, repr(hash(value)))
 
     def __in__(cls, value):
-        return COWDictMeta.has_key(repr(hash(value)))
+        return repr(hash(value)) in COWDictMeta
 
     def iterkeys(cls):
         raise TypeError("sets don't have keys")
@@ -192,12 +190,10 @@ class COWSetMeta(COWDictMeta):
         raise TypeError("sets don't have 'items'")
 
 # These are the actual classes you use!
-class COWDictBase(object):
-    __metaclass__ = COWDictMeta
+class COWDictBase(object, metaclass = COWDictMeta):
     __count__ = 0
 
-class COWSetBase(object):
-    __metaclass__ = COWSetMeta
+class COWSetBase(object, metaclass = COWSetMeta):
     __count__ = 0
 
 if __name__ == "__main__":
@@ -217,11 +213,11 @@ if __name__ == "__main__":
     print()
 
     print("a", a)
-    for x in a.iteritems():
+    for x in a.items():
         print(x)
     print("--")
     print("b", b)
-    for x in b.iteritems():
+    for x in b.items():
         print(x)
     print()
 
@@ -229,11 +225,11 @@ if __name__ == "__main__":
     b['a'] = 'c'
 
     print("a", a)
-    for x in a.iteritems():
+    for x in a.items():
         print(x)
     print("--")
     print("b", b)
-    for x in b.iteritems():
+    for x in b.items():
         print(x)
     print()
 
@@ -248,22 +244,22 @@ if __name__ == "__main__":
     a['set'].add("o2")
 
     print("a", a)
-    for x in a['set'].itervalues():
+    for x in a['set'].values():
         print(x)
     print("--")
     print("b", b)
-    for x in b['set'].itervalues():
+    for x in b['set'].values():
         print(x)
     print()
 
     b['set'].add('o3')
 
     print("a", a)
-    for x in a['set'].itervalues():
+    for x in a['set'].values():
         print(x)
     print("--")
     print("b", b)
-    for x in b['set'].itervalues():
+    for x in b['set'].values():
         print(x)
     print()
 
@@ -273,7 +269,7 @@ if __name__ == "__main__":
     a['set2'].add("o2")
 
     print("a", a)
-    for x in a.iteritems():
+    for x in a.items():
         print(x)
     print("--")
     print("b", b)
@@ -287,13 +283,13 @@ if __name__ == "__main__":
     except KeyError:
         print("Yay! deleted key raises error")
 
-    if b.has_key('b'):
+    if 'b' in b:
         print("Boo!")
     else:
         print("Yay - has_key with delete works!")
 
     print("a", a)
-    for x in a.iteritems():
+    for x in a.items():
         print(x)
     print("--")
     print("b", b)
@@ -304,7 +300,7 @@ if __name__ == "__main__":
     b.__revertitem__('b')
 
     print("a", a)
-    for x in a.iteritems():
+    for x in a.items():
         print(x)
     print("--")
     print("b", b)
@@ -314,7 +310,7 @@ if __name__ == "__main__":
 
     b.__revertitem__('dict')
     print("a", a)
-    for x in a.iteritems():
+    for x in a.items():
         print(x)
     print("--")
     print("b", b)
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 4ae6b8a..6b85984 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -84,7 +84,7 @@ def plain(*args):
     mainlogger.plain(''.join(args))
 
 def debug(lvl, *args):
-    if isinstance(lvl, basestring):
+    if isinstance(lvl, str):
         mainlogger.warning("Passed invalid debug level '%s' to bb.debug", lvl)
         args = (lvl,) + args
         lvl = 1
diff --git a/lib/bb/build.py b/lib/bb/build.py
index 9854553..e016ae3 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -35,8 +35,7 @@ import stat
 import bb
 import bb.msg
 import bb.process
-from contextlib import nested
-from bb import event, utils
+from bb import data, event, utils
 
 bblogger = logging.getLogger('BitBake')
 logger = logging.getLogger('BitBake.Build')
@@ -328,7 +327,7 @@ trap '' 0
 exit $ret
 ''')
 
-    os.chmod(runfile, 0775)
+    os.chmod(runfile, 0o775)
 
     cmd = runfile
     if d.getVarFlag(func, 'fakeroot', False):
@@ -342,12 +341,12 @@ exit $ret
         logfile = sys.stdout
 
     def readfifo(data):
-        lines = data.split('\0')
+        lines = data.split(b'\0')
         for line in lines:
-            splitval = line.split(' ', 1)
+            splitval = line.split(b' ', 1)
             cmd = splitval[0]
             if len(splitval) > 1:
-                value = splitval[1]
+                value = splitval[1].decode("utf-8")
             else:
                 value = ''
             if cmd == 'bbplain':
@@ -375,7 +374,7 @@ exit $ret
     if os.path.exists(fifopath):
         os.unlink(fifopath)
     os.mkfifo(fifopath)
-    with open(fifopath, 'r+') as fifo:
+    with open(fifopath, 'r+b', buffering=0) as fifo:
         try:
             bb.debug(2, "Executing shell function %s" % func)
 
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 393d541..96abd71 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -28,21 +28,15 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-
 import os
+import sys
 import logging
+import pickle
 from collections import defaultdict
 import bb.utils
 
 logger = logging.getLogger("BitBake.Cache")
 
-try:
-    import cPickle as pickle
-except ImportError:
-    import pickle
-    logger.info("Importing cPickle failed. "
-                "Falling back to a very slow implementation.")
-
 __cache_version__ = "150"
 
 def getCacheFile(path, filename, data_hash):
@@ -80,7 +74,7 @@ class RecipeInfoCommon(object):
         out_dict = dict((var, metadata.getVarFlag(var, flag, True))
                     for var in varlist)
         if squash:
-            return dict((k,v) for (k,v) in out_dict.iteritems() if v)
+            return dict((k,v) for (k,v) in out_dict.items() if v)
         else:
             return out_dict
 
@@ -240,7 +234,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.universe_target.append(self.pn)
 
         cachedata.hashfn[fn] = self.hashfilename
-        for task, taskhash in self.basetaskhashes.iteritems():
+        for task, taskhash in self.basetaskhashes.items():
             identifier = '%s.%s' % (fn, task)
             cachedata.basetaskhash[identifier] = taskhash
 
@@ -404,7 +398,7 @@ class Cache(object):
         infos = []
         datastores = cls.load_bbfile(filename, appends, configdata)
         depends = []
-        for variant, data in sorted(datastores.iteritems(),
+        for variant, data in sorted(datastores.items(),
                                     key=lambda i: i[0],
                                     reverse=True):
             virtualfn = cls.realfn2virtual(filename, variant)
@@ -616,7 +610,7 @@ class Cache(object):
         pickler_dict['CoreRecipeInfo'].dump(bb.__version__)
 
         try:
-            for key, info_array in self.depends_cache.iteritems():
+            for key, info_array in self.depends_cache.items():
                 for info in info_array:
                     if isinstance(info, RecipeInfoCommon):
                         cache_class_name = info.__class__.__name__
diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 2ec964d..be4ab68 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -19,20 +19,13 @@ import glob
 import operator
 import os
 import stat
+import pickle
 import bb.utils
 import logging
 from bb.cache import MultiProcessCache
 
 logger = logging.getLogger("BitBake.Cache")
 
-try:
-    import cPickle as pickle
-except ImportError:
-    import pickle
-    logger.info("Importing cPickle failed. "
-                "Falling back to a very slow implementation.")
-
-
 # mtime cache (non-persistent)
 # based upon the assumption that files do not change during bitbake run
 class FileMtimeCache(object):
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 70b0a8d..b1d067a 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -1,22 +1,17 @@
 import ast
+import sys
 import codegen
 import logging
+import pickle
+import bb.pysh as pysh
 import os.path
 import bb.utils, bb.data
 from itertools import chain
-from pysh import pyshyacc, pyshlex, sherrors
+from bb.pysh import pyshyacc, pyshlex, sherrors
 from bb.cache import MultiProcessCache
 
-
 logger = logging.getLogger('BitBake.CodeParser')
 
-try:
-    import cPickle as pickle
-except ImportError:
-    import pickle
-    logger.info('Importing cPickle failed.  Falling back to a very slow implementation.')
-
-
 def check_indent(codestr):
     """If the code is indented, add a top level piece of code to 'remove' the indentation"""
 
@@ -68,7 +63,7 @@ class SetCache(object):
         
         new = []
         for i in items:
-            new.append(intern(i))
+            new.append(sys.intern(i))
         s = frozenset(new)
         if hash(s) in self.setcache:
             return self.setcache[hash(s)]
diff --git a/lib/bb/command.py b/lib/bb/command.py
index 0559ffc..caa3e4d 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -110,7 +110,7 @@ class Command:
             return False
         except SystemExit as exc:
             arg = exc.args[0]
-            if isinstance(arg, basestring):
+            if isinstance(arg, str):
                 self.finishAsyncCommand(arg)
             else:
                 self.finishAsyncCommand("Exited with %s" % arg)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 11f17ef..2154ef4 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -30,13 +30,13 @@ import logging
 import multiprocessing
 import sre_constants
 import threading
-from cStringIO import StringIO
+from io import StringIO
 from contextlib import closing
 from functools import wraps
 from collections import defaultdict
 import bb, bb.exceptions, bb.command
 from bb import utils, data, parse, event, cache, providers, taskdata, runqueue, build
-import Queue
+import queue
 import signal
 import subprocess
 import errno
@@ -65,7 +65,7 @@ class CollectionError(bb.BBHandledException):
     """
 
 class state:
-    initial, parsing, running, shutdown, forceshutdown, stopped, error = range(7)
+    initial, parsing, running, shutdown, forceshutdown, stopped, error = list(range(7))
 
     @classmethod
     def get_name(cls, code):
@@ -93,7 +93,7 @@ class SkippedPackage:
 
 
 class CookerFeatures(object):
-    _feature_list = [HOB_EXTRA_CACHES, BASEDATASTORE_TRACKING, SEND_SANITYEVENTS] = range(3)
+    _feature_list = [HOB_EXTRA_CACHES, BASEDATASTORE_TRACKING, SEND_SANITYEVENTS] = list(range(3))
 
     def __init__(self):
         self._features=set()
@@ -110,8 +110,8 @@ class CookerFeatures(object):
     def __iter__(self):
         return self._features.__iter__()
 
-    def next(self):
-        return self._features.next()
+    def __next__(self):
+        return next(self._features)
 
 
 #============================================================================#
@@ -726,13 +726,13 @@ class BBCooker:
         depend_tree['providermap'] = {}
         depend_tree["layer-priorities"] = self.recipecache.bbfile_config_priorities
 
-        for name, fn in taskdata.get_providermap().iteritems():
+        for name, fn in list(taskdata.get_providermap().items()):
             pn = self.recipecache.pkg_fn[fn]
             if name != pn:
                 version = "%s:%s-%s" % self.recipecache.pkg_pepvpr[fn]
                 depend_tree['providermap'][name] = (pn, version)
 
-        for task in xrange(len(rq.rqdata.runq_fnid)):
+        for task in range(len(rq.rqdata.runq_fnid)):
             taskname = rq.rqdata.runq_task[task]
             fnid = rq.rqdata.runq_fnid[task]
             fn = taskdata.fn_index[fnid]
@@ -807,7 +807,7 @@ class BBCooker:
         _, taskdata = self.prepareTreeData(pkgs_to_build, task)
         tasks_fnid = []
         if len(taskdata.tasks_name) != 0:
-            for task in xrange(len(taskdata.tasks_name)):
+            for task in range(len(taskdata.tasks_name)):
                 tasks_fnid.append(taskdata.tasks_fnid[task])
 
         seen_fnids = []
@@ -825,7 +825,7 @@ class BBCooker:
                 cachefields = getattr(cache_class, 'cachefields', [])
                 extra_info = extra_info + cachefields
 
-        for task in xrange(len(tasks_fnid)):
+        for task in range(len(tasks_fnid)):
             fnid = tasks_fnid[task]
             fn = taskdata.fn_index[fnid]
             pn = self.recipecache.pkg_fn[fn]
@@ -953,7 +953,7 @@ class BBCooker:
         # Determine which bbappends haven't been applied
 
         # First get list of recipes, including skipped
-        recipefns = self.recipecache.pkg_fn.keys()
+        recipefns = list(self.recipecache.pkg_fn.keys())
         recipefns.extend(self.skiplist.keys())
 
         # Work out list of bbappends that have been applied
@@ -1152,7 +1152,7 @@ class BBCooker:
                         deplist = bb.utils.explode_dep_versions2(deps)
                     except bb.utils.VersionStringException as vse:
                         bb.fatal('Error parsing LAYERDEPENDS_%s: %s' % (c, str(vse)))
-                    for dep, oplist in deplist.iteritems():
+                    for dep, oplist in list(deplist.items()):
                         if dep in collection_list:
                             for opstr in oplist:
                                 layerver = self.data.getVar("LAYERVERSION_%s" % dep, True)
@@ -1888,7 +1888,7 @@ class Feeder(multiprocessing.Process):
         while True:
             try:
                 quit = self.quit.get_nowait()
-            except Queue.Empty:
+            except queue.Empty:
                 pass
             else:
                 if quit == 'cancel':
@@ -1902,7 +1902,7 @@ class Feeder(multiprocessing.Process):
 
             try:
                 self.to_parsers.put(job, timeout=0.5)
-            except Queue.Full:
+            except queue.Full:
                 self.jobs.insert(0, job)
                 continue
 
@@ -1942,7 +1942,7 @@ class Parser(multiprocessing.Process):
         while True:
             try:
                 self.quit.get_nowait()
-            except Queue.Empty:
+            except queue.Empty:
                 pass
             else:
                 self.results.cancel_join_thread()
@@ -1953,7 +1953,7 @@ class Parser(multiprocessing.Process):
             else:
                 try:
                     job = self.jobs.get(timeout=0.25)
-                except Queue.Empty:
+                except queue.Empty:
                     continue
 
                 if job is None:
@@ -1962,7 +1962,7 @@ class Parser(multiprocessing.Process):
 
             try:
                 self.results.put(result, timeout=0.25)
-            except Queue.Full:
+            except queue.Full:
                 pending.append(result)
 
     def parse(self, filename, appends, caches_array):
@@ -2115,7 +2115,7 @@ class CookerParser(object):
 
             try:
                 result = self.result_queue.get(timeout=0.25)
-            except Queue.Empty:
+            except queue.Empty:
                 pass
             else:
                 value = result[1]
@@ -2128,7 +2128,7 @@ class CookerParser(object):
         result = []
         parsed = None
         try:
-            parsed, result = self.results.next()
+            parsed, result = next(self.results)
         except StopIteration:
             self.shutdown()
             return False
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 2ab884b..2a61386 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -372,7 +372,7 @@ class DataSmart(MutableMapping):
 
     def expandWithRefs(self, s, varname):
 
-        if not isinstance(s, basestring): # sanity check
+        if not isinstance(s, str): # sanity check
             return VariableParse(varname, self, s)
 
         if varname and varname in self.expand_cache:
@@ -966,4 +966,4 @@ class DataSmart(MutableMapping):
                     data.update({i:value})
 
         data_str = str([(k, data[k]) for k in sorted(data.keys())])
-        return hashlib.md5(data_str).hexdigest()
+        return hashlib.md5(data_str.encode("utf-8")).hexdigest()
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 29b14f6..6fb3712 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -24,10 +24,7 @@ BitBake build tools.
 
 import os, sys
 import warnings
-try:
-    import cPickle as pickle
-except ImportError:
-    import pickle
+import pickle
 import logging
 import atexit
 import traceback
@@ -107,7 +104,7 @@ def fire_class_handlers(event, d):
 
     eid = str(event.__class__)[8:-2]
     evt_hmap = _event_handler_map.get(eid, {})
-    for name, handler in _handlers.iteritems():
+    for name, handler in list(_handlers.items()):
         if name in _catchall_handlers or name in evt_hmap:
             if _eventfilter:
                 if not _eventfilter(name, handler, event, d):
@@ -192,7 +189,7 @@ def register(name, handler, mask=None, filename=None, lineno=None):
 
     if handler is not None:
         # handle string containing python code
-        if isinstance(handler, basestring):
+        if isinstance(handler, str):
             tmp = "def %s(e):\n%s" % (name, handler)
             try:
                 code = bb.methodpool.compile_cache(tmp)
diff --git a/lib/bb/exceptions.py b/lib/bb/exceptions.py
index eadfc57..cd71343 100644
--- a/lib/bb/exceptions.py
+++ b/lib/bb/exceptions.py
@@ -86,6 +86,6 @@ def format_exception(etype, value, tb, context=1, limit=None, formatter=None):
 
 def to_string(exc):
     if isinstance(exc, SystemExit):
-        if not isinstance(exc.code, basestring):
+        if not isinstance(exc.code, str):
             return 'Exited with "%d"' % exc.code
     return str(exc)
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 14fe3c7..be01bdb 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -28,27 +28,23 @@ BitBake build tools.
 import os, re
 import signal
 import logging
-import urllib
-import urlparse
+import urllib.request, urllib.parse, urllib.error
+if 'git' not in urllib.parse.uses_netloc:
+    urllib.parse.uses_netloc.append('git')
+import operator
 import collections
+import subprocess
+import pickle
 import bb.persist_data, bb.utils
 import bb.checksum
 from bb import data
 import bb.process
-import subprocess
 
 __version__ = "2"
 _checksum_cache = bb.checksum.FileChecksumCache()
 
 logger = logging.getLogger("BitBake.Fetcher")
 
-try:
-    import cPickle as pickle
-except ImportError:
-    import pickle
-    logger.info("Importing cPickle failed. "
-                "Falling back to a very slow implementation.")
-
 class BBFetchException(Exception):
     """Class all fetch exceptions inherit from"""
     def __init__(self, message):
@@ -230,14 +226,14 @@ class URI(object):
         # them are not quite RFC compliant.
         uri, param_str = (uri.split(";", 1) + [None])[:2]
 
-        urlp = urlparse.urlparse(uri)
+        urlp = urllib.parse.urlparse(uri)
         self.scheme = urlp.scheme
 
         reparse = 0
 
         # Coerce urlparse to make URI scheme use netloc
-        if not self.scheme in urlparse.uses_netloc:
-            urlparse.uses_params.append(self.scheme)
+        if not self.scheme in urllib.parse.uses_netloc:
+            urllib.parse.uses_params.append(self.scheme)
             reparse = 1
 
         # Make urlparse happy(/ier) by converting local resources
@@ -248,7 +244,7 @@ class URI(object):
             reparse = 1
 
         if reparse:
-            urlp = urlparse.urlparse(uri)
+            urlp = urllib.parse.urlparse(uri)
 
         # Identify if the URI is relative or not
         if urlp.scheme in self._relative_schemes and \
@@ -264,7 +260,7 @@ class URI(object):
             if urlp.password:
                 self.userinfo += ':%s' % urlp.password
 
-        self.path = urllib.unquote(urlp.path)
+        self.path = urllib.parse.unquote(urlp.path)
 
         if param_str:
             self.params = self._param_str_split(param_str, ";")
@@ -312,11 +308,11 @@ class URI(object):
 
     @property
     def path_quoted(self):
-        return urllib.quote(self.path)
+        return urllib.parse.quote(self.path)
 
     @path_quoted.setter
     def path_quoted(self, path):
-        self.path = urllib.unquote(path)
+        self.path = urllib.parse.unquote(path)
 
     @property
     def path(self):
@@ -398,7 +394,7 @@ def decodeurl(url):
                 s1, s2 = s.split('=')
                 p[s1] = s2
 
-    return type, host, urllib.unquote(path), user, pswd, p
+    return type, host, urllib.parse.unquote(path), user, pswd, p
 
 def encodeurl(decoded):
     """Encodes a URL from tokens (scheme, network location, path,
@@ -422,7 +418,7 @@ def encodeurl(decoded):
     # Standardise path to ensure comparisons work
     while '//' in path:
         path = path.replace("//", "/")
-    url += "%s" % urllib.quote(path)
+    url += "%s" % urllib.parse.quote(path)
     if p:
         for parm in p:
             url += ";%s=%s" % (parm, p[parm])
@@ -1735,7 +1731,7 @@ class FetchConnectionCache(object):
             del self.cache[cn]
 
     def close_connections(self):
-        for cn in self.cache.keys():
+        for cn in list(self.cache.keys()):
             self.cache[cn].close()
             del self.cache[cn]
 
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 303a52b..51ca78d 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -26,7 +26,7 @@ BitBake build tools.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import os
-import urllib
+import urllib.request, urllib.parse, urllib.error
 import bb
 import bb.utils
 from   bb import data
@@ -42,7 +42,7 @@ class Local(FetchMethod):
 
     def urldata_init(self, ud, d):
         # We don't set localfile as for this fetcher the file is already local!
-        ud.decodedurl = urllib.unquote(ud.url.split("://")[1].split(";")[0])
+        ud.decodedurl = urllib.parse.unquote(ud.url.split("://")[1].split(";")[0])
         ud.basename = os.path.basename(ud.decodedurl)
         ud.basepath = ud.decodedurl
         ud.needdonestamp = False
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index d9e46b2..2fd4303 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -20,7 +20,7 @@ Usage in the recipe:
 
 import os
 import sys
-import urllib
+import urllib.request, urllib.parse, urllib.error
 import json
 import subprocess
 import signal
@@ -196,9 +196,9 @@ class Npm(FetchMethod):
                 optdepsfound[dep] = dependencies[dep]
             else:
                 depsfound[dep] = dependencies[dep]
-        for dep, version in optdepsfound.iteritems():
+        for dep, version in optdepsfound.items():
             self._getdependencies(dep, data[pkg]['deps'], version, d, ud, optional=True)
-        for dep, version in depsfound.iteritems():
+        for dep, version in depsfound.items():
             self._getdependencies(dep, data[pkg]['deps'], version, d, ud)
 
     def _getshrinkeddependencies(self, pkg, data, version, d, ud, lockdown, manifest):
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 1aef246..ce3cda2 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -61,7 +61,7 @@ class Perforce(FetchMethod):
                     keys.append(key)
                     values.append(value)
 
-            parm = dict(zip(keys, values))
+            parm = dict(list(zip(keys, values)))
         path = "//" + path.split(';')[0]
         host += ":%s" % (port)
         parm["cset"] = Perforce.getcset(d, path, host, user, pswd, parm)
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index cb2f753..7989fcc 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -61,8 +61,7 @@ SRC_URI = "sftp://user@host.example.com/dir/path.file.txt"
 
 import os
 import bb
-import urllib
-import commands
+import urllib.request, urllib.parse, urllib.error
 from bb import data
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
@@ -93,7 +92,7 @@ class SFTP(FetchMethod):
         else:
             ud.basename = os.path.basename(ud.path)
 
-        ud.localfile = data.expand(urllib.unquote(ud.basename), d)
+        ud.localfile = data.expand(urllib.parse.unquote(ud.basename), d)
 
     def download(self, ud, d):
         """Fetch urls"""
@@ -121,8 +120,7 @@ class SFTP(FetchMethod):
 
         remote = '%s%s:%s' % (user, urlo.hostname, path)
 
-        cmd = '%s %s %s %s' % (basecmd, port, commands.mkarg(remote),
-                               commands.mkarg(lpath))
+        cmd = '%s %s %s %s' % (basecmd, port, remote, lpath)
 
         bb.fetch2.check_network_access(d, cmd, ud.url)
         runfetchcmd(cmd, d)
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 635578a..56f9b7e 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -114,12 +114,10 @@ class SSH(FetchMethod):
             fr = host
         fr += ':%s' % path
 
-
-        import commands
         cmd = 'scp -B -r %s %s %s/' % (
             portarg,
-            commands.mkarg(fr),
-            commands.mkarg(dldir)
+            fr,
+            dldir
         )
 
         bb.fetch2.check_network_access(d, cmd, urldata.url)
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 8bc9e93..d688fd9 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -31,7 +31,7 @@ import subprocess
 import os
 import logging
 import bb
-import urllib
+import urllib.request, urllib.parse, urllib.error
 from   bb import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
@@ -62,9 +62,9 @@ class Wget(FetchMethod):
         else:
             ud.basename = os.path.basename(ud.path)
 
-        ud.localfile = data.expand(urllib.unquote(ud.basename), d)
+        ud.localfile = data.expand(urllib.parse.unquote(ud.basename), d)
         if not ud.localfile:
-            ud.localfile = data.expand(urllib.unquote(ud.host + ud.path).replace("/", "."), d)
+            ud.localfile = data.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."), d)
 
         self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
 
@@ -105,11 +105,11 @@ class Wget(FetchMethod):
         return True
 
     def checkstatus(self, fetch, ud, d):
-        import urllib2, socket, httplib
-        from urllib import addinfourl
+        import urllib.request, urllib.error, urllib.parse, socket, http.client
+        from urllib.response import addinfourl
         from bb.fetch2 import FetchConnectionCache
 
-        class HTTPConnectionCache(httplib.HTTPConnection):
+        class HTTPConnectionCache(http.client.HTTPConnection):
             if fetch.connection_cache:
                 def connect(self):
                     """Connect to the host and port specified in __init__."""
@@ -125,7 +125,7 @@ class Wget(FetchMethod):
                     if self._tunnel_host:
                         self._tunnel()
 
-        class CacheHTTPHandler(urllib2.HTTPHandler):
+        class CacheHTTPHandler(urllib.request.HTTPHandler):
             def http_open(self, req):
                 return self.do_open(HTTPConnectionCache, req)
 
@@ -139,7 +139,7 @@ class Wget(FetchMethod):
                     - geturl(): return the original request URL
                     - code: HTTP status code
                 """
-                host = req.get_host()
+                host = req.host
                 if not host:
                     raise urlllib2.URLError('no host given')
 
@@ -147,7 +147,7 @@ class Wget(FetchMethod):
                 h.set_debuglevel(self._debuglevel)
 
                 headers = dict(req.unredirected_hdrs)
-                headers.update(dict((k, v) for k, v in req.headers.items()
+                headers.update(dict((k, v) for k, v in list(req.headers.items())
                             if k not in headers))
 
                 # We want to make an HTTP/1.1 request, but the addinfourl
@@ -164,7 +164,7 @@ class Wget(FetchMethod):
                     headers["Connection"] = "Keep-Alive" # Works for HTTP/1.0
 
                 headers = dict(
-                    (name.title(), val) for name, val in headers.items())
+                    (name.title(), val) for name, val in list(headers.items()))
 
                 if req._tunnel_host:
                     tunnel_headers = {}
@@ -177,12 +177,12 @@ class Wget(FetchMethod):
                     h.set_tunnel(req._tunnel_host, headers=tunnel_headers)
 
                 try:
-                    h.request(req.get_method(), req.get_selector(), req.data, headers)
-                except socket.error, err: # XXX what error?
+                    h.request(req.get_method(), req.selector, req.data, headers)
+                except socket.error as err: # XXX what error?
                     # Don't close connection when cache is enabled.
                     if fetch.connection_cache is None:
                         h.close()
-                    raise urllib2.URLError(err)
+                    raise urllib.error.URLError(err)
                 else:
                     try:
                         r = h.getresponse(buffering=True)
@@ -222,7 +222,7 @@ class Wget(FetchMethod):
 
                 return resp
 
-        class HTTPMethodFallback(urllib2.BaseHandler):
+        class HTTPMethodFallback(urllib.request.BaseHandler):
             """
             Fallback to GET if HEAD is not allowed (405 HTTP error)
             """
@@ -230,11 +230,11 @@ class Wget(FetchMethod):
                 fp.read()
                 fp.close()
 
-                newheaders = dict((k,v) for k,v in req.headers.items()
+                newheaders = dict((k,v) for k,v in list(req.headers.items())
                                   if k.lower() not in ("content-length", "content-type"))
-                return self.parent.open(urllib2.Request(req.get_full_url(),
+                return self.parent.open(urllib.request.Request(req.get_full_url(),
                                                         headers=newheaders,
-                                                        origin_req_host=req.get_origin_req_host(),
+                                                        origin_req_host=req.origin_req_host,
                                                         unverifiable=True))
 
             """
@@ -249,35 +249,35 @@ class Wget(FetchMethod):
             """
             http_error_406 = http_error_405
 
-        class FixedHTTPRedirectHandler(urllib2.HTTPRedirectHandler):
+        class FixedHTTPRedirectHandler(urllib.request.HTTPRedirectHandler):
             """
             urllib2.HTTPRedirectHandler resets the method to GET on redirect,
             when we want to follow redirects using the original method.
             """
             def redirect_request(self, req, fp, code, msg, headers, newurl):
-                newreq = urllib2.HTTPRedirectHandler.redirect_request(self, req, fp, code, msg, headers, newurl)
+                newreq = urllib.request.HTTPRedirectHandler.redirect_request(self, req, fp, code, msg, headers, newurl)
                 newreq.get_method = lambda: req.get_method()
                 return newreq
         exported_proxies = export_proxies(d)
 
         handlers = [FixedHTTPRedirectHandler, HTTPMethodFallback]
         if export_proxies:
-            handlers.append(urllib2.ProxyHandler())
+            handlers.append(urllib.request.ProxyHandler())
         handlers.append(CacheHTTPHandler())
         # XXX: Since Python 2.7.9 ssl cert validation is enabled by default
         # see PEP-0476, this causes verification errors on some https servers
         # so disable by default.
         import ssl
         if hasattr(ssl, '_create_unverified_context'):
-            handlers.append(urllib2.HTTPSHandler(context=ssl._create_unverified_context()))
-        opener = urllib2.build_opener(*handlers)
+            handlers.append(urllib.request.HTTPSHandler(context=ssl._create_unverified_context()))
+        opener = urllib.request.build_opener(*handlers)
 
         try:
             uri = ud.url.split(";")[0]
-            r = urllib2.Request(uri)
+            r = urllib.request.Request(uri)
             r.get_method = lambda: "HEAD"
             opener.open(r)
-        except urllib2.URLError as e:
+        except urllib.error.URLError as e:
             # debug for now to avoid spamming the logs in e.g. remote sstate searches
             logger.debug(2, "checkstatus() urlopen failed: %s" % e)
             return False
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 761ea45..b296ef8 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -27,6 +27,7 @@ import sys
 import logging
 import optparse
 import warnings
+import fcntl
 
 import bb
 from bb import event
@@ -336,10 +337,7 @@ def start_server(servermodule, configParams, configuration, features):
         server.saveConnectionDetails()
     except Exception as e:
         while hasattr(server, "event_queue"):
-            try:
-                import queue
-            except ImportError:
-                import Queue as queue
+            import queue
             try:
                 event = server.event_queue.get(block=False)
             except (queue.Empty, IOError):
@@ -363,7 +361,10 @@ def bitbake_main(configParams, configuration):
     # updates to log files for use with tail
     try:
         if sys.stdout.name == '<stdout>':
-            sys.stdout = os.fdopen(sys.stdout.fileno(), 'w', 0)
+            # Reopen with O_SYNC (unbuffered)
+            fl = fcntl.fcntl(sys.stdout.fileno(), fcntl.F_GETFL)
+            fl |= os.O_SYNC
+            fcntl.fcntl(sys.stdout.fileno(), fcntl.F_SETFL, fl)
     except:
         pass
 
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 6fdd1f5..8c3ab47 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -57,7 +57,7 @@ class BBLogFormatter(logging.Formatter):
     }
 
     color_enabled = False
-    BASECOLOR, BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(29,38)
+    BASECOLOR, BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = list(range(29,38))
 
     COLORS = {
         DEBUG3  : CYAN,
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index bc3a2f8..548929f 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -138,7 +138,7 @@ class DataNode(AstNode):
             data.setVar(key, val, parsing=True, **loginfo)
 
 class MethodNode(AstNode):
-    tr_tbl = string.maketrans('/.+-@%&', '_______')
+    tr_tbl = str.maketrans('/.+-@%&', '_______')
 
     def __init__(self, filename, lineno, func_name, body, python, fakeroot):
         AstNode.__init__(self, filename, lineno)
@@ -340,17 +340,17 @@ def _create_variants(datastores, names, function, onlyfinalise):
         function(arg or name, new_d)
         datastores[name] = new_d
 
-    for variant, variant_d in datastores.items():
+    for variant in list(datastores.keys()):
         for name in names:
             if not variant:
                 # Based on main recipe
-                create_variant(name, variant_d)
+                create_variant(name, datastores[""])
             else:
-                create_variant("%s-%s" % (variant, name), variant_d, name)
+                create_variant("%s-%s" % (variant, name), datastores[variant], name)
 
 def _expand_versions(versions):
     def expand_one(version, start, end):
-        for i in xrange(start, end + 1):
+        for i in range(start, end + 1):
             ver = _bbversions_re.sub(str(i), version, 1)
             yield ver
 
@@ -459,16 +459,16 @@ def multi_finalize(fn, d):
         safe_d.setVar("BBCLASSEXTEND", extended)
         _create_variants(datastores, extendedmap.keys(), extendfunc, onlyfinalise)
 
-    for variant, variant_d in datastores.iteritems():
+    for variant in datastores.keys():
         if variant:
             try:
                 if not onlyfinalise or variant in onlyfinalise:
-                    finalize(fn, variant_d, variant)
+                    finalize(fn, datastores[variant], variant)
             except bb.parse.SkipRecipe as e:
-                variant_d.setVar("__SKIPPED", e.args[0])
+                datastores[variant].setVar("__SKIPPED", e.args[0])
 
     if len(datastores) > 1:
-        variants = filter(None, datastores.iterkeys())
+        variants = filter(None, datastores.keys())
         safe_d.setVar("__VARIANTS", " ".join(variants))
 
     datastores[""] = d
diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index e450423..403f3a5 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -92,9 +92,9 @@ class SQLTable(collections.MutableMapping):
         self._execute("DELETE from %s where key=?;" % self.table, [key])
 
     def __setitem__(self, key, value):
-        if not isinstance(key, basestring):
+        if not isinstance(key, str):
             raise TypeError('Only string keys are supported')
-        elif not isinstance(value, basestring):
+        elif not isinstance(value, str):
             raise TypeError('Only string values are supported')
 
         data = self._execute("SELECT * from %s where key=?;" %
@@ -131,14 +131,14 @@ class SQLTable(collections.MutableMapping):
         return [row[1] for row in data]
 
     def values(self):
-        return list(self.itervalues())
+        return list(self.values())
 
     def itervalues(self):
         data = self._execute("SELECT value FROM %s;" % self.table)
         return (row[0] for row in data)
 
     def items(self):
-        return list(self.iteritems())
+        return list(self.items())
 
     def iteritems(self):
         return self._execute("SELECT * FROM %s;" % self.table)
@@ -178,7 +178,7 @@ class PersistData(object):
         """
         Return a list of key + value pairs for a domain
         """
-        return self.data[domain].items()
+        return list(self.data[domain].items())
 
     def getValue(self, domain, key):
         """
diff --git a/lib/bb/process.py b/lib/bb/process.py
index 1c07f2d..c62d7bc 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -17,7 +17,7 @@ class CmdError(RuntimeError):
         self.msg = msg
 
     def __str__(self):
-        if not isinstance(self.command, basestring):
+        if not isinstance(self.command, str):
             cmd = subprocess.list2cmdline(self.command)
         else:
             cmd = self.command
@@ -97,6 +97,8 @@ def _logged_communicate(pipe, log, input, extrafiles):
     try:
         while pipe.poll() is None:
             rlist = rin
+            stdoutbuf = b""
+            stderrbuf = b""
             try:
                 r,w,e = select.select (rlist, [], [], 1)
             except OSError as e:
@@ -104,16 +106,26 @@ def _logged_communicate(pipe, log, input, extrafiles):
                     raise
 
             if pipe.stdout in r:
-                data = pipe.stdout.read()
-                if data is not None:
-                    outdata.append(data)
-                    log.write(data)
+                data = stdoutbuf + pipe.stdout.read()
+                if data is not None and len(data) > 0:
+                    try:
+                        data = data.decode("utf-8")
+                        outdata.append(data)
+                        log.write(data)
+                        stdoutbuf = b""
+                    except UnicodeDecodeError:
+                        stdoutbuf = data
 
             if pipe.stderr in r:
-                data = pipe.stderr.read()
-                if data is not None:
-                    errdata.append(data)
-                    log.write(data)
+                data = stderrbuf + pipe.stderr.read()
+                if data is not None and len(data) > 0:
+                    try:
+                        data = data.decode("utf-8")
+                        errdata.append(data)
+                        log.write(data)
+                        stderrbuf = b""
+                    except UnicodeDecodeError:
+                        stderrbuf = data
 
             readextras(r)
 
@@ -135,7 +147,7 @@ def run(cmd, input=None, log=None, extrafiles=None, **options):
     if not extrafiles:
         extrafiles = []
 
-    if isinstance(cmd, basestring) and not "shell" in options:
+    if isinstance(cmd, str) and not "shell" in options:
         options["shell"] = True
 
     try:
@@ -150,6 +162,10 @@ def run(cmd, input=None, log=None, extrafiles=None, **options):
         stdout, stderr = _logged_communicate(pipe, log, input, extrafiles)
     else:
         stdout, stderr = pipe.communicate(input)
+        if stdout:
+            stdout = stdout.decode("utf-8")
+        if stderr:
+            stderr = stderr.decode("utf-8")
 
     if pipe.returncode != 0:
         raise ExecutionError(cmd, pipe.returncode, stdout, stderr)
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 563a091..80701b2 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -245,7 +245,7 @@ def _filterProviders(providers, item, cfgData, dataCache):
             pkg_pn[pn] = []
         pkg_pn[pn].append(p)
 
-    logger.debug(1, "providers for %s are: %s", item, pkg_pn.keys())
+    logger.debug(1, "providers for %s are: %s", item, list(pkg_pn.keys()))
 
     # First add PREFERRED_VERSIONS
     for pn in pkg_pn:
diff --git a/lib/bb/pysh/builtin.py b/lib/bb/pysh/builtin.py
index b748e4a..a8814dc 100644
--- a/lib/bb/pysh/builtin.py
+++ b/lib/bb/pysh/builtin.py
@@ -527,7 +527,7 @@ def utility_sed(name, args, interp, env, stdin, stdout, stderr, debugflags):
         print interp.log(' '.join([name, str(args), interp['PWD']]) + '\n')
         
     # Scan pattern arguments and append a space if necessary
-    for i in xrange(len(args)):
+    for i in range(len(args)):
         if not RE_SED.search(args[i]):
             continue
         args[i] = args[i] + ' '
diff --git a/lib/bb/pysh/interp.py b/lib/bb/pysh/interp.py
index 25d8c92..d14ecf3 100644
--- a/lib/bb/pysh/interp.py
+++ b/lib/bb/pysh/interp.py
@@ -474,7 +474,7 @@ class Environment:
         """
         # Save and remove previous arguments
         prevargs = []        
-        for i in xrange(int(self._env['#'])):
+        for i in range(int(self._env['#'])):
             i = str(i+1)
             prevargs.append(self._env[i])
             del self._env[i]
@@ -488,7 +488,7 @@ class Environment:
         return prevargs
         
     def get_positional_args(self):
-        return [self._env[str(i+1)] for i in xrange(int(self._env['#']))]
+        return [self._env[str(i+1)] for i in range(int(self._env['#']))]
         
     def get_variables(self):
         return dict(self._env)
diff --git a/lib/bb/pysh/pyshlex.py b/lib/bb/pysh/pyshlex.py
index b301236..fbf094b 100644
--- a/lib/bb/pysh/pyshlex.py
+++ b/lib/bb/pysh/pyshlex.py
@@ -20,7 +20,7 @@ except NameError:
     from Set import Set as set
 
 from ply import lex
-from sherrors import *
+from bb.pysh.sherrors import *
 
 class NeedMore(Exception):
     pass
diff --git a/lib/bb/pysh/pyshyacc.py b/lib/bb/pysh/pyshyacc.py
index e8e80aa..ba4cefd 100644
--- a/lib/bb/pysh/pyshyacc.py
+++ b/lib/bb/pysh/pyshyacc.py
@@ -10,11 +10,11 @@
 import os.path
 import sys
 
-import pyshlex
+import bb.pysh.pyshlex as pyshlex
 tokens = pyshlex.tokens
 
 from ply import yacc
-import sherrors
+import bb.pysh.sherrors as sherrors
     
 class IORedirect:
     def __init__(self, op, filename, io_number=None):
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 5ab7e97..376c9f5 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -35,11 +35,7 @@ import bb
 from bb import msg, data, event
 from bb import monitordisk
 import subprocess
-
-try:
-    import cPickle as pickle
-except ImportError:
-    import pickle
+import pickle
 
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
@@ -108,7 +104,7 @@ class RunQueueScheduler(object):
 
         self.buildable = []
         self.stamps = {}
-        for taskid in xrange(self.numTasks):
+        for taskid in range(self.numTasks):
             fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[taskid]]
             taskname = self.rqdata.runq_task[taskid]
             self.stamps[taskid] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
@@ -127,12 +123,12 @@ class RunQueueScheduler(object):
         if len(self.buildable) == 1:
             taskid = self.buildable[0]
             stamp = self.stamps[taskid]
-            if stamp not in self.rq.build_stamps.itervalues():
+            if stamp not in self.rq.build_stamps.values():
                 return taskid
 
         if not self.rev_prio_map:
-            self.rev_prio_map = range(self.numTasks)
-            for taskid in xrange(self.numTasks):
+            self.rev_prio_map = list(range(self.numTasks))
+            for taskid in range(self.numTasks):
                 self.rev_prio_map[self.prio_map[taskid]] = taskid
 
         best = None
@@ -141,7 +137,7 @@ class RunQueueScheduler(object):
             prio = self.rev_prio_map[taskid]
             if bestprio is None or bestprio > prio:
                 stamp = self.stamps[taskid]
-                if stamp in self.rq.build_stamps.itervalues():
+                if stamp in self.rq.build_stamps.values():
                     continue
                 bestprio = prio
                 best = taskid
@@ -269,7 +265,7 @@ class RunQueueData:
 
 
     def get_task_id(self, fnid, taskname):
-        for listid in xrange(len(self.runq_fnid)):
+        for listid in range(len(self.runq_fnid)):
             if self.runq_fnid[listid] == fnid and self.runq_task[listid] == taskname:
                 return listid
         return None
@@ -291,7 +287,7 @@ class RunQueueData:
             """
             lowest = 0
             new_chain = []
-            for entry in xrange(len(chain)):
+            for entry in range(len(chain)):
                 if chain[entry] < chain[lowest]:
                     lowest = entry
             new_chain.extend(chain[lowest:])
@@ -304,7 +300,7 @@ class RunQueueData:
             """
             if len(chain1) != len(chain2):
                 return False
-            for index in xrange(len(chain1)):
+            for index in range(len(chain1)):
                 if chain1[index] != chain2[index]:
                     return False
             return True
@@ -375,7 +371,7 @@ class RunQueueData:
         deps_left = []
         task_done = []
 
-        for listid in xrange(numTasks):
+        for listid in range(numTasks):
             task_done.append(False)
             weight.append(1)
             deps_left.append(len(self.runq_revdeps[listid]))
@@ -399,7 +395,7 @@ class RunQueueData:
 
         # Circular dependency sanity check
         problem_tasks = []
-        for task in xrange(numTasks):
+        for task in range(numTasks):
             if task_done[task] is False or deps_left[task] != 0:
                 problem_tasks.append(task)
                 logger.debug(2, "Task %s (%s) is not buildable", task, self.get_user_idstring(task))
@@ -482,7 +478,7 @@ class RunQueueData:
                     if taskid is not None:
                         depends.add(taskid)
 
-        for task in xrange(len(taskData.tasks_name)):
+        for task in range(len(taskData.tasks_name)):
             depends = set()
             fnid = taskData.tasks_fnid[task]
             fn = taskData.fn_index[fnid]
@@ -597,7 +593,7 @@ class RunQueueData:
         for task in recursivetasks:
             extradeps[task].difference_update(recursivetasksselfref)
 
-        for task in xrange(len(taskData.tasks_name)):
+        for task in range(len(taskData.tasks_name)):
             # Add in extra dependencies
             if task in extradeps:
                  self.runq_depends[task] = extradeps[task]
@@ -675,7 +671,7 @@ class RunQueueData:
 
         maps = []
         delcount = 0
-        for listid in xrange(len(self.runq_fnid)):
+        for listid in range(len(self.runq_fnid)):
             if runq_build[listid-delcount] == 1:
                 maps.append(listid-delcount)
             else:
@@ -703,7 +699,7 @@ class RunQueueData:
 
         # Remap the dependencies to account for the deleted tasks
         # Check we didn't delete a task we depend on
-        for listid in xrange(len(self.runq_fnid)):
+        for listid in range(len(self.runq_fnid)):
             newdeps = []
             origdeps = self.runq_depends[listid]
             for origdep in origdeps:
@@ -715,14 +711,14 @@ class RunQueueData:
         logger.verbose("Assign Weightings")
 
         # Generate a list of reverse dependencies to ease future calculations
-        for listid in xrange(len(self.runq_fnid)):
+        for listid in range(len(self.runq_fnid)):
             for dep in self.runq_depends[listid]:
                 self.runq_revdeps[dep].add(listid)
 
         # Identify tasks at the end of dependency chains
         # Error on circular dependency loops (length two)
         endpoints = []
-        for listid in xrange(len(self.runq_fnid)):
+        for listid in range(len(self.runq_fnid)):
             revdeps = self.runq_revdeps[listid]
             if len(revdeps) == 0:
                 endpoints.append(listid)
@@ -740,7 +736,7 @@ class RunQueueData:
         # Sanity Check - Check for multiple tasks building the same provider
         prov_list = {}
         seen_fn = []
-        for task in xrange(len(self.runq_fnid)):
+        for task in range(len(self.runq_fnid)):
             fn = taskData.fn_index[self.runq_fnid[task]]
             if fn in seen_fn:
                 continue
@@ -905,7 +901,7 @@ class RunQueueData:
         Dump some debug information on the internal data structures
         """
         logger.debug(3, "run_tasks:")
-        for task in xrange(len(self.rqdata.runq_task)):
+        for task in range(len(self.rqdata.runq_task)):
             logger.debug(3, " (%s)%s - %s: %s   Deps %s RevDeps %s", task,
                          taskQueue.fn_index[self.rqdata.runq_fnid[task]],
                          self.rqdata.runq_task[task],
@@ -914,7 +910,7 @@ class RunQueueData:
                          self.rqdata.runq_revdeps[task])
 
         logger.debug(3, "sorted_tasks:")
-        for task1 in xrange(len(self.rqdata.runq_task)):
+        for task1 in range(len(self.rqdata.runq_task)):
             if task1 in self.prio_map:
                 task = self.prio_map[task1]
                 logger.debug(3, " (%s)%s - %s: %s   Deps %s RevDeps %s", task,
@@ -982,8 +978,8 @@ class RunQueue:
             "time" : self.cfgData.getVar("TIME", True),
         }
 
-        worker.stdin.write("<cookerconfig>" + pickle.dumps(self.cooker.configuration) + "</cookerconfig>")
-        worker.stdin.write("<workerdata>" + pickle.dumps(workerdata) + "</workerdata>")
+        worker.stdin.write(b"<cookerconfig>" + pickle.dumps(self.cooker.configuration) + b"</cookerconfig>")
+        worker.stdin.write(b"<workerdata>" + pickle.dumps(workerdata) + b"</workerdata>")
         worker.stdin.flush()
 
         return worker, workerpipe
@@ -993,8 +989,9 @@ class RunQueue:
             return
         logger.debug(1, "Teardown for bitbake-worker")
         try:
-           worker.stdin.write("<quit></quit>")
+           worker.stdin.write(b"<quit></quit>")
            worker.stdin.flush()
+           worker.stdin.close()
         except IOError:
            pass
         while worker.returncode is None:
@@ -1245,7 +1242,7 @@ class RunQueue:
         stamppresent = []
         valid_new = set()
 
-        for task in xrange(len(self.rqdata.runq_fnid)):
+        for task in range(len(self.rqdata.runq_fnid)):
             fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
             taskname = self.rqdata.runq_task[task]
             taskdep = self.rqdata.dataCache.task_deps[fn]
@@ -1287,7 +1284,7 @@ class RunQueue:
                     valid_new.add(dep)
 
         invalidtasks = set()
-        for task in xrange(len(self.rqdata.runq_fnid)):
+        for task in range(len(self.rqdata.runq_fnid)):
             if task not in valid_new and task not in noexec:
                 invalidtasks.add(task)
 
@@ -1346,7 +1343,7 @@ class RunQueue:
                     match = m
             if match is None:
                 bb.fatal("Can't find a task we're supposed to have written out? (hash: %s)?" % h)
-            matches = {k : v for k, v in matches.iteritems() if h not in k}
+            matches = {k : v for k, v in iter(matches.items()) if h not in k}
             if matches:
                 latestmatch = sorted(matches.keys(), key=lambda f: matches[f])[-1]
                 prevh = __find_md5__.search(latestmatch).group(0)
@@ -1395,17 +1392,15 @@ class RunQueueExecute:
         return True
 
     def finish_now(self):
-
         for worker in [self.rq.worker, self.rq.fakeworker]:
             if not worker:
                 continue
             try:
-                worker.stdin.write("<finishnow></finishnow>")
+                worker.stdin.write(b"<finishnow></finishnow>")
                 worker.stdin.flush()
             except IOError:
                 # worker must have died?
                 pass
-
         if len(self.failed_fnids) != 0:
             self.rq.state = runQueueFailed
             return
@@ -1468,7 +1463,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
         initial_covered = self.rq.scenequeue_covered.copy()
 
         # Mark initial buildable tasks
-        for task in xrange(self.stats.total):
+        for task in range(self.stats.total):
             self.runq_running.append(0)
             self.runq_complete.append(0)
             if len(self.rqdata.runq_depends[task]) == 0:
@@ -1481,7 +1476,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
         found = True
         while found:
             found = False
-            for task in xrange(self.stats.total):
+            for task in range(self.stats.total):
                 if task in self.rq.scenequeue_covered:
                     continue
                 logger.debug(1, 'Considering %s (%s): %s' % (task, self.rqdata.get_user_idstring(task), str(self.rqdata.runq_revdeps[task])))
@@ -1496,7 +1491,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
         covered_remove = set()
         if self.rq.setsceneverify:
             invalidtasks = []
-            for task in xrange(len(self.rqdata.runq_task)):
+            for task in range(len(self.rqdata.runq_task)):
                 fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
                 taskname = self.rqdata.runq_task[task]
                 taskdep = self.rqdata.dataCache.task_deps[fn]
@@ -1684,10 +1679,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
                         logger.critical("Failed to spawn fakeroot worker to run %s:%s: %s" % (fn, taskname, str(exc)))
                         self.rq.state = runQueueFailed
                         return True
-                self.rq.fakeworker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + "</runtask>")
+                self.rq.fakeworker.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + b"</runtask>")
                 self.rq.fakeworker.stdin.flush()
             else:
-                self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + "</runtask>")
+                self.rq.worker.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + b"</runtask>")
                 self.rq.worker.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
@@ -1706,7 +1701,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             return True
 
         # Sanity Checks
-        for task in xrange(self.stats.total):
+        for task in range(self.stats.total):
             if self.runq_buildable[task] == 0:
                 logger.error("Task %s never buildable!", task)
             if self.runq_running[task] == 0:
@@ -1764,14 +1759,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # therefore aims to collapse the huge runqueue dependency tree into a smaller one
         # only containing the setscene functions.
 
-        for task in xrange(self.stats.total):
+        for task in range(self.stats.total):
             self.runq_running.append(0)
             self.runq_complete.append(0)
             self.runq_buildable.append(0)
 
         # First process the chains up to the first setscene task.
         endpoints = {}
-        for task in xrange(len(self.rqdata.runq_fnid)):
+        for task in range(len(self.rqdata.runq_fnid)):
             sq_revdeps.append(copy.copy(self.rqdata.runq_revdeps[task]))
             sq_revdeps_new.append(set())
             if (len(self.rqdata.runq_revdeps[task]) == 0) and task not in self.rqdata.runq_setscene:
@@ -1833,7 +1828,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                         newendpoints[dep] = tasks
             if len(newendpoints) != 0:
                 process_endpoints2(newendpoints)
-        for task in xrange(len(self.rqdata.runq_fnid)):
+        for task in range(len(self.rqdata.runq_fnid)):
             sq_revdeps2.append(copy.copy(self.rqdata.runq_revdeps[task]))
             sq_revdeps_new2.append(set())
             if (len(self.rqdata.runq_revdeps[task]) == 0) and task not in self.rqdata.runq_setscene:
@@ -1844,7 +1839,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             if sq_revdeps_new2[task]:
                 self.unskippable.append(self.rqdata.runq_setscene.index(task))
 
-        for task in xrange(len(self.rqdata.runq_fnid)):
+        for task in range(len(self.rqdata.runq_fnid)):
             if task in self.rqdata.runq_setscene:
                 deps = set()
                 for dep in sq_revdeps_new[task]:
@@ -1883,7 +1878,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
              for dep in self.sq_harddeps[task]:
                  sq_revdeps_squash[dep].add(task)
 
-        #for task in xrange(len(sq_revdeps_squash)):
+        #for task in range(len(sq_revdeps_squash)):
         #    realtask = self.rqdata.runq_setscene[task]
         #    bb.warn("Task %s: %s_setscene is %s " % (task, self.rqdata.get_user_idstring(realtask) , sq_revdeps_squash[task]))
 
@@ -1891,13 +1886,13 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.sq_revdeps = sq_revdeps_squash
         self.sq_revdeps2 = copy.deepcopy(self.sq_revdeps)
 
-        for task in xrange(len(self.sq_revdeps)):
+        for task in range(len(self.sq_revdeps)):
             self.sq_deps.append(set())
-        for task in xrange(len(self.sq_revdeps)):
+        for task in range(len(self.sq_revdeps)):
             for dep in self.sq_revdeps[task]:
                 self.sq_deps[dep].add(task)
 
-        for task in xrange(len(self.sq_revdeps)):
+        for task in range(len(self.sq_revdeps)):
             if len(self.sq_revdeps[task]) == 0:
                 self.runq_buildable[task] = 1
 
@@ -1910,7 +1905,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             sq_task = []
             noexec = []
             stamppresent = []
-            for task in xrange(len(self.sq_revdeps)):
+            for task in range(len(self.sq_revdeps)):
                 realtask = self.rqdata.runq_setscene[task]
                 fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[realtask]]
                 taskname = self.rqdata.runq_task[realtask]
@@ -1947,7 +1942,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             for v in valid:
                 valid_new.append(sq_task[v])
 
-            for task in xrange(len(self.sq_revdeps)):
+            for task in range(len(self.sq_revdeps)):
                 if task not in valid_new and task not in noexec:
                     realtask = self.rqdata.runq_setscene[task]
                     logger.debug(2, 'No package found, so skipping setscene task %s',
@@ -2024,7 +2019,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         task = None
         if self.stats.active < self.number_tasks:
             # Find the next setscene to run
-            for nexttask in xrange(self.stats.total):
+            for nexttask in range(self.stats.total):
                 if self.runq_buildable[nexttask] == 1 and self.runq_running[nexttask] != 1:
                     if nexttask in self.unskippable:
                         logger.debug(2, "Setscene task %s is unskippable" % self.rqdata.get_user_idstring(self.rqdata.runq_setscene[nexttask]))                      
@@ -2076,10 +2071,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not self.rq.fakeworker:
                     self.rq.start_fakeworker(self)
-                self.rq.fakeworker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + "</runtask>")
+                self.rq.fakeworker.stdin.write(b"<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
                 self.rq.fakeworker.stdin.flush()
             else:
-                self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + "</runtask>")
+                self.rq.worker.stdin.write(b"<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
                 self.rq.worker.stdin.flush()
 
             self.runq_running[task] = 1
@@ -2091,7 +2086,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             self.rq.read_workers()
             return self.rq.active_fds()
 
-        #for task in xrange(self.stats.total):
+        #for task in range(self.stats.total):
         #    if self.runq_running[task] != 1:
         #        buildable = self.runq_buildable[task]
         #        revdeps = self.sq_revdeps[task]
@@ -2227,7 +2222,7 @@ class runQueuePipe():
         if pipeout:
             pipeout.close()
         bb.utils.nonblockingfd(self.input)
-        self.queue = ""
+        self.queue = b""
         self.d = d
         self.rq = rq
         self.rqexec = rqexec
@@ -2251,7 +2246,7 @@ class runQueuePipe():
 
         start = len(self.queue)
         try:
-            self.queue = self.queue + self.input.read(102400)
+            self.queue = self.queue + (self.input.read(102400) or b"")
         except (OSError, IOError) as e:
             if e.errno != errno.EAGAIN:
                 raise
@@ -2259,8 +2254,8 @@ class runQueuePipe():
         found = True
         while found and len(self.queue):
             found = False
-            index = self.queue.find("</event>")
-            while index != -1 and self.queue.startswith("<event>"):
+            index = self.queue.find(b"</event>")
+            while index != -1 and self.queue.startswith(b"<event>"):
                 try:
                     event = pickle.loads(self.queue[7:index])
                 except ValueError as e:
@@ -2268,9 +2263,9 @@ class runQueuePipe():
                 bb.event.fire_from_worker(event, self.d)
                 found = True
                 self.queue = self.queue[index+8:]
-                index = self.queue.find("</event>")
-            index = self.queue.find("</exitcode>")
-            while index != -1 and self.queue.startswith("<exitcode>"):
+                index = self.queue.find(b"</event>")
+            index = self.queue.find(b"</exitcode>")
+            while index != -1 and self.queue.startswith(b"<exitcode>"):
                 try:
                     task, status = pickle.loads(self.queue[10:index])
                 except ValueError as e:
@@ -2278,7 +2273,7 @@ class runQueuePipe():
                 self.rqexec.runqueue_process_waitpid(task, status)
                 found = True
                 self.queue = self.queue[index+11:]
-                index = self.queue.find("</exitcode>")
+                index = self.queue.find(b"</exitcode>")
         return (end > start)
 
     def close(self):
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index cc58c72..982fcf7 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -30,7 +30,7 @@ import signal
 import sys
 import time
 import select
-from Queue import Empty
+from queue import Empty
 from multiprocessing import Event, Process, util, Queue, Pipe, queues, Manager
 
 from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
@@ -137,7 +137,7 @@ class ProcessServer(Process, BaseImplServer):
         if not fds:
             fds = []
 
-        for function, data in self._idlefuns.items():
+        for function, data in list(self._idlefuns.items()):
             try:
                 retval = function(self, data, False)
                 if retval is False:
@@ -145,7 +145,7 @@ class ProcessServer(Process, BaseImplServer):
                     nextsleep = None
                 elif retval is True:
                     nextsleep = None
-                elif isinstance(retval, float):
+                elif isinstance(retval, float) and nextsleep:
                     if (retval < nextsleep):
                         nextsleep = retval
                 elif nextsleep is None:
@@ -213,7 +213,7 @@ class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
 # Wrap Queue to provide API which isn't server implementation specific
 class ProcessEventQueue(multiprocessing.queues.Queue):
     def __init__(self, maxsize):
-        multiprocessing.queues.Queue.__init__(self, maxsize)
+        multiprocessing.queues.Queue.__init__(self, maxsize, ctx=multiprocessing.get_context())
         self.exit = False
         bb.utils.set_process_name("ProcessEQueue")
 
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index ace1cf6..146ca17 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -31,31 +31,33 @@
     in the server's main loop.
 """
 
+import os
+import sys
+
+import hashlib
+import time
+import socket
+import signal
+import threading
+import pickle
+import inspect
+import select
+import http.client
+import xmlrpc.client
+from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
+
 import bb
-import xmlrpclib, sys
 from bb import daemonize
 from bb.ui import uievent
-import hashlib, time
-import socket
-import os, signal
-import threading
-try:
-    import cPickle as pickle
-except ImportError:
-    import pickle
+from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
 
 DEBUG = False
 
-from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
-import inspect, select, httplib
-
-from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
-
-class BBTransport(xmlrpclib.Transport):
+class BBTransport(xmlrpc.client.Transport):
     def __init__(self, timeout):
         self.timeout = timeout
         self.connection_token = None
-        xmlrpclib.Transport.__init__(self)
+        xmlrpc.client.Transport.__init__(self)
 
     # Modified from default to pass timeout to HTTPConnection
     def make_connection(self, host):
@@ -67,7 +69,7 @@ class BBTransport(xmlrpclib.Transport):
         # create a HTTP connection object from a host descriptor
         chost, self._extra_headers, x509 = self.get_host_info(host)
         #store the host argument along with the connection object
-        self._connection = host, httplib.HTTPConnection(chost, timeout=self.timeout)
+        self._connection = host, http.client.HTTPConnection(chost, timeout=self.timeout)
         return self._connection[1]
 
     def set_connection_token(self, token):
@@ -76,11 +78,11 @@ class BBTransport(xmlrpclib.Transport):
     def send_content(self, h, body):
         if self.connection_token:
             h.putheader("Bitbake-token", self.connection_token)
-        xmlrpclib.Transport.send_content(self, h, body)
+        xmlrpc.client.Transport.send_content(self, h, body)
 
 def _create_server(host, port, timeout = 60):
     t = BBTransport(timeout)
-    s = xmlrpclib.ServerProxy("http://%s:%d/" % (host, port), transport=t, allow_none=True)
+    s = xmlrpc.client.ServerProxy("http://%s:%d/" % (host, port), transport=t, allow_none=True, use_builtin_types=True)
     return s, t
 
 class BitBakeServerCommands():
@@ -128,7 +130,7 @@ class BitBakeServerCommands():
     def addClient(self):
         if self.has_client:
             return None
-        token = hashlib.md5(str(time.time())).hexdigest()
+        token = hashlib.md5(str(time.time()).encode("utf-8")).hexdigest()
         self.server.set_connection_token(token)
         self.has_client = True
         return token
@@ -232,7 +234,7 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         while not self.quit:
             fds = [self]
             nextsleep = 0.1
-            for function, data in self._idlefuns.items():
+            for function, data in list(self._idlefuns.items()):
                 retval = None
                 try:
                     retval = function(self, data, False)
@@ -267,7 +269,7 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
                 pass
 
         # Tell idle functions we're exiting
-        for function, data in self._idlefuns.items():
+        for function, data in list(self._idlefuns.items()):
             try:
                 retval = function(self, data, True)
             except:
@@ -379,7 +381,7 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
             bb.warn("Could not create socket for %s:%s (%s)" % (host, port, str(e)))
             raise e
         try:
-            self.serverImpl = XMLRPCProxyServer(host, port)
+            self.serverImpl = XMLRPCProxyServer(host, port, use_builtin_types=True)
             self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only, featureset)
             return self.connection.connect(self.token)
         except Exception as e:
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index e4085cf..db3daef 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -3,19 +3,14 @@ import logging
 import os
 import re
 import tempfile
+import pickle
 import bb.data
 from bb.checksum import FileChecksumCache
 
 logger = logging.getLogger('BitBake.SigGen')
 
-try:
-    import cPickle as pickle
-except ImportError:
-    import pickle
-    logger.info('Importing cPickle failed.  Falling back to a very slow implementation.')
-
 def init(d):
-    siggens = [obj for obj in globals().itervalues()
+    siggens = [obj for obj in globals().values()
                       if type(obj) is type and issubclass(obj, SignatureGenerator)]
 
     desired = d.getVar("BB_SIGNATURE_HANDLER", True) or "noop"
@@ -138,7 +133,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 var = lookupcache[dep]
                 if var is not None:
                     data = data + str(var)
-            self.basehash[fn + "." + task] = hashlib.md5(data).hexdigest()
+            self.basehash[fn + "." + task] = hashlib.md5(data.encode("utf-8")).hexdigest()
             taskdeps[task] = alldeps
 
         self.taskdeps[fn] = taskdeps
@@ -223,7 +218,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             self.taints[k] = taint
             logger.warning("%s is tainted from a forced run" % k)
 
-        h = hashlib.md5(data).hexdigest()
+        h = hashlib.md5(data.encode("utf-8")).hexdigest()
         self.taskhash[k] = h
         #d.setVar("BB_TASKHASH_task-%s" % task, taskhash[task])
         return h
@@ -287,7 +282,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             with os.fdopen(fd, "wb") as stream:
                 p = pickle.dump(data, stream, -1)
                 stream.flush()
-            os.chmod(tmpfile, 0664)
+            os.chmod(tmpfile, 0o664)
             os.rename(tmpfile, sigfile)
         except (OSError, IOError) as err:
             try:
@@ -545,7 +540,7 @@ def calc_basehash(sigdata):
         if val is not None:
             basedata = basedata + str(val)
 
-    return hashlib.md5(basedata).hexdigest()
+    return hashlib.md5(basedata.encode("utf-8")).hexdigest()
 
 def calc_taskhash(sigdata):
     data = sigdata['basehash']
@@ -562,7 +557,7 @@ def calc_taskhash(sigdata):
         else:
             data = data + sigdata['taint']
 
-    return hashlib.md5(data).hexdigest()
+    return hashlib.md5(data.encode("utf-8")).hexdigest()
 
 
 def dump_sigfile(a):
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 9ae52d7..65628c8 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -446,7 +446,7 @@ class TaskData:
             return
 
         if not item in dataCache.providers:
-            close_matches = self.get_close_matches(item, dataCache.providers.keys())
+            close_matches = self.get_close_matches(item, list(dataCache.providers.keys()))
             # Is it in RuntimeProviders ?
             all_p = bb.providers.getRuntimeProviders(dataCache, item)
             for fn in all_p:
@@ -576,7 +576,7 @@ class TaskData:
         dependees = self.get_dependees(targetid)
         for fnid in dependees:
             self.fail_fnid(fnid, missing_list)
-        for taskid in xrange(len(self.tasks_idepends)):
+        for taskid in range(len(self.tasks_idepends)):
             idepends = self.tasks_idepends[taskid]
             for (idependid, idependtask) in idepends:
                 if idependid == targetid:
@@ -602,7 +602,7 @@ class TaskData:
         dependees = self.get_rdependees(targetid)
         for fnid in dependees:
             self.fail_fnid(fnid, missing_list)
-        for taskid in xrange(len(self.tasks_irdepends)):
+        for taskid in range(len(self.tasks_irdepends)):
             irdepends = self.tasks_irdepends[taskid]
             for (idependid, idependtask) in irdepends:
                 if idependid == targetid:
@@ -658,7 +658,7 @@ class TaskData:
         logger.debug(3, ", ".join(self.run_names_index))
 
         logger.debug(3, "build_targets:")
-        for buildid in xrange(len(self.build_names_index)):
+        for buildid in range(len(self.build_names_index)):
             target = self.build_names_index[buildid]
             targets = "None"
             if buildid in self.build_targets:
@@ -666,7 +666,7 @@ class TaskData:
             logger.debug(3, " (%s)%s: %s", buildid, target, targets)
 
         logger.debug(3, "run_targets:")
-        for runid in xrange(len(self.run_names_index)):
+        for runid in range(len(self.run_names_index)):
             target = self.run_names_index[runid]
             targets = "None"
             if runid in self.run_targets:
@@ -674,7 +674,7 @@ class TaskData:
             logger.debug(3, " (%s)%s: %s", runid, target, targets)
 
         logger.debug(3, "tasks:")
-        for task in xrange(len(self.tasks_name)):
+        for task in range(len(self.tasks_name)):
             logger.debug(3, " (%s)%s - %s: %s",
                        task,
                        self.fn_index[self.tasks_fnid[task]],
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index 5ea9d84..14f0e25 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -191,8 +191,8 @@ class PythonReferenceTest(ReferenceTest):
         if hasattr(bb.utils, "_context"):
             self.context = bb.utils._context
         else:
-            import __builtin__
-            self.context = __builtin__.__dict__
+            import builtins
+            self.context = builtins.__dict__
 
     def parseExpression(self, exp):
         parsedvar = self.d.expandWithRefs(exp, None)
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 1223230..b54eb06 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -147,14 +147,14 @@ class DataExpansions(unittest.TestCase):
         self.assertEqual(self.d.getVar("foo", False), None)
 
     def test_keys(self):
-        keys = self.d.keys()
-        self.assertEqual(keys, ['value_of_foo', 'foo', 'bar'])
+        keys = list(self.d.keys())
+        self.assertCountEqual(keys, ['value_of_foo', 'foo', 'bar'])
 
     def test_keys_deletion(self):
         newd = bb.data.createCopy(self.d)
         newd.delVar("bar")
-        keys = newd.keys()
-        self.assertEqual(keys, ['value_of_foo', 'foo'])
+        keys = list(newd.keys())
+        self.assertCountEqual(keys, ['value_of_foo', 'foo'])
 
 class TestNestedExpansions(unittest.TestCase):
     def setUp(self):
@@ -334,7 +334,7 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("TEST2_bar", "testvalue2")
         bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST2", True), "testvalue2")
-        self.assertItemsEqual(self.d.keys(), ['TEST', 'TEST2', 'OVERRIDES', 'TEST2_bar'])
+        self.assertCountEqual(list(self.d.keys()), ['TEST', 'TEST2', 'OVERRIDES', 'TEST2_bar'])
 
     def test_multiple_override(self):
         self.d.setVar("TEST_bar", "testvalue2")
@@ -342,7 +342,7 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("TEST_foo", "testvalue4")
         bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
-        self.assertItemsEqual(self.d.keys(), ['TEST', 'TEST_foo', 'OVERRIDES', 'TEST_bar', 'TEST_local'])
+        self.assertCountEqual(list(self.d.keys()), ['TEST', 'TEST_foo', 'OVERRIDES', 'TEST_bar', 'TEST_local'])
 
     def test_multiple_combined_overrides(self):
         self.d.setVar("TEST_local_foo_bar", "testvalue3")
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 6beb76a..c296db2 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -50,7 +50,7 @@ C = "3"
     def parsehelper(self, content, suffix = ".bb"):
 
         f = tempfile.NamedTemporaryFile(suffix = suffix)
-        f.write(content)
+        f.write(bytes(content, "utf-8"))
         f.flush()
         os.chdir(os.path.dirname(f.name))
         return f
diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 2b969c1..1f51a3c 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -612,7 +612,7 @@ class HobIconChecker(hic):
     def set_hob_icon_to_stock_icon(self, file_path, stock_id=""):
         try:
             pixbuf = gtk.gdk.pixbuf_new_from_file(file_path)
-        except Exception, e:
+        except Exception as e:
             return None
 
         if stock_id and (gtk.icon_factory_lookup_default(stock_id) == None):
diff --git a/lib/bb/ui/crumbs/progressbar.py b/lib/bb/ui/crumbs/progressbar.py
index 3e2c660..03230ae 100644
--- a/lib/bb/ui/crumbs/progressbar.py
+++ b/lib/bb/ui/crumbs/progressbar.py
@@ -44,9 +44,9 @@ class HobProgressBar (gtk.ProgressBar):
         self.set_text(text)
 
     def set_stop_title(self, text=None):
-	if not text:
-	    text = ""
-	self.set_text(text)
+        if not text:
+            text = ""
+        self.set_text(text)
 
     def reset(self):
         self.set_fraction(0)
diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index 16a955d..9b695ac 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -23,14 +23,14 @@ import gtk
 import gobject
 import logging
 import time
-import urllib
-import urllib2
+import urllib.request, urllib.parse, urllib.error
+import urllib.request, urllib.error, urllib.parse
 import pango
 from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import HobWarpCellRendererText, HobCellRendererPixbuf
 
 class RunningBuildModel (gtk.TreeStore):
-    (COL_LOG, COL_PACKAGE, COL_TASK, COL_MESSAGE, COL_ICON, COL_COLOR, COL_NUM_ACTIVE) = range(7)
+    (COL_LOG, COL_PACKAGE, COL_TASK, COL_MESSAGE, COL_ICON, COL_COLOR, COL_NUM_ACTIVE) = list(range(7))
 
     def __init__ (self):
         gtk.TreeStore.__init__ (self,
@@ -443,8 +443,8 @@ def do_pastebin(text):
     url = 'http://pastebin.com/api_public.php'
     params = {'paste_code': text, 'paste_format': 'text'}
 
-    req = urllib2.Request(url, urllib.urlencode(params))
-    response = urllib2.urlopen(req)
+    req = urllib.request.Request(url, urllib.parse.urlencode(params))
+    response = urllib.request.urlopen(req)
     paste_url = response.read()
 
     return paste_url
@@ -519,7 +519,7 @@ class RunningBuildTreeView (gtk.TreeView):
 
         # @todo Provide visual feedback to the user that it is done and that
         # it worked.
-        print paste_url
+        print(paste_url)
 
         self._add_to_clipboard(paste_url)
 
diff --git a/lib/bb/ui/goggle.py b/lib/bb/ui/goggle.py
index f4ee7b4..f5f8f16 100644
--- a/lib/bb/ui/goggle.py
+++ b/lib/bb/ui/goggle.py
@@ -18,13 +18,18 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+from gi import pygtkcompat
+
+pygtkcompat.enable()
+pygtkcompat.enable_gtk(version='3.0')
+
 import gobject
 import gtk
-import xmlrpclib
+import xmlrpc.client
 from bb.ui.crumbs.runningbuild import RunningBuildTreeView, RunningBuild
 from bb.ui.crumbs.progress import ProgressBar
 
-import Queue
+import queue
 
 
 def event_handle_idle_func (eventHandler, build, pbar):
@@ -96,7 +101,7 @@ def main (server, eventHandler, params):
         elif ret != True:
             print("Error running command '%s': returned %s" % (cmdline, ret))
             return 1
-    except xmlrpclib.Fault as x:
+    except xmlrpcclient.Fault as x:
         print("XMLRPC Fault getting commandline:\n %s" % x)
         return 1
 
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 08c872e..9605c8e 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -22,7 +22,7 @@ from __future__ import division
 
 import os
 import sys
-import xmlrpclib
+import xmlrpc.client as xmlrpclib
 import logging
 import progressbar
 import signal
@@ -184,8 +184,8 @@ class TerminalFilter(object):
     def clearFooter(self):
         if self.footer_present:
             lines = self.footer_present
-            sys.stdout.write(self.curses.tparm(self.cuu, lines))
-            sys.stdout.write(self.curses.tparm(self.ed))
+            sys.stdout.buffer.write(self.curses.tparm(self.cuu, lines))
+            sys.stdout.buffer.write(self.curses.tparm(self.ed))
             sys.stdout.flush()
         self.footer_present = False
 
diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index 9589a77..d81e413 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -45,7 +45,7 @@
 """
 
 
-from __future__ import division
+
 import logging
 import os, sys, itertools, time, subprocess
 
@@ -55,7 +55,7 @@ except ImportError:
     sys.exit("FATAL: The ncurses ui could not load the required curses python module.")
 
 import bb
-import xmlrpclib
+import xmlrpc.client
 from bb import ui
 from bb.ui import uihelper
 
@@ -252,7 +252,7 @@ class NCursesUI:
             elif ret != True:
                 print("Couldn't get default commandlind! %s" % ret)
                 return
-        except xmlrpclib.Fault as x:
+        except xmlrpc.client.Fault as x:
             print("XMLRPC Fault getting commandline:\n %s" % x)
             return
 
@@ -331,7 +331,7 @@ class NCursesUI:
                     taw.setText(0, 0, "")
                     if activetasks:
                         taw.appendText("Active Tasks:\n")
-                        for task in activetasks.itervalues():
+                        for task in activetasks.values():
                             taw.appendText(task["title"] + '\n')
                     if failedtasks:
                         taw.appendText("Failed Tasks:\n")
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index df093c5..ca19166 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -25,7 +25,7 @@ client/server deadlocks.
 """
 
 import socket, threading, pickle, collections
-from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
+from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 
 class BBUIEventQueue:
     def __init__(self, BBServer, clientinfo=("localhost, 0")):
@@ -137,7 +137,7 @@ class UIXMLRPCServer (SimpleXMLRPCServer):
         SimpleXMLRPCServer.__init__( self,
                                     interface,
                                     requestHandler=SimpleXMLRPCRequestHandler,
-                                    logRequests=False, allow_none=True)
+                                    logRequests=False, allow_none=True, use_builtin_types=True)
 
     def get_request(self):
         while not self.quit:
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 588c192..138da44 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -37,7 +37,7 @@ import errno
 import signal
 import ast
 import collections
-from commands import getstatusoutput
+from subprocess import getstatusoutput
 from contextlib import contextmanager
 from ctypes import cdll
 
@@ -76,7 +76,7 @@ def explode_version(s):
             r.append((0, int(m.group(1))))
             s = m.group(2)
             continue
-        if s[0] in string.letters:
+        if s[0] in string.ascii_letters:
             m = alpha_regexp.match(s)
             r.append((1, m.group(1)))
             s = m.group(2)
@@ -588,7 +588,7 @@ def filter_environment(good_vars):
     """
 
     removed_vars = {}
-    for key in os.environ.keys():
+    for key in list(os.environ):
         if key in good_vars:
             continue
 
@@ -641,7 +641,7 @@ def empty_environment():
     """
     Remove all variables from the environment.
     """
-    for s in os.environ.keys():
+    for s in list(os.environ.keys()):
         os.unsetenv(s)
         del os.environ[s]
 
@@ -958,7 +958,7 @@ def contains(variable, checkvalues, truevalue, falsevalue, d):
     if not val:
         return falsevalue
     val = set(val.split())
-    if isinstance(checkvalues, basestring):
+    if isinstance(checkvalues, str):
         checkvalues = set(checkvalues.split())
     else:
         checkvalues = set(checkvalues)
@@ -971,7 +971,7 @@ def contains_any(variable, checkvalues, truevalue, falsevalue, d):
     if not val:
         return falsevalue
     val = set(val.split())
-    if isinstance(checkvalues, basestring):
+    if isinstance(checkvalues, str):
         checkvalues = set(checkvalues.split())
     else:
         checkvalues = set(checkvalues)
@@ -1040,7 +1040,7 @@ def exec_flat_python_func(func, *args, **kwargs):
         aidx += 1
     # Handle keyword arguments
     context.update(kwargs)
-    funcargs.extend(['%s=%s' % (arg, arg) for arg in kwargs.iterkeys()])
+    funcargs.extend(['%s=%s' % (arg, arg) for arg in kwargs.keys()])
     code = 'retval = %s(%s)' % (func, ', '.join(funcargs))
     comp = bb.utils.better_compile(code, '<string>', '<string>')
     bb.utils.better_exec(comp, context, code, '<string>')
@@ -1127,7 +1127,7 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
             else:
                 varset_new = varset_start
 
-            if isinstance(indent, (int, long)):
+            if isinstance(indent, int):
                 if indent == -1:
                     indentspc = ' ' * (len(varset_new) + 2)
                 else:
@@ -1195,7 +1195,7 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
                 in_var = None
         else:
             skip = False
-            for (varname, var_re) in var_res.iteritems():
+            for (varname, var_re) in var_res.items():
                 res = var_re.match(line)
                 if res:
                     isfunc = varname.endswith('()')
@@ -1373,7 +1373,7 @@ def get_file_layer(filename, d):
         # Use longest path so we handle nested layers
         matchlen = 0
         match = None
-        for collection, regex in collection_res.iteritems():
+        for collection, regex in collection_res.items():
             if len(regex) > matchlen and re.match(regex, path):
                 matchlen = len(regex)
                 match = collection
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index 5b95e2e..d4c1792 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -117,7 +117,7 @@ build results (as the layer priority order has effectively changed).
         applied_appends = []
         for layer in layers:
             overlayed = []
-            for f in self.tinfoil.cooker.collection.overlayed.iterkeys():
+            for f in self.tinfoil.cooker.collection.overlayed.keys():
                 for of in self.tinfoil.cooker.collection.overlayed[f]:
                     if of.startswith(layer):
                         overlayed.append(of)
diff --git a/lib/bblayers/common.py b/lib/bblayers/common.py
index 360b9d7..b10fb4c 100644
--- a/lib/bblayers/common.py
+++ b/lib/bblayers/common.py
@@ -14,7 +14,7 @@ class LayerPlugin():
         self.tinfoil = tinfoil
         self.bblayers = (self.tinfoil.config_data.getVar('BBLAYERS', True) or "").split()
         layerconfs = self.tinfoil.config_data.varhistory.get_variable_items_files('BBFILE_COLLECTIONS', self.tinfoil.config_data)
-        self.bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.iteritems()}
+        self.bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.items()}
 
     @staticmethod
     def add_command(subparsers, cmdname, function, parserecipes=True, *args, **kwargs):
diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 3c39d8a..10ad718 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -1,10 +1,10 @@
 import argparse
-import httplib
+import http.client
 import json
 import logging
 import os
 import subprocess
-import urlparse
+import urllib.parse
 
 from bblayers.action import ActionPlugin
 
@@ -24,12 +24,12 @@ class LayerIndexPlugin(ActionPlugin):
     def get_json_data(self, apiurl):
         proxy_settings = os.environ.get("http_proxy", None)
         conn = None
-        _parsedurl = urlparse.urlparse(apiurl)
+        _parsedurl = urllib.parse.urlparse(apiurl)
         path = _parsedurl.path
         query = _parsedurl.query
 
         def parse_url(url):
-            parsedurl = urlparse.urlparse(url)
+            parsedurl = urllib.parse.urlparse(url)
             if parsedurl.netloc[0] == '[':
                 host, port = parsedurl.netloc[1:].split(']', 1)
                 if ':' in port:
@@ -46,11 +46,11 @@ class LayerIndexPlugin(ActionPlugin):
 
         if proxy_settings is None:
             host, port = parse_url(apiurl)
-            conn = httplib.HTTPConnection(host, port)
+            conn = http.client.HTTPConnection(host, port)
             conn.request("GET", path + "?" + query)
         else:
             host, port = parse_url(proxy_settings)
-            conn = httplib.HTTPConnection(host, port)
+            conn = http.client.HTTPConnection(host, port)
             conn.request("GET", apiurl)
 
         r = conn.getresponse()
diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index b5b98f7..b8c817b 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -128,7 +128,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
         # Ensure we list skipped recipes
         # We are largely guessing about PN, PV and the preferred version here,
         # but we have no choice since skipped recipes are not fully parsed
-        skiplist = self.tinfoil.cooker.skiplist.keys()
+        skiplist = list(self.tinfoil.cooker.skiplist.keys())
         skiplist.sort( key=lambda fileitem: self.tinfoil.cooker.collection.calc_bbfile_priority(fileitem) )
         skiplist.reverse()
         for fn in skiplist:
@@ -275,7 +275,7 @@ Lists recipes with the bbappends that apply to them as subitems.
 
     def show_appends_for_skipped(self):
         filenames = [os.path.basename(f)
-                    for f in self.tinfoil.cooker.skiplist.iterkeys()]
+                    for f in self.tinfoil.cooker.skiplist.keys()]
         return self.show_appends_output(filenames, None, " (skipped)")
 
     def show_appends_output(self, filenames, best_filename, name_suffix = ''):
diff --git a/lib/codegen.py b/lib/codegen.py
index be772d5..62a6748 100644
--- a/lib/codegen.py
+++ b/lib/codegen.py
@@ -214,11 +214,11 @@ class SourceGenerator(NodeVisitor):
                 paren_or_comma()
                 self.write(keyword.arg + '=')
                 self.visit(keyword.value)
-            if node.starargs is not None:
+            if hasattr(node, 'starargs') and node.starargs is not None:
                 paren_or_comma()
                 self.write('*')
                 self.visit(node.starargs)
-            if node.kwargs is not None:
+            if hasattr(node, 'kwargs') and node.kwargs is not None:
                 paren_or_comma()
                 self.write('**')
                 self.visit(node.kwargs)
@@ -379,11 +379,11 @@ class SourceGenerator(NodeVisitor):
             write_comma()
             self.write(keyword.arg + '=')
             self.visit(keyword.value)
-        if node.starargs is not None:
+        if hasattr(node, 'starargs') and node.starargs is not None:
             write_comma()
             self.write('*')
             self.visit(node.starargs)
-        if node.kwargs is not None:
+        if hasattr(node, 'kwargs') and node.kwargs is not None:
             write_comma()
             self.write('**')
             self.visit(node.kwargs)
diff --git a/lib/ply/yacc.py b/lib/ply/yacc.py
index 6168fd9..d50886e 100644
--- a/lib/ply/yacc.py
+++ b/lib/ply/yacc.py
@@ -195,6 +195,8 @@ class YaccProduction:
         self.lexer = None
         self.parser= None
     def __getitem__(self,n):
+        if isinstance(n,slice):
+            return [self[i] for i in range(*(n.indices(len(self.slice))))]
         if n >= 0: return self.slice[n].value
         else: return self.stack[n].value
 
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 2a86184..495d09f 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -260,7 +260,7 @@ class PRData(object):
         self.connection.close()
 
     def __getitem__(self,tblname):
-        if not isinstance(tblname, basestring):
+        if not isinstance(tblname, str):
             raise TypeError("tblname argument must be a string, not '%s'" %
                             type(tblname))
         if tblname in self._tables:
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 8cec9f8..cafcc82 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -1,10 +1,10 @@
 import os,sys,logging
 import signal, time
-from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
+from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 import threading
-import Queue
+import queue
 import socket
-import StringIO
+import io
 
 try:
     import sqlite3
@@ -64,7 +64,7 @@ class PRServer(SimpleXMLRPCServer):
         self.register_function(self.importone, "importone")
         self.register_introspection_functions()
 
-        self.requestqueue = Queue.Queue()
+        self.requestqueue = queue.Queue()
         self.handlerthread = threading.Thread(target = self.process_request_thread)
         self.handlerthread.daemon = False
 
@@ -83,7 +83,7 @@ class PRServer(SimpleXMLRPCServer):
         while not self.quit:
             try:
                 (request, client_address) = self.requestqueue.get(True, 30)
-            except Queue.Empty:
+            except queue.Empty:
                 self.table.sync_if_dirty()
                 continue
             try:
@@ -126,7 +126,7 @@ class PRServer(SimpleXMLRPCServer):
         Returns None if the database engine does not support dumping to
         script or if some other error is encountered in processing.
         """
-        buff = StringIO.StringIO()
+        buff = io.StringIO()
         try:
             self.table.sync()
             self.table.dump_db(buff)
@@ -420,7 +420,7 @@ class PRServiceConfigError(Exception):
 def auto_start(d):
     global singleton
 
-    host_params = filter(None, (d.getVar('PRSERV_HOST', True) or '').split(':'))
+    host_params = list(filter(None, (d.getVar('PRSERV_HOST', True) or '').split(':')))
     if not host_params:
         return None
 
-- 
2.5.0


