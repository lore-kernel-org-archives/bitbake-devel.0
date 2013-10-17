Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 6CAED60FF0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2013 15:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 05ADD19E20
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2013 17:22:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZW+mY0tOgmw8 for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2013 17:22:56 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id D796A19D76
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2013 17:22:55 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id B48D39D5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2013 17:22:55 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id A92DD9C7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2013 17:22:55 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id A70733E06F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2013 17:22:55 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Thu, 17 Oct 2013
	17:22:55 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 657D49C078; 
	Thu, 17 Oct 2013 17:22:55 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Oct 2013 17:22:55 +0200
Message-ID: <1382023375-16167-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH] monitordisk: lower inode check warning to note
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
X-List-Received-Date: Thu, 17 Oct 2013 15:23:01 -0000
Content-Type: text/plain

Filesystems like btrfs and reiserfs sets the inode count to 0, since
they don't have an inode concept. This is excepted, and having a warning
show up every time you run bitbake can cause undue concern.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/monitordisk.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index 3e6ecbd..fca43ee 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -243,7 +243,7 @@ class diskMonitor:
                     # zero, this is a feature of the fs, we disable the inode
                     # checking for such a fs.
                     if st.f_files == 0:
-                        logger.warn("Inode check for %s is unavaliable, will remove it from disk monitor" % path)
+                        logger.info("Inode check for %s is unavaliable, will remove it from disk monitor" % path)
                         self.devDict[k][2] = None
                         continue
                     # Always show warning, the self.checked would always be False if the action is WARN
-- 
1.7.10.4


