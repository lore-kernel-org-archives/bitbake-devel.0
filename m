Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D6C346AC00
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 13:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3EDTTGk012680 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 14:29:29 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id m_qRtuJ2OjuC for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 14:29:29 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3EDTRan012677
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 14:29:28 +0100
Message-ID: <1460640567.9308.172.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Apr 2016 14:29:27 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cooker/knotty: Prefix parse logs with filename being parsed
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
X-List-Received-Date: Thu, 14 Apr 2016 13:29:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We now prefix log messages coming from worker task context with the
PF and task info, however parsing messages all have to be manually 
prefixed which is ugly and error prone. This change modifies the log 
handler filter so this happens automatically, meaning we don't have
to change every message to include that information. This makes error
messages longer but more usable.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 4068b8f..9b565fc 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1970,9 +1970,17 @@ class Parser(multiprocessing.Process):
 
     def parse(self, filename, appends, caches_array):
         try:
+            # Record the filename we're parsing into any events generated
+            def parse_filter(self, record):
+                record.taskpid = bb.event.worker_pid
+                record.fn = filename
+                return True
+
             # Reset our environment and handlers to the original settings
             bb.utils.set_context(self.context.copy())
             bb.event.set_class_handlers(self.handlers.copy())
+            bb.event.LogHandler.filter = parse_filter
+
             return True, bb.cache.Cache.parse(filename, appends, self.cfg, caches_array)
         except Exception as exc:
             tb = sys.exc_info()[2]
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index dff92bc..2fc20cf 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -371,7 +371,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     if event.taskpid in helper.running_tasks:
                         taskinfo = helper.running_tasks[event.taskpid]
                         event.msg = taskinfo['title'] + ': ' + event.msg
-
+                if hasattr(event, 'fn'):
+                        event.msg = event.fn + ': ' + event.msg
                 logger.handle(event)
                 continue
 



