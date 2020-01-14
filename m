Return-Path: <frazer.clews@codethink.co.uk>
X-Greylist: delayed 2640 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 14 Jan 2020 15:27:13 UTC
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
	by mail.openembedded.org (Postfix) with ESMTP id D5E587BEDF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jan 2020 15:27:13 +0000 (UTC)
Received: from [167.98.27.226] (helo=localhost.co.uk)
	by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1irNPV-0004dY-Bf; Tue, 14 Jan 2020 14:43:13 +0000
From: frazer.clews@codethink.co.uk
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jan 2020 14:43:03 +0000
Message-Id: <20200114144303.163316-1-frazer.clews@codethink.co.uk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 14 Jan 2020 22:30:13 +0000
Subject: [PATCH] lib: remove unused imports
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
X-List-Received-Date: Tue, 14 Jan 2020 15:27:14 -0000
Content-Transfer-Encoding: 8bit

From: Frazer Clews <frazer.clews@codethink.co.uk>

removed unused imports which made the code harder to read, and slightly
but less efficient

Signed-off-by: Frazer Clews <frazer.clews@codethink.co.uk>
---
 lib/bb/COW.py                                 |  1 -
 lib/bb/build.py                               |  1 -
 lib/bb/cache.py                               |  1 -
 lib/bb/checksum.py                            |  1 -
 lib/bb/codeparser.py                          | 26 ++-----------------
 lib/bb/cooker.py                              |  4 ---
 lib/bb/event.py                               |  3 +--
 lib/bb/exceptions.py                          |  1 -
 lib/bb/fetch2/bzr.py                          |  2 --
 lib/bb/fetch2/clearcase.py                    |  1 -
 lib/bb/fetch2/cvs.py                          |  1 -
 lib/bb/fetch2/gitannex.py                     |  2 --
 lib/bb/fetch2/gitsm.py                        |  1 -
 lib/bb/fetch2/hg.py                           |  2 --
 lib/bb/fetch2/npm.py                          |  1 -
 lib/bb/fetch2/osc.py                          |  2 --
 lib/bb/fetch2/perforce.py                     |  1 -
 lib/bb/fetch2/ssh.py                          |  2 --
 lib/bb/fetch2/svn.py                          |  2 --
 lib/bb/fetch2/wget.py                         |  3 ---
 lib/bb/monitordisk.py                         |  2 +-
 lib/bb/msg.py                                 |  2 --
 lib/bb/parse/ast.py                           |  4 ---
 lib/bb/parse/parse_py/BBHandler.py            |  2 --
 lib/bb/progress.py                            |  1 -
 lib/bb/runqueue.py                            |  4 +--
 lib/bb/server/process.py                      |  1 -
 lib/bb/server/xmlrpcclient.py                 |  3 ---
 lib/bb/server/xmlrpcserver.py                 |  3 ---
 lib/bb/tests/cooker.py                        |  1 -
 lib/bb/tests/cow.py                           |  2 +-
 lib/bb/tests/fetch.py                         |  2 --
 lib/bb/tests/runqueue.py                      |  1 -
 lib/bb/tinfoil.py                             |  4 +--
 lib/bb/ui/knotty.py                           |  1 -
 lib/bb/ui/ncurses.py                          |  3 +--
 lib/bb/ui/taskexp.py                          |  2 --
 lib/bb/utils.py                               |  1 -
 lib/bs4/builder/_html5lib.py                  |  1 -
 lib/bs4/dammit.py                             |  8 ------
 lib/bs4/element.py                            |  1 -
 lib/bs4/testing.py                            |  1 -
 lib/bs4/tests/test_docs.py                    |  4 ---
 lib/bs4/tests/test_htmlparser.py              |  1 -
 lib/bs4/tests/test_lxml.py                    |  8 +-----
 lib/bs4/tests/test_soup.py                    |  6 +----
 lib/bs4/tests/test_tree.py                    | 11 ++------
 lib/hashserv/client.py                        |  1 -
 lib/layerindexlib/cooker.py                   |  3 +--
 lib/layerindexlib/plugin.py                   |  3 ---
 lib/layerindexlib/tests/cooker.py             |  3 ---
 lib/layerindexlib/tests/layerindexobj.py      |  6 -----
 lib/layerindexlib/tests/restapi.py            |  3 ---
 lib/toaster/bldcollector/urls.py              |  2 +-
 lib/toaster/bldcollector/views.py             |  8 ------
 lib/toaster/bldcontrol/admin.py               |  1 -
 lib/toaster/bldcontrol/bbcontroller.py        |  4 +--
 .../bldcontrol/localhostbecontroller.py       | 11 +++-----
 .../management/commands/checksettings.py      |  4 +--
 lib/toaster/bldcontrol/models.py              |  3 +--
 .../orm/management/commands/lsupdates.py      |  2 +-
 .../orm/migrations/0011_delete_layersource.py |  2 +-
 .../tests/browser/selenium_helpers_base.py    |  1 -
 .../tests/browser/test_project_config_page.py |  3 ---
 .../tests/functional/test_functional_basic.py |  1 -
 lib/toaster/toastergui/api.py                 |  3 ---
 lib/toaster/toastergui/tables.py              |  9 ++-----
 .../objects_to_dictionaries_filter.py         |  1 -
 .../toastergui/templatetags/projecttags.py    |  2 +-
 lib/toaster/toastergui/urls.py                |  5 ++--
 lib/toaster/toastergui/views.py               |  9 +++----
 .../management/commands/builddelete.py        |  4 +--
 .../management/commands/buildimport.py        |  6 ++---
 .../management/commands/buildslist.py         |  3 +--
 74 files changed, 36 insertions(+), 205 deletions(-)

diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index d26e9819..bc20ce38 100644
--- a/lib/bb/COW.py
+++ b/lib/bb/COW.py
@@ -10,7 +10,6 @@
 
 
 import copy
-import types
 ImmutableTypes = (
     bool,
     complex,
diff --git a/lib/bb/build.py b/lib/bb/build.py
index 3d9cc10c..b6d23e68 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -15,7 +15,6 @@
 import os
 import sys
 import logging
-import shlex
 import glob
 import time
 import stat
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index ead8abc5..a5aaf3b9 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -17,7 +17,6 @@
 #
 
 import os
-import sys
 import logging
 import pickle
 from collections import defaultdict
diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 677020f4..1d50a264 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -9,7 +9,6 @@ import glob
 import operator
 import os
 import stat
-import pickle
 import bb.utils
 import logging
 from bb.cache import MultiProcessCache
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index fd2c4734..25a7ac69 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -25,13 +25,11 @@ import ast
 import sys
 import codegen
 import logging
-import pickle
 import bb.pysh as pysh
-import os.path
 import bb.utils, bb.data
 import hashlib
 from itertools import chain
-from bb.pysh import pyshyacc, pyshlex, sherrors
+from bb.pysh import pyshyacc, pyshlex
 from bb.cache import MultiProcessCache
 
 logger = logging.getLogger('BitBake.CodeParser')
@@ -58,30 +56,10 @@ def check_indent(codestr):
 
     return codestr
 
-
-# Basically pickle, in python 2.7.3 at least, does badly with data duplication 
-# upon pickling and unpickling. Combine this with duplicate objects and things
-# are a mess.
-#
-# When the sets are originally created, python calls intern() on the set keys
-# which significantly improves memory usage. Sadly the pickle/unpickle process
-# doesn't call intern() on the keys and results in the same strings being duplicated
-# in memory. This also means pickle will save the same string multiple times in
-# the cache file.
-#
-# By having shell and python cacheline objects with setstate/getstate, we force
-# the object creation through our own routine where we can call intern (via internSet).
-#
-# We also use hashable frozensets and ensure we use references to these so that
-# duplicates can be removed, both in memory and in the resulting pickled data.
-#
-# By playing these games, the size of the cache file shrinks dramatically
-# meaning faster load times and the reloaded cache files also consume much less
-# memory. Smaller cache files, faster load times and lower memory usage is good.
-#
 # A custom getstate/setstate using tuples is actually worth 15% cachesize by
 # avoiding duplication of the attribute names!
 
+
 class SetCache(object):
     def __init__(self):
         self.setcache = {}
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b74affa7..3d65b0cb 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -10,7 +10,6 @@
 #
 
 import sys, os, glob, os.path, re, time
-import atexit
 import itertools
 import logging
 import multiprocessing
@@ -18,14 +17,11 @@ import sre_constants
 import threading
 from io import StringIO, UnsupportedOperation
 from contextlib import closing
-from functools import wraps
 from collections import defaultdict, namedtuple
 import bb, bb.exceptions, bb.command
 from bb import utils, data, parse, event, cache, providers, taskdata, runqueue, build
 import queue
 import signal
-import subprocess
-import errno
 import prserv.serv
 import pyinotify
 import json
diff --git a/lib/bb/event.py b/lib/bb/event.py
index d44621ed..42143e74 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -10,8 +10,7 @@ BitBake build tools.
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import os, sys
-import warnings
+import sys
 import pickle
 import logging
 import atexit
diff --git a/lib/bb/exceptions.py b/lib/bb/exceptions.py
index ecbad599..321cbf64 100644
--- a/lib/bb/exceptions.py
+++ b/lib/bb/exceptions.py
@@ -4,7 +4,6 @@
 
 import inspect
 import traceback
-import bb.namedtuple_with_abc
 from collections import namedtuple
 
 
diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
index c56d8753..566ace9f 100644
--- a/lib/bb/fetch2/bzr.py
+++ b/lib/bb/fetch2/bzr.py
@@ -14,8 +14,6 @@ BitBake 'Fetch' implementation for bzr.
 #
 
 import os
-import sys
-import logging
 import bb
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index ad2f3edc..49d7ae1b 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -49,7 +49,6 @@ User credentials:
 #
 
 import os
-import sys
 import shutil
 import bb
 from   bb.fetch2 import FetchMethod
diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
index 1b35ba4c..29123a48 100644
--- a/lib/bb/fetch2/cvs.py
+++ b/lib/bb/fetch2/cvs.py
@@ -14,7 +14,6 @@ BitBake build tools.
 #
 
 import os
-import logging
 import bb
 from bb.fetch2 import FetchMethod, FetchError, MissingParameterError, logger
 from bb.fetch2 import runfetchcmd
diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index 1d497dcb..80a808d8 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -8,11 +8,9 @@ BitBake 'Fetch' git annex implementation
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import os
 import bb
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
-from   bb.fetch2 import logger
 
 class GitANNEX(Git):
     def supports(self, ud, d):
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index c622771d..aa121cbe 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -24,7 +24,6 @@ from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 from   bb.fetch2 import Fetch
-from   bb.fetch2 import BBFetchException
 
 class GitSM(Git):
     def supports(self, ud, d):
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index e21115de..8f503701 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -13,8 +13,6 @@ BitBake 'Fetch' implementation for mercurial DRCS (hg).
 #
 
 import os
-import sys
-import logging
 import bb
 import errno
 from bb.fetch2 import FetchMethod
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 9700e610..be21399e 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -20,7 +20,6 @@ Usage in the recipe:
 """
 
 import os
-import sys
 import urllib.request, urllib.parse, urllib.error
 import json
 import subprocess
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index 3e567155..f55db6f7 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -7,8 +7,6 @@ Based on the svn "Fetch" implementation.
 
 """
 
-import  os
-import  sys
 import logging
 import  bb
 from    bb.fetch2 import FetchMethod
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 54d001ec..b2ac11ec 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -11,7 +11,6 @@ BitBake 'Fetch' implementation for perforce
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import os
-import logging
 import bb
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index f5be060c..34debe39 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -32,8 +32,6 @@ IETF secsh internet draft:
 
 import re, os
 from   bb.fetch2 import FetchMethod
-from   bb.fetch2 import FetchError
-from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
 
 
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 96d666ba..6c8caf5f 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -11,8 +11,6 @@ BitBake 'Fetch' implementation for svn.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import os
-import sys
-import logging
 import bb
 import re
 from   bb.fetch2 import FetchMethod
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 725586d2..72bc6c8f 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -14,9 +14,7 @@ BitBake build tools.
 
 import re
 import tempfile
-import subprocess
 import os
-import logging
 import errno
 import bb
 import bb.progress
@@ -27,7 +25,6 @@ from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
-from   bb.fetch2 import FetchConnectionCache
 from   bb.utils import export_proxies
 from   bs4 import BeautifulSoup
 from   bs4 import SoupStrainer
diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index 1a25b004..e7c07264 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import os, logging, re, sys
+import os, logging, re
 import bb
 logger = logging.getLogger("BitBake.Monitor")
 
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 6216eb3b..33c0e2fa 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -13,9 +13,7 @@ Message handling infrastructure for bitbake
 import sys
 import copy
 import logging
-import collections
 from itertools import groupby
-import warnings
 import bb
 import bb.event
 
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index f0911e6f..362c1a39 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -9,11 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import re
-import string
-import logging
 import bb
-import itertools
 from bb import methodpool
 from bb.parse import logger
 
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 6f7cf82b..6e216eff 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -13,9 +13,7 @@
 #
 
 import re, bb, os
-import logging
 import bb.build, bb.utils
-from bb import data
 
 from . import ConfHandler
 from .. import resolve_file, ast, logger, ParseError
diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index 4022caa7..9c755b7f 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -7,7 +7,6 @@ BitBake progress handling code
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import sys
 import re
 import time
 import inspect
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index d7186e85..71108eee 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -12,14 +12,12 @@ Handles preparation and execution of a queue of tasks
 import copy
 import os
 import sys
-import signal
 import stat
-import fcntl
 import errno
 import logging
 import re
 import bb
-from bb import msg, data, event
+from bb import msg, event
 from bb import monitordisk
 import subprocess
 import pickle
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 69aae626..5b1d22cb 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -27,7 +27,6 @@ import re
 import datetime
 import bb.server.xmlrpcserver
 from bb import daemonize
-from multiprocessing import queues
 
 logger = logging.getLogger('BitBake')
 
diff --git a/lib/bb/server/xmlrpcclient.py b/lib/bb/server/xmlrpcclient.py
index c054c3c8..442ea7b2 100644
--- a/lib/bb/server/xmlrpcclient.py
+++ b/lib/bb/server/xmlrpcclient.py
@@ -7,9 +7,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import os
-import sys
-
 import socket
 import http.client
 import xmlrpc.client
diff --git a/lib/bb/server/xmlrpcserver.py b/lib/bb/server/xmlrpcserver.py
index 54fa32f5..2fa71be6 100644
--- a/lib/bb/server/xmlrpcserver.py
+++ b/lib/bb/server/xmlrpcserver.py
@@ -7,9 +7,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import os
-import sys
-
 import hashlib
 import time
 import inspect
diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index 090916e9..74c903f0 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -5,7 +5,6 @@
 #
 
 import unittest
-import tempfile
 import os
 import bb, bb.cooker
 import re
diff --git a/lib/bb/tests/cow.py b/lib/bb/tests/cow.py
index b4af4bbc..bf6e79fc 100644
--- a/lib/bb/tests/cow.py
+++ b/lib/bb/tests/cow.py
@@ -7,7 +7,7 @@
 #
 
 import unittest
-import os
+
 
 class COWTestCase(unittest.TestCase):
     """
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 83fad3ff..f29631ec 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -9,11 +9,9 @@
 import unittest
 import hashlib
 import tempfile
-import subprocess
 import collections
 import os
 from bb.fetch2 import URI
-from bb.fetch2 import FetchMethod
 import bb
 
 def skipIfNoNetwork():
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 20c88ac3..4ba12a07 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -7,7 +7,6 @@
 #
 
 import unittest
-import bb
 import os
 import tempfile
 import subprocess
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 0a1b9130..0bd78363 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -21,8 +21,8 @@ import bb.taskdata
 import bb.utils
 import bb.command
 import bb.remotedata
-from bb.cookerdata import CookerConfiguration, ConfigParameters
-from bb.main import setup_bitbake, BitBakeConfigParameters, BBMainException
+from bb.cookerdata import CookerConfiguration
+from bb.main import setup_bitbake, BitBakeConfigParameters
 import bb.fetch2
 
 
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index c6abb2a1..19008a4e 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -12,7 +12,6 @@ from __future__ import division
 
 import os
 import sys
-import xmlrpc.client as xmlrpclib
 import logging
 import progressbar
 import signal
diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index c422732b..49569e37 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -37,7 +37,7 @@
 
 
 import logging
-import os, sys, itertools, time, subprocess
+import os, sys, itertools, time
 
 try:
     import curses
@@ -46,7 +46,6 @@ except ImportError:
 
 import bb
 import xmlrpc.client
-from bb import ui
 from bb.ui import uihelper
 
 parsespin = itertools.cycle( r'|/-\\' )
diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 50a943cd..7895102b 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -11,10 +11,8 @@ import sys
 import gi
 gi.require_version('Gtk', '3.0')
 from gi.repository import Gtk, Gdk, GObject
-from multiprocessing import Queue
 import threading
 from xmlrpc import client
-import time
 import bb
 import bb.event
 
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index d65265c4..06c8819d 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -24,7 +24,6 @@ import fnmatch
 import traceback
 import errno
 import signal
-import ast
 import collections
 import copy
 from subprocess import getstatusoutput
diff --git a/lib/bs4/builder/_html5lib.py b/lib/bs4/builder/_html5lib.py
index 2b7a70aa..4091ce88 100644
--- a/lib/bs4/builder/_html5lib.py
+++ b/lib/bs4/builder/_html5lib.py
@@ -2,7 +2,6 @@ __all__ = [
     'HTML5TreeBuilder',
     ]
 
-from pdb import set_trace
 import warnings
 from bs4.builder import (
     PERMISSIVE,
diff --git a/lib/bs4/dammit.py b/lib/bs4/dammit.py
index 805aa908..7ad9e0dd 100644
--- a/lib/bs4/dammit.py
+++ b/lib/bs4/dammit.py
@@ -8,12 +8,10 @@ XML or HTML to reflect a new encoding; that's the tree builder's job.
 """
 __license__ = "MIT"
 
-from pdb import set_trace
 import codecs
 from html.entities import codepoint2name
 import re
 import logging
-import string
 
 # Import a library to autodetect character encodings.
 chardet_type = None
@@ -38,12 +36,6 @@ except ImportError:
         def chardet_dammit(s):
             return None
 
-# Available from http://cjkpython.i18n.org/.
-try:
-    import iconv_codec
-except ImportError:
-    pass
-
 xml_encoding_re = re.compile(
     r'^<\?.*encoding=[\'"](.*?)[\'"].*\?>'.encode(), re.I)
 html_meta_re = re.compile(
diff --git a/lib/bs4/element.py b/lib/bs4/element.py
index 3775a604..68be42d1 100644
--- a/lib/bs4/element.py
+++ b/lib/bs4/element.py
@@ -1,6 +1,5 @@
 __license__ = "MIT"
 
-from pdb import set_trace
 import collections.abc
 import re
 import sys
diff --git a/lib/bs4/testing.py b/lib/bs4/testing.py
index 3a2f260e..953bca8e 100644
--- a/lib/bs4/testing.py
+++ b/lib/bs4/testing.py
@@ -4,7 +4,6 @@ __license__ = "MIT"
 
 import pickle
 import copy
-import functools
 import unittest
 from unittest import TestCase
 from bs4 import BeautifulSoup
diff --git a/lib/bs4/tests/test_docs.py b/lib/bs4/tests/test_docs.py
index 5b9f6770..d1d76a33 100644
--- a/lib/bs4/tests/test_docs.py
+++ b/lib/bs4/tests/test_docs.py
@@ -7,19 +7,15 @@ __all__ = [
     'additional_tests',
     ]
 
-import atexit
 import doctest
-import os
 #from pkg_resources import (
 #    resource_filename, resource_exists, resource_listdir, cleanup_resources)
-import unittest
 
 DOCTEST_FLAGS = (
     doctest.ELLIPSIS |
     doctest.NORMALIZE_WHITESPACE |
     doctest.REPORT_NDIFF)
 
-
 # def additional_tests():
 #     "Run the doc tests (README.txt and docs/*, if any exist)"
 #     doctest_files = [
diff --git a/lib/bs4/tests/test_htmlparser.py b/lib/bs4/tests/test_htmlparser.py
index b45e35f9..30a25e67 100644
--- a/lib/bs4/tests/test_htmlparser.py
+++ b/lib/bs4/tests/test_htmlparser.py
@@ -1,7 +1,6 @@
 """Tests to ensure that the html.parser tree builder generates good
 trees."""
 
-from pdb import set_trace
 import pickle
 from bs4.testing import SoupTest, HTMLTreeBuilderSmokeTest
 from bs4.builder import HTMLParserTreeBuilder
diff --git a/lib/bs4/tests/test_lxml.py b/lib/bs4/tests/test_lxml.py
index 6c2a1d73..6b6cdd07 100644
--- a/lib/bs4/tests/test_lxml.py
+++ b/lib/bs4/tests/test_lxml.py
@@ -1,6 +1,5 @@
 """Tests to ensure that the lxml tree builder generates good trees."""
 
-import re
 import warnings
 
 try:
@@ -14,13 +13,8 @@ except ImportError as e:
 if LXML_PRESENT:
     from bs4.builder import LXMLTreeBuilder, LXMLTreeBuilderForXML
 
-from bs4 import (
-    BeautifulSoup,
-    BeautifulStoneSoup,
-    )
-from bs4.element import Comment, Doctype, SoupStrainer
+from bs4 import BeautifulStoneSoup
 from bs4.testing import skipIf
-from bs4.tests import test_htmlparser
 from bs4.testing import (
     HTMLTreeBuilderSmokeTest,
     XMLTreeBuilderSmokeTest,
diff --git a/lib/bs4/tests/test_soup.py b/lib/bs4/tests/test_soup.py
index f87949e3..6ad3cb37 100644
--- a/lib/bs4/tests/test_soup.py
+++ b/lib/bs4/tests/test_soup.py
@@ -1,16 +1,12 @@
 # -*- coding: utf-8 -*-
 """Tests of Beautiful Soup as a whole."""
 
-from pdb import set_trace
 import logging
 import unittest
 import sys
 import tempfile
 
-from bs4 import (
-    BeautifulSoup,
-    BeautifulStoneSoup,
-)
+from bs4 import BeautifulSoup
 from bs4.element import (
     CharsetMetaAttributeValue,
     ContentMetaAttributeValue,
diff --git a/lib/bs4/tests/test_tree.py b/lib/bs4/tests/test_tree.py
index 6d3e67f3..8e5c6642 100644
--- a/lib/bs4/tests/test_tree.py
+++ b/lib/bs4/tests/test_tree.py
@@ -9,16 +9,12 @@ same markup, but all Beautiful Soup trees can be traversed with the
 methods tested here.
 """
 
-from pdb import set_trace
 import copy
 import pickle
 import re
 import warnings
 from bs4 import BeautifulSoup
-from bs4.builder import (
-    builder_registry,
-    HTMLParserTreeBuilder,
-)
+from bs4.builder import builder_registry
 from bs4.element import (
     PY3K,
     CData,
@@ -29,10 +25,7 @@ from bs4.element import (
     SoupStrainer,
     Tag,
 )
-from bs4.testing import (
-    SoupTest,
-    skipIf,
-)
+from bs4.testing import SoupTest
 
 XML_BUILDER_PRESENT = (builder_registry.lookup("xml") is not None)
 LXML_PRESENT = (builder_registry.lookup("lxml") is not None)
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index ae0cce9d..46085d64 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -3,7 +3,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from contextlib import closing
 import json
 import logging
 import socket
diff --git a/lib/layerindexlib/cooker.py b/lib/layerindexlib/cooker.py
index 604a9611..4ce397d8 100644
--- a/lib/layerindexlib/cooker.py
+++ b/lib/layerindexlib/cooker.py
@@ -4,9 +4,8 @@
 #
 
 import logging
-import json
 
-from collections import OrderedDict, defaultdict
+from collections import defaultdict
 
 from urllib.parse import unquote, urlparse
 
diff --git a/lib/layerindexlib/plugin.py b/lib/layerindexlib/plugin.py
index 7015a1af..cadda36c 100644
--- a/lib/layerindexlib/plugin.py
+++ b/lib/layerindexlib/plugin.py
@@ -7,10 +7,7 @@
 #   Plugin base class
 #   Utility Functions for working on layerindex data
 
-import argparse
 import logging
-import os
-import bb.msg
 
 logger = logging.getLogger('BitBake.layerindexlib.plugin')
 
diff --git a/lib/layerindexlib/tests/cooker.py b/lib/layerindexlib/tests/cooker.py
index 1fa102e6..1d0685e0 100644
--- a/lib/layerindexlib/tests/cooker.py
+++ b/lib/layerindexlib/tests/cooker.py
@@ -3,15 +3,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import unittest
-import tempfile
 import os
 import bb
 
 import layerindexlib
 from layerindexlib.tests.common import LayersTest
 
-import logging
 
 class LayerIndexCookerTest(LayersTest):
 
diff --git a/lib/layerindexlib/tests/layerindexobj.py b/lib/layerindexlib/tests/layerindexobj.py
index 0c5ec888..de1e4746 100644
--- a/lib/layerindexlib/tests/layerindexobj.py
+++ b/lib/layerindexlib/tests/layerindexobj.py
@@ -3,14 +3,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import unittest
-import tempfile
-import os
-import bb
-
 from layerindexlib.tests.common import LayersTest
 
-import logging
 
 class LayerIndexObjectsTest(LayersTest):
     def setUp(self):
diff --git a/lib/layerindexlib/tests/restapi.py b/lib/layerindexlib/tests/restapi.py
index 6d8dc005..e5ccafe5 100644
--- a/lib/layerindexlib/tests/restapi.py
+++ b/lib/layerindexlib/tests/restapi.py
@@ -4,14 +4,11 @@
 #
 
 import unittest
-import tempfile
 import os
-import bb
 
 import layerindexlib
 from layerindexlib.tests.common import LayersTest
 
-import logging
 
 def skipIfNoNetwork():
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
diff --git a/lib/toaster/bldcollector/urls.py b/lib/toaster/bldcollector/urls.py
index 8eb1e34a..efd67a81 100644
--- a/lib/toaster/bldcollector/urls.py
+++ b/lib/toaster/bldcollector/urls.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.conf.urls import include, url
+from django.conf.urls import url
 
 import bldcollector.views
 
diff --git a/lib/toaster/bldcollector/views.py b/lib/toaster/bldcollector/views.py
index c708b415..6d9227cd 100644
--- a/lib/toaster/bldcollector/views.py
+++ b/lib/toaster/bldcollector/views.py
@@ -6,16 +6,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.views.decorators.cache import cache_control
 from django.core.urlresolvers import reverse
-from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseBadRequest, HttpResponse
-from django.utils import timezone
-from django.utils.html import escape
-from datetime import timedelta
-from django.utils import formats
-from toastergui.templatetags.projecttags import json as jsonfilter
-import json
 import os
 import tempfile
 import subprocess
diff --git a/lib/toaster/bldcontrol/admin.py b/lib/toaster/bldcontrol/admin.py
index e85c30ed..1754bc11 100644
--- a/lib/toaster/bldcontrol/admin.py
+++ b/lib/toaster/bldcontrol/admin.py
@@ -3,7 +3,6 @@
 #
 
 from django.contrib import admin
-from django.contrib.admin.filters import RelatedFieldListFilter
 from .models import BuildEnvironment
 
 class BuildEnvironmentAdmin(admin.ModelAdmin):
diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 301df188..71c288df 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -8,10 +8,8 @@
 
 import os
 import sys
-import re
-from django.db import transaction
 from django.db.models import Q
-from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget, BRBitbake
+from bldcontrol.models import BuildEnvironment, BRLayer, BRBitbake
 
 # load Bitbake components
 path = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 39ea736b..75674ccb 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -7,27 +7,24 @@
 #
 
 import os
-import sys
 import re
 import shutil
 import time
-from django.db import transaction
-from django.db.models import Q
-from bldcontrol.models import BuildEnvironment, BuildRequest, BRLayer, BRVariable, BRTarget, BRBitbake, Build
-from orm.models import CustomImageRecipe, Layer, Layer_Version, Project, ProjectLayer, ToasterSetting
+from bldcontrol.models import BuildEnvironment, BuildRequest, Build
+from orm.models import CustomImageRecipe, Layer, Layer_Version, Project, ToasterSetting
 from orm.models import signal_runbuilds
 import subprocess
 
 from toastermain import settings
 
-from bldcontrol.bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, BitbakeController
+from bldcontrol.bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException
 
 import logging
 logger = logging.getLogger("toaster")
 
 install_dir = os.environ.get('TOASTER_DIR')
 
-from pprint import pprint, pformat
+from pprint import pformat
 
 class LocalhostBEController(BuildEnvironmentController):
     """ Implementation of the BuildEnvironmentController for the localhost;
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index fe2c4dc2..cfcd4a00 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -2,11 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.management.base import BaseCommand, CommandError
-from django.db import transaction
+from django.core.management.base import BaseCommand
 
 from django.core.management import call_command
-from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException
 from bldcontrol.models import BuildRequest, BuildEnvironment, BRError
 from orm.models import ToasterSetting, Build, Layer
 
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index bcffcf5e..0d30fd9b 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -4,9 +4,8 @@
 
 from __future__ import unicode_literals
 from django.db import models
-from django.core.validators import MaxValueValidator, MinValueValidator
 from django.utils.encoding import force_text
-from orm.models import Project, ProjectLayer, ProjectVariable, ProjectTarget, Build, Layer_Version
+from orm.models import Project, Build, Layer_Version
 
 import logging
 logger = logging.getLogger("toaster")
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 5b5abbb2..a4dbcaa7 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -8,7 +8,7 @@
 
 from django.core.management.base import BaseCommand
 
-from orm.models import LayerSource, Layer, Release, Layer_Version
+from orm.models import Layer, Release, Layer_Version
 from orm.models import LayerVersionDependency, Machine, Recipe
 from orm.models import Distro
 from orm.models import ToasterSetting
diff --git a/lib/toaster/orm/migrations/0011_delete_layersource.py b/lib/toaster/orm/migrations/0011_delete_layersource.py
index 75506961..3f3a2e16 100644
--- a/lib/toaster/orm/migrations/0011_delete_layersource.py
+++ b/lib/toaster/orm/migrations/0011_delete_layersource.py
@@ -1,7 +1,7 @@
 # -*- coding: utf-8 -*-
 from __future__ import unicode_literals
 
-from django.db import migrations, models
+from django.db import migrations
 
 
 class Migration(migrations.Migration):
diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 6c94684e..644d45fe 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -19,7 +19,6 @@ import os
 import time
 import unittest
 
-from django.contrib.staticfiles.testing import StaticLiveServerTestCase
 from selenium import webdriver
 from selenium.webdriver.support.ui import WebDriverWait
 from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
diff --git a/lib/toaster/tests/browser/test_project_config_page.py b/lib/toaster/tests/browser/test_project_config_page.py
index 2816eb90..eaf27a1e 100644
--- a/lib/toaster/tests/browser/test_project_config_page.py
+++ b/lib/toaster/tests/browser/test_project_config_page.py
@@ -7,10 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import re
-
 from django.core.urlresolvers import reverse
-from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 
 from orm.models import BitbakeVersion, Release, Project, ProjectVariable
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/toaster/tests/functional/test_functional_basic.py
index 56c84fba..5683e387 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -7,7 +7,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import time
 import re
 from tests.functional.functional_helpers import SeleniumFunctionalTestCase
 from orm.models import Project
diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 8b49b3ee..a4afc9e7 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -13,7 +13,6 @@ import logging
 import json
 import subprocess
 from collections import Counter
-from shutil import copyfile
 
 from orm.models import Project, ProjectTarget, Build, Layer_Version
 from orm.models import LayerVersionDependency, LayerSource, ProjectLayer
@@ -29,8 +28,6 @@ from django.core.urlresolvers import reverse
 from django.db.models import Q, F
 from django.db import Error
 from toastergui.templatetags.projecttags import filtered_filesizeformat
-from django.utils import timezone
-import pytz
 
 # development/debugging support
 verbose = 2
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index b3ea2227..528dd32b 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -7,15 +7,10 @@
 #
 
 from toastergui.widgets import ToasterTable
-from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
+from orm.models import Recipe, ProjectLayer, Layer_Version, Project
 from orm.models import CustomImageRecipe, Package, Target, Build, LogMessage, Task
 from orm.models import CustomImagePackage, Package_DependencyManager
-from orm.models import Distro
-from django.db.models import Q, Max, Sum, Count, When, Case, Value, IntegerField
-from django.conf.urls import url
-from django.core.urlresolvers import reverse, resolve
-from django.http import HttpResponse
-from django.views.generic import TemplateView
+from django.db.models import Q, Sum, Count, When, Case, Value, IntegerField
 
 from toastergui.tablefilter import TableFilter
 from toastergui.tablefilter import TableFilterActionToggle
diff --git a/lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py b/lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py
index 048d5338..e242234b 100644
--- a/lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py
+++ b/lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py
@@ -3,7 +3,6 @@
 #
 
 from django import template
-import json
 
 register = template.Library()
 
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 1dbab3bd..354b61f0 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from datetime import datetime, timedelta
+from datetime import timedelta
 from os.path import relpath
 import re
 from django import template
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 673d9ae9..d2df4e60 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -6,10 +6,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.conf.urls import include, url
-from django.views.generic import RedirectView, TemplateView
+from django.conf.urls import url
+from django.views.generic import RedirectView
 
-from django.http import HttpResponseBadRequest
 from toastergui import tables
 from toastergui import buildtables
 from toastergui import typeaheads
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index d7acaff8..7fecdaa9 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -20,7 +20,7 @@ from orm.models import TargetKernelFile, TargetSDKFile, Target_Image_File
 from orm.models import BitbakeVersion, CustomImageRecipe
 
 from django.core.urlresolvers import reverse, resolve
-from django.core.exceptions import MultipleObjectsReturned, ObjectDoesNotExist
+from django.core.exceptions import ObjectDoesNotExist
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseNotFound, JsonResponse
 from django.utils import timezone
@@ -664,7 +664,6 @@ def recipe_packages(request, build_id, recipe_id):
     _set_parameters_values(pagesize, orderby, request)
     return response
 
-from django.core.serializers.json import DjangoJSONEncoder
 from django.http import HttpResponse
 def xhr_dirinfo(request, build_id, target_id):
     top = request.GET.get('start', '/')
@@ -1340,7 +1339,7 @@ def json_build(request,build_id):
 
 import toastermain.settings
 
-from orm.models import Project, ProjectLayer, ProjectTarget, ProjectVariable
+from orm.models import Project, ProjectLayer, ProjectVariable
 from bldcontrol.models import  BuildEnvironment
 
 # we have a set of functions if we're in managed mode, or
@@ -1349,10 +1348,8 @@ from bldcontrol.models import  BuildEnvironment
 if True:
     from django.contrib.auth.models import User
     from django.contrib.auth import authenticate, login
-    from django.contrib.auth.decorators import login_required
 
-    from orm.models import LayerSource, ToasterSetting, Release, Machine, LayerVersionDependency
-    from bldcontrol.models import BuildRequest
+    from orm.models import LayerSource, ToasterSetting, Release
 
     import traceback
 
diff --git a/lib/toaster/toastermain/management/commands/builddelete.py b/lib/toaster/toastermain/management/commands/builddelete.py
index c2d773a5..93919dec 100644
--- a/lib/toaster/toastermain/management/commands/builddelete.py
+++ b/lib/toaster/toastermain/management/commands/builddelete.py
@@ -2,12 +2,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.management.base import BaseCommand, CommandError
+from django.core.management.base import BaseCommand
 from django.core.exceptions import ObjectDoesNotExist
 from orm.models import Build
 from django.db import OperationalError
-import os
-
 
 
 class Command(BaseCommand):
diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
index 408ad44e..9af54ec2 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -31,12 +31,10 @@
 
 # ../bitbake/lib/toaster/manage.py buildimport --name=test --path=`pwd` --callback="" --command=import
 
-from django.core.management.base import BaseCommand, CommandError
-from django.core.exceptions import ObjectDoesNotExist
-from orm.models import ProjectManager, Project, Release, ProjectVariable
+from django.core.management.base import BaseCommand
+from orm.models import Project, Release, ProjectVariable
 from orm.models import Layer, Layer_Version, LayerSource, ProjectLayer
 from toastergui.api import scan_layer_content
-from django.db import OperationalError
 
 import os
 import re
diff --git a/lib/toaster/toastermain/management/commands/buildslist.py b/lib/toaster/toastermain/management/commands/buildslist.py
index 1ed20224..3ad5289c 100644
--- a/lib/toaster/toastermain/management/commands/buildslist.py
+++ b/lib/toaster/toastermain/management/commands/buildslist.py
@@ -2,9 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.management.base import BaseCommand, CommandError
+from django.core.management.base import BaseCommand
 from orm.models import Build
-import os
 
 
 
-- 
2.24.1


