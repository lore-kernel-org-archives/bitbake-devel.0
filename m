Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1RQLem-00035o-U5
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 Nov 2011 17:14:45 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pAFDk9WV019516
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Nov 2011 05:46:09 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Tue, 15 Nov 2011 05:46:09 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 Nov 2011 21:45:39 +0800
Message-ID: <c7fca16d218cd31ab32239b970d57a95b2858532.1321364305.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1321364305.git.liezhi.yang@windriver.com>
References: <cover.1321364305.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [RFC PATCH 1/1] Fix bitbake-runtask
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 15 Nov 2011 16:14:45 -0000
Content-Type: text/plain

Fixes bug [YOCTO #1229]

The bitbake doesn't use bitbake-runtask to excute the task any more,
but bitbake-runtask is a useful tool for excuting the task without
the scheduler of bitbake, so that the external tool can invoke it
easily. The main changes are:

* It used 4 arguments in the past, but currently uses 2, the reasons:
  1) The argv[1] was the tmp/cache/hashdata.dat, but bitbake doesn't
     dump the hashdata.dat currently, and since the bitbake-runtask
     is only used by the external tool currently, so we don't have to
     dump the hashdata.dat, I had tried to add code in
     lib/bb/runqueue.py to dump it, but failed.

  2) The argv[4] was used to check whether it is "True" or not, if true
     then don't excute the task, otherwise, excute it, I dont' know why
     we need this, so remove it, but it would be easy to add it back.

* Since there is no hashdata.dat, there is no way to get the value of
  debug or debug_domains, so we don't use them any more.

* Since there is no hashdata.dat, so we can't get the hashdata, so the
  function make_stamp doesn't work when run bitbake-runtask, the
  make_stamp is use for making stamps and dump sigdata to ${STAMP} (e.g,
  tmp/stamps/i586-poky-linux), making stamps are ok, but dump sigdata
  failed since there is no hashdata , so I added a variable BB_NO_DUMPSIG
  to prevent it dump the sigdata when run by btibake-runtask.

* Add the log handler to bitbake-runtask, otherwise it would not print
  some useful information, for example, when run:

  $ bitbake-runtask gzip do_fetch

  There are more than one recipes of gzip, it just prints that
  "MultipleMatches", but doesn't print which recipes without the
   log handler.

* It prints out some strange lines, for exmaple:
(clogging
LogRecord
p2
c__builtin__
object
p3
NtRp4
(dp5
S'taskpid'
p6
I6653
sS'threadName'
p7
S'MainThread'
p8

It printed such lines in the past, but now it printed much more
lines (more than 2000 lines), though I think this is harmless,
I don't know how to reduce them.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake-runtask |   74 ++++++++++++++++++++++--------------------
 bitbake/lib/bb/build.py     |    4 +-
 2 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/bitbake/bin/bitbake-runtask b/bitbake/bin/bitbake-runtask
index bee0f42..68f6c33 100755
--- a/bitbake/bin/bitbake-runtask
+++ b/bitbake/bin/bitbake-runtask
@@ -4,6 +4,10 @@ import os
 import sys
 import warnings
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
+from bb import fetch2
+import logging
+
+logger = logging.getLogger("BitBake")
 
 try:
     import cPickle as pickle
@@ -11,18 +15,24 @@ except ImportError:
     import pickle
     bb.msg.note(1, bb.msg.domain.Cache, "Importing cPickle failed. Falling back to a very slow implementation.")
 
+
 class BBConfiguration(object):
     """
     Manages build options and configurations for one run
     """
 
-    def __init__(self, debug, debug_domains):
-        setattr(self, "data", {})
-        setattr(self, "file", [])
-        setattr(self, "cmd", None)
-        setattr(self, "dump_signatures", True)
-        setattr(self, "debug", debug)
-        setattr(self, "debug_domains", debug_domains)
+    def __init__(self, **options):
+        self.prefile = []
+        self.postfile = []
+        self.parse_only = True
+
+    def __getattr__(self, attribute):
+        try:
+            return super(BBConfiguration, self).__getattribute__(attribute)
+        except AttributeError:
+            return None
+
+
 
 _warnings_showwarning = warnings.showwarning
 def _showwarning(message, category, filename, lineno, file=None, line=None):
@@ -68,37 +78,38 @@ os.setpgrp()
 bb.event.worker_pid = os.getpid()
 bb.event.useStdout = False
 
-hashfile = sys.argv[1]
-buildfile = sys.argv[2]
-taskname = sys.argv[3]
+buildfile = sys.argv[1]
+taskname = sys.argv[2]
 
 import bb.cooker
 
-p = pickle.Unpickler(file(hashfile, "rb"))
-hashdata = p.load()
+def register_idle_function(self, function, data):
+    pass
 
-debug = hashdata["msg-debug"]
-debug_domains = hashdata["msg-debug-domains"]
-verbose = hashdata["verbose"]
+# Print the log information
+handler = bb.event.LogHandler()
+logger.setLevel(logging.INFO)
+logger.addHandler(handler)
 
-bb.utils.init_logger(bb.msg, verbose, debug, debug_domains)
+initialenv = os.environ.copy()
+config = BBConfiguration()
 
-cooker = bb.cooker.BBCooker(BBConfiguration(debug, debug_domains), None)
-cooker.parseConfiguration()
+cooker = bb.cooker.BBCooker(config, register_idle_function, initialenv)
+config_data = cooker.configuration.data
+cooker.status = config_data
+cooker.handleCollections(bb.data.getVar("BBFILE_COLLECTIONS", config_data, 1))
 
-cooker.bb_cache = bb.cache.init(cooker)
-cooker.status = bb.cache.CacheData()
-
-(fn, cls) = cooker.bb_cache.virtualfn2realfn(buildfile)
+fn, cls = bb.cache.Cache.virtualfn2realfn(buildfile)
 buildfile = cooker.matchFile(fn)
-fn = cooker.bb_cache.realfn2virtual(buildfile, cls)
+fn = bb.cache.Cache.realfn2virtual(buildfile, cls)
 
 cooker.buildSetVars()
 
 # Load data into the cache for fn and parse the loaded cache data
-the_data = cooker.bb_cache.loadDataFull(fn, cooker.get_file_appends(fn), cooker.configuration.data)
-cooker.bb_cache.setData(fn, buildfile, the_data)
-cooker.bb_cache.handle_data(fn, cooker.status)
+the_data = bb.cache.Cache.loadDataFull(fn, cooker.get_file_appends(fn), cooker.configuration.data)
+
+# Don't dump the signature for the task since we have no hashdata
+the_data.setVar("BB_NO_DUMPSIG", True)
 
 #exportlist = bb.utils.preserved_envvars_export_list()
 #bb.utils.filter_environment(exportlist)
@@ -106,15 +117,8 @@ cooker.bb_cache.handle_data(fn, cooker.status)
 if taskname.endswith("_setscene"):
     the_data.setVarFlag(taskname, "quieterrors", "1")
 
-bb.parse.siggen.set_taskdata(hashdata["hashes"], hashdata["deps"])
-
-for h in hashdata["hashes"]:
-    bb.data.setVar("BBHASH_%s" % h, hashdata["hashes"][h], the_data)
-for h in hashdata["deps"]:
-    bb.data.setVar("BBHASHDEPS_%s" % h, hashdata["deps"][h], the_data)
-
 ret = 0
-if sys.argv[4] != "True":
-    ret = bb.build.exec_task(fn, taskname, the_data)
+
+ret = bb.build.exec_task(fn, taskname, the_data)
 sys.exit(ret)
 
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 8937f08..898678a 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -415,8 +415,8 @@ def make_stamp(task, d, file_name = None):
         f.close()
 
     # If we're in task context, write out a signature file for each task
-    # as it completes
-    if not task.endswith("_setscene") and task != "do_setscene" and not file_name:
+    # as it completes, the BB_NO_DUMPSIG is used by bitbake-runtask currently
+    if not task.endswith("_setscene") and task != "do_setscene" and not file_name and not d.getVar('BB_NO_DUMPSIG', True):
         file_name = d.getVar('BB_FILENAME', True)
         bb.parse.siggen.dump_sigtask(file_name, task, d.getVar('STAMP', True), True)
 
-- 
1.7.4.1



