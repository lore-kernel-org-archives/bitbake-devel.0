Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>) id 1SVglg-0002Vg-LG
	for bitbake-devel@lists.openembedded.org;
	Sat, 19 May 2012 12:20:12 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id q4J9xwXl012050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 May 2012 11:59:59 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1SVgS6-0006IP-Lk; Sat, 19 May 2012 11:59:58 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 19 May 2012 11:59:53 +0200
Message-Id: <1337421593-24163-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 1.7.7.6
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 0.995
X-Spam-Score: -5.3
X-Spam-Level: -----
X-Spam-Tests: AWL,BAYES_00,SPF_NEUTRAL,T_RP_MATCHES_RCVD,DSPAM_INNOCENT
X-Scanned-By: MIMEDefang 2.73
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
	Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Subject: [PATCH] knotty2: return exit code
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
X-List-Received-Date: Sat, 19 May 2012 10:20:12 -0000

From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>

'bitbake -u knotty2' never failed which was caused by main() not
propagating the exit code.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 lib/bb/ui/knotty2.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/knotty2.py b/lib/bb/ui/knotty2.py
index aa6a408..65e941b 100644
--- a/lib/bb/ui/knotty2.py
+++ b/lib/bb/ui/knotty2.py
@@ -106,4 +106,4 @@ class TerminalFilter2(object):
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
 
 def main(server, eventHandler):
-    bb.ui.knotty.main(server, eventHandler, TerminalFilter2)
+    return bb.ui.knotty.main(server, eventHandler, TerminalFilter2)
-- 
1.7.7.6



