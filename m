Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RTZ3p-00018O-B8 for bitbake-devel@lists.openembedded.org;
	Thu, 24 Nov 2011 14:09:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOD3Kob024747;
	Thu, 24 Nov 2011 13:03:20 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23806-09; Thu, 24 Nov 2011 13:03:16 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOD3BmB024741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Nov 2011 13:03:12 GMT
Message-ID: <1322139798.24143.22.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Thu, 24 Nov 2011 13:03:18 +0000
In-Reply-To: <c7fca16d218cd31ab32239b970d57a95b2858532.1321364305.git.liezhi.yang@windriver.com>
References: <cover.1321364305.git.liezhi.yang@windriver.com>
	<c7fca16d218cd31ab32239b970d57a95b2858532.1321364305.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/1] Fix bitbake-runtask
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
X-List-Received-Date: Thu, 24 Nov 2011 13:09:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Robert,

On Tue, 2011-11-15 at 21:45 +0800, Robert Yang wrote:
> Fixes bug [YOCTO #1229]
> 
> The bitbake doesn't use bitbake-runtask to excute the task any more,
> but bitbake-runtask is a useful tool for excuting the task without
> the scheduler of bitbake, so that the external tool can invoke it
> easily. The main changes are:
> 
> * It used 4 arguments in the past, but currently uses 2, the reasons:
>   1) The argv[1] was the tmp/cache/hashdata.dat, but bitbake doesn't
>      dump the hashdata.dat currently, and since the bitbake-runtask
>      is only used by the external tool currently, so we don't have to
>      dump the hashdata.dat, I had tried to add code in
>      lib/bb/runqueue.py to dump it, but failed.
> 
>   2) The argv[4] was used to check whether it is "True" or not, if true
>      then don't excute the task, otherwise, excute it, I dont' know why
>      we need this, so remove it, but it would be easy to add it back.
> 
> * Since there is no hashdata.dat, there is no way to get the value of
>   debug or debug_domains, so we don't use them any more.
> 
> * Since there is no hashdata.dat, so we can't get the hashdata, so the
>   function make_stamp doesn't work when run bitbake-runtask, the
>   make_stamp is use for making stamps and dump sigdata to ${STAMP} (e.g,
>   tmp/stamps/i586-poky-linux), making stamps are ok, but dump sigdata
>   failed since there is no hashdata , so I added a variable BB_NO_DUMPSIG
>   to prevent it dump the sigdata when run by btibake-runtask.
> 
> * Add the log handler to bitbake-runtask, otherwise it would not print
>   some useful information, for example, when run:
> 
>   $ bitbake-runtask gzip do_fetch
> 
>   There are more than one recipes of gzip, it just prints that
>   "MultipleMatches", but doesn't print which recipes without the
>    log handler.
> 
> * It prints out some strange lines, for exmaple:
> (clogging
> LogRecord
> p2
> c__builtin__
> object
> p3
> NtRp4
> (dp5
> S'taskpid'
> p6
> I6653
> sS'threadName'
> p7
> S'MainThread'
> p8
> 
> It printed such lines in the past, but now it printed much more
> lines (more than 2000 lines), though I think this is harmless,
> I don't know how to reduce them.

Sorry for the delay in getting back to you. This patch raised some
questions I couldn't answer off the top of my head without experimenting
with the codebase a bit.

I've created an updated version of this patch which is at:
http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/useradd2&id=f11b9e26d806557e7f79538b87e20f5d63a11762
and also pasted below.

The changes:

I reworked the arguments passed to the code to be cleaner and to make
some of them optional. This makes it more intuitive to use.

I changed the log handling in this code entirely. It now hooks into the
log parsing code within bitbake so all log messages are nicely
formatted. If someone did want the raw messages, we could add a mode
which passed them to stdout like that but I think this is a good default
mode.

I also found a neater way to avoid the BB_NO_DUMPSIG option and retain
some of the signature generation code.

Can you have a look and see if this revised code does everything you
need? Reading the patch, I need to clean up the mess I made of the
BBConfiguration class but please see if there are any other problems.

Cheers,

Richard


From f11b9e26d806557e7f79538b87e20f5d63a11762 Mon Sep 17 00:00:00 2001
From: Robert Yang <liezhi.yang@windriver.co>
Date: Thu, 24 Nov 2011 12:55:14 +0000
Subject: Fix bitbake-runtask

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake-runtask b/bitbake/bin/bitbake-runtask
index bee0f42..7a3775c 100755
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
@@ -16,13 +20,23 @@ class BBConfiguration(object):
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
+    #def __init__(self, debug, debug_domains):
+        self.data = {}
+        self.file = []
+        self.cmd = None
+        self.dump_signatures = True
+        #self.debug = debug
+        #self.debug_domains", debug_domains)
+        self.prefile = []
+        self.postfile = []
+        self.parse_only = True
+
+    def __getattr__(self, attribute):
+        try:
+            return super(BBConfiguration, self).__getattribute__(attribute)
+        except AttributeError:
+            return None
 
 _warnings_showwarning = warnings.showwarning
 def _showwarning(message, category, filename, lineno, file=None, line=None):
@@ -39,82 +53,70 @@ warnings.showwarning = _showwarning
 warnings.simplefilter("ignore", DeprecationWarning)
 
 import bb.event
-
-# Need to map our I/O correctly. stdout is a pipe to the server expecting 
-# events. We save this and then map stdout to stderr.
-
-eventfd = os.dup(sys.stdout.fileno())
-bb.event.worker_pipe = os.fdopen(eventfd, 'w', 0)
-
-# map stdout to stderr
-os.dup2(sys.stderr.fileno(), sys.stdout.fileno())
-
-# Replace those fds with our own
-#logout = data.expand("${TMPDIR}/log/stdout.%s" % os.getpid(), self.cfgData, True)
-#mkdirhier(os.path.dirname(logout))
-#newso = open("/tmp/stdout.%s" % os.getpid(), 'w')
-#os.dup2(newso.fileno(), sys.stdout.fileno())
-#os.dup2(newso.fileno(), sys.stderr.fileno())
-
-# Don't read from stdin from the parent
-si = file("/dev/null", 'r')
-os.dup2(si.fileno( ), sys.stdin.fileno( ))
-
-# We don't want to see signals to our parent, e.g. Ctrl+C
-os.setpgrp()
-
-# Save out the PID so that the event can include it the
-# events
-bb.event.worker_pid = os.getpid()
-bb.event.useStdout = False
-
-hashfile = sys.argv[1]
-buildfile = sys.argv[2]
-taskname = sys.argv[3]
-
 import bb.cooker
 
-p = pickle.Unpickler(file(hashfile, "rb"))
-hashdata = p.load()
-
-debug = hashdata["msg-debug"]
-debug_domains = hashdata["msg-debug-domains"]
-verbose = hashdata["verbose"]
+buildfile = sys.argv[1]
+taskname = sys.argv[2]
+if len(sys.argv) >= 4:
+    dryrun = sys.argv[3]    
+else:
+    dryrun = False
+if len(sys.argv) >= 5:
+    hashfile = sys.argv[4]
+    p = pickle.Unpickler(file(hashfile, "rb"))
+    hashdata = p.load()
+else:
+    hashdata = None
+
+handler = bb.event.LogHandler()
+logger.addHandler(handler)
+
+#An example to make debug log messages show up
+#bb.msg.init_msgconfig(True, 3, [])
+
+console = logging.StreamHandler(sys.stdout)
+format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+bb.msg.addDefaultlogFilter(console)
+console.setFormatter(format)
+
+def worker_fire(event, d):
+    if isinstance(event, logging.LogRecord):
+        console.handle(event)
+bb.event.worker_fire = worker_fire
+bb.event.worker_pid = os.getpid()
 
-bb.utils.init_logger(bb.msg, verbose, debug, debug_domains)
+initialenv = os.environ.copy()
+config = BBConfiguration()
 
-cooker = bb.cooker.BBCooker(BBConfiguration(debug, debug_domains), None)
-cooker.parseConfiguration()
+def register_idle_function(self, function, data):
+    pass
 
-cooker.bb_cache = bb.cache.init(cooker)
-cooker.status = bb.cache.CacheData()
+cooker = bb.cooker.BBCooker(config, register_idle_function, initialenv)
+config_data = cooker.configuration.data
+cooker.status = config_data
+cooker.handleCollections(bb.data.getVar("BBFILE_COLLECTIONS", config_data, 1))
 
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
-
-#exportlist = bb.utils.preserved_envvars_export_list()
-#bb.utils.filter_environment(exportlist)
+the_data = bb.cache.Cache.loadDataFull(fn, cooker.get_file_appends(fn), cooker.configuration.data)
 
 if taskname.endswith("_setscene"):
     the_data.setVarFlag(taskname, "quieterrors", "1")
 
-bb.parse.siggen.set_taskdata(hashdata["hashes"], hashdata["deps"])
-
-for h in hashdata["hashes"]:
-    bb.data.setVar("BBHASH_%s" % h, hashdata["hashes"][h], the_data)
-for h in hashdata["deps"]:
-    bb.data.setVar("BBHASHDEPS_%s" % h, hashdata["deps"][h], the_data)
+if hashdata:
+    bb.parse.siggen.set_taskdata(hashdata["hashes"], hashdata["deps"])
+    for h in hashdata["hashes"]:
+        bb.data.setVar("BBHASH_%s" % h, hashdata["hashes"][h], the_data)
+    for h in hashdata["deps"]:
+        bb.data.setVar("BBHASHDEPS_%s" % h, hashdata["deps"][h], the_data)
 
 ret = 0
-if sys.argv[4] != "True":
+if dryrun != "True":
     ret = bb.build.exec_task(fn, taskname, the_data)
 sys.exit(ret)
 
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 9231291..3aa3fe1 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -160,7 +160,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         k = fn + "." + task
         if runtime == "customfile":
             sigfile = stampbase
-        elif runtime:
+        elif runtime and k in self.taskhash:
             sigfile = stampbase + "." + task + ".sigdata" + "." + self.taskhash[k]
         else:
             sigfile = stampbase + "." + task + ".sigbasedata" + "." + self.basehash[k]
@@ -181,7 +181,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             data['gendeps'][dep] = self.gendeps[fn][dep]
             data['varvals'][dep] = self.lookupcache[fn][dep]
 
-        if runtime:
+        if runtime and k in self.taskhash:
             data['runtaskdeps'] = self.runtaskdeps[k]
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:





