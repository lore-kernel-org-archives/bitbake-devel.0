Return-Path: <jason.wessel@windriver.com>
Received: from mail7.windriver.com (mail7.windriver.com [128.224.252.3])
	by mail.openembedded.org (Postfix) with ESMTP id 956A26BB90
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Aug 2013 20:13:06 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail7.windriver.com (8.14.5/8.14.3) with ESMTP id r7RKD5ET025234
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Aug 2013 16:13:06 -0400 (EDT)
Received: from splat.wrs.com (128.224.60.28) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.347.0;
	Tue, 27 Aug 2013 13:13:05 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Aug 2013 15:12:55 -0500
Message-ID: <1377634375-13016-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH] serv.py: Fix hang when spawned dynamically with bitbake
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
X-List-Received-Date: Tue, 27 Aug 2013 20:13:07 -0000
Content-Type: text/plain

The PRServer has the possibility to hang indefinitely blocking on a
semaphore processing a xmlrpc request to send an event back to the
main bitbake instance.  This was observed during a "bitbake -e" on a
heavily loaded machine and the main bitbake instance and cooker exited
before the PRServer emitted its first log.

The stack trace is provided below as to show what happens every time a
logger.info() is executed in the PRServer.  Not only does it write to
the stream handler but it also tries to send the event to the main
event processor.

    self._notempty.acquire()
    self.queue.put(event)
    _ui_handlers[h].event.send(event)
    fire_ui_handlers(event, d)
    fire(record, None)
    self.emit(record)
    hdlr.handle(record)
    self.callHandlers(record)
    self.handle(record)
    self._log(INFO, msg, args, **kwargs)
    (self.dbfile, self.host, self.port, str(os.getpid())))
    self.work_forever()
    pid = self.daemonize()
    self.prserv.start()
    singleton.start()
    self.prhost = prserv.serv.auto_start(self.data)
    cooker.pre_serve()
    bb.cooker.server_main(self.cooker, self.main)
    self.run()
    code = process_obj._bootstrap()
    self._popen = Popen(self)
    self.serverImpl.start()
    server.detach()
    server = start_server(servermodule, configParams, configuration)
    ret = main()

It was never intended for the PRServer to send its logs anywhere but
its own log file.  The event processing is an artifact of how the
PRServer was forked and it inherits the event log handlers.  The
simple fix is to clean up and purge all the log handlers after the
fork() but before doing any of the typical PRServer work or logging.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/prserv/serv.py |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 81b4f8d..781f054 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -143,6 +143,11 @@ class PRServer(SimpleXMLRPCServer):
         os.dup2(so.fileno(),sys.stdout.fileno())
         os.dup2(se.fileno(),sys.stderr.fileno())
 
+        # Clear out all log handlers prior to the fork() to avoid calling
+        # event handlers not part of the PRserver
+        for logger_iter in logging.Logger.manager.loggerDict.keys():
+            logger_iter.handlers = []
+
         # Ensure logging makes it to the logfile
         streamhandler = logging.StreamHandler()
         streamhandler.setLevel(logging.DEBUG)
-- 
1.7.9.5


