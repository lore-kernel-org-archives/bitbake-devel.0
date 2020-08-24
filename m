Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web12.196138.1598280703587326384
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 07:51:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=KAi9lgYn;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: frazerleslieclews@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 83so8611913wme.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OcDfeGQqAhDA9Vdmhu15s5YBH+bCAlNRcQkP9ERyPU=;
        b=KAi9lgYnbeB3XZ+s8D1gHyrN2TT3VpijXUnJtmTljmrSv6n8d4bZ6DKifxL9BH9/GW
         hrNKg6PN/5bNZfM53rRxOdf+bafJGaJJbHdh1gQ7Pjyig2us8k1BYCBHVHNZKhDX6tCK
         dsdcXrdQDbu2CxzEVtv40DwQapROMB1CnWgCQgHvI9ss4Gr6l7TgEkYcalsWRuQwTbeB
         XnqgSrlk1yor7W0IkvxOyIgJAOgwC6V8ohHQlEa12SJWlfcsa4sAOrYra9yovGqYdRjQ
         VZVhKi2bA95FhtrGrx5Y9kIrJxcIexy7GJu9c9/eUAFdQXIMxsdDCJJvEINAejwUca6R
         69iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OcDfeGQqAhDA9Vdmhu15s5YBH+bCAlNRcQkP9ERyPU=;
        b=NDQYIHGV5pzjYGpeIFwEk438un2OdzrTSqX149VCAsPaQokQ3kPSklfGLapFRok4zB
         QEILQEQU6q1TpFDUkl1A+0Fv4yhKDIz/talrgQRh+gVpAR/d3o5qiat1gEJ7OTHS5Ebe
         zkBjzTWXVElK+2wZtuX3UhiKBQVMtnXjvzz7OSdHRq3QRx6lKGfHDdgL6cQjsbxrOt7X
         jvvPWOkgt1b6nOw5FILs+5g7rBkwhFQUV43NY2uUTU/7nmdLcAQ4rTVp/B16h/1+LLWy
         tJb7feom8YYRcg4eKGTP5/3fAAACRXFwgjodoW0KqXL/MuHLUuyLug44BKCfgZRmzx12
         R4tw==
X-Gm-Message-State: AOAM532aHHUwSJfR5demv6qJq6RsH0e35VXk1EmNeJZMeh2f0IJyU19h
	cr1/1quBspmtzpimj1A2XXlbAURRPtpL91pa
X-Google-Smtp-Source: ABdhPJwyQyGz7rVLNBTWVLZ9J/OMZI/ma2kgKz0v9T+ROjPHnsiw+Pz2OZIjT0GkgJC+kWYl4ro6Hg==
X-Received: by 2002:a1c:7502:: with SMTP id o2mr5840099wmc.29.1598280701290;
        Mon, 24 Aug 2020 07:51:41 -0700 (PDT)
Return-Path: <frazerleslieclews@gmail.com>
Received: from DESKTOP-2MBQFFQ.localdomain (host86-136-199-129.range86-136.btcentralplus.com. [86.136.199.129])
        by smtp.gmail.com with ESMTPSA id v29sm24204091wrv.51.2020.08.24.07.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 07:51:40 -0700 (PDT)
From: frazerleslieclews@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Frazer Clews <frazerleslieclews@gmail.com>
Subject: [PATCH] lib: fix most undefined code picked up by pylint
Date: Mon, 24 Aug 2020 15:51:37 +0100
Message-Id: <20200824145137.12318-1-frazerleslieclews@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correctly import, and inherit functions, and variables.
Also fix some typos and remove some Python 2 code that isn't recognised.

Signed-off-by: Frazer Clews <frazerleslieclews@gmail.com>
---
 lib/bb/__init__.py                                |  2 +-
 lib/bb/daemonize.py                               |  2 ++
 lib/bb/data_smart.py                              |  2 +-
 lib/bb/fetch2/osc.py                              |  3 +++
 lib/bb/fetch2/ssh.py                              |  7 +++----
 lib/bb/msg.py                                     |  1 +
 lib/bb/namedtuple_with_abc.py                     | 14 +++-----------
 lib/bb/process.py                                 |  1 +
 lib/bb/server/process.py                          |  1 +
 lib/bb/tests/data.py                              |  1 +
 lib/bb/tinfoil.py                                 |  2 +-
 lib/bb/ui/knotty.py                               |  2 +-
 lib/bb/ui/ncurses.py                              |  2 ++
 lib/bb/ui/uievent.py                              |  6 +++++-
 lib/hashserv/tests.py                             |  1 +
 lib/layerindexlib/__init__.py                     | 15 ++++++++-------
 lib/layerindexlib/cooker.py                       |  7 ++++---
 lib/layerindexlib/restapi.py                      |  6 +++++-
 lib/layerindexlib/tests/restapi.py                |  2 +-
 lib/ply/lex.py                                    |  6 +-----
 lib/ply/yacc.py                                   |  2 +-
 .../tests/functional/functional_helpers.py        |  8 ++++----
 22 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 2c94e10c..888dd5cc 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -93,7 +93,7 @@ class BBLoggerAdapter(logging.LoggerAdapter, BBLoggerMixin):
 
         def __repr__(self):
             logger = self.logger
-            level = getLevelName(logger.getEffectiveLevel())
+            level = logger.getLevelName(logger.getEffectiveLevel())
             return '<%s %s (%s)>' % (self.__class__.__name__, logger.name, level)
 
 logging.LoggerAdapter = BBLoggerAdapter
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
index 8f091efd..3a6cd295 100644
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
 
+logger = logging.getLogger(__name__)
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
 
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 2d88c4e7..60a176ff 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -14,6 +14,7 @@ import sys
 import copy
 import logging
 import logging.config
+import os
 from itertools import groupby
 import bb
 import bb.event
diff --git a/lib/bb/namedtuple_with_abc.py b/lib/bb/namedtuple_with_abc.py
index 646aed6f..e46dbf08 100644
--- a/lib/bb/namedtuple_with_abc.py
+++ b/lib/bb/namedtuple_with_abc.py
@@ -61,17 +61,9 @@ class _NamedTupleABCMeta(ABCMeta):
         return ABCMeta.__new__(mcls, name, bases, namespace)
 
 
-exec(
-    # Python 2.x metaclass declaration syntax
-    """class _NamedTupleABC(object):
-        '''The abstract base class + mix-in for named tuples.'''
-        __metaclass__ = _NamedTupleABCMeta
-        _fields = abstractproperty()""" if version_info[0] < 3 else
-    # Python 3.x metaclass declaration syntax
-    """class _NamedTupleABC(metaclass=_NamedTupleABCMeta):
-        '''The abstract base class + mix-in for named tuples.'''
-        _fields = abstractproperty()"""
-)
+class _NamedTupleABC(metaclass=_NamedTupleABCMeta):
+    '''The abstract base class + mix-in for named tuples.'''
+    _fields = abstractproperty()
 
 
 _namedtuple.abc = _NamedTupleABC
diff --git a/lib/bb/process.py b/lib/bb/process.py
index f36c929d..7c3995cc 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -7,6 +7,7 @@ import signal
 import subprocess
 import errno
 import select
+import bb
 
 logger = logging.getLogger('BitBake.Process')
 
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 65e1eab5..3d4dde58 100644
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
index dccbe0eb..2b770b07 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -738,7 +738,7 @@ class Tinfoil:
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
 
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 6e862950..b34c4368 100644
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
index 77196b40..45157b66 100644
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
@@ -266,8 +267,8 @@ will write out the individual elements split by layer and related components.
                 logger.debug(1, "Store not implemented in %s" % plugin.type)
                 pass
         else:
-            logger.debug(1, "No plugins support %s" % url)
-            raise LayerIndexException("No plugins support %s" % url)
+            logger.debug(1, "No plugins support %s" % indexURI)
+            raise LayerIndexException("No plugins support %s" % indexURI)
 
 
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
index 65b23d08..21ec438a 100644
--- a/lib/layerindexlib/cooker.py
+++ b/lib/layerindexlib/cooker.py
@@ -4,6 +4,7 @@
 #
 
 import logging
+import os
 
 from collections import defaultdict
 
@@ -73,7 +74,7 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
         d = self.layerindex.data
 
         if not branches:
-            raise LayerIndexFetchError("No branches specified for _load_bblayers!")
+            raise layerindexlib.LayerIndexFetchError("No branches specified for _load_bblayers!")
 
         index = layerindexlib.LayerIndexObj()
 
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
index 21fd1441..7023f42f 100644
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
 
@@ -163,7 +167,7 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
                     parsed = _get_json_response(apiurl=up_stripped.geturl(), username=username, password=password, retry=False)
                     logger.debug(1, "%s: retry successful.")
                 else:
-                    raise LayerIndexFetchError('%s: Connection reset by peer.  Is there a firewall blocking your connection?' % apiurl)
+                    raise layerindexlib.LayerIndexFetchError('%s: Connection reset by peer.  Is there a firewall blocking your connection?' % apiurl)
 
             return parsed
 
diff --git a/lib/layerindexlib/tests/restapi.py b/lib/layerindexlib/tests/restapi.py
index e5ccafe5..4646d01f 100644
--- a/lib/layerindexlib/tests/restapi.py
+++ b/lib/layerindexlib/tests/restapi.py
@@ -112,7 +112,7 @@ class LayerIndexWebRestApiTest(LayersTest):
                     break
             else:
                 self.logger.debug(1, "meta-python was not found")
-                self.assetTrue(False)
+                raise self.failureException
 
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
diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toaster/tests/functional/functional_helpers.py
index 455c408e..5c4ea717 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -75,7 +75,7 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
         try:
             table_element = self.get_table_element(table_id)
             element = table_element.find_element_by_link_text(link_text)
-        except NoSuchElementException as e:
+        except self.NoSuchElementException:
             print('no element found')
             raise
         return element
@@ -86,7 +86,7 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
             element_xpath = "//*[@id='" + table_id + "']"
             try:
                 element = self.driver.find_element_by_xpath(element_xpath)
-            except NoSuchElementException as e:
+            except self.NoSuchElementException:
                 raise
             return element
         row = coordinate[0]
@@ -96,7 +96,7 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
             element_xpath = "//*[@id='" + table_id + "']/tbody/tr[" + str(row) + "]"
             try:
                 element = self.driver.find_element_by_xpath(element_xpath)
-            except NoSuchElementException as e:
+            except self.NoSuchElementException:
                 return False
             return element
 #now we are looking for an element with specified X and Y
@@ -105,6 +105,6 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
         element_xpath = "//*[@id='" + table_id + "']/tbody/tr[" + str(row) + "]/td[" + str(column) + "]"
         try:
             element = self.driver.find_element_by_xpath(element_xpath)
-        except NoSuchElementException as e:
+        except self.NoSuchElementException:
             return False
         return element
-- 
2.25.1

