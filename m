Return-Path: <olof.johansson@axis.com>
X-Greylist: delayed 522 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 09 Jul 2015 10:12:52 UTC
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 649656017E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jul 2015 10:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 554632E452
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jul 2015 12:04:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id UIjnZhrRqCJ3 for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jul 2015 12:04:07 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id A84F22E439
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jul 2015 12:04:07 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 861A8FB9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jul 2015 12:04:07 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 7924EA93
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jul 2015 12:04:07 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 7733134005
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jul 2015 12:04:07 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0;
	Thu, 9 Jul 2015 12:04:07 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 328BC9C68B; 
	Thu,  9 Jul 2015 12:04:07 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 9 Jul 2015 12:04:07 +0200
Message-ID: <1436436247-20509-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Subject: [PATCH] fetch2/sftp: Set BatchMode=yes as argument to sftp
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
X-List-Received-Date: Thu, 09 Jul 2015 10:12:53 -0000
Content-Type: text/plain

Set BatchMode=yes instead of PasswordAuthentication=no. This will make
sftp fail immediately, not only when SSH requires interactive
authentication, but also on errors related to host key verifcation.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/sftp.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 8ea4ef2..cb2f753 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -99,7 +99,7 @@ class SFTP(FetchMethod):
         """Fetch urls"""
 
         urlo = URI(ud.url)
-        basecmd = 'sftp -oPasswordAuthentication=no'
+        basecmd = 'sftp -oBatchMode=yes'
         port = ''
         if urlo.port:
             port = '-P %d' % urlo.port
-- 
2.1.4


