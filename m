Received: from ra.se.axis.com ([195.60.68.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1UEjGv-0006qt-L1
	for bitbake-devel@lists.openembedded.org;
	Sun, 10 Mar 2013 17:39:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id B689B26134C
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Jr2zH+TnwSbd for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:15 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by ra.se.axis.com (Postfix) with ESMTP id 6C36C261348
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:15 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 2B54C3E2AB
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:15 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Sun, 10 Mar 2013
	17:22:15 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 2F3A39C079; 
	Sun, 10 Mar 2013 17:22:23 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 10 Mar 2013 17:22:19 +0100
Message-ID: <1362932543-3737-3-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1362932543-3737-1-git-send-email-olof.johansson@axis.com>
References: <1362932543-3737-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 2/5] tests.fetch: Remove debug assert
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
X-List-Received-Date: Sun, 10 Mar 2013 16:40:06 -0000
Content-Type: text/plain

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/tests/fetch.py |    2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 778d94f..1ba33e6 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -243,8 +243,6 @@ class URITest(unittest.TestCase):
             uri.params = test['params']
             self.assertEqual(uri.params, test['params'])
 
-            self.assertEqual(str(uri)+str(uri.relative), str(test['uri'])+str(test['relative']))
-
             self.assertEqual(str(uri), test['uri'])
 
             uri.params = {}
-- 
1.7.10.4



