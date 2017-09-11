Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 37A4577DA3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Sep 2017 22:50:33 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Sep 2017 15:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,380,1500966000"; d="scan'208";a="150679297"
Received: from nrahulx-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.73.25])
	by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2017 15:50:31 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Sep 2017 10:49:54 +1200
Message-Id: <9d6e8390ed36109fa92e4a9988a923e236b9aaea.1505170163.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1505170163.git.paul.eggleton@linux.intel.com>
References: <cover.1505170163.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] server/process: ensure server failure log is limited to current session
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
X-List-Received-Date: Mon, 11 Sep 2017 22:50:33 -0000

Printing the last 10 lines of bitbake-cookerdaemon.log when the server
fails to start can sometimes result in printing the output from a
previous run, which could lead the user completely down the wrong path
in terms of the cause of the failure. Use a known start text containing
the time which we can then look for when scanning through the log, and
then grab the last 10 lines of that part instead.

Fixes [YOCTO #11903].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/server/process.py | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 5c7dfae..e64194d 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -33,6 +33,8 @@ import select
 import socket
 import subprocess
 import errno
+import re
+import datetime
 import bb.server.xmlrpcserver
 from bb import daemonize
 from multiprocessing import queues
@@ -358,6 +360,9 @@ class BitBakeProcessServerConnection(object):
         return
 
 class BitBakeServer(object):
+    start_log_format = '--- Starting bitbake server pid %s at %s ---'
+    start_log_datetime_format = '%Y-%m-%d %H:%M:%S.%f'
+
     def __init__(self, lock, sockname, configuration, featureset):
 
         self.configuration = configuration
@@ -383,6 +388,7 @@ class BitBakeServer(object):
         self.sock.listen(1)
 
         os.set_inheritable(self.sock.fileno(), True)
+        startdatetime = datetime.datetime.now()
         bb.daemonize.createDaemon(self._startServer, logfile)
         self.sock.close()
         self.bitbake_lock.close()
@@ -393,15 +399,31 @@ class BitBakeServer(object):
             ready.close()
             bb.error("Unable to start bitbake server")
             if os.path.exists(logfile):
+                logstart_re = re.compile(self.start_log_format % ('([0-9]+)', '([0-9-]+ [0-9:.]+)'))
+                started = False
+                lines = []
                 with open(logfile, "r") as f:
-                    logs=f.readlines()
-                bb.error("Last 10 lines of server log %s:\n%s" % (logfile, "".join(logs[-10:])))
+                    for line in f:
+                        if started:
+                            lines.append(line)
+                        else:
+                            res = logstart_re.match(line.rstrip())
+                            if res:
+                                ldatetime = datetime.datetime.strptime(res.group(2), self.start_log_datetime_format)
+                                if ldatetime >= startdatetime:
+                                    started = True
+                                    lines.append(line)
+                if lines:
+                    if len(lines) > 10:
+                        bb.error("Last 10 lines of server log for this session (%s):\n%s" % (logfile, "".join(lines[-10:])))
+                    else:
+                        bb.error("Server log for this session (%s):\n%s" % (logfile, "".join(lines)))
             raise SystemExit(1)
         ready.close()
         os.close(self.readypipein)
 
     def _startServer(self):
-        print("Starting bitbake server pid %d" % os.getpid())
+        print(self.start_log_format % (os.getpid(), datetime.datetime.now().strftime(self.start_log_datetime_format)))
         server = ProcessServer(self.bitbake_lock, self.sock, self.sockname)
         self.configuration.setServerRegIdleCallback(server.register_idle_function)
 
-- 
2.9.5


