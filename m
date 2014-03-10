Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id AC4FC6F58F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:58:21 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2A0wH21028031 for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:58:17 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DN74UU90rf7H for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:58:17 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2A0w7GQ028027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:58:12 GMT
Message-ID: <1394413082.7883.19.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 17:58:02 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] server/process: Use a pipe for quit events instead of Event()
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
X-List-Received-Date: Mon, 10 Mar 2014 00:58:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Its not possible to notice the change of status of an Event() in
the select call we sleep in. It would be possible in python 3.3 but
for now use a pipe instead. This removes small latency when bitbake
commands finish since the system doesn't sit in the select call.

(Debugging these kind of issues is apparent by setting a long sleep
for the select call)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index f4cb32c..386294f 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -87,8 +87,7 @@ class ProcessServer(Process, BaseImplServer):
         self.featurelist = featurelist
         self.quit = False
 
-        self.keep_running = Event()
-        self.keep_running.set()
+        self.quitin, self.quitout = Pipe()
         self.event_handle = multiprocessing.Value("i")
 
     def run(self):
@@ -101,14 +100,18 @@ class ProcessServer(Process, BaseImplServer):
     def main(self):
         # Ignore SIGINT within the server, as all SIGINT handling is done by
         # the UI and communicated to us
+        self.quitin.close()
         signal.signal(signal.SIGINT, signal.SIG_IGN)
-        while self.keep_running.is_set():
+        while not self.quit:
             try:
                 if self.command_channel.poll():
                     command = self.command_channel.recv()
                     self.runCommand(command)
+                if self.quitout.poll():
+                    self.quitout.recv()
+                    self.quit = True
 
-                self.idle_commands(.1, [self.event_queue._reader, self.command_channel])
+                self.idle_commands(.1, [self.event_queue._reader, self.command_channel, self.quitout])
             except Exception:
                 logger.exception('Running command %s', command)
 
@@ -147,7 +150,8 @@ class ProcessServer(Process, BaseImplServer):
         self.command_channel.send(self.cooker.command.runCommand(command))
 
     def stop(self):
-        self.keep_running.clear()
+        self.quitin.send("quit")
+        self.quitin.close()
 
 class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
     def __init__(self, serverImpl, ui_channel, event_queue):



