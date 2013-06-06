Return-Path: <cristiana.voicu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id B13076A456
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Jun 2013 08:00:42 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 06 Jun 2013 01:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,813,1363158000"; d="scan'208";a="348970827"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
	by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2013 01:00:40 -0700
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.3]) by
	IRSMSX101.ger.corp.intel.com ([169.254.1.105]) with mapi id
	14.03.0123.003; Thu, 6 Jun 2013 09:00:40 +0100
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [RFC PATCH] Split runqueue to use bitbake-worker
Thread-Index: AQHOYfUJCjPty6LuDkCxG6VdsF9GO5koUnoQ
Date: Thu, 6 Jun 2013 08:00:39 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7D6013@IRSMSX105.ger.corp.intel.com>
References: <1370440792.1640.48.camel@ted>
In-Reply-To: <1370440792.1640.48.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.182]
MIME-Version: 1.0
Subject: Re: [RFC PATCH] Split runqueue to use bitbake-worker
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
X-List-Received-Date: Thu, 06 Jun 2013 08:00:43 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

I have tested your patches with Hob, but I can't see the issue for it. In H=
ob you can change the configuration at the begging (before starting the bui=
ld task), so when the bitbake-worker will start will take the changed confi=
guration. I have tested it changing the sstate-cache dir, and everything wo=
rked ok (it created a new dir for sstate-cache). Also, in Hob I can see the=
 warnings you placed to see if the worker is working properly.=20

Is there something I'm missing?

Thanks,
Cristiana

-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Richard Purdie
Sent: Wednesday, June 05, 2013 5:00 PM
To: bitbake-devel
Subject: [bitbake-devel] [RFC PATCH] Split runqueue to use bitbake-worker

This is a pretty fundamental change to the way bitbake operates. It
splits out the task execution part of runqueue into a completely
separately exec'd process called bitbake-worker.

This means that the separate process has to build its own datastore and
that configuration needs to be passed from the cooker over to the
bitbake worker process.

At this point the patch is an RFC just to let people see the way things
are moving. Known issues:

* Hob is broken with this patch since it writes to the configuration=20
  and that configuration isn't preserved in bitbake-worker.
* We create a worker for setscene, then a new worker for the main task
  execution. This is wasteful but shouldn't be hard to fix.
* Logging is a bit verbose/debuggy at the moment.
* The worker_fire() logic is ugly, needs a proper interface.
* Need to have bitbake-worker have a magic argument and exit telling=20
  the user not to run it directly.
* We probably send too much data over to bitbake-worker, need to=20
  see if we can streamline it.

On the other hand it does actually build things and works without
exploding horribly in local tests :)

I'm open to feedback and we're running this change through the
benchmarking to see what impact it has on performance as it stands.

Obviously the interesting bit (removal of the double bitbake execution)
would be a follow on to this patch, this just builds the groundwork.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
new file mode 100755
index 0000000..1f511d2
--- /dev/null
+++ b/bitbake/bin/bitbake-worker
@@ -0,0 +1,354 @@
+#!/usr/bin/env python
+
+import os
+import sys
+import warnings
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0=
])), 'lib'))
+from bb import fetch2
+import logging
+import bb
+import select
+import errno
+
+logger =3D logging.getLogger("BitBake")
+
+try:
+    import cPickle as pickle
+except ImportError:
+    import pickle
+    bb.msg.note(1, bb.msg.domain.Cache, "Importing cPickle failed. Falling=
 back to a very slow implementation.")
+
+bb.event.worker_pid =3D os.getpid()
+workerpipe =3D sys.stdout.fileno()
+bb.event.worker_pipe =3D workerpipe
+
+handler =3D bb.event.LogHandler()
+logger.addHandler(handler)
+
+bb.msg.init_msgconfig(False, 0, [])
+
+if 1:
+        format_str =3D "%(levelname)s: %(message)s"
+        conlogformat =3D bb.msg.BBLogFormatter(format_str)
+        consolelog =3D logging.FileHandler("/tmp/rp6")
+        bb.msg.addDefaultlogFilter(consolelog)
+        consolelog.setFormatter(conlogformat)
+        logger.addHandler(consolelog)
+
+lf =3D open("/tmp/rp7", "w+")
+
+bb.utils.nonblockingfd(workerpipe)
+
+
+worker_queue =3D ""
+
+def worker_fire(event, d):
+    global worker_queue
+
+    data =3D "<event>" + pickle.dumps(event) + "</event>"
+    worker_fire_prepickled(data)
+
+def worker_fire_prepickled(event):
+    global worker_queue
+
+    worker_queue =3D worker_queue + event
+    worker_flush()
+
+def worker_flush():
+    global worker_queue
+    if not worker_queue:
+        return
+
+    try:
+        written =3D os.write(bb.event.worker_pipe, worker_queue)
+        worker_queue =3D worker_queue[written:]
+    except (IOError, OSError) as e:
+        if e.errno !=3D errno.EAGAIN:
+            raise
+
+worker_fire_orig =3D bb.event.worker_fire
+bb.event.worker_fire =3D worker_fire
+
+
+def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, quie=
terrors=3DFalse):
+    # We need to setup the environment BEFORE the fork, since
+    # a fork() or exec*() activates PSEUDO...
+
+    envbackup =3D {}
+    fakeenv =3D {}
+    umask =3D None
+
+    taskdep =3D workerdata["taskdeps"][fn]
+    if 'umask' in taskdep and taskname in taskdep['umask']:
+        # umask might come in as a number or text string..
+        try:
+             umask =3D int(taskdep['umask'][taskname],8)
+        except TypeError:
+             umask =3D taskdep['umask'][taskname]
+
+    if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
+        envvars =3D (workerdata["fakerootenv"][fn] or "").split()
+        for key, value in (var.split('=3D') for var in envvars):
+            envbackup[key] =3D os.environ.get(key)
+            os.environ[key] =3D value
+            fakeenv[key] =3D value
+
+        fakedirs =3D (workerdata["fakerootdirs"][fn] or "").split()
+        for p in fakedirs:
+            bb.utils.mkdirhier(p)
+        logger.debug(2, 'Running %s:%s under fakeroot, fakedirs: %s' %
+                        (fn, taskname, ', '.join(fakedirs)))
+    else:
+        envvars =3D (workerdata["fakerootnoenv"][fn] or "").split()
+        for key, value in (var.split('=3D') for var in envvars):
+            envbackup[key] =3D os.environ.get(key)
+            os.environ[key] =3D value
+            fakeenv[key] =3D value
+
+    sys.stdout.flush()
+    sys.stderr.flush()
+    try:
+        pipein, pipeout =3D os.pipe()
+        pipein =3D os.fdopen(pipein, 'rb', 4096)
+        pipeout =3D os.fdopen(pipeout, 'wb', 0)
+        pid =3D os.fork()
+    except OSError as e:
+        bb.msg.fatal("RunQueue", "fork failed: %d (%s)" % (e.errno, e.stre=
rror))
+
+    if pid =3D=3D 0:
+            pipein.close()
+
+            # Save out the PID so that the event can include it the
+            # events
+            bb.event.worker_pid =3D os.getpid()
+            bb.event.worker_pipe =3D pipeout
+            bb.event.worker_fire =3D worker_fire_orig
+
+            # Make the child the process group leader
+            os.setpgid(0, 0)
+            # No stdin
+            newsi =3D os.open(os.devnull, os.O_RDWR)
+            os.dup2(newsi, sys.stdin.fileno())
+
+            if umask:
+                os.umask(umask)
+
+            data.setVar("BB_WORKERCONTEXT", "1")
+            bb.parse.siggen.set_taskdata(workerdata["hashes"], workerdata[=
"hash_deps"], workerdata["sigchecksums"])
+            ret =3D 0
+            try:
+                the_data =3D bb.cache.Cache.loadDataFull(fn, appends, data=
)
+                the_data.setVar('BB_TASKHASH', workerdata["runq_hash"][tas=
k])
+                for h in workerdata["hashes"]:
+                    the_data.setVar("BBHASH_%s" % h, workerdata["hashes"][=
h])
+                for h in workerdata["hash_deps"]:
+                    the_data.setVar("BBHASHDEPS_%s" % h, workerdata["hash_=
deps"][h])
+
+                # exported_vars() returns a generator which *cannot* be pa=
ssed to os.environ.update()=20
+                # successfully. We also need to unset anything from the en=
vironment which shouldn't be there=20
+                exports =3D bb.data.exported_vars(the_data)
+                bb.utils.empty_environment()
+                for e, v in exports:
+                    os.environ[e] =3D v
+                for e in fakeenv:
+                    os.environ[e] =3D fakeenv[e]
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
+                    ret =3D bb.build.exec_task(fn, taskname, the_data, cfg=
.profile)
+                os._exit(ret)
+            except:
+                os._exit(1)
+    else:
+        for key, value in envbackup.iteritems():
+            if value is None:
+                del os.environ[key]
+            else:
+                os.environ[key] =3D value
+
+    return pid, pipein, pipeout
+
+
+
+class runQueueWorkerPipe():
+    """
+    Abstraction for a pipe between a worker thread and the worker server
+    """
+    def __init__(self, pipein, pipeout):
+        self.input =3D pipein
+        if pipeout:
+            pipeout.close()
+        bb.utils.nonblockingfd(self.input)
+        self.queue =3D ""
+
+    def read(self):
+        start =3D len(self.queue)
+        try:
+            self.queue =3D self.queue + self.input.read(102400)
+        except (OSError, IOError):
+            pass
+        end =3D len(self.queue)
+        index =3D self.queue.find("</event>")
+        while index !=3D -1:
+            worker_fire_prepickled(self.queue[:index+8])
+            self.queue =3D self.queue[index+8:]
+            index =3D self.queue.find("</event>")
+        return (end > start)
+
+    def close(self):
+        while self.read():
+            continue
+        if len(self.queue) > 0:
+            print("Warning, worker child left partial message: %s" % self.=
queue)
+        self.input.close()
+
+normalexit =3D False
+
+class BitbakeWorker(object):
+    def __init__(self, din):
+        self.input =3D din
+        bb.utils.nonblockingfd(self.input)
+        self.queue =3D ""
+        self.cookercfg =3D None
+        self.databuilder =3D None
+        self.data =3D None
+        self.build_pids =3D {}
+        self.build_pipes =3D {}
+   =20
+    def serve(self):       =20
+        while True:
+            (ready, _, _) =3D select.select([self.input] + [i.input for i =
in self.build_pipes.values()], [] , [], 1)
+            if self.input in ready:
+                start =3D len(self.queue)
+                try:
+                    self.queue =3D self.queue + self.input.read()
+                except (OSError, IOError):
+                    pass
+                end =3D len(self.queue)
+                self.handle_item("cookerconfig", self.handle_cookercfg)
+                self.handle_item("workerdata", self.handle_workerdata)
+                self.handle_item("runtask", self.handle_runtask)
+                self.handle_item("finishnow", self.handle_finishnow)
+                self.handle_item("ping", self.handle_ping)
+                self.handle_item("quit", self.handle_quit)
+
+            worker_flush()
+            if len(self.build_pids):
+                self.process_waitpid()
+            for pipe in self.build_pipes:
+                self.build_pipes[pipe].read()
+
+
+    def handle_item(self, item, func):
+        if self.queue.startswith("<" + item + ">"):
+            index =3D self.queue.find("</" + item + ">")
+            while index !=3D -1:
+                func(self.queue[(len(item) + 2):index])
+                self.queue =3D self.queue[(index + len(item) + 3):]
+                index =3D self.queue.find("</" + item + ">")
+
+    def handle_cookercfg(self, data):
+        self.cookercfg =3D pickle.loads(data)
+        self.databuilder =3D bb.cookerdata.CookerDataBuilder(self.cookercf=
g, worker=3DTrue)
+        logger.warn("Have databuilder %s" % self.databuilder)
+        self.databuilder.parseBaseConfiguration()
+        self.data =3D self.databuilder.data
+        logger.warn("Have datastore %s" % self.data)
+
+    def handle_workerdata(self, data):
+        self.workerdata =3D pickle.loads(data)
+        bb.msg.loggerDefaultDebugLevel =3D self.workerdata["logdefaultdebu=
g"]
+        bb.msg.loggerDefaultVerbose =3D self.workerdata["logdefaultverbose=
"]
+        bb.msg.loggerVerboseLogs =3D self.workerdata["logdefaultverboselog=
s"]
+        bb.msg.loggerDefaultDomains =3D self.workerdata["logdefaultdomain"=
]
+
+    def handle_ping(self, _):
+        lf.write("Handling ping\n")
+        lf.flush()
+
+        logger.warn("Pong!")
+
+    def handle_quit(self, data):
+        lf.write("Handling quit\n")
+        lf.flush()
+
+        global normalexit
+        normalexit =3D True
+        sys.exit(0)
+
+    def handle_runtask(self, data):
+        fn, task, taskname, quieterrors, appends =3D pickle.loads(data)
+        pid, pipein, pipeout =3D fork_off_task(self.cookercfg, self.data, =
self.workerdata, fn, task, taskname, appends, quieterrors)
+
+        lf.write("Handling runtask %s %s %s\n" % (task, fn, taskname))
+        lf.flush()
+
+
+        self.build_pids[pid] =3D task
+        self.build_pipes[pid] =3D runQueueWorkerPipe(pipein, pipeout)
+
+    def process_waitpid(self):
+        """
+        Return none is there are no processes awaiting result collection, =
otherwise
+        collect the process exit codes and close the information pipe.
+        """
+        try:
+            pid, status =3D os.waitpid(-1, os.WNOHANG)
+            if pid =3D=3D 0 or os.WIFSTOPPED(status):
+                return None
+        except OSError:
+            return None
+
+        lf.write("Got %s for %s\n" % (status, pid))
+        lf.flush()
+
+        if os.WIFEXITED(status):
+            status =3D os.WEXITSTATUS(status)
+        elif os.WIFSIGNALED(status):
+            # Per shell conventions for $?, when a process exits due to
+            # a signal, we return an exit code of 128 + SIGNUM
+            status =3D 128 + os.WTERMSIG(status)
+
+        task =3D self.build_pids[pid]
+        del self.build_pids[pid]
+
+        self.build_pipes[pid].close()
+        del self.build_pipes[pid]
+
+        worker_fire_prepickled("<exitcode>" + pickle.dumps((task, status))=
 + "</exitcode>")
+
+    def handle_finishnow(self, _):
+        if self.build_pids:
+            logger.info("Sending SIGTERM to remaining %s tasks", len(self.=
build_pids))
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
+    worker =3D BitbakeWorker(sys.stdin)
+    worker.serve()
+except BaseException as e:
+    if not normalexit:
+        import traceback
+        sys.stderr.write(traceback.format_exc())
+        sys.stderr.write(str(e))
+while len(worker_queue):
+    worker_flush()
+lf.write("exitting")
+lf.flush()
+sys.exit(0)
+
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 9e89742..a38ca0d 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -715,7 +715,6 @@ class CacheData(object):
         for info in info_array:
             info.add_cacheData(self, fn)
=20
-
 class MultiProcessCache(object):
     """
     BitBake multi-process cache implementation
@@ -737,13 +736,18 @@ class MultiProcessCache(object):
         self.cachefile =3D os.path.join(cachedir, self.__class__.cache_fil=
e_name)
         logger.debug(1, "Using cache in '%s'", self.cachefile)
=20
+        glf =3D bb.utils.lockfile(self.cachefile + ".lock")
+
         try:
             with open(self.cachefile, "rb") as f:
                 p =3D pickle.Unpickler(f)
                 data, version =3D p.load()
         except:
+            bb.utils.unlockfile(glf)
             return
=20
+        bb.utils.unlockfile(glf)
+
         if version !=3D self.__class__.CACHE_VERSION:
             return
=20
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
=20
 logger      =3D logging.getLogger("BitBake")
 parselog    =3D logging.getLogger("BitBake.Parsing")
@@ -139,6 +141,20 @@ class CookerConfiguration(object):
     def setServerRegIdleCallback(self, srcb):
         self.server_register_idlecallback =3D srcb
=20
+    def __getstate__(self):
+        state =3D {}
+        for key in self.__dict__.keys():
+            if key =3D=3D "server_register_idlecallback":
+                state[key] =3D None
+            else:
+                state[key] =3D getattr(self, key)
+        return state
+
+    def __setstate__(self,state):
+        for k in state:
+            setattr(self, k, state[k])=20
+
+
 def catch_parse_error(func):
     """Exception handling bits for our parsing"""
     @wraps(func)
@@ -146,6 +162,8 @@ def catch_parse_error(func):
         try:
             return func(fn, *args)
         except (IOError, bb.parse.ParseError, bb.data_smart.ExpansionError=
) as exc:
+            import traceback
+            parselog.critical( traceback.format_exc())
             parselog.critical("Unable to parse %s: %s" % (fn, exc))
             sys.exit(1)
     return wrapped
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 2826e35..abc3892 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -33,6 +33,7 @@ import atexit
 import traceback
 import bb.utils
 import bb.compat
+import bb.exceptions
=20
 # This is the pid for which we should generate the event. This is set when
 # the runqueue forks off.
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 090d1b5..9f92ce6 100644
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
=20
 bblogger =3D logging.getLogger("BitBake")
 logger =3D logging.getLogger("BitBake.RunQueue")
@@ -938,6 +945,10 @@ class RunQueue:
             raise
         except:
             logger.error("An uncaught exception occured in runqueue, pleas=
e see the failure below:")
+            try:
+                self.rqexe.teardown()
+            except:
+                pass
             self.state =3D runQueueComplete
             raise
=20
@@ -979,38 +990,42 @@ class RunQueueExecute:
         self.runq_buildable =3D []
         self.runq_running =3D []
         self.runq_complete =3D []
-        self.build_pids =3D {}
-        self.build_pipes =3D {}
+
         self.build_stamps =3D {}
         self.failed_fnids =3D []
=20
         self.stampcache =3D {}
=20
-    def runqueue_process_waitpid(self):
-        """
-        Return none is there are no processes awaiting result collection, =
otherwise
-        collect the process exit codes and close the information pipe.
-        """
-        pid, status =3D os.waitpid(-1, os.WNOHANG)
-        if pid =3D=3D 0 or os.WIFSTOPPED(status):
-            return None
-
-        if os.WIFEXITED(status):
-            status =3D os.WEXITSTATUS(status)
-        elif os.WIFSIGNALED(status):
-            # Per shell conventions for $?, when a process exits due to
-            # a signal, we return an exit code of 128 + SIGNUM
-            status =3D 128 + os.WTERMSIG(status)
-
-        task =3D self.build_pids[pid]
-        del self.build_pids[pid]
-
-        self.build_pipes[pid].close()
-        del self.build_pipes[pid]
+        logger.warn("Starting worker")
+        self.worker =3D subprocess.Popen("bitbake-worker", stdout=3Dsubpro=
cess.PIPE, stdin=3Dsubprocess.PIPE)
+        bb.utils.nonblockingfd(self.worker.stdout)
+        self.workerpipe =3D runQueuePipe(self.worker.stdout, None, self.cf=
gData, self)
+
+        workerdata =3D {
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
+        self.worker.stdin.write("<cookerconfig>" + pickle.dumps(self.cooke=
r.configuration) + "</cookerconfig>")
+        self.worker.stdin.write("<workerdata>" + pickle.dumps(workerdata) =
+ "</workerdata>")
+        self.worker.stdin.write("<ping></ping>")
+        self.worker.stdin.flush()
+
+    def runqueue_process_waitpid(self, task, status):
=20
         # self.build_stamps[pid] may not exist when use shared work direct=
ory.
-        if pid in self.build_stamps:
-            del self.build_stamps[pid]
+        if task in self.build_stamps:
+            del self.build_stamps[task]
=20
         if status !=3D 0:
             self.task_fail(task, status)
@@ -1019,16 +1034,11 @@ class RunQueueExecute:
         return True
=20
     def finish_now(self):
-        if self.stats.active:
-            logger.info("Sending SIGTERM to remaining %s tasks", self.stat=
s.active)
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
=20
         if len(self.failed_fnids) !=3D 0:
             self.rq.state =3D runQueueFailed
@@ -1040,14 +1050,13 @@ class RunQueueExecute:
     def finish(self):
         self.rq.state =3D runQueueCleanUp
=20
-        for pipe in self.build_pipes:
-            self.build_pipes[pipe].read()
-
         if self.stats.active > 0:
             bb.event.fire(runQueueExitWait(self.stats.active), self.cfgDat=
a)
-            self.runqueue_process_waitpid()
+            self.workerpipe.read()
             return
=20
+        self.teardown()
+
         if len(self.failed_fnids) !=3D 0:
             self.rq.state =3D runQueueFailed
             return
@@ -1055,115 +1064,6 @@ class RunQueueExecute:
         self.rq.state =3D runQueueComplete
         return
=20
-    def fork_off_task(self, fn, task, taskname, quieterrors=3DFalse):
-        # We need to setup the environment BEFORE the fork, since
-        # a fork() or exec*() activates PSEUDO...
-
-        envbackup =3D {}
-        fakeenv =3D {}
-        umask =3D None
-
-        taskdep =3D self.rqdata.dataCache.task_deps[fn]
-        if 'umask' in taskdep and taskname in taskdep['umask']:
-            # umask might come in as a number or text string..
-            try:
-                 umask =3D int(taskdep['umask'][taskname],8)
-            except TypeError:
-                 umask =3D taskdep['umask'][taskname]
-
-        if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
-            envvars =3D (self.rqdata.dataCache.fakerootenv[fn] or "").spli=
t()
-            for key, value in (var.split('=3D') for var in envvars):
-                envbackup[key] =3D os.environ.get(key)
-                os.environ[key] =3D value
-                fakeenv[key] =3D value
-
-            fakedirs =3D (self.rqdata.dataCache.fakerootdirs[fn] or "").sp=
lit()
-            for p in fakedirs:
-                bb.utils.mkdirhier(p)
-
-            logger.debug(2, 'Running %s:%s under fakeroot, fakedirs: %s' %
-                            (fn, taskname, ', '.join(fakedirs)))
-        else:
-            envvars =3D (self.rqdata.dataCache.fakerootnoenv[fn] or "").sp=
lit()
-            for key, value in (var.split('=3D') for var in envvars):
-                envbackup[key] =3D os.environ.get(key)
-                os.environ[key] =3D value
-                fakeenv[key] =3D value
-
-        sys.stdout.flush()
-        sys.stderr.flush()
-        try:
-            pipein, pipeout =3D os.pipe()
-            pipein =3D os.fdopen(pipein, 'rb', 4096)
-            pipeout =3D os.fdopen(pipeout, 'wb', 0)
-            pid =3D os.fork()
-        except OSError as e:
-            bb.msg.fatal("RunQueue", "fork failed: %d (%s)" % (e.errno, e.=
strerror))
-
-        if pid =3D=3D 0:
-            pipein.close()
-
-            # Save out the PID so that the event can include it the
-            # events
-            bb.event.worker_pid =3D os.getpid()
-            bb.event.worker_pipe =3D pipeout
-
-            self.rq.state =3D runQueueChildProcess
-            # Make the child the process group leader
-            os.setpgid(0, 0)
-            # No stdin
-            newsi =3D os.open(os.devnull, os.O_RDWR)
-            os.dup2(newsi, sys.stdin.fileno())
-
-            if umask:
-                os.umask(umask)
-
-            self.cooker.data.setVar("BB_WORKERCONTEXT", "1")
-            bb.parse.siggen.set_taskdata(self.rqdata.hashes, self.rqdata.h=
ash_deps)
-            ret =3D 0
-            try:
-                the_data =3D bb.cache.Cache.loadDataFull(fn, self.cooker.c=
ollection.get_file_appends(fn), self.cooker.data)
-                the_data.setVar('BB_TASKHASH', self.rqdata.runq_hash[task]=
)
-                for h in self.rqdata.hashes:
-                    the_data.setVar("BBHASH_%s" % h, self.rqdata.hashes[h]=
)
-                for h in self.rqdata.hash_deps:
-                    the_data.setVar("BBHASHDEPS_%s" % h, self.rqdata.hash_=
deps[h])
-
-                # exported_vars() returns a generator which *cannot* be pa=
ssed to os.environ.update()=20
-                # successfully. We also need to unset anything from the en=
vironment which shouldn't be there=20
-                exports =3D bb.data.exported_vars(the_data)
-                bb.utils.empty_environment()
-                for e, v in exports:
-                    os.environ[e] =3D v
-                for e in fakeenv:
-                    os.environ[e] =3D fakeenv[e]
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
-                    profile =3D self.cooker.configuration.profile
-                    ret =3D bb.build.exec_task(fn, taskname, the_data, pro=
file)
-                os._exit(ret)
-            except:
-                os._exit(1)
-        else:
-            for key, value in envbackup.iteritems():
-                if value is None:
-                    del os.environ[key]
-                else:
-                    os.environ[key] =3D value
-
-        return pid, pipein, pipeout
-
     def check_dependencies(self, task, taskdeps, setscene =3D False):
         if not self.rq.depvalidate:
             return False
@@ -1184,6 +1084,16 @@ class RunQueueExecute:
         valid =3D bb.utils.better_eval(call, locs)
         return valid
=20
+    def teardown(self):
+        logger.warn("Teardown called")
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
         self.rq =3D rq
@@ -1275,7 +1185,6 @@ class RunQueueExecuteTasks(RunQueueExecute):
             bb.fatal("Invalid scheduler '%s'.  Available schedulers: %s" %
                      (self.scheduler, ", ".join(obj.name for obj in schedu=
lers)))
=20
-
     def get_schedulers(self):
         schedulers =3D set(obj for obj in globals().values()
                              if type(obj) is type and
@@ -1349,6 +1258,9 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Run the tasks in a queue prepared by rqdata.prepare()
         """
=20
+        self.workerpipe.read()
+       =20
+
         if self.stats.total =3D=3D 0:
             # nothing to do
             self.rq.state =3D runQueueCleanUp
@@ -1384,23 +1296,19 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 startevent =3D runQueueTaskStarted(task, self.stats, self.=
rq)
                 bb.event.fire(startevent, self.cfgData)
=20
-            pid, pipein, pipeout =3D self.fork_off_task(fn, task, taskname=
)
+            self.worker.stdin.write("<runtask>" + pickle.dumps((fn, task, =
taskname, False, self.cooker.collection.get_file_appends(fn))) + "</runtask=
>")
=20
-            self.build_pids[pid] =3D task
-            self.build_pipes[pid] =3D runQueuePipe(pipein, pipeout, self.c=
fgData)
-            self.build_stamps[pid] =3D bb.build.stampfile(taskname, self.r=
qdata.dataCache, fn)
+            self.build_stamps[task] =3D bb.build.stampfile(taskname, self.=
rqdata.dataCache, fn)
             self.runq_running[task] =3D 1
             self.stats.taskActive()
             if self.stats.active < self.number_tasks:
                 return True
=20
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
=20
         if len(self.failed_fnids) !=3D 0:
             self.rq.state =3D runQueueFailed
@@ -1415,6 +1323,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             if self.runq_complete[task] =3D=3D 0:
                 logger.error("Task %s never completed!", task)
         self.rq.state =3D runQueueComplete
+
         return True
=20
 class RunQueueExecuteScenequeue(RunQueueExecute):
@@ -1428,6 +1337,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # If we don't have any setscene functions, skip this step
         if len(self.rqdata.runq_setscene) =3D=3D 0:
             rq.scenequeue_covered =3D set()
+            self.teardown()
             rq.state =3D runQueueRunInit
             return
=20
@@ -1676,6 +1586,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         Run the tasks in a queue prepared by prepare_runqueue
         """
=20
+        self.workerpipe.read()
+
         task =3D None
         if self.stats.active < self.number_tasks:
             # Find the next setscene to run
@@ -1716,22 +1628,16 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             startevent =3D sceneQueueTaskStarted(task, self.stats, self.rq=
)
             bb.event.fire(startevent, self.cfgData)
=20
-            pid, pipein, pipeout =3D self.fork_off_task(fn, realtask, task=
name)
+            self.worker.stdin.write("<runtask>" + pickle.dumps((fn, realta=
sk, taskname, True, self.cooker.collection.get_file_appends(fn))) + "</runt=
ask>")
=20
-            self.build_pids[pid] =3D task
-            self.build_pipes[pid] =3D runQueuePipe(pipein, pipeout, self.c=
fgData)
             self.runq_running[task] =3D 1
             self.stats.taskActive()
             if self.stats.active < self.number_tasks:
                 return True
=20
-        for pipe in self.build_pipes:
-            self.build_pipes[pipe].read()
-
         if self.stats.active > 0:
-            if self.runqueue_process_waitpid() is None:
-                return 0.5
-            return True
+            self.workerpipe.read()
+            return 0.5
=20
         # Convert scenequeue_covered task numbers into full taskgraph ids
         oldcovered =3D self.scenequeue_covered
@@ -1745,11 +1651,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         logger.debug(1, 'We can skip tasks %s', sorted(self.rq.scenequeue_=
covered))
=20
         self.rq.state =3D runQueueRunInit
+        self.teardown()
         return True
=20
-    def fork_off_task(self, fn, task, taskname):
-        return RunQueueExecute.fork_off_task(self, fn, task, taskname, qui=
eterrors=3DTrue)
-
 class TaskFailure(Exception):
     """
     Exception raised when a task in a runqueue fails
@@ -1828,25 +1732,42 @@ class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
     """
-    def __init__(self, pipein, pipeout, d):
+    def __init__(self, pipein, pipeout, d, rq):
         self.input =3D pipein
-        pipeout.close()
+        if pipeout:
+            pipeout.close()
         bb.utils.nonblockingfd(self.input)
         self.queue =3D ""
         self.d =3D d
+        self.rq =3D rq
+
+    def setrunqueue(self, rq):
+        self.rq =3D rq
=20
     def read(self):
         start =3D len(self.queue)
         try:
             self.queue =3D self.queue + self.input.read(102400)
-        except (OSError, IOError):
-            pass
+        except (OSError, IOError) as e:
+            if e.errno !=3D errno.EAGAIN:
+                raise
         end =3D len(self.queue)
-        indexFrom 9df95c7903fe69b37958b1357c3da8e1f21d0bd1 Mon Sep 17 00:0=
0:00 2001
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Thu, 30 May 2013 12:29:32 +0000
Subject: Start work on bitbake-worker

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
new file mode 100755
index 0000000..1f511d2
--- /dev/null
+++ b/bitbake/bin/bitbake-worker
@@ -0,0 +1,354 @@
+#!/usr/bin/env python
+
+import os
+import sys
+import warnings
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0=
])), 'lib'))
+from bb import fetch2
+import logging
+import bb
+import select
+import errno
+
+logger =3D logging.getLogger("BitBake")
+
+try:
+    import cPickle as pickle
+except ImportError:
+    import pickle
+    bb.msg.note(1, bb.msg.domain.Cache, "Importing cPickle failed. Falling=
 back to a very slow implementation.")
+
+bb.event.worker_pid =3D os.getpid()
+workerpipe =3D sys.stdout.fileno()
+bb.event.worker_pipe =3D workerpipe
+
+handler =3D bb.event.LogHandler()
+logger.addHandler(handler)
+
+bb.msg.init_msgconfig(False, 0, [])
+
+if 1:
+        format_str =3D "%(levelname)s: %(message)s"
+        conlogformat =3D bb.msg.BBLogFormatter(format_str)
+        consolelog =3D logging.FileHandler("/tmp/rp6")
+        bb.msg.addDefaultlogFilter(consolelog)
+        consolelog.setFormatter(conlogformat)
+        logger.addHandler(consolelog)
+
+lf =3D open("/tmp/rp7", "w+")
+
+bb.utils.nonblockingfd(workerpipe)
+
+
+worker_queue =3D ""
+
+def worker_fire(event, d):
+    global worker_queue
+
+    data =3D "<event>" + pickle.dumps(event) + "</event>"
+    worker_fire_prepickled(data)
+
+def worker_fire_prepickled(event):
+    global worker_queue
+
+    worker_queue =3D worker_queue + event
+    worker_flush()
+
+def worker_flush():
+    global worker_queue
+    if not worker_queue:
+        return
+
+    try:
+        written =3D os.write(bb.event.worker_pipe, worker_queue)
+        worker_queue =3D worker_queue[written:]
+    except (IOError, OSError) as e:
+        if e.errno !=3D errno.EAGAIN:
+            raise
+
+worker_fire_orig =3D bb.event.worker_fire
+bb.event.worker_fire =3D worker_fire
+
+
+def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, quie=
terrors=3DFalse):
+    # We need to setup the environment BEFORE the fork, since
+    # a fork() or exec*() activates PSEUDO...
+
+    envbackup =3D {}
+    fakeenv =3D {}
+    umask =3D None
+
+    taskdep =3D workerdata["taskdeps"][fn]
+    if 'umask' in taskdep and taskname in taskdep['umask']:
+        # umask might come in as a number or text string..
+        try:
+             umask =3D int(taskdep['umask'][taskname],8)
+        except TypeError:
+             umask =3D taskdep['umask'][taskname]
+
+    if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
+        envvars =3D (workerdata["fakerootenv"][fn] or "").split()
+        for key, value in (var.split('=3D') for var in envvars):
+            envbackup[key] =3D os.environ.get(key)
+            os.environ[key] =3D value
+            fakeenv[key] =3D value
+
+        fakedirs =3D (workerdata["fakerootdirs"][fn] or "").split()
+        for p in fakedirs:
+            bb.utils.mkdirhier(p)
+        logger.debug(2, 'Running %s:%s under fakeroot, fakedirs: %s' %
+                        (fn, taskname, ', '.join(fakedirs)))
+    else:
+        envvars =3D (workerdata["fakerootnoenv"][fn] or "").split()
+        for key, value in (var.split('=3D') for var in envvars):
+            envbackup[key] =3D os.environ.get(key)
+            os.environ[key] =3D value
+            fakeenv[key] =3D value
+
+    sys.stdout.flush()
+    sys.stderr.flush()
+    try:
+        pipein, pipeout =3D os.pipe()
+        pipein =3D os.fdopen(pipein, 'rb', 4096)
+        pipeout =3D os.fdopen(pipeout, 'wb', 0)
+        pid =3D os.fork()
+    except OSError as e:
+        bb.msg.fatal("RunQueue", "fork failed: %d (%s)" % (e.errno, e.stre=
rror))
+
+    if pid =3D=3D 0:
+            pipein.close()
+
+            # Save out the PID so that the event can include it the
+            # events
+            bb.event.worker_pid =3D os.getpid()
+            bb.event.worker_pipe =3D pipeout
+            bb.event.worker_fire =3D worker_fire_orig
+
+            # Make the child the process group leader
+            os.setpgid(0, 0)
+            # No stdin
+            newsi =3D os.open(os.devnull, os.O_RDWR)
+            os.dup2(newsi, sys.stdin.fileno())
+
+            if umask:
+                os.umask(umask)
+
+            data.setVar("BB_WORKERCONTEXT", "1")
+            bb.parse.siggen.set_taskdata(workerdata["hashes"], workerdata[=
"hash_deps"], workerdata["sigchecksums"])
+            ret =3D 0
+            try:
+                the_data =3D bb.cache.Cache.loadDataFull(fn, appends, data=
)
+                the_data.setVar('BB_TASKHASH', workerdata["runq_hash"][tas=
k])
+                for h in workerdata["hashes"]:
+                    the_data.setVar("BBHASH_%s" % h, workerdata["hashes"][=
h])
+                for h in workerdata["hash_deps"]:
+                    the_data.setVar("BBHASHDEPS_%s" % h, workerdata["hash_=
deps"][h])
+
+                # exported_vars() returns a generator which *cannot* be pa=
ssed to os.environ.update()=20
+                # successfully. We also need to unset anything from the en=
vironment which shouldn't be there=20
+                exports =3D bb.data.exported_vars(the_data)
+                bb.utils.empty_environment()
+                for e, v in exports:
+                    os.environ[e] =3D v
+                for e in fakeenv:
+                    os.environ[e] =3D fakeenv[e]
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
+                    ret =3D bb.build.exec_task(fn, taskname, the_data, cfg=
.profile)
+                os._exit(ret)
+            except:
+                os._exit(1)
+    else:
+        for key, value in envbackup.iteritems():
+            if value is None:
+                del os.environ[key]
+            else:
+                os.environ[key] =3D value
+
+    return pid, pipein, pipeout
+
+
+
+class runQueueWorkerPipe():
+    """
+    Abstraction for a pipe between a worker thread and the worker server
+    """
+    def __init__(self, pipein, pipeout):
+        self.input =3D pipein
+        if pipeout:
+            pipeout.close()
+        bb.utils.nonblockingfd(self.input)
+        self.queue =3D ""
+
+    def read(self):
+        start =3D len(self.queue)
+        try:
+            self.queue =3D self.queue + self.input.read(102400)
+        except (OSError, IOError):
+            pass
+        end =3D len(self.queue)
+        index =3D self.queue.find("</event>")
+        while index !=3D -1:
+            worker_fire_prepickled(self.queue[:index+8])
+            self.queue =3D self.queue[index+8:]
+            index =3D self.queue.find("</event>")
+        return (end > start)
+
+    def close(self):
+        while self.read():
+            continue
+        if len(self.queue) > 0:
+            print("Warning, worker child left partial message: %s" % self.=
queue)
+        self.input.close()
+
+normalexit =3D False
+
+class BitbakeWorker(object):
+    def __init__(self, din):
+        self.input =3D din
+        bb.utils.nonblockingfd(self.input)
+        self.queue =3D ""
+        self.cookercfg =3D None
+        self.databuilder =3D None
+        self.data =3D None
+        self.build_pids =3D {}
+        self.build_pipes =3D {}
+   =20
+    def serve(self):       =20
+        while True:
+            (ready, _, _) =3D select.select([self.input] + [i.input for i =
in self.build_pipes.values()], [] , [], 1)
+            if self.input in ready:
+                start =3D len(self.queue)
+                try:
+                    self.queue =3D self.queue + self.input.read()
+                except (OSError, IOError):
+                    pass
+                end =3D len(self.queue)
+                self.handle_item("cookerconfig", self.handle_cookercfg)
+                self.handle_item("workerdata", self.handle_workerdata)
+                self.handle_item("runtask", self.handle_runtask)
+                self.handle_item("finishnow", self.handle_finishnow)
+                self.handle_item("ping", self.handle_ping)
+                self.handle_item("quit", self.handle_quit)
+
+            worker_flush()
+            if len(self.build_pids):
+                self.process_waitpid()
+            for pipe in self.build_pipes:
+                self.build_pipes[pipe].read()
+
+
+    def handle_item(self, item, func):
+        if self.queue.startswith("<" + item + ">"):
+            index =3D self.queue.find("</" + item + ">")
+            while index !=3D -1:
+                func(self.queue[(len(item) + 2):index])
+                self.queue =3D self.queue[(index + len(item) + 3):]
+                index =3D self.queue.find("</" + item + ">")
+
+    def handle_cookercfg(self, data):
+        self.cookercfg =3D pickle.loads(data)
+        self.databuilder =3D bb.cookerdata.CookerDataBuilder(self.cookercf=
g, worker=3DTrue)
+        logger.warn("Have databuilder %s" % self.databuilder)
+        self.databuilder.parseBaseConfiguration()
+        self.data =3D self.databuilder.data
+        logger.warn("Have datastore %s" % self.data)
+
+    def handle_workerdata(self, data):
+        self.workerdata =3D pickle.loads(data)
+        bb.msg.loggerDefaultDebugLevel =3D self.workerdata["logdefaultdebu=
g"]
+        bb.msg.loggerDefaultVerbose =3D self.workerdata["logdefaultverbose=
"]
+        bb.msg.loggerVerboseLogs =3D self.workerdata["logdefaultverboselog=
s"]
+        bb.msg.loggerDefaultDomains =3D self.workerdata["logdefaultdomain"=
]
+
+    def handle_ping(self, _):
+        lf.write("Handling ping\n")
+        lf.flush()
+
+        logger.warn("Pong!")
+
+    def handle_quit(self, data):
+        lf.write("Handling quit\n")
+        lf.flush()
+
+        global normalexit
+        normalexit =3D True
+        sys.exit(0)
+
+    def handle_runtask(self, data):
+        fn, task, taskname, quieterrors, appends =3D pickle.loads(data)
+        pid, pipein, pipeout =3D fork_off_task(self.cookercfg, self.data, =
self.workerdata, fn, task, taskname, appends, quieterrors)
+
+        lf.write("Handling runtask %s %s %s\n" % (task, fn, taskname))
+        lf.flush()
+
+
+        self.build_pids[pid] =3D task
+        self.build_pipes[pid] =3D runQueueWorkerPipe(pipein, pipeout)
+
+    def process_waitpid(self):
+        """
+        Return none is there are no processes awaiting result collection, =
otherwise
+        collect the process exit codes and close the information pipe.
+        """
+        try:
+            pid, status =3D os.waitpid(-1, os.WNOHANG)
+            if pid =3D=3D 0 or os.WIFSTOPPED(status):
+                return None
+        except OSError:
+            return None
+
+        lf.write("Got %s for %s\n" % (status, pid))
+        lf.flush()
+
+        if os.WIFEXITED(status):
+            status =3D os.WEXITSTATUS(status)
+        elif os.WIFSIGNALED(status):
+            # Per shell conventions for $?, when a process exits due to
+            # a signal, we return an exit code of 128 + SIGNUM
+            status =3D 128 + os.WTERMSIG(status)
+
+        task =3D self.build_pids[pid]
+        del self.build_pids[pid]
+
+        self.build_pipes[pid].close()
+        del self.build_pipes[pid]
+
+        worker_fire_prepickled("<exitcode>" + pickle.dumps((task, status))=
 + "</exitcode>")
+
+    def handle_finishnow(self, _):
+        if self.build_pids:
+            logger.info("Sending SIGTERM to remaining %s tasks", len(self.=
build_pids))
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
+    worker =3D BitbakeWorker(sys.stdin)
+    worker.serve()
+except BaseException as e:
+    if not normalexit:
+        import traceback
+        sys.stderr.write(traceback.format_exc())
+        sys.stderr.write(str(e))
+while len(worker_queue):
+    worker_flush()
+lf.write("exitting")
+lf.flush()
+sys.exit(0)
+
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 9e89742..a38ca0d 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -715,7 +715,6 @@ class CacheData(object):
         for info in info_array:
             info.add_cacheData(self, fn)
=20
-
 class MultiProcessCache(object):
     """
     BitBake multi-process cache implementation
@@ -737,13 +736,18 @@ class MultiProcessCache(object):
         self.cachefile =3D os.path.join(cachedir, self.__class__.cache_fil=
e_name)
         logger.debug(1, "Using cache in '%s'", self.cachefile)
=20
+        glf =3D bb.utils.lockfile(self.cachefile + ".lock")
+
         try:
             with open(self.cachefile, "rb") as f:
                 p =3D pickle.Unpickler(f)
                 data, version =3D p.load()
         except:
+            bb.utils.unlockfile(glf)
             return
=20
+        bb.utils.unlockfile(glf)
+
         if version !=3D self.__class__.CACHE_VERSION:
             return
=20
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
=20
 logger      =3D logging.getLogger("BitBake")
 parselog    =3D logging.getLogger("BitBake.Parsing")
@@ -139,6 +141,20 @@ class CookerConfiguration(object):
     def setServerRegIdleCallback(self, srcb):
         self.server_register_idlecallback =3D srcb
=20
+    def __getstate__(self):
+        state =3D {}
+        for key in self.__dict__.keys():
+            if key =3D=3D "server_register_idlecallback":
+                state[key] =3D None
+            else:
+                state[key] =3D getattr(self, key)
+        return state
+
+    def __setstate__(self,state):
+        for k in state:
+            setattr(self, k, state[k])=20
+
+
 def catch_parse_error(func):
     """Exception handling bits for our parsing"""
     @wraps(func)
@@ -146,6 +162,8 @@ def catch_parse_error(func):
         try:
             return func(fn, *args)
         except (IOError, bb.parse.ParseError, bb.data_smart.ExpansionError=
) as exc:
+            import traceback
+            parselog.critical( traceback.format_exc())
             parselog.critical("Unable to parse %s: %s" % (fn, exc))
             sys.exit(1)
     return wrapped
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 2826e35..abc3892 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -33,6 +33,7 @@ import atexit
 import traceback
 import bb.utils
 import bb.compat
+import bb.exceptions
=20
 # This is the pid for which we should generate the event. This is set when
 # the runqueue forks off.
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 090d1b5..9f92ce6 100644
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
=20
 bblogger =3D logging.getLogger("BitBake")
 logger =3D logging.getLogger("BitBake.RunQueue")
@@ -938,6 +945,10 @@ class RunQueue:
             raise
         except:
             logger.error("An uncaught exception occured in runqueue, pleas=
e see the failure below:")
+            try:
+                self.rqexe.teardown()
+            except:
+                pass
             self.state =3D runQueueComplete
             raise
=20
@@ -979,38 +990,42 @@ class RunQueueExecute:
         self.runq_buildable =3D []
         self.runq_running =3D []
         self.runq_complete =3D []
-        self.build_pids =3D {}
-        self.build_pipes =3D {}
+
         self.build_stamps =3D {}
         self.failed_fnids =3D []
=20
         self.stampcache =3D {}
=20
-    def runqueue_process_waitpid(self):
-        """
-        Return none is there are no processes awaiting result collection, =
otherwise
-        collect the process exit codes and close the information pipe.
-        """
-        pid, status =3D os.waitpid(-1, os.WNOHANG)
-        if pid =3D=3D 0 or os.WIFSTOPPED(status):
-            return None
-
-        if os.WIFEXITED(status):
-            status =3D os.WEXITSTATUS(status)
-        elif os.WIFSIGNALED(status):
-            # Per shell conventions for $?, when a process exits due to
-            # a signal, we return an exit code of 128 + SIGNUM
-            status =3D 128 + os.WTERMSIG(status)
-
-        task =3D self.build_pids[pid]
-        del self.build_pids[pid]
-
-        self.build_pipes[pid].close()
-        del self.build_pipes[pid]
+        logger.warn("Starting worker")
+        self.worker =3D subprocess.Popen("bitbake-worker", stdout=3Dsubpro=
cess.PIPE, stdin=3Dsubprocess.PIPE)
+        bb.utils.nonblockingfd(self.worker.stdout)
+        self.workerpipe =3D runQueuePipe(self.worker.stdout, None, self.cf=
gData, self)
+
+        workerdata =3D {
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
+        self.worker.stdin.write("<cookerconfig>" + pickle.dumps(self.cooke=
r.configuration) + "</cookerconfig>")
+        self.worker.stdin.write("<workerdata>" + pickle.dumps(workerdata) =
+ "</workerdata>")
+        self.worker.stdin.write("<ping></ping>")
+        self.worker.stdin.flush()
+
+    def runqueue_process_waitpid(self, task, status):
=20
         # self.build_stamps[pid] may not exist when use shared work direct=
ory.
-        if pid in self.build_stamps:
-            del self.build_stamps[pid]
+        if task in self.build_stamps:
+            del self.build_stamps[task]
=20
         if status !=3D 0:
             self.task_fail(task, status)
@@ -1019,16 +1034,11 @@ class RunQueueExecute:
         return True
=20
     def finish_now(self):
-        if self.stats.active:
-            logger.info("Sending SIGTERM to remaining %s tasks", self.stat=
s.active)
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
=20
         if len(self.failed_fnids) !=3D 0:
             self.rq.state =3D runQueueFailed
@@ -1040,14 +1050,13 @@ class RunQueueExecute:
     def finish(self):
         self.rq.state =3D runQueueCleanUp
=20
-        for pipe in self.build_pipes:
-            self.build_pipes[pipe].read()
-
         if self.stats.active > 0:
             bb.event.fire(runQueueExitWait(self.stats.active), self.cfgDat=
a)
-            self.runqueue_process_waitpid()
+            self.workerpipe.read()
             return
=20
+        self.teardown()
+
         if len(self.failed_fnids) !=3D 0:
             self.rq.state =3D runQueueFailed
             return
@@ -1055,115 +1064,6 @@ class RunQueueExecute:
         self.rq.state =3D runQueueComplete
         return
=20
-    def fork_off_task(self, fn, task, taskname, quieterrors=3DFalse):
-        # We need to setup the environment BEFORE the fork, since
-        # a fork() or exec*() activates PSEUDO...
-
-        envbackup =3D {}
-        fakeenv =3D {}
-        umask =3D None
-
-        taskdep =3D self.rqdata.dataCache.task_deps[fn]
-        if 'umask' in taskdep and taskname in taskdep['umask']:
-            # umask might come in as a number or text string..
-            try:
-                 umask =3D int(taskdep['umask'][taskname],8)
-            except TypeError:
-                 umask =3D taskdep['umask'][taskname]
-
-        if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
-            envvars =3D (self.rqdata.dataCache.fakerootenv[fn] or "").spli=
t()
-            for key, value in (var.split('=3D') for var in envvars):
-                envbackup[key] =3D os.environ.get(key)
-                os.environ[key] =3D value
-                fakeenv[key] =3D value
-
-            fakedirs =3D (self.rqdata.dataCache.fakerootdirs[fn] or "").sp=
lit()
-            for p in fakedirs:
-                bb.utils.mkdirhier(p)
-
-            logger.debug(2, 'Running %s:%s under fakeroot, fakedirs: %s' %
-                            (fn, taskname, ', '.join(fakedirs)))
-        else:
-            envvars =3D (self.rqdata.dataCache.fakerootnoenv[fn] or "").sp=
lit()
-            for key, value in (var.split('=3D') for var in envvars):
-                envbackup[key] =3D os.environ.get(key)
-                os.environ[key] =3D value
-                fakeenv[key] =3D value
-
-        sys.stdout.flush()
-        sys.stderr.flush()
-        try:
-            pipein, pipeout =3D os.pipe()
-            pipein =3D os.fdopen(pipein, 'rb', 4096)
-            pipeout =3D os.fdopen(pipeout, 'wb', 0)
-            pid =3D os.fork()
-        except OSError as e:
-            bb.msg.fatal("RunQueue", "fork failed: %d (%s)" % (e.errno, e.=
strerror))
-
-        if pid =3D=3D 0:
-            pipein.close()
-
-            # Save out the PID so that the event can include it the
-            # events
-            bb.event.worker_pid =3D os.getpid()
-            bb.event.worker_pipe =3D pipeout
-
-            self.rq.state =3D runQueueChildProcess
-            # Make the child the process group leader
-            os.setpgid(0, 0)
-            # No stdin
-            newsi =3D os.open(os.devnull, os.O_RDWR)
-            os.dup2(newsi, sys.stdin.fileno())
-
-            if umask:
-                os.umask(umask)
-
-            self.cooker.data.setVar("BB_WORKERCONTEXT", "1")
-            bb.parse.siggen.set_taskdata(self.rqdata.hashes, self.rqdata.h=
ash_deps)
-            ret =3D 0
-            try:
-                the_data =3D bb.cache.Cache.loadDataFull(fn, self.cooker.c=
ollection.get_file_appends(fn), self.cooker.data)
-                the_data.setVar('BB_TASKHASH', self.rqdata.runq_hash[task]=
)
-                for h in self.rqdata.hashes:
-                    the_data.setVar("BBHASH_%s" % h, self.rqdata.hashes[h]=
)
-                for h in self.rqdata.hash_deps:
-                    the_data.setVar("BBHASHDEPS_%s" % h, self.rqdata.hash_=
deps[h])
-
-                # exported_vars() returns a generator which *cannot* be pa=
ssed to os.environ.update()=20
-                # successfully. We also need to unset anything from the en=
vironment which shouldn't be there=20
-                exports =3D bb.data.exported_vars(the_data)
-                bb.utils.empty_environment()
-                for e, v in exports:
-                    os.environ[e] =3D v
-                for e in fakeenv:
-                    os.environ[e] =3D fakeenv[e]
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
-                    profile =3D self.cooker.configuration.profile
-                    ret =3D bb.build.exec_task(fn, taskname, the_data, pro=
file)
-                os._exit(ret)
-            except:
-                os._exit(1)
-        else:
-            for key, value in envbackup.iteritems():
-                if value is None:
-                    del os.environ[key]
-                else:
-                    os.environ[key] =3D value
-
-        return pid, pipein, pipeout
-
     def check_dependencies(self, task, taskdeps, setscene =3D False):
         if not self.rq.depvalidate:
             return False
@@ -1184,6 +1084,16 @@ class RunQueueExecute:
         valid =3D bb.utils.better_eval(call, locs)
         return valid
=20
+    def teardown(self):
+        logger.warn("Teardown called")
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
         self.rq =3D rq
@@ -1275,7 +1185,6 @@ class RunQueueExecuteTasks(RunQueueExecute):
             bb.fatal("Invalid scheduler '%s'.  Available schedulers: %s" %
                      (self.scheduler, ", ".join(obj.name for obj in schedu=
lers)))
=20
-
     def get_schedulers(self):
         schedulers =3D set(obj for obj in globals().values()
                              if type(obj) is type and
@@ -1349,6 +1258,9 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Run the tasks in a queue prepared by rqdata.prepare()
         """
=20
+        self.workerpipe.read()
+       =20
+
         if self.stats.total =3D=3D 0:
             # nothing to do
             self.rq.state =3D runQueueCleanUp
@@ -1384,23 +1296,19 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 startevent =3D runQueueTaskStarted(task, self.stats, self.=
rq)
                 bb.event.fire(startevent, self.cfgData)
=20
-            pid, pipein, pipeout =3D self.fork_off_task(fn, task, taskname=
)
+            self.worker.stdin.write("<runtask>" + pickle.dumps((fn, task, =
taskname, False, self.cooker.collection.get_file_appends(fn))) + "</runtask=
>")
=20
-            self.build_pids[pid] =3D task
-            self.build_pipes[pid] =3D runQueuePipe(pipein, pipeout, self.c=
fgData)
-            self.build_stamps[pid] =3D bb.build.stampfile(taskname, self.r=
qdata.dataCache, fn)
+            self.build_stamps[task] =3D bb.build.stampfile(taskname, self.=
rqdata.dataCache, fn)
             self.runq_running[task] =3D 1
             self.stats.taskActive()
             if self.stats.active < self.number_tasks:
                 return True
=20
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
=20
         if len(self.failed_fnids) !=3D 0:
             self.rq.state =3D runQueueFailed
@@ -1415,6 +1323,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             if self.runq_complete[task] =3D=3D 0:
                 logger.error("Task %s never completed!", task)
         self.rq.state =3D runQueueComplete
+
         return True
=20
 class RunQueueExecuteScenequeue(RunQueueExecute):
@@ -1428,6 +1337,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # If we don't have any setscene functions, skip this step
         if len(self.rqdata.runq_setscene) =3D=3D 0:
             rq.scenequeue_covered =3D set()
+            self.teardown()
             rq.state =3D runQueueRunInit
             return
=20
@@ -1676,6 +1586,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         Run the tasks in a queue prepared by prepare_runqueue
         """
=20
+        self.workerpipe.read()
+
         task =3D None
         if self.stats.active < self.number_tasks:
             # Find the next setscene to run
@@ -1716,22 +1628,16 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             startevent =3D sceneQueueTaskStarted(task, self.stats, self.rq=
)
             bb.event.fire(startevent, self.cfgData)
=20
-            pid, pipein, pipeout =3D self.fork_off_task(fn, realtask, task=
name)
+            self.worker.stdin.write("<runtask>" + pickle.dumps((fn, realta=
sk, taskname, True, self.cooker.collection.get_file_appends(fn))) + "</runt=
ask>")
=20
-            self.build_pids[pid] =3D task
-            self.build_pipes[pid] =3D runQueuePipe(pipein, pipeout, self.c=
fgData)
             self.runq_running[task] =3D 1
             self.stats.taskActive()
             if self.stats.active < self.number_tasks:
                 return True
=20
-        for pipe in self.build_pipes:
-            self.build_pipes[pipe].read()
-
         if self.stats.active > 0:
-            if self.runqueue_process_waitpid() is None:
-                return 0.5
-            return True
+            self.workerpipe.read()
+            return 0.5
=20
         # Convert scenequeue_covered task numbers into full taskgraph ids
         oldcovered =3D self.scenequeue_covered
@@ -1745,11 +1651,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         logger.debug(1, 'We can skip tasks %s', sorted(self.rq.scenequeue_=
covered))
=20
         self.rq.state =3D runQueueRunInit
+        self.teardown()
         return True
=20
-    def fork_off_task(self, fn, task, taskname):
-        return RunQueueExecute.fork_off_task(self, fn, task, taskname, qui=
eterrors=3DTrue)
-
 class TaskFailure(Exception):
     """
     Exception raised when a task in a runqueue fails
@@ -1828,25 +1732,42 @@ class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
     """
-    def __init__(self, pipein, pipeout, d):
+    def __init__(self, pipein, pipeout, d, rq):
         self.input =3D pipein
-        pipeout.close()
+        if pipeout:
+            pipeout.close()
         bb.utils.nonblockingfd(self.input)
         self.queue =3D ""
         self.d =3D d
+        self.rq =3D rq
+
+    def setrunqueue(self, rq):
+        self.rq =3D rq
=20
     def read(self):
         start =3D len(self.queue)
         try:
             self.queue =3D self.queue + self.input.read(102400)
-        except (OSError, IOError):
-            pass
+        except (OSError, IOError) as e:
+            if e.errno !=3D errno.EAGAIN:
+                raise
         end =3D len(self.queue)
-        index =3D self.queue.find("</event>")
-        while index !=3D -1:
-            bb.event.fire_from_worker(self.queue[:index+8], self.d)
-            self.queue =3D self.queue[index+8:]
+        found =3D True
+        while found and len(self.queue):
+            found =3D False
             index =3D self.queue.find("</event>")
+            while index !=3D -1 and self.queue.startswith("<event>"):
+                bb.event.fire_from_worker(self.queue[:index+8], self.d)
+                found =3D True
+                self.queue =3D self.queue[index+8:]
+                index =3D self.queue.find("</event>")
+            index =3D self.queue.find("</exitcode>")
+            while index !=3D -1 and self.queue.startswith("<exitcode>"):
+                task, status =3D pickle.loads(self.queue[10:index])
+                self.rq.runqueue_process_waitpid(task, status)
+                found =3D True
+                self.queue =3D self.queue[index+11:]
+                index =3D self.queue.find("</exitcode>")
         return (end > start)
=20
     def close(self):
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 1ff2ecc..fb8b678 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -201,9 +201,10 @@ class SignatureGeneratorBasic(SignatureGenerator):
         #d.setVar("BB_TASKHASH_task-%s" % task, taskhash[task])
         return h
=20
-    def set_taskdata(self, hashes, deps):
+    def set_taskdata(self, hashes, deps, checksums):
         self.runtaskdeps =3D deps
         self.taskhash =3D hashes
+        self.file_checksum_values =3D checksums
=20
     def dump_sigtask(self, fn, task, stampbase, runtime):
         k =3D fn + "." + task


_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

