Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id C37BC6A8B4
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 17:11:24 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HGT5V001907 for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:16:29 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bul2AvA-IlGq for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 18:16:29 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HGOfL001892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:16:26 +0100
Message-ID: <1370625069.6864.51.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Jun 2013 18:11:09 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Split runqueue to use bitbake-worker
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 07 Jun 2013 17:11:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This is a pretty fundamental change to the way bitbake operates. It
splits out the task execution part of runqueue into a completely
separately exec'd process called bitbake-worker.

This means that the separate process has to build its own datastore and
that configuration needs to be passed from the cooker over to the
bitbake worker process.

Known issues:

* Hob is broken with this patch since it writes to the configuration
  and that configuration isn't preserved in bitbake-worker.
* We create a worker for setscene, then a new worker for the main task
  execution. This is wasteful but shouldn't be hard to fix.
* We probably send too much data over to bitbake-worker, need to
  see if we can streamline it.

These are issues which will be followed up in subsequent patches.

This patch sets the groundwork for the removal of the double bitbake
execution for psuedo which will be in a follow on patch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
new file mode 100755
index 0000000..8edf8dd
--- /dev/null
+++ b/bitbake/bin/bitbake-worker
@@ -0,0 +1,358 @@
+#!/usr/bin/env python
+
+import os
+import sys
+import warnings
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
+from bb import fetch2
+import logging
+import bb
+import select
+import errno
+
+# Users shouldn't be running this code directly
+if len(sys.argv) != 2 or sys.argv[1] != "decafbad":
+    print("bitbake-worker is meant for internal execution by bitbake itself, please don't use it standalone.")
+    sys.exit(1)
+
+logger = logging.getLogger("BitBake")
+
+try:
+    import cPickle as pickle
+except ImportError:
+    import pickle
+    bb.msg.note(1, bb.msg.domain.Cache, "Importing cPickle failed. Falling back to a very slow implementation.")
+
+
+worker_pipe = sys.stdout.fileno()
+bb.utils.nonblockingfd(worker_pipe)
+
+handler = bb.event.LogHandler()
+logger.addHandler(handler)
+
+if 0:
+    # Code to write out a log file of all events passing through the worker
+    logfilename = "/tmp/workerlogfile"
+    format_str = "%(levelname)s: %(message)s"
+    conlogformat = bb.msg.BBLogFormatter(format_str)
+    consolelog = logging.FileHandler(logfilename)
+    bb.msg.addDefaultlogFilter(consolelog)
+    consolelog.setFormatter(conlogformat)
+    logger.addHandler(consolelog)
+
+worker_queue = ""
+
+def worker_fire(event, d):
+    data = "<event>" + pickle.dumps(event) + "</event>"
+    worker_fire_prepickled(data)
+
+def worker_fire_prepickled(event):
+    global worker_queue
+
+    worker_queue = worker_queue + event
+    worker_flush()
+
+def worker_flush():
+    global worker_queue, worker_pipe
+
+    if not worker_queue:
+        return
+
+    try:
+        written = os.write(worker_pipe, worker_queue)
+        worker_queue = worker_queue[written:]
+    except (IOError, OSError) as e:
+        if e.errno != errno.EAGAIN:
+            raise
+
+def worker_child_fire(event, d):
+    global worker_pipe
+
+    data = "<event>" + pickle.dumps(event) + "</event>"
+    worker_pipe.write(data)
+
+bb.event.worker_fire = worker_fire
+
+lf = None
+#lf = open("/tmp/workercommandlog", "w+")
+def workerlog_write(msg):
+    if lf:
+        lf.write(msg)
+        lf.flush()
+
+def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, quieterrors=False):
+    # We need to setup the environment BEFORE the fork, since
+    # a fork() or exec*() activates PSEUDO...
+
+    envbackup = {}
+    fakeenv = {}
+    umask = None
+
+    taskdep = workerdata["taskdeps"][fn]
+    if 'umask' in taskdep and taskname in taskdep['umask']:
+        # umask might come in as a number or text string..
+        try:
+             umask = int(taskdep['umask'][taskname],8)
+        except TypeError:
+             umask = taskdep['umask'][taskname]
+
+    if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
+        envvars = (workerdata["fakerootenv"][fn] or "").split()
+        for key, value in (var.split('=') for var in envvars):
+            envbackup[key] = os.environ.get(key)
+            os.environ[key] = value
+            fakeenv[key] = value
+
+        fakedirs = (workerdata["fakerootdirs"][fn] or "").split()
+        for p in fakedirs:
+            bb.utils.mkdirhier(p)
+        logger.debug(2, 'Running %s:%s under fakeroot, fakedirs: %s' %
+                        (fn, taskname, ', '.join(fakedirs)))
+    else:
+        envvars = (workerdata["fakerootnoenv"][fn] or "").split()
+        for key, value in (var.split('=') for var in envvars):
+            envbackup[key] = os.environ.get(key)
+            os.environ[key] = value
+            fakeenv[key] = value
+
+    sys.stdout.flush()
+    sys.stderr.flush()
+
+    try:
+        pipein, pipeout = os.pipe()
+        pipein = os.fdopen(pipein, 'rb', 4096)
+        pipeout = os.fdopen(pipeout, 'wb', 0)
+        pid = os.fork()
+    except OSError as e:
+        bb.msg.fatal("RunQueue", "fork failed: %d (%s)" % (e.errno, e.strerror))
+
+    if pid == 0:
+            global worker_pipe
+            pipein.close()
+
+            # Save out the PID so that the event can include it the
+            # events
+            bb.event.worker_pid = os.getpid()
+            bb.event.worker_fire = worker_child_fire
+            worker_pipe = pipeout
+
+            # Make the child the process group leader
+            os.setpgid(0, 0)
+            # No stdin
+            newsi = os.open(os.devnull, os.O_RDWR)
+            os.dup2(newsi, sys.stdin.fileno())
+
+            if umask:
+                os.umask(umask)
+
+            data.setVar("BB_WORKERCONTEXT", "1")
+            bb.parse.siggen.set_taskdata(workerdata["hashes"], workerdata["hash_deps"], workerdata["sigchecksums"])
+            ret = 0
+            try:
+                the_data = bb.cache.Cache.loadDataFull(fn, appends, data)
+                the_data.setVar('BB_TASKHASH', workerdata["runq_hash"][task])
+                for h in workerdata["hashes"]:
+                    the_data.setVar("BBHASH_%s" % h, workerdata["hashes"][h])
+                for h in workerdata["hash_deps"]:
+                    the_data.setVar("BBHASHDEPS_%s" % h, workerdata["hash_deps"][h])
+
+                # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
+                # successfully. We also need to unset anything from the environment which shouldn't be there 
+                exports = bb.data.exported_vars(the_data)
+                bb.utils.empty_environment()
+                for e, v in exports:
+                    os.environ[e] = v
+                for e in fakeenv:
+                    os.environ[e] = fakeenv[e]
+                    the_data.setVar(e, fakeenv[e])
+                    the_data.setVarFlag(e, 'export', "1")
+
+                if quieterrors:
+                    the_data.setVarFlag(taskname, "quieterrors", "1")
+
+            except Exception as exc:
+                if not quieterrors:
+                    logger.critical(str(exc))
+                os._exit(1)
+            try:
+                if not cfg.dry_run:
+                    ret = bb.build.exec_task(fn, taskname, the_data, cfg.profile)
+                os._exit(ret)
+            except:
+                os._exit(1)
+    else:
+        for key, value in envbackup.iteritems():
+            if value is None:
+                del os.environ[key]
+            else:
+                os.environ[key] = value
+
+    return pid, pipein, pipeout
+
+class runQueueWorkerPipe():
+    """
+    Abstraction for a pipe between a worker thread and the worker server
+    """
+    def __init__(self, pipein, pipeout):
+        self.input = pipein
+        if pipeout:
+            pipeout.close()
+        bb.utils.nonblockingfd(self.input)
+        self.queue = ""
+
+    def read(self):
+        start = len(self.queue)
+        try:
+            self.queue = self.queue + self.input.read(102400)
+        except (OSError, IOError) as e:
+            if e.errno != errno.EAGAIN:
+                raise
+
+        end = len(self.queue)
+        index = self.queue.find("</event>")
+        while index != -1:
+            worker_fire_prepickled(self.queue[:index+8])
+            self.queue = self.queue[index+8:]
+            index = self.queue.find("</event>")
+        return (end > start)
+
+    def close(self):
+        while self.read():
+            continue
+        if len(self.queue) > 0:
+            print("Warning, worker child left partial message: %s" % self.queue)
+        self.input.close()
+
+normalexit = False
+
+class BitbakeWorker(object):
+    def __init__(self, din):
+        self.input = din
+        bb.utils.nonblockingfd(self.input)
+        self.queue = ""
+        self.cookercfg = None
+        self.databuilder = None
+        self.data = None
+        self.build_pids = {}
+        self.build_pipes = {}
+    
+    def serve(self):        
+        while True:
+            (ready, _, _) = select.select([self.input] + [i.input for i in self.build_pipes.values()], [] , [], 1)
+            if self.input in ready or len(self.queue):
+                start = len(self.queue)
+                try:
+                    self.queue = self.queue + self.input.read()
+                except (OSError, IOError):
+                    pass
+                end = len(self.queue)
+                self.handle_item("cookerconfig", self.handle_cookercfg)
+                self.handle_item("workerdata", self.handle_workerdata)
+                self.handle_item("runtask", self.handle_runtask)
+                self.handle_item("finishnow", self.handle_finishnow)
+                self.handle_item("ping", self.handle_ping)
+                self.handle_item("quit", self.handle_quit)
+
+            for pipe in self.build_pipes:
+                self.build_pipes[pipe].read()
+            if len(self.build_pids):
+                self.process_waitpid()
+            worker_flush()
+
+
+    def handle_item(self, item, func):
+        if self.queue.startswith("<" + item + ">"):
+            index = self.queue.find("</" + item + ">")
+            while index != -1:
+                func(self.queue[(len(item) + 2):index])
+                self.queue = self.queue[(index + len(item) + 3):]
+                index = self.queue.find("</" + item + ">")
+
+    def handle_cookercfg(self, data):
+        self.cookercfg = pickle.loads(data)
+        self.databuilder = bb.cookerdata.CookerDataBuilder(self.cookercfg, worker=True)
+        self.databuilder.parseBaseConfiguration()
+        self.data = self.databuilder.data
+
+    def handle_workerdata(self, data):
+        self.workerdata = pickle.loads(data)
+        bb.msg.loggerDefaultDebugLevel = self.workerdata["logdefaultdebug"]
+        bb.msg.loggerDefaultVerbose = self.workerdata["logdefaultverbose"]
+        bb.msg.loggerVerboseLogs = self.workerdata["logdefaultverboselogs"]
+        bb.msg.loggerDefaultDomains = self.workerdata["logdefaultdomain"]
+
+    def handle_ping(self, _):
+        workerlog_write("Handling ping\n")
+
+        logger.warn("Pong from bitbake-worker!")
+
+    def handle_quit(self, data):
+        workerlog_write("Handling quit\n")
+
+        global normalexit
+        normalexit = True
+        sys.exit(0)
+
+    def handle_runtask(self, data):
+        fn, task, taskname, quieterrors, appends = pickle.loads(data)
+        workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
+
+        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.workerdata, fn, task, taskname, appends, quieterrors)
+
+        self.build_pids[pid] = task
+        self.build_pipes[pid] = runQueueWorkerPipe(pipein, pipeout)
+
+    def process_waitpid(self):
+        """
+        Return none is there are no processes awaiting result collection, otherwise
+        collect the process exit codes and close the information pipe.
+        """
+        try:
+            pid, status = os.waitpid(-1, os.WNOHANG)
+            if pid == 0 or os.WIFSTOPPED(status):
+                return None
+        except OSError:
+            return None
+
+        workerlog_write("Exit code of %s for pid %s\n" % (status, pid))
+
+        if os.WIFEXITED(status):
+            status = os.WEXITSTATUS(status)
+        elif os.WIFSIGNALED(status):
+            # Per shell conventions for $?, when a process exits due to
+            # a signal, we return an exit code of 128 + SIGNUM
+            status = 128 + os.WTERMSIG(status)
+
+        task = self.build_pids[pid]
+        del self.build_pids[pid]
+
+        self.build_pipes[pid].close()
+        del self.build_pipes[pid]
+
+        worker_fire_prepickled("<exitcode>" + pickle.dumps((task, status)) + "</exitcode>")
+
+    def handle_finishnow(self, _):
+        if self.build_pids:
+            logger.info("Sending SIGTERM to remaining %s tasks", len(self.build_pids))
+            for k, v in self.build_pids.iteritems():
+                try:
+                    os.kill(-k, signal.SIGTERM)
+                    os.waitpid(-1, 0)
+                except:
+                    pass
+        for pipe in self.build_pipes:
+            self.build_pipes[pipe].read()
+
+try:
+    worker = BitbakeWorker(sys.stdin)
+    worker.serve()
+except BaseException as e:
+    if not normalexit:
+        import traceback
+        sys.stderr.write(traceback.format_exc())
+        sys.stderr.write(str(e))
+while len(worker_queue):
+    worker_flush()
+workerlog_write("exitting")
+sys.exit(0)
+
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index fb0f40c..b99fa99 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -724,7 +724,6 @@ class CacheData(object):
         for info in info_array:
             info.add_cacheData(self, fn)
 
-
 class MultiProcessCache(object):
     """
     BitBake multi-process cache implementation
@@ -746,13 +745,18 @@ class MultiProcessCache(object):
         self.cachefile = os.path.join(cachedir, self.__class__.cache_file_name)
         logger.debug(1, "Using cache in '%s'", self.cachefile)
 
+        glf = bb.utils.lockfile(self.cachefile + ".lock")
+
         try:
             with open(self.cachefile, "rb") as f:
                 p = pickle.Unpickler(f)
                 data, version = p.load()
         except:
+            bb.utils.unlockfile(glf)
             return
 
+        bb.utils.unlockfile(glf)
+
         if version != self.__class__.CACHE_VERSION:
             return
 
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 149878f..1bed455 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -25,7 +25,9 @@
 import os, sys
 from functools import wraps
 import logging
+import bb
 from bb import data
+import bb.parse
 
 logger      = logging.getLogger("BitBake")
 parselog    = logging.getLogger("BitBake.Parsing")
@@ -139,6 +141,20 @@ class CookerConfiguration(object):
     def setServerRegIdleCallback(self, srcb):
         self.server_register_idlecallback = srcb
 
+    def __getstate__(self):
+        state = {}
+        for key in self.__dict__.keys():
+            if key == "server_register_idlecallback":
+                state[key] = None
+            else:
+                state[key] = getattr(self, key)
+        return state
+
+    def __setstate__(self,state):
+        for k in state:
+            setattr(self, k, state[k]) 
+
+
 def catch_parse_error(func):
     """Exception handling bits for our parsing"""
     @wraps(func)
@@ -146,6 +162,8 @@ def catch_parse_error(func):
         try:
             return func(fn, *args)
         except (IOError, bb.parse.ParseError, bb.data_smart.ExpansionError) as exc:
+            import traceback
+            parselog.critical( traceback.format_exc())
             parselog.critical("Unable to parse %s: %s" % (fn, exc))
             sys.exit(1)
     return wrapped
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 2826e35..d73067f 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -33,11 +33,12 @@ import atexit
 import traceback
 import bb.utils
 import bb.compat
+import bb.exceptions
 
 # This is the pid for which we should generate the event. This is set when
 # the runqueue forks off.
 worker_pid = 0
-worker_pipe = None
+worker_fire = None
 
 logger = logging.getLogger('BitBake.Event')
 
@@ -150,20 +151,12 @@ def fire(event, d):
     # don't have a datastore so the datastore context isn't a problem.
 
     fire_class_handlers(event, d)
-    if worker_pid != 0:
+    if worker_fire:
         worker_fire(event, d)
     else:
         fire_ui_handlers(event, d)
 
-def worker_fire(event, d):
-    data = "<event>" + pickle.dumps(event) + "</event>"
-    worker_pipe.write(data)
-
 def fire_from_worker(event, d):
-    if not event.startswith("<event>") or not event.endswith("</event>"):
-        print("Error, not an event %s" % event)
-        return
-    event = pickle.loads(event[7:-8])
     fire_ui_handlers(event, d)
 
 noop = lambda _: None
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 090d1b5..dd6e071 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -28,10 +28,17 @@ import sys
 import signal
 import stat
 import fcntl
+import errno
 import logging
 import bb
 from bb import msg, data, event
 from bb import monitordisk
+import subprocess
+
+try:
+    import cPickle as pickle
+except ImportError:
+    import pickle
 
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
@@ -938,6 +945,10 @@ class RunQueue:
             raise
         except:
             logger.error("An uncaught exception occured in runqueue, please see the failure below:")
+            try:
+                self.rqexe.teardown()
+            except:
+                pass
             self.state = runQueueComplete
             raise
 
@@ -979,38 +990,41 @@ class RunQueueExecute:
         self.runq_buildable = []
         self.runq_running = []
         self.runq_complete = []
-        self.build_pids = {}
-        self.build_pipes = {}
+
         self.build_stamps = {}
         self.failed_fnids = []
 
         self.stampcache = {}
 
-    def runqueue_process_waitpid(self):
-        """
-        Return none is there are no processes awaiting result collection, otherwise
-        collect the process exit codes and close the information pipe.
-        """
-        pid, status = os.waitpid(-1, os.WNOHANG)
-        if pid == 0 or os.WIFSTOPPED(status):
-            return None
-
-        if os.WIFEXITED(status):
-            status = os.WEXITSTATUS(status)
-        elif os.WIFSIGNALED(status):
-            # Per shell conventions for $?, when a process exits due to
-            # a signal, we return an exit code of 128 + SIGNUM
-            status = 128 + os.WTERMSIG(status)
-
-        task = self.build_pids[pid]
-        del self.build_pids[pid]
-
-        self.build_pipes[pid].close()
-        del self.build_pipes[pid]
+        logger.debug(1, "Starting bitbake-worker")
+        self.worker = subprocess.Popen(["bitbake-worker", "decafbad"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
+        bb.utils.nonblockingfd(self.worker.stdout)
+        self.workerpipe = runQueuePipe(self.worker.stdout, None, self.cfgData, self)
+
+        workerdata = {
+            "taskdeps" : self.rqdata.dataCache.task_deps,
+            "fakerootenv" : self.rqdata.dataCache.fakerootenv,
+            "fakerootdirs" : self.rqdata.dataCache.fakerootdirs,
+            "fakerootnoenv" : self.rqdata.dataCache.fakerootnoenv,
+            "hashes" : self.rqdata.hashes,
+            "hash_deps" : self.rqdata.hash_deps,
+            "sigchecksums" : bb.parse.siggen.file_checksum_values,
+            "runq_hash" : self.rqdata.runq_hash,
+            "logdefaultdebug" : bb.msg.loggerDefaultDebugLevel,
+            "logdefaultverbose" : bb.msg.loggerDefaultVerbose,
+            "logdefaultverboselogs" : bb.msg.loggerVerboseLogs,
+            "logdefaultdomain" : bb.msg.loggerDefaultDomains,
+        }
+
+        self.worker.stdin.write("<cookerconfig>" + pickle.dumps(self.cooker.configuration) + "</cookerconfig>")
+        self.worker.stdin.write("<workerdata>" + pickle.dumps(workerdata) + "</workerdata>")
+        self.worker.stdin.flush()
+
+    def runqueue_process_waitpid(self, task, status):
 
         # self.build_stamps[pid] may not exist when use shared work directory.
-        if pid in self.build_stamps:
-            del self.build_stamps[pid]
+        if task in self.build_stamps:
+            del self.build_stamps[task]
 
         if status != 0:
             self.task_fail(task, status)
@@ -1019,16 +1033,11 @@ class RunQueueExecute:
         return True
 
     def finish_now(self):
-        if self.stats.active:
-            logger.info("Sending SIGTERM to remaining %s tasks", self.stats.active)
-            for k, v in self.build_pids.iteritems():
-                try:
-                    os.kill(-k, signal.SIGTERM)
-                    os.waitpid(-1, 0)
-                except:
-                    pass
-        for pipe in self.build_pipes:
-            self.build_pipes[pipe].read()
+
+        self.worker.stdin.write("<finishnow></finishnow>")
+        self.worker.stdin.flush()
+
+        self.teardown()
 
         if len(self.failed_fnids) != 0:
             self.rq.state = runQueueFailed
@@ -1040,14 +1049,13 @@ class RunQueueExecute:
     def finish(self):
         self.rq.state = runQueueCleanUp
 
-        for pipe in self.build_pipes:
-            self.build_pipes[pipe].read()
-
         if self.stats.active > 0:
             bb.event.fire(runQueueExitWait(self.stats.active), self.cfgData)
-            self.runqueue_process_waitpid()
+            self.workerpipe.read()
             return
 
+        self.teardown()
+
         if len(self.failed_fnids) != 0:
             self.rq.state = runQueueFailed
             return
@@ -1055,115 +1063,6 @@ class RunQueueExecute:
         self.rq.state = runQueueComplete
         return
 
-    def fork_off_task(self, fn, task, taskname, quieterrors=False):
-        # We need to setup the environment BEFORE the fork, since
-        # a fork() or exec*() activates PSEUDO...
-
-        envbackup = {}
-        fakeenv = {}
-        umask = None
-
-        taskdep = self.rqdata.dataCache.task_deps[fn]
-        if 'umask' in taskdep and taskname in taskdep['umask']:
-            # umask might come in as a number or text string..
-            try:
-                 umask = int(taskdep['umask'][taskname],8)
-            except TypeError:
-                 umask = taskdep['umask'][taskname]
-
-        if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
-            envvars = (self.rqdata.dataCache.fakerootenv[fn] or "").split()
-            for key, value in (var.split('=') for var in envvars):
-                envbackup[key] = os.environ.get(key)
-                os.environ[key] = value
-                fakeenv[key] = value
-
-            fakedirs = (self.rqdata.dataCache.fakerootdirs[fn] or "").split()
-            for p in fakedirs:
-                bb.utils.mkdirhier(p)
-
-            logger.debug(2, 'Running %s:%s under fakeroot, fakedirs: %s' %
-                            (fn, taskname, ', '.join(fakedirs)))
-        else:
-            envvars = (self.rqdata.dataCache.fakerootnoenv[fn] or "").split()
-            for key, value in (var.split('=') for var in envvars):
-                envbackup[key] = os.environ.get(key)
-                os.environ[key] = value
-                fakeenv[key] = value
-
-        sys.stdout.flush()
-        sys.stderr.flush()
-        try:
-            pipein, pipeout = os.pipe()
-            pipein = os.fdopen(pipein, 'rb', 4096)
-            pipeout = os.fdopen(pipeout, 'wb', 0)
-            pid = os.fork()
-        except OSError as e:
-            bb.msg.fatal("RunQueue", "fork failed: %d (%s)" % (e.errno, e.strerror))
-
-        if pid == 0:
-            pipein.close()
-
-            # Save out the PID so that the event can include it the
-            # events
-            bb.event.worker_pid = os.getpid()
-            bb.event.worker_pipe = pipeout
-
-            self.rq.state = runQueueChildProcess
-            # Make the child the process group leader
-            os.setpgid(0, 0)
-            # No stdin
-            newsi = os.open(os.devnull, os.O_RDWR)
-            os.dup2(newsi, sys.stdin.fileno())
-
-            if umask:
-                os.umask(umask)
-
-            self.cooker.data.setVar("BB_WORKERCONTEXT", "1")
-            bb.parse.siggen.set_taskdata(self.rqdata.hashes, self.rqdata.hash_deps)
-            ret = 0
-            try:
-                the_data = bb.cache.Cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn), self.cooker.data)
-                the_data.setVar('BB_TASKHASH', self.rqdata.runq_hash[task])
-                for h in self.rqdata.hashes:
-                    the_data.setVar("BBHASH_%s" % h, self.rqdata.hashes[h])
-                for h in self.rqdata.hash_deps:
-                    the_data.setVar("BBHASHDEPS_%s" % h, self.rqdata.hash_deps[h])
-
-                # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
-                # successfully. We also need to unset anything from the environment which shouldn't be there 
-                exports = bb.data.exported_vars(the_data)
-                bb.utils.empty_environment()
-                for e, v in exports:
-                    os.environ[e] = v
-                for e in fakeenv:
-                    os.environ[e] = fakeenv[e]
-                    the_data.setVar(e, fakeenv[e])
-                    the_data.setVarFlag(e, 'export', "1")
-
-                if quieterrors:
-                    the_data.setVarFlag(taskname, "quieterrors", "1")
-
-            except Exception as exc:
-                if not quieterrors:
-                    logger.critical(str(exc))
-                os._exit(1)
-            try:
-                if not self.cooker.configuration.dry_run:
-                    profile = self.cooker.configuration.profile
-                    ret = bb.build.exec_task(fn, taskname, the_data, profile)
-                os._exit(ret)
-            except:
-                os._exit(1)
-        else:
-            for key, value in envbackup.iteritems():
-                if value is None:
-                    del os.environ[key]
-                else:
-                    os.environ[key] = value
-
-        return pid, pipein, pipeout
-
     def check_dependencies(self, task, taskdeps, setscene = False):
         if not self.rq.depvalidate:
             return False
@@ -1184,6 +1083,16 @@ class RunQueueExecute:
         valid = bb.utils.better_eval(call, locs)
         return valid
 
+    def teardown(self):
+        logger.debug(1, "Teardown for bitbake-worker")
+        self.worker.stdin.write("<quit></quit>")
+        self.worker.stdin.flush()
+        while self.worker.returncode is None:
+            self.workerpipe.read()
+            self.worker.poll()
+        while self.workerpipe.read():
+            continue
+
 class RunQueueExecuteDummy(RunQueueExecute):
     def __init__(self, rq):
         self.rq = rq
@@ -1275,7 +1184,6 @@ class RunQueueExecuteTasks(RunQueueExecute):
             bb.fatal("Invalid scheduler '%s'.  Available schedulers: %s" %
                      (self.scheduler, ", ".join(obj.name for obj in schedulers)))
 
-
     def get_schedulers(self):
         schedulers = set(obj for obj in globals().values()
                              if type(obj) is type and
@@ -1349,6 +1257,9 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Run the tasks in a queue prepared by rqdata.prepare()
         """
 
+        self.workerpipe.read()
+        
+
         if self.stats.total == 0:
             # nothing to do
             self.rq.state = runQueueCleanUp
@@ -1384,23 +1295,20 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 startevent = runQueueTaskStarted(task, self.stats, self.rq)
                 bb.event.fire(startevent, self.cfgData)
 
-            pid, pipein, pipeout = self.fork_off_task(fn, task, taskname)
+            self.worker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+            self.worker.stdin.flush()
 
-            self.build_pids[pid] = task
-            self.build_pipes[pid] = runQueuePipe(pipein, pipeout, self.cfgData)
-            self.build_stamps[pid] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
+            self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
             self.runq_running[task] = 1
             self.stats.taskActive()
             if self.stats.active < self.number_tasks:
                 return True
 
-        for pipe in self.build_pipes:
-            self.build_pipes[pipe].read()
-
         if self.stats.active > 0:
-            if self.runqueue_process_waitpid() is None:
-                return 0.5
-            return True
+            self.workerpipe.read()
+            return 0.5
+
+        self.teardown()
 
         if len(self.failed_fnids) != 0:
             self.rq.state = runQueueFailed
@@ -1415,6 +1323,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             if self.runq_complete[task] == 0:
                 logger.error("Task %s never completed!", task)
         self.rq.state = runQueueComplete
+
         return True
 
 class RunQueueExecuteScenequeue(RunQueueExecute):
@@ -1428,6 +1337,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # If we don't have any setscene functions, skip this step
         if len(self.rqdata.runq_setscene) == 0:
             rq.scenequeue_covered = set()
+            self.teardown()
             rq.state = runQueueRunInit
             return
 
@@ -1676,6 +1586,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         Run the tasks in a queue prepared by prepare_runqueue
         """
 
+        self.workerpipe.read()
+
         task = None
         if self.stats.active < self.number_tasks:
             # Find the next setscene to run
@@ -1716,22 +1628,17 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
-            pid, pipein, pipeout = self.fork_off_task(fn, realtask, taskname)
+            self.worker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+            self.worker.stdin.flush()
 
-            self.build_pids[pid] = task
-            self.build_pipes[pid] = runQueuePipe(pipein, pipeout, self.cfgData)
             self.runq_running[task] = 1
             self.stats.taskActive()
             if self.stats.active < self.number_tasks:
                 return True
 
-        for pipe in self.build_pipes:
-            self.build_pipes[pipe].read()
-
         if self.stats.active > 0:
-            if self.runqueue_process_waitpid() is None:
-                return 0.5
-            return True
+            self.workerpipe.read()
+            return 0.5
 
         # Convert scenequeue_covered task numbers into full taskgraph ids
         oldcovered = self.scenequeue_covered
@@ -1745,10 +1652,13 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         logger.debug(1, 'We can skip tasks %s', sorted(self.rq.scenequeue_covered))
 
         self.rq.state = runQueueRunInit
+        self.teardown()
         return True
 
-    def fork_off_task(self, fn, task, taskname):
-        return RunQueueExecute.fork_off_task(self, fn, task, taskname, quieterrors=True)
+    def runqueue_process_waitpid(self, task, status):
+        task = self.rq.rqdata.runq_setscene.index(task)
+
+        RunQueueExecute.runqueue_process_waitpid(self, task, status)
 
 class TaskFailure(Exception):
     """
@@ -1828,25 +1738,43 @@ class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
     """
-    def __init__(self, pipein, pipeout, d):
+    def __init__(self, pipein, pipeout, d, rq):
         self.input = pipein
-        pipeout.close()
+        if pipeout:
+            pipeout.close()
         bb.utils.nonblockingfd(self.input)
         self.queue = ""
         self.d = d
+        self.rq = rq
+
+    def setrunqueue(self, rq):
+        self.rq = rq
 
     def read(self):
         start = len(self.queue)
         try:
             self.queue = self.queue + self.input.read(102400)
-        except (OSError, IOError):
-            pass
+        except (OSError, IOError) as e:
+            if e.errno != errno.EAGAIN:
+                raise
         end = len(self.queue)
-        index = self.queue.find("</event>")
-        while index != -1:
-            bb.event.fire_from_worker(self.queue[:index+8], self.d)
-            self.queue = self.queue[index+8:]
+        found = True
+        while found and len(self.queue):
+            found = False
             index = self.queue.find("</event>")
+            while index != -1 and self.queue.startswith("<event>"):
+                event = pickle.loads(self.queue[7:index])
+                bb.event.fire_from_worker(event, self.d)
+                found = True
+                self.queue = self.queue[index+8:]
+                index = self.queue.find("</event>")
+            index = self.queue.find("</exitcode>")
+            while index != -1 and self.queue.startswith("<exitcode>"):
+                task, status = pickle.loads(self.queue[10:index])
+                self.rq.runqueue_process_waitpid(task, status)
+                found = True
+                self.queue = self.queue[index+11:]
+                index = self.queue.find("</exitcode>")
         return (end > start)
 
     def close(self):
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 1ff2ecc..fb8b678 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -201,9 +201,10 @@ class SignatureGeneratorBasic(SignatureGenerator):
         #d.setVar("BB_TASKHASH_task-%s" % task, taskhash[task])
         return h
 
-    def set_taskdata(self, hashes, deps):
+    def set_taskdata(self, hashes, deps, checksums):
         self.runtaskdeps = deps
         self.taskhash = hashes
+        self.file_checksum_values = checksums
 
     def dump_sigtask(self, fn, task, stampbase, runtime):
         k = fn + "." + task



