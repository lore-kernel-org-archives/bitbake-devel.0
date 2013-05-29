Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id A89F86A5FA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 03:53:05 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r4T3r9rq001304
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2013 20:53:09 -0700 (PDT)
Received: from msp-mhatle-lx2.wrs.com (172.25.34.61) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.342.3; Tue, 28 May 2013 20:53:07 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 28 May 2013 22:59:15 -0500
Message-ID: <1369799955-1488-7-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.1.2.545.g2f19ada
In-Reply-To: <1369799955-1488-1-git-send-email-mark.hatle@windriver.com>
References: <1369799955-1488-1-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 7/7] knotty.py: Handle rare interrupted select call
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
X-List-Received-Date: Wed, 29 May 2013 03:53:05 -0000
Content-Type: text/plain

From: Jason Wessel <jason.wessel@windriver.com>

Under a high load and while resizing the terminal window, I received the following traceback:

Traceback (most recent call last):
  File "/bitbake/bin//bitbake", line 263, in <module>
    ret = main()
  File "/bitbake/bin//bitbake", line 252, in main
    return server.launchUI(ui_main, server_connection.connection, server_connection.events)
  File "/bitbake/lib/bb/server/process.py", line 269, in launchUI
    return bb.cooker.server_main(self.cooker, uifunc, *args)
  File "/bitbake/lib/bb/cooker.py", line 1407, in server_main
    ret = func(*args)
  File "/bitbake/lib/bb/ui/knotty.py", line 385, in main
    if stdin_mgr.poll():
error: (4, 'Interrupted system call')

Interrupted system calls from a sigwinch are certainly possible and the
right thing to do is just restart the system call, or in this case,
punt and wait until the next poll cycle.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index b2fb141..5cea884 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -262,7 +262,11 @@ class StdinMgr:
     def poll(self):
         if not self.stdinbackup:
             return False
-        return select.select([sys.stdin], [], [], 0) == ([sys.stdin], [], [])
+        try:
+            ret = select.select([sys.stdin], [], [], 0) == ([sys.stdin], [], [])
+        except:
+            return False
+        return ret
 
     def restore(self):
         if self.stdinbackup:
-- 
1.8.1.2.545.g2f19ada


