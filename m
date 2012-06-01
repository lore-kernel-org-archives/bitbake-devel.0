Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SaZPC-00023P-CV
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jun 2012 23:29:10 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q51LIm2P021599
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 1 Jun 2012 14:18:48 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 1 Jun 2012 14:18:47 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 1 Jun 2012 16:18:38 -0500
Message-ID: <1338585519-869-9-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1338585519-869-1-git-send-email-jason.wessel@windriver.com>
References: <1338585519-869-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v2 8/9] meta/lib/oe/terminal.py: Add an additional reference to screen called screen_inline
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
X-List-Received-Date: Fri, 01 Jun 2012 21:29:11 -0000
Content-Type: text/plain

This is a new mode for screen with the explicit purpose of invoking
screen on the same terminal that you started bitbake.  The bitbake knotty
will attempt to launch screen directly when using this setting for
OE_TERMINAL.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 meta/lib/oe/terminal.py |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/meta/lib/oe/terminal.py b/meta/lib/oe/terminal.py
index 43639d5..ca94e73 100644
--- a/meta/lib/oe/terminal.py
+++ b/meta/lib/oe/terminal.py
@@ -92,6 +92,13 @@ class Rxvt(XTerminal):
     command = 'rxvt -T "{title}" -e {command}'
     priority = 1
 
+class Screen_inline(Terminal):
+    command = 'screen -D -m -t "{title}" -S devshell {command}'
+
+    def __init__(self, command, title=None, env=None):
+        Terminal.__init__(self, command, title, env)
+        logger.warn('Screen Connect Command: screen -r devshell')
+
 class Screen(Terminal):
     command = 'screen -D -m -t "{title}" -S devshell {command}'
 
-- 
1.7.10



