Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8s-0003Uk-Mb
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:50:15 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbZLV009871
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:35 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:34 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:51 -0500
Message-ID: <1347921831-60604-5-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1347921831-60604-1-git-send-email-jason.wessel@windriver.com>
References: <1347921831-60604-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 4/4] terminal: Send LogExecTTY event to spawn screen
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
X-List-Received-Date: Mon, 17 Sep 2012 22:50:15 -0000
Content-Type: text/plain

Bitbake has the ability to request to run a command
and if it is not possible fall back to emitting a
log message.  This can be used to start a screen
client automatically on the controling tty if
the UI has an interactive tty.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 meta/lib/oe/terminal.py |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/meta/lib/oe/terminal.py b/meta/lib/oe/terminal.py
index c71d6ad..1e74315 100644
--- a/meta/lib/oe/terminal.py
+++ b/meta/lib/oe/terminal.py
@@ -97,9 +97,14 @@ class Screen(Terminal):
     def __init__(self, sh_cmd, title=None, env=None, d=None):
         s_id = "devshell_%i" % os.getpid()
         self.command = "screen -D -m -t \"{title}\" -S %s {command}" % s_id
-        Terminal.__init__(self, sh_cmd, title, env)
-        logger.warn('Screen started. Please connect in another terminal with '
-                    '"screen -r devshell %s"' % s_id)
+        Terminal.__init__(self, sh_cmd, title, env, d)
+        msg = 'Screen started. Please connect in another terminal with ' \
+            '"screen -r %s"' % s_id
+        if (d):
+            bb.event.fire(bb.event.LogExecTTY(msg, "screen -r %s" % s_id,
+                                              0.5, 10), d)
+        else:
+            logger.warn(msg)
 
 
 def prioritized():
-- 
1.7.1



