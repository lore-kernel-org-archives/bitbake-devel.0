Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
 by mx.groups.io with SMTP id smtpd.web12.3500.1588780714568327231
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2020 08:58:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=SPF record not found (domain: codethink.co.uk, ip: 78.40.148.184, mailfrom: frazer.clews@codethink.co.uk)
Received: from host86-138-115-188.range86-138.btcentralplus.com ([86.138.115.188] helo=localhost.co.uk)
	by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1jWMRJ-0004pO-Hp; Wed, 06 May 2020 16:58:29 +0100
From: "Frazer Clews" <frazer.clews@codethink.co.uk>
To: bitbake-devel@lists.openembedded.org
Cc: Frazer Clews <frazer.clews@codethink.co.uk>
Subject: [PATCH] WIP: lib: fix undefined code
Date: Wed,  6 May 2020 16:58:08 +0100
Message-Id: <20200506155808.95240-1-frazer.clews@codethink.co.uk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frazer Clews <frazer.clews@codethink.co.uk>

TODO comments are areas I am not too sure about

fix undefined terms which was usually a typo or
not inheriting from self, also remove some old
python 2 code which can't be used

Signed-off-by: Frazer Clews <frazer.clews@codethink.co.uk>
---
 lib/bb/daemonize.py                |  2 ++
 lib/bb/data_smart.py               |  2 +-
 lib/bb/fetch2/osc.py               |  3 +++
 lib/bb/fetch2/ssh.py               |  7 +++----
 lib/bb/process.py                  |  1 +
 lib/bb/server/process.py           |  1 +
 lib/bb/tests/data.py               |  1 +
 lib/bb/tinfoil.py                  |  2 +-
 lib/bb/ui/knotty.py                |  2 +-
 lib/bb/ui/ncurses.py               |  2 ++
 lib/bb/ui/uievent.py               |  6 +++++-
 lib/hashserv/client.py             |  2 +-
 lib/hashserv/tests.py              |  1 +
 lib/layerindexlib/__init__.py      | 17 +++++++++--------
 lib/layerindexlib/cooker.py        |  5 +++--
 lib/layerindexlib/restapi.py       |  4 ++++
 lib/layerindexlib/tests/restapi.py |  2 +-
 lib/ply/lex.py                     |  6 +-----
 lib/ply/yacc.py                    |  2 +-
 19 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index f01e6ec7..c187fcfc 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -14,6 +14,8 @@ import sys
 import io
 import traceback
 
+import bb
+
 def createDaemon(function, logfile):
     """
     Detach a process from the controlling terminal and run it in the
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 7f1b6dcb..c559102c 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -189,7 +189,7 @@ class IncludeHistory(object):
         if self.current.parent:
             self.current = self.current.parent
         else:
-            bb.warn("Include log: Tried to finish '%s' at top level." % filename)
+            bb.warn("Include log: Tried to finish '%s' at top level." % self.filename)
         return False
 
     def emit(self, o, level = 0):
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index 8f091efd..d5f75d7c 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -8,12 +8,15 @@ Based on the svn "Fetch" implementation.
 """
 
 import logging
+import os
 import  bb
 from    bb.fetch2 import FetchMethod
 from    bb.fetch2 import FetchError
 from    bb.fetch2 import MissingParameterError
 from    bb.fetch2 import runfetchcmd
 
+logger = logging.getLogger(__name__) # TODO needed since it can't inherit from __init__, logging may need refactoring like this, similar in other files
+
 class Osc(FetchMethod):
     """Class to fetch a module or modules from Opensuse build server
        repositories."""
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 5e982ecf..2c8557e1 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -31,8 +31,7 @@ IETF secsh internet draft:
 #
 
 import re, os
-from   bb.fetch2 import FetchMethod
-from   bb.fetch2 import runfetchcmd
+from bb.fetch2 import check_network_access, FetchMethod, ParameterError, runfetchcmd
 
 
 __pattern__ = re.compile(r'''
@@ -65,7 +64,7 @@ class SSH(FetchMethod):
 
     def urldata_init(self, urldata, d):
         if 'protocol' in urldata.parm and urldata.parm['protocol'] == 'git':
-            raise bb.fetch2.ParameterError(
+            raise ParameterError(
                 "Invalid protocol - if you wish to fetch from a git " +
                 "repository using ssh, you need to use " +
                 "git:// prefix with protocol=ssh", urldata.url)
@@ -105,7 +104,7 @@ class SSH(FetchMethod):
             dldir
         )
 
-        bb.fetch2.check_network_access(d, cmd, urldata.url)
+        check_network_access(d, cmd, urldata.url)
 
         runfetchcmd(cmd, d)
 
diff --git a/lib/bb/process.py b/lib/bb/process.py
index 2dc472a8..0422a85c 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -7,6 +7,7 @@ import signal
 import subprocess
 import errno
 import select
+import bb
 
 logger = logging.getLogger('BitBake.Process')
 
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 69aae626..1b65ebb5 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -25,6 +25,7 @@ import subprocess
 import errno
 import re
 import datetime
+import pickle
 import bb.server.xmlrpcserver
 from bb import daemonize
 from multiprocessing import queues
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 5f195047..1d4a64b1 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -12,6 +12,7 @@ import bb
 import bb.data
 import bb.parse
 import logging
+import os
 
 class LogRecord():
     def __enter__(self):
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 8c9b6b8c..d48381f4 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -736,7 +736,7 @@ class Tinfoil:
                                 continue
                             if helper.eventHandler(event):
                                 if isinstance(event, bb.build.TaskFailedSilent):
-                                    logger.warning("Logfile for failed setscene task is %s" % event.logfile)
+                                    self.logger.warning("Logfile for failed setscene task is %s" % event.logfile)
                                 elif isinstance(event, bb.build.TaskFailed):
                                     bb.ui.knotty.print_event_log(event, includelogs, loglines, termfilter)
                                 continue
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 87e873d6..a3507afb 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -144,7 +144,7 @@ class TerminalFilter(object):
                 pass
         if not cr:
             try:
-                cr = (env['LINES'], env['COLUMNS'])
+                cr = (os.environ['LINES'], os.environ['COLUMNS'])
             except:
                 cr = (25, 80)
         return cr
diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index da4fbeab..cf1c876a 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -48,6 +48,8 @@ import bb
 import xmlrpc.client
 from bb.ui import uihelper
 
+logger = logging.getLogger(__name__)
+
 parsespin = itertools.cycle( r'|/-\\' )
 
 X = 0
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index 13d0d4a0..8607d052 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -11,9 +11,13 @@ server and queue them for the UI to process. This process must be used to avoid
 client/server deadlocks.
 """
 
-import socket, threading, pickle, collections
+import collections, logging, pickle, socket, threading
 from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 
+import bb
+
+logger = logging.getLogger(__name__)
+
 class BBUIEventQueue:
     def __init__(self, BBServer, clientinfo=("localhost, 0")):
 
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 46085d64..32fa6d1d 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -100,7 +100,7 @@ class Client(object):
                 raise HashConnectionError('Connection closed')
 
             if not l.endswith('\n'):
-                raise HashConnectionError('Bad message %r' % message)
+                raise HashConnectionError('Bad message %r' % msg)
 
             return json.loads(l)
 
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index a5472a99..8cde3cc9 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -9,6 +9,7 @@ from . import create_server, create_client
 import hashlib
 import logging
 import multiprocessing
+import os
 import sys
 import tempfile
 import threading
diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
index 77196b40..9304d148 100644
--- a/lib/layerindexlib/__init__.py
+++ b/lib/layerindexlib/__init__.py
@@ -7,6 +7,7 @@ import datetime
 
 import logging
 import imp
+import os
 
 from collections import OrderedDict
 from layerindexlib.plugin import LayerIndexPluginUrlError
@@ -70,7 +71,7 @@ class LayerIndex():
 
         if self.__class__ != newIndex.__class__ or \
            other.__class__ != newIndex.__class__:
-            raise TypeException("Can not add different types.")
+            raise TypeError("Can not add different types.")
 
         for indexEnt in self.indexes:
             newIndex.indexes.append(indexEnt)
@@ -254,7 +255,7 @@ will write out the individual elements split by layer and related components.
 
         for plugin in self.plugins:
             # Check if the plugin was initialized
-            logger.debug(1, 'Trying %s' % plugin.__class__)
+            logger.debug(1, "Trying %s" % plugin.__class__)
             if not hasattr(plugin, 'type') or not plugin.type:
                 continue
             try:
@@ -266,8 +267,8 @@ will write out the individual elements split by layer and related components.
                 logger.debug(1, "Store not implemented in %s" % plugin.type)
                 pass
         else:
-            logger.debug(1, "No plugins support %s" % url)
-            raise LayerIndexException("No plugins support %s" % url)
+            logger.debug(1, "No plugins support %s" % indexURI) # TODO correct?
+            raise LayerIndexException("No plugins support %s" % indexURI) # TODO correct?
 
 
     def is_empty(self):
@@ -657,7 +658,7 @@ class LayerIndexObj():
             if obj.id in self._index[indexname]:
                 if self._index[indexname][obj.id] == obj:
                     continue
-                raise LayerIndexError('Conflict adding object %s(%s) to index' % (indexname, obj.id))
+                raise LayerIndexException('Conflict adding object %s(%s) to index' % (indexname, obj.id))
             self._index[indexname][obj.id] = obj
 
     def add_raw_element(self, indexname, objtype, rawobjs):
@@ -842,11 +843,11 @@ class LayerIndexObj():
 
         def _resolve_dependencies(layerbranches, ignores, dependencies, invalid):
             for layerbranch in layerbranches:
-                if ignores and layerBranch.layer.name in ignores:
+                if ignores and layerbranch.layer.name in ignores:
                     continue
 
-                for layerdependency in layerbranch.index.layerDependencies_layerBranchId[layerBranch.id]:
-                    deplayerbranch = layerDependency.dependency_layerBranch
+                for layerdependency in layerbranch.index.layerDependencies_layerBranchId[layerbranch.id]:
+                    deplayerbranch = layerdependency.dependency_layerBranch
 
                     if ignores and deplayerbranch.layer.name in ignores:
                         continue
diff --git a/lib/layerindexlib/cooker.py b/lib/layerindexlib/cooker.py
index 65b23d08..39fb3dd4 100644
--- a/lib/layerindexlib/cooker.py
+++ b/lib/layerindexlib/cooker.py
@@ -4,6 +4,7 @@
 #
 
 import logging
+import os
 
 from collections import defaultdict
 
@@ -202,7 +203,7 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
                     try:
                         depDict = bb.utils.explode_dep_versions2(deps)
                     except bb.utils.VersionStringException as vse:
-                        bb.fatal('Error parsing LAYERDEPENDS_%s: %s' % (c, str(vse)))
+                        bb.fatal('Error parsing LAYERDEPENDS_%s: %s' % (collection, str(vse)))
 
                     for dep, oplist in list(depDict.items()):
                         # We need to search ourselves, so use the _ version...
@@ -268,7 +269,7 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
 
                     layer = bb.utils.get_file_layer(realfn[0], self.config_data)
 
-                    depBranchId = collection_layerbranch[layer]
+                    depBranchId = collection[layer]
 
                     recipeId += 1
                     recipe = layerindexlib.Recipe(index, None)
diff --git a/lib/layerindexlib/restapi.py b/lib/layerindexlib/restapi.py
index 21fd1441..ebeb04d4 100644
--- a/lib/layerindexlib/restapi.py
+++ b/lib/layerindexlib/restapi.py
@@ -5,9 +5,13 @@
 
 import logging
 import json
+import os
+
 from urllib.parse import unquote
 from urllib.parse import urlparse
 
+import bb
+
 import layerindexlib
 import layerindexlib.plugin
 
diff --git a/lib/layerindexlib/tests/restapi.py b/lib/layerindexlib/tests/restapi.py
index e5ccafe5..b491a3a5 100644
--- a/lib/layerindexlib/tests/restapi.py
+++ b/lib/layerindexlib/tests/restapi.py
@@ -112,7 +112,7 @@ class LayerIndexWebRestApiTest(LayersTest):
                     break
             else:
                 self.logger.debug(1, "meta-python was not found")
-                self.assetTrue(False)
+                self.assertTrue(False)
 
             # Only check the first element...
             break
diff --git a/lib/ply/lex.py b/lib/ply/lex.py
index 267ec100..182f2e83 100644
--- a/lib/ply/lex.py
+++ b/lib/ply/lex.py
@@ -705,11 +705,7 @@ class LexerReflect(object):
 
         # Sort the functions by line number
         for f in self.funcsym.values():
-            if sys.version_info[0] < 3:
-                f.sort(lambda x,y: cmp(func_code(x[1]).co_firstlineno,func_code(y[1]).co_firstlineno))
-            else:
-                # Python 3.0
-                f.sort(key=lambda x: func_code(x[1]).co_firstlineno)
+            f.sort(key=lambda x: func_code(x[1]).co_firstlineno)
 
         # Sort the strings by regular expression length
         for s in self.strsym.values():
diff --git a/lib/ply/yacc.py b/lib/ply/yacc.py
index 561784f2..46e7dc96 100644
--- a/lib/ply/yacc.py
+++ b/lib/ply/yacc.py
@@ -1205,7 +1205,7 @@ class Production(object):
 
         # Precompute the list of productions immediately following.  Hack. Remove later
         try:
-            p.lr_after = Prodnames[p.prod[n+1]]
+            p.lr_after = self.Prodnames[p.prod[n+1]]
         except (IndexError,KeyError):
             p.lr_after = []
         try:
-- 
2.26.2

