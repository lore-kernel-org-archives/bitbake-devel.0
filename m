Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8g-0003RO-EA
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:50:02 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbMO5002006
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:22 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:22 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:38 -0500
Message-ID: <1347921818-60562-9-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
References: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 8/8] knotty.py: Handle rare interrupted select call
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 17 Sep 2012 22:50:02 -0000
Content-Type: text/plain

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

(LOCAL REV: NOT UPSTREAM)

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 2d58ebe..73327b5 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -257,7 +257,11 @@ class StdinMgr:
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
1.7.1



