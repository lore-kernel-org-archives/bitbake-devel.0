Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A8EC433F5
	for <webhook@archiver.kernel.org>; Sat, 11 Dec 2021 18:25:29 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web11.24993.1639247128971483426
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Dec 2021 10:25:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Pz8RY+QM;
 spf=pass (domain: gmail.com, ip: 209.85.167.176,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f176.google.com with SMTP id u74so17630341oie.8
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Dec 2021 10:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/V1aLc0ptTyMk7y0kzZ8Btfirfy03gQRhaGQgtFnfO8=;
        b=Pz8RY+QMqOmPeqtnCl7byET/f5XTzB4+DaHAFDRle5pp6Rscww9g7GqEwiTJ4schYe
         h3UsTSGaKeBOXyEt1/g2f2VBOSLRLeDoa3SFUrzT4PoOQbQeAmBkLnt/pD9rFIoWjpUX
         gd9C6XZGIB9631/OlM6fG9yx5fe+AbleT4Ow4BmT/NveiXAyt716G6jyk9J787Paglg6
         WYnKyA+qwBtlWXHFXQLK+htWbLFIt3oQePrf6juIEbvhrJ1p6FqHHwhxA4J25OTpI6aU
         JOL9UNb0xGnLnoQkqeovDJa67EcMh+L733TiLJr6IBmKlIB19Ar7gf0exepwL42+SJW/
         K8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/V1aLc0ptTyMk7y0kzZ8Btfirfy03gQRhaGQgtFnfO8=;
        b=4zFfPsFmqrJZ9bmFm3WDtvueDkcINdYwV3nyNQvw2u616efd8tpXC7cOI9xJZ8YDj7
         YhEnJufvKJA+vQBYf0Z0+ySu+trpLWq/hbdt0RkKEw1DFJqNOHrYD3gZXfy8swulWzv+
         hOTz65XrrKQh5n/LOWStGFj3HBYsUAJzvrpcNwllUTNtkMaet184Kvp+8Bbo1ECn3pHV
         tERjuzA95slSVYlTJciVe7vZPSfj9HZeF+UXAzYq0LnyF2KztSXZuRbzPfYNG/iUwqo3
         tknU1yMAzoEMZJqYTSYa8+IohUmzGk4U3bDWVU2ESlic0Ztr/RPjvXHRnLOu4XBV8k5z
         ODcQ==
X-Gm-Message-State: AOAM532ypj2pghbmAjJe/5B7ZhaRLgs5MT7buSF+FN91k/gDJu4GmWcA
	Zkh6LtHsLVDvJdnTrdGKz10UUFMFymE=
X-Google-Smtp-Source: 
 ABdhPJzj1iBSVtnWrB4uGXwDjlJ5RaNMr6mpw0ZuuNg2iHrb3INBwIEo+NSjtD7P7IZMc1cbH4/jEw==
X-Received: by 2002:a05:6808:10ce:: with SMTP id
 s14mr18214381ois.137.1639247127838;
        Sat, 11 Dec 2021 10:25:27 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id
 o19sm1661703oiw.22.2021.12.11.10.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 10:25:27 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org,
	ross@burtonini.com,
	kergoth@gmail.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC] bitbake-worker: Switch to use asyncio
Date: Sat, 11 Dec 2021 12:25:24 -0600
Message-Id: <20211211182524.1807371-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Dec 2021 18:25:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13147

Switches bitbake-worker to use asyncio. This is a good canidate for
initial modernization using asyncio because it is self-contained will a
well defined interface to the bitbake server process.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker | 554 +++++++++++++++++++------------------
 1 file changed, 284 insertions(+), 270 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index bf96207edc..d5cc4fa248 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -11,16 +11,14 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), '
 from bb import fetch2
 import logging
 import bb
-import select
 import errno
 import signal
 import pickle
 import traceback
-import queue
 import shlex
 import subprocess
 from multiprocessing import Lock
-from threading import Thread
+import asyncio
 
 if sys.getfilesystemencoding() != "utf-8":
     sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
@@ -53,14 +51,15 @@ except:
 
 logger = logging.getLogger("BitBake")
 
-worker_pipe = sys.stdout.fileno()
-bb.utils.nonblockingfd(worker_pipe)
-# Need to guard against multiprocessing being used in child processes
-# and multiple processes trying to write to the parent at the same time
-worker_pipe_lock = None
 
-handler = bb.event.LogHandler()
-logger.addHandler(handler)
+async def connect_stdout():
+    loop = asyncio.get_event_loop()
+    w_transport, w_protocol = await loop.connect_write_pipe(asyncio.streams.FlowControlMixin, sys.stdout)
+    writer = asyncio.StreamWriter(w_transport, w_protocol, None, loop)
+    return writer
+
+log_handler = bb.event.LogHandler()
+logger.addHandler(log_handler)
 
 if 0:
     # Code to write out a log file of all events passing through the worker
@@ -71,73 +70,270 @@ if 0:
     consolelog.setFormatter(conlogformat)
     logger.addHandler(consolelog)
 
-worker_queue = queue.Queue()
-
-def worker_fire(event, d):
-    data = b"<event>" + pickle.dumps(event) + b"</event>"
-    worker_fire_prepickled(data)
+async def read_messages(fd, handlers):
+    buf = b""
+    event = asyncio.Event()
+    done = False
 
-def worker_fire_prepickled(event):
-    global worker_queue
+    def read_data():
+        nonlocal buf
+        nonlocal fd
+        nonlocal event
+        nonlocal done
 
-    worker_queue.put(event)
+        try:
+            data = os.read(fd, 102400)
+        except (OSError, IOError) as e:
+            if e.errno != errno.EAGAIN:
+                raise
+            return
 
-#
-# We can end up with write contention with the cooker, it can be trying to send commands
-# and we can be trying to send event data back. Therefore use a separate thread for writing 
-# back data to cooker.
-#
-worker_thread_exit = False
+        if len(data) == 0:
+            done = True
+        else:
+            buf += data
+        event.set()
 
-def worker_flush(worker_queue):
-    worker_queue_int = b""
-    global worker_pipe, worker_thread_exit
+    asyncio.get_event_loop().add_reader(fd, read_data)
 
-    while True:
+    try:
+        while not done:
+            for name, handler in handlers.items():
+                prefix = b"<" + name + b">"
+                if buf.startswith(prefix):
+                    suffix = b"</" + name + b">"
+                    index = buf.find(suffix)
+                    if index != -1:
+                        try:
+                            workerlog_write("%d: Handling %r\n" % (fd, name))
+                            await handler(buf[len(prefix):index])
+                        except pickle.UnpicklingError:
+                            workerlog_write("Unable to unpickle data: %s\n" % ":".join("{:02x}".format(c) for c in buf))
+                            raise
+
+                        buf = buf[index + len(suffix):]
+                        break
+                        # TODO: The old code would keep looking for an ending
+                        # tag in a loop, so that a stream like
+                        # <A>foo</A>bar</A> was valid. This doesn't appear to
+                        # be necessary anymore?
+                        #index = self.buf.find(b"</" + item + b">")
+            else:
+                # Nothing found in the buffer. Wait for more data
+                await event.wait()
+                event.clear()
+    finally:
+        asyncio.get_event_loop().remove_reader(fd)
+
+class ChildHandler(object):
+    def __init__(self, writer, task, pid, pipeinfd, pipeoutfd):
+        self.task = task
+        self.writer = writer
+        self.pid = pid
+        self.pipeinfd = pipeinfd
+        if pipeoutfd >= 0:
+            os.close(pipeoutfd)
+
+        self.done_event = asyncio.Event()
+        self.loop = asyncio.get_running_loop()
+
+        asyncio.get_child_watcher().add_child_handler(self.pid, self._child_watcher_callback)
+
+    def _child_watcher_callback(self, pid, status):
+        # The callback may be called in a thread, so call_soon_threadsafe is
+        # recommended to get back to the main loop.
+        self.loop.call_soon_threadsafe(self.child_exited, pid, status)
+
+    async def main_loop(self):
+        bb.utils.nonblockingfd(self.pipeinfd)
+        await read_messages(self.pipeinfd, {
+            b"event": self.handle_event,
+        })
+        os.close(self.pipeinfd)
+        await self.done_event.wait()
+
+    async def handle_event(self, data):
+        self.writer.write(b"<event>")
+        self.writer.write(data)
+        self.writer.write(b"</event>")
+        await self.writer.drain()
+
+    def child_exited(self, pid, status):
         try:
-            worker_queue_int = worker_queue_int + worker_queue.get(True, 1)
-        except queue.Empty:
-            pass
-        while (worker_queue_int or not worker_queue.empty()):
+            if pid != self.pid:
+                return
+
+            workerlog_write("Exit code of %d for pid %d (fd %d)\n" % (status, pid, self.pipeinfd))
+
+            asyncio.get_child_watcher().remove_child_handler(self.pid)
+
+            if os.WIFEXITED(status):
+                status = os.WEXITSTATUS(status)
+            elif os.WIFSIGNALED(status):
+                # Per shell conventions for $?, when a process exits due to
+                # a signal, we return an exit code of 128 + SIGNUM
+                status = 128 + os.WTERMSIG(status)
+
+            self.writer.write(b"<exitcode>")
+            self.writer.write(pickle.dumps((self.task, status)))
+            self.writer.write(b"</exitcode>")
+
+            self.done_event.set()
+        except Exception as e:
+            workerlog_write("%s\n%s\n" % (traceback.format_exc(), e))
+            raise e
+
+    def close(self):
+        if not self.done_event.is_set():
             try:
-                (_, ready, _) = select.select([], [worker_pipe], [], 1)
-                if not worker_queue.empty():
-                    worker_queue_int = worker_queue_int + worker_queue.get()
-                written = os.write(worker_pipe, worker_queue_int)
-                worker_queue_int = worker_queue_int[written:]
-            except (IOError, OSError) as e:
-                if e.errno != errno.EAGAIN and e.errno != errno.EPIPE:
-                    raise
-        if worker_thread_exit and worker_queue.empty() and not worker_queue_int:
-            return
+                os.kill(-self.pid, signal.SIGTERM)
+            except OSError:
+                pass
+
+
+class MainHandler(object):
+    def __init__(self, writer):
+        self.writer = writer
+        self.cookercfg = None
+        self.databuilder = None
+        self.data = None
+        self.extraconfigdata = None
+        self.children = []
+        self.child_tasks = []
 
-worker_thread = Thread(target=worker_flush, args=(worker_queue,))
-worker_thread.start()
+    async def main_loop(self):
+        loop = asyncio.get_running_loop()
+        fd = sys.stdin.fileno()
+        bb.utils.nonblockingfd(fd)
 
-def worker_child_fire(event, d):
-    global worker_pipe
-    global worker_pipe_lock
+        loop.add_signal_handler(signal.SIGTERM, self.signal_handler)
+        loop.add_signal_handler(signal.SIGHUP, self.signal_handler)
 
-    data = b"<event>" + pickle.dumps(event) + b"</event>"
-    try:
-        worker_pipe_lock.acquire()
-        while(len(data)):
-            written = worker_pipe.write(data)
-            data = data[written:]
-        worker_pipe_lock.release()
-    except IOError:
-        sigterm_handler(None, None)
-        raise
+        try:
+            await read_messages(fd, {
+                b"cookerconfig": self.handle_cookercfg,
+                b"extraconfigdata": self.handle_extraconfigdata,
+                b"workerdata": self.handle_workerdata,
+                b"newtaskhashes": self.handle_newtaskhashes,
+                b"runtask": self.handle_runtask,
+                b"finishnow": self.handle_finishnow,
+                b"ping": self.handle_ping,
+                b"quit": self.handle_quit,
+                }
+            )
+        finally:
+            loop.remove_signal_handler(signal.SIGTERM)
+            loop.remove_signal_handler(signal.SIGHUP)
+
+    def signal_handler(self, signum, stackframe):
+        loop = asyncio.get_running_loop()
+
+        if signum == signal.SIGTERM:
+            bb.warn("Worker received SIGTERM, shutting down...")
+        elif signum == signal.SIGHUP:
+            bb.warn("Worker received SIGHUP, shutting down...")
+
+        self.handle_finishnow(None)
+        loop.remove_signal_handler(signal.SIGTERM)
+        os.kill(os.getpid(), signal.SIGTERM)
+
+    async def handle_cookercfg(self, data):
+        self.cookercfg = pickle.loads(data)
+        self.databuilder = bb.cookerdata.CookerDataBuilder(self.cookercfg, worker=True)
+        self.databuilder.parseBaseConfiguration()
+        self.data = self.databuilder.data
+
+    async def handle_extraconfigdata(self, data):
+        self.extraconfigdata = pickle.loads(data)
+
+    async def handle_workerdata(self, data):
+        self.workerdata = pickle.loads(data)
+        bb.build.verboseShellLogging = self.workerdata["build_verbose_shell"]
+        bb.build.verboseStdoutLogging = self.workerdata["build_verbose_stdout"]
+        bb.msg.loggerDefaultLogLevel = self.workerdata["logdefaultlevel"]
+        bb.msg.loggerDefaultDomains = self.workerdata["logdefaultdomain"]
+        for mc in self.databuilder.mcdata:
+            self.databuilder.mcdata[mc].setVar("PRSERV_HOST", self.workerdata["prhost"])
+            self.databuilder.mcdata[mc].setVar("BB_HASHSERVE", self.workerdata["hashservaddr"])
+
+    async def handle_newtaskhashes(self, data):
+        self.workerdata["newhashes"] = pickle.loads(data)
+
+    async def handle_ping(self, _):
+        logger.warning("Pong from bitbake-worker!")
+
+    async def handle_quit(self, data):
+        global normalexit
+        normalexit = True
+        sys.exit(0)
+
+    async def run_child(self, child):
+        await child.main_loop()
+        self.children.remove(child)
+        self.child_tasks.remove(asyncio.current_task())
+
+    async def handle_runtask(self, data):
+        fn, task, taskname, taskhash, unihash, quieterrors, appends, taskdepdata, dry_run_exec = pickle.loads(data)
+        workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
+
+        pid, pipeinfd, pipeoutfd = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, taskhash, unihash, appends, taskdepdata, self.extraconfigdata, quieterrors, dry_run_exec)
+
+        child = ChildHandler(self.writer, task, pid, pipeinfd, pipeoutfd)
+        self.children.append(child)
+
+        t = asyncio.ensure_future(self.run_child(child))
+        self.child_tasks.append(t)
+
+    async def handle_finishnow(self, _=None):
+        for c in self.children:
+            c.close()
+
+        workerlog_write("Waiting for %d child tasks: %s\n" % (len(self.child_tasks),
+            " ".join(str(c.pid) for c in self.children)))
+
+        # Wait for all outstanding children to exit
+        await asyncio.gather(*self.child_tasks)
+
+async def main():
+    writer = await connect_stdout()
+    worker_queue = []
+
+    def worker_fire(event, d):
+        nonlocal worker_queue
+
+        async def flush_worker_queue():
+            nonlocal writer
+            nonlocal worker_queue
+
+            if worker_queue:
+                for m in worker_queue:
+                    writer.write(m)
+                worker_queue = []
+                await writer.drain()
+
+        # To ensure the messages are sent out in the order they are received,
+        # put them in a list then schedule a task to write them out
+        data = b"<event>" + pickle.dumps(event) + b"</event>"
+        worker_queue.append(data)
+        asyncio.ensure_future(flush_worker_queue())
 
-bb.event.worker_fire = worker_fire
+    bb.event.worker_fire = worker_fire
+
+    handler = MainHandler(writer)
+
+    await asyncio.gather(handler.main_loop())
+
+normalexit = False
 
 lf = None
 #lf = open("/tmp/workercommandlog", "w+")
 def workerlog_write(msg):
+    global lf
     if lf:
         lf.write(msg)
         lf.flush()
 
+
 def sigterm_handler(signum, frame):
     signal.signal(signal.SIGTERM, signal.SIG_DFL)
     os.killpg(0, signal.SIGTERM)
@@ -191,9 +387,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
     sys.stderr.flush()
 
     try:
-        pipein, pipeout = os.pipe()
-        pipein = os.fdopen(pipein, 'rb', 4096)
-        pipeout = os.fdopen(pipeout, 'wb', 0)
+        pipeinfd, pipeoutfd = os.pipe()
         pid = os.fork()
     except OSError as e:
         logger.critical("fork failed: %d (%s)" % (e.errno, e.strerror))
@@ -201,18 +395,30 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
 
     if pid == 0:
         def child():
-            global worker_pipe
-            global worker_pipe_lock
-            pipein.close()
+            os.close(pipeinfd)
 
             bb.utils.signal_on_parent_exit("SIGTERM")
 
+            pipeout = os.fdopen(pipeoutfd, 'wb', 0)
+            pipelock = Lock()
+            def worker_child_fire(event, d):
+                nonlocal pipeout
+                nonlocal pipelock
+
+                data = b"<event>" + pickle.dumps(event) + b"</event>"
+                try:
+                    with pipelock:
+                        while(len(data)):
+                            written = pipeout.write(data)
+                            data = data[written:]
+                except IOError:
+                    sigterm_handler(None, None)
+                    raise
+
             # Save out the PID so that the event can include it the
             # events
             bb.event.worker_pid = os.getpid()
             bb.event.worker_fire = worker_child_fire
-            worker_pipe = pipeout
-            worker_pipe_lock = Lock()
 
             # Make the child the process group leader and ensure no
             # child process will be controlled by the current terminal
@@ -315,225 +521,33 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
             else:
                 os.environ[key] = value
 
-    return pid, pipein, pipeout
-
-class runQueueWorkerPipe():
-    """
-    Abstraction for a pipe between a worker thread and the worker server
-    """
-    def __init__(self, pipein, pipeout):
-        self.input = pipein
-        if pipeout:
-            pipeout.close()
-        bb.utils.nonblockingfd(self.input)
-        self.queue = b""
-
-    def read(self):
-        start = len(self.queue)
-        try:
-            self.queue = self.queue + (self.input.read(102400) or b"")
-        except (OSError, IOError) as e:
-            if e.errno != errno.EAGAIN:
-                raise
-
-        end = len(self.queue)
-        index = self.queue.find(b"</event>")
-        while index != -1:
-            msg = self.queue[:index+8]
-            assert msg.startswith(b"<event>") and msg.count(b"<event>") == 1
-            worker_fire_prepickled(msg)
-            self.queue = self.queue[index+8:]
-            index = self.queue.find(b"</event>")
-        return (end > start)
-
-    def close(self):
-        while self.read():
-            continue
-        if len(self.queue) > 0:
-            print("Warning, worker child left partial message: %s" % self.queue)
-        self.input.close()
-
-normalexit = False
+    return pid, pipeinfd, pipeoutfd
 
-class BitbakeWorker(object):
-    def __init__(self, din):
-        self.input = din
-        bb.utils.nonblockingfd(self.input)
-        self.queue = b""
-        self.cookercfg = None
-        self.databuilder = None
-        self.data = None
-        self.extraconfigdata = None
-        self.build_pids = {}
-        self.build_pipes = {}
-    
-        signal.signal(signal.SIGTERM, self.sigterm_exception)
-        # Let SIGHUP exit as SIGTERM
-        signal.signal(signal.SIGHUP, self.sigterm_exception)
-        if "beef" in sys.argv[1]:
-            bb.utils.set_process_name("Worker (Fakeroot)")
-        else:
-            bb.utils.set_process_name("Worker")
-
-    def sigterm_exception(self, signum, stackframe):
-        if signum == signal.SIGTERM:
-            bb.warn("Worker received SIGTERM, shutting down...")
-        elif signum == signal.SIGHUP:
-            bb.warn("Worker received SIGHUP, shutting down...")
-        self.handle_finishnow(None)
-        signal.signal(signal.SIGTERM, signal.SIG_DFL)
-        os.kill(os.getpid(), signal.SIGTERM)
-
-    def serve(self):        
-        while True:
-            (ready, _, _) = select.select([self.input] + [i.input for i in self.build_pipes.values()], [] , [], 1)
-            if self.input in ready:
-                try:
-                    r = self.input.read()
-                    if len(r) == 0:
-                        # EOF on pipe, server must have terminated
-                        self.sigterm_exception(signal.SIGTERM, None)
-                    self.queue = self.queue + r
-                except (OSError, IOError):
-                    pass
-            if len(self.queue):
-                self.handle_item(b"cookerconfig", self.handle_cookercfg)
-                self.handle_item(b"extraconfigdata", self.handle_extraconfigdata)
-                self.handle_item(b"workerdata", self.handle_workerdata)
-                self.handle_item(b"newtaskhashes", self.handle_newtaskhashes)
-                self.handle_item(b"runtask", self.handle_runtask)
-                self.handle_item(b"finishnow", self.handle_finishnow)
-                self.handle_item(b"ping", self.handle_ping)
-                self.handle_item(b"quit", self.handle_quit)
-
-            for pipe in self.build_pipes:
-                if self.build_pipes[pipe].input in ready:
-                    self.build_pipes[pipe].read()
-            if len(self.build_pids):
-                while self.process_waitpid():
-                    continue
-
-
-    def handle_item(self, item, func):
-        if self.queue.startswith(b"<" + item + b">"):
-            index = self.queue.find(b"</" + item + b">")
-            while index != -1:
-                try:
-                    func(self.queue[(len(item) + 2):index])
-                except pickle.UnpicklingError:
-                    workerlog_write("Unable to unpickle data: %s\n" % ":".join("{:02x}".format(c) for c in self.queue))
-                    raise
-                self.queue = self.queue[(index + len(item) + 3):]
-                index = self.queue.find(b"</" + item + b">")
-
-    def handle_cookercfg(self, data):
-        self.cookercfg = pickle.loads(data)
-        self.databuilder = bb.cookerdata.CookerDataBuilder(self.cookercfg, worker=True)
-        self.databuilder.parseBaseConfiguration()
-        self.data = self.databuilder.data
-
-    def handle_extraconfigdata(self, data):
-        self.extraconfigdata = pickle.loads(data)
-
-    def handle_workerdata(self, data):
-        self.workerdata = pickle.loads(data)
-        bb.build.verboseShellLogging = self.workerdata["build_verbose_shell"]
-        bb.build.verboseStdoutLogging = self.workerdata["build_verbose_stdout"]
-        bb.msg.loggerDefaultLogLevel = self.workerdata["logdefaultlevel"]
-        bb.msg.loggerDefaultDomains = self.workerdata["logdefaultdomain"]
-        for mc in self.databuilder.mcdata:
-            self.databuilder.mcdata[mc].setVar("PRSERV_HOST", self.workerdata["prhost"])
-            self.databuilder.mcdata[mc].setVar("BB_HASHSERVE", self.workerdata["hashservaddr"])
-
-    def handle_newtaskhashes(self, data):
-        self.workerdata["newhashes"] = pickle.loads(data)
-
-    def handle_ping(self, _):
-        workerlog_write("Handling ping\n")
-
-        logger.warning("Pong from bitbake-worker!")
-
-    def handle_quit(self, data):
-        workerlog_write("Handling quit\n")
-
-        global normalexit
-        normalexit = True
-        sys.exit(0)
-
-    def handle_runtask(self, data):
-        fn, task, taskname, taskhash, unihash, quieterrors, appends, taskdepdata, dry_run_exec = pickle.loads(data)
-        workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
-
-        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, taskhash, unihash, appends, taskdepdata, self.extraconfigdata, quieterrors, dry_run_exec)
-
-        self.build_pids[pid] = task
-        self.build_pipes[pid] = runQueueWorkerPipe(pipein, pipeout)
-
-    def process_waitpid(self):
-        """
-        Return none is there are no processes awaiting result collection, otherwise
-        collect the process exit codes and close the information pipe.
-        """
-        try:
-            pid, status = os.waitpid(-1, os.WNOHANG)
-            if pid == 0 or os.WIFSTOPPED(status):
-                return False
-        except OSError:
-            return False
-
-        workerlog_write("Exit code of %s for pid %s\n" % (status, pid))
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
-
-        worker_fire_prepickled(b"<exitcode>" + pickle.dumps((task, status)) + b"</exitcode>")
-
-        return True
+try:
+    if "beef" in sys.argv[1]:
+        bb.utils.set_process_name("Worker (Fakeroot)")
+    else:
+        bb.utils.set_process_name("Worker")
 
-    def handle_finishnow(self, _):
-        if self.build_pids:
-            logger.info("Sending SIGTERM to remaining %s tasks", len(self.build_pids))
-            for k, v in iter(self.build_pids.items()):
-                try:
-                    os.kill(-k, signal.SIGTERM)
-                    os.waitpid(-1, 0)
-                except:
-                    pass
-        for pipe in self.build_pipes:
-            self.build_pipes[pipe].read()
+    loop = asyncio.get_event_loop()
 
-try:
-    worker = BitbakeWorker(os.fdopen(sys.stdin.fileno(), 'rb'))
     if not profiling:
-        worker.serve()
+        loop.run_until_complete(main())
     else:
         profname = "profile-worker.log"
         prof = profile.Profile()
         try:
-            profile.Profile.runcall(prof, worker.serve)
+            profile.Profile.runcall(prof, loop.run_until_complete, main())
         finally:
             prof.dump_stats(profname)
             bb.utils.process_profilelog(profname)
-except BaseException as e:
+except Exception as e:
+    workerlog_write("%s\n%s\n" % (traceback.format_exc(), e))
     if not normalexit:
-        import traceback
         sys.stderr.write(traceback.format_exc())
         sys.stderr.write(str(e))
-finally:
-    worker_thread_exit = True
-    worker_thread.join()
 
-workerlog_write("exiting")
+workerlog_write("exiting\n")
 if not normalexit:
     sys.exit(1)
 sys.exit(0)
-- 
2.33.0


