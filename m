Received: from ra.se.axis.com ([195.60.68.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1UZeOC-0000Vp-Rv
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 May 2013 11:40:58 +0200
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 7CF6F11ED5
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pYRpnlLOeAH8 for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:51 +0200 (CEST)
Received: from boulder.localdomain (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id 260C7282F0C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:39 +0200 (CEST)
Received: from boulder.localdomain (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id F341E8A6
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:38 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.localdomain (Postfix) with ESMTP id E7FFA89E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:38 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id E50393E056
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:38 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0;
	Tue, 7 May 2013 11:22:38 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id BB59B9C079; 
	Tue,  7 May 2013 11:22:38 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 7 May 2013 11:22:37 +0200
Message-ID: <1367918558-16136-2-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1367918558-16136-1-git-send-email-olof.johansson@axis.com>
References: <1367918558-16136-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [WIP 1/2] pysh: Say what kind of token isn't implemented
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
X-List-Received-Date: Tue, 07 May 2013 09:41:00 -0000
Content-Type: text/plain

When the shell lexer finds an unrecognized dollar token, the error
message should contain what kind of token it is having problems with.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/pysh/pyshlex.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/pysh/pyshlex.py b/lib/bb/pysh/pyshlex.py
index b977b5e..b301236 100644
--- a/lib/bb/pysh/pyshlex.py
+++ b/lib/bb/pysh/pyshlex.py
@@ -292,7 +292,7 @@ class WordLexer:
         elif sep=='${':
             parsefunc = self._parse_parameter
         else:
-            raise NotImplementedError()
+            raise NotImplementedError(sep)
             
         pos, closed = parsefunc(buf, result, eof)
         return pos, closed
-- 
1.7.10.4



