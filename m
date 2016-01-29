Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2825A77218
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jan 2016 11:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0TB8tFf017090 for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jan 2016 11:08:55 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lwKsw8tMGQpr for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jan 2016 11:08:55 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0TB8oI9017084
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jan 2016 11:08:51 GMT
Message-ID: <1454065730.10340.64.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 29 Jan 2016 11:08:50 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] bitbake: Set process names to be meaninful
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
X-List-Received-Date: Fri, 29 Jan 2016 11:08:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

This means that when you view the process tree, the processes
have meaningful names, aiding debugging:

$ pstree -p 30021
bash(30021)───KnottyUI(115579)───Cooker(115590)─┬─PRServ(115592)───{PRServ Handler}(115593)
                                                ├─Worker(115630)───bash:sleep(115631)───run.do_sleep.11(115633)───sleep(115634)
                                                └─{ProcessEQueue}(115591)

$ pstree -p 30021
bash(30021)───KnottyUI(117319)───Cooker(117330)─┬─Cooker(117335)
                                                ├─PRServ(117332)───{PRServ Handler}(117333)
                                                ├─Parser-1:2(117336)
                                                └─{ProcessEQueue}(117331)

Applies to parse threads, PR Server, cooker, the workers and execution
threads, working within the 16 character limit as best we can.

Needed to tweak the bitbake-worker magic values to tell the 
workers apart.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 8340d42..158171a 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -19,7 +19,7 @@ if len(sys.argv) != 2 or not sys.argv[1].startswith("decafbad"):
     sys.exit(1)
 
 profiling = False
-if sys.argv[1] == "decafbadbad":
+if sys.argv[1].startswith("decafbadbad"):
     profiling = True
     try:
         import cProfile as profile
@@ -209,6 +209,8 @@ def fork_off_task(worker, cfg, data, workerdata, fn, task, taskname, appends, ta
                 the_data = bb.cache.Cache.loadDataFull(fn, appends, data)
                 the_data.setVar('BB_TASKHASH', workerdata["runq_hash"][task])
 
+                bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN", True), taskname.replace("do_", "")))
+
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
                 exports = bb.data.exported_vars(the_data)
@@ -310,6 +312,10 @@ class BitbakeWorker(object):
         signal.signal(signal.SIGTERM, self.sigterm_exception)
         # Let SIGHUP exit as SIGTERM
         signal.signal(signal.SIGHUP, self.sigterm_exception)
+        if "beef" in sys.argv[1]:
+            bb.utils.set_process_name("Worker (Fakeroot)")
+        else:
+            bb.utils.set_process_name("Worker")
 
     def sigterm_exception(self, signum, stackframe):
         if signum == signal.SIGTERM:
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9c58d95..e5be448 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1999,6 +1999,7 @@ class CookerParser(object):
             bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgdata)
             def init():
                 Parser.cfg = self.cfgdata
+                bb.utils.set_process_name(multiprocessing.current_process().name)
                 multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, args=(self.cfgdata,), exitpriority=1)
                 multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, args=(self.cfgdata,), exitpriority=1)
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 763952a..e194ea9 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -884,6 +884,7 @@ class RunQueue:
         if self.cooker.configuration.profile:
             magic = "decafbadbad"
         if fakeroot:
+            magic = magic + "beef"
             fakerootcmd = self.cfgData.getVar("FAKEROOTCMD", True)
             fakerootenv = (self.cfgData.getVar("FAKEROOTBASEENV", True) or "").split()
             env = os.environ.copy()
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 5fca350..1e2b824 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -106,6 +106,7 @@ class ProcessServer(Process, BaseImplServer):
         # the UI and communicated to us
         self.quitin.close()
         signal.signal(signal.SIGINT, signal.SIG_IGN)
+        bb.utils.set_process_name("Cooker")
         while not self.quit:
             try:
                 if self.command_channel.poll():
@@ -212,6 +213,7 @@ class ProcessEventQueue(multiprocessing.queues.Queue):
     def __init__(self, maxsize):
         multiprocessing.queues.Queue.__init__(self, maxsize)
         self.exit = False
+        bb.utils.set_process_name("ProcessEQueue")
 
     def setexit(self):
         self.exit = True
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index b42f8eb..3f2b77b 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -272,6 +272,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     logger.addHandler(console)
     logger.addHandler(errconsole)
 
+    bb.utils.set_process_name("KnottyUI")
+
     if params.options.remote_server and params.options.kill_server:
         server.terminateServer()
         return
diff --git a/bitbake/lib/bb/ui/uievent.py b/bitbake/lib/bb/ui/uievent.py
index df22e25..6b479bf 100644
--- a/bitbake/lib/bb/ui/uievent.py
+++ b/bitbake/lib/bb/ui/uievent.py
@@ -104,6 +104,7 @@ class BBUIEventQueue:
     def startCallbackHandler(self):
 
         self.server.timeout = 1
+        bb.utils.set_process_name("UIEventQueue")
         while not self.server.quit:
             try:
                 self.server.handle_request()
diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index eafc3aa..a4ae229 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -79,6 +79,8 @@ class PRServer(SimpleXMLRPCServer):
         # 60 iterations between syncs or sync if dirty every ~30 seconds
         iterations_between_sync = 60
 
+        bb.utils.set_process_name("PRServ Handler")
+
         while not self.quit:
             try:
                 (request, client_address) = self.requestqueue.get(True, 30)
@@ -141,6 +143,8 @@ class PRServer(SimpleXMLRPCServer):
         self.quit = False
         self.timeout = 0.5
 
+        bb.utils.set_process_name("PRServ")
+
         logger.info("Started PRServer with DBfile: %s, IP: %s, PORT: %s, PID: %s" %
                      (self.dbfile, self.host, self.port, str(os.getpid())))
 



