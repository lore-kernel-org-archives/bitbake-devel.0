Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 8DC3F6D315
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 11:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id E55A519DD2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OaYHRaQfpZy0 for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:43 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 3E1A119DBE
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 1D20BC6A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 11BF170A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 0FF633E06F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Mon, 20 Jan 2014
	12:03:25 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id E00F29C075; 
	Mon, 20 Jan 2014 12:03:24 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 12:03:21 +0100
Message-ID: <1390215804-20578-3-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
References: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 2/5] tests.fetch: Remove debug assert
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
X-List-Received-Date: Mon, 20 Jan 2014 11:03:45 -0000
Content-Type: text/plain

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/tests/fetch.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4bcff54..3dbeafa 100644
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
1.8.5.2


