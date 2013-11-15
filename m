Return-Path: <Konrad.Scherer@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2FA876D476
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2013 20:51:47 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rAFKpmts015287
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2013 12:51:49 -0800 (PST)
Received: from yow-kscherer-d1.wrs.com (128.224.146.215) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.347.0; Fri, 15 Nov 2013 12:51:48 -0800
From: Konrad Scherer <konrad.scherer@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 15 Nov 2013 15:51:47 -0500
Message-ID: <1384548707-31336-2-git-send-email-konrad.scherer@windriver.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1384548707-31336-1-git-send-email-konrad.scherer@windriver.com>
References: <1384548707-31336-1-git-send-email-konrad.scherer@windriver.com>
MIME-Version: 1.0
Subject: [PATCH] serv.py: Give pr-server up to 5 seconds to commit data
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
X-List-Received-Date: Fri, 15 Nov 2013 20:51:47 -0000
Content-Type: text/plain

From: Konrad Scherer <Konrad.Scherer@windriver.com>

The default value of 0.5 seconds before sending the pr-server a
SIGTERM is not enough to guarantee that sqlite has committed all
the pr data to the database. By polling the pid to see if it is
still running, this allows the pr-server process to shutdown
cleanly and finish the final pr data commit.

Signed-off-by: Konrad Scherer <Konrad.Scherer@windriver.com>
---
 lib/prserv/serv.py | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 7864594..e4c1c2a 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -13,6 +13,7 @@ except ImportError:
 import bb.server.xmlrpc
 import prserv
 import prserv.db
+import errno
 
 logger = logging.getLogger("BitBake.PRserv")
 
@@ -280,8 +281,18 @@ def stop_daemon(host, port):
         if pid:
             if os.path.exists(pidfile):
                 os.remove(pidfile)
-            os.kill(pid,signal.SIGTERM)
-            time.sleep(0.1)
+
+            wait_timeout = 0
+            while is_running(pid) and wait_timeout < 10:
+                print("Waiting for pr-server to exit.")
+                time.sleep(0.5)
+                wait_timeout += 1
+
+            if is_running(pid):
+                print("Sending SIGTERM to pr-server.")
+                os.kill(pid,signal.SIGTERM)
+                time.sleep(0.1)
+
     except OSError as e:
         err = str(e)
         if err.find("No such process") <= 0:
@@ -289,6 +300,14 @@ def stop_daemon(host, port):
 
     return 0
 
+def is_running(pid):
+    try:
+        os.kill(pid, 0)
+    except OSError as err:
+        if err.errno == errno.ESRCH:
+            return False
+    return True
+
 def is_local_special(host, port):
     if host.strip().upper() == 'localhost'.upper() and (not port):
         return True
-- 
1.8.3.2


