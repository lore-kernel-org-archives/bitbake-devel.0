Received: from exprod5og117.obsmtp.com ([64.18.0.149])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.donnelly@ge.com>) id 1UVVbp-0003qt-FT
	for bitbake-devel@lists.openembedded.org;
	Fri, 26 Apr 2013 01:29:58 +0200
Received: from alpmlip12.e2k.ad.ge.com ([165.156.5.1]) (using TLSv1) by
	exprod5ob117.postini.com ([64.18.4.12]) with SMTP
	ID DSNKUXm4Rq7yUNCkp4P+JqcJIVKYY19j3l2r@postini.com;
	Thu, 25 Apr 2013 16:12:07 PDT
Received: from unknown (HELO alpmlip01.e2k.ad.ge.com) ([3.159.17.48])
	by alpmlip12.e2k.ad.ge.com with ESMTP/TLS/RC4-SHA;
	25 Apr 2013 12:41:25 -0400
Received: from selma.edi.geip.ge.com ([3.26.68.70])
	by alpmlip01.e2k.ad.ge.com with ESMTP; 25 Apr 2013 12:41:26 -0400
Received: from edna.edi.geip.ge.com (edna.edi.geip.ge.com [3.26.68.71])
	by selma.edi.geip.ge.com (Postfix) with ESMTP id 9F37BE0826;
	Thu, 25 Apr 2013 17:41:24 +0100 (BST)
From: Martin Donnelly <martin.donnelly@ge.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Apr 2013 17:41:06 +0100
Message-Id: <1366908066-8493-1-git-send-email-martin.donnelly@ge.com>
X-Mailer: git-send-email 1.7.1
Subject: [PATCH] goggle: fix invalid error check
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
X-List-Received-Date: Thu, 25 Apr 2013 23:30:03 -0000

runCommand was returning 'error' but checking for 'err'
resulting in an exception.

Signed-off-by: Martin Donnelly <martin.donnelly@ge.com>
---
 lib/bb/ui/goggle.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/goggle.py b/lib/bb/ui/goggle.py
index c0785b7..e8a54ab 100644
--- a/lib/bb/ui/goggle.py
+++ b/lib/bb/ui/goggle.py
@@ -81,7 +81,7 @@ def main (server, eventHandler):
 
     try:
         cmdline, error = server.runCommand(["getCmdLineAction"])
-        if err:
+        if error:
             print("Error getting bitbake commandline: %s" % error)
             return 1
         elif not cmdline:
-- 
1.7.1



