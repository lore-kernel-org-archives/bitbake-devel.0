Return-Path: <olof.johansson@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id F2A416D23B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Oct 2013 10:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id A0DA713BCE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Oct 2013 12:22:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bK0QqqyPYFBh for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Oct 2013 12:22:01 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id D746113BA3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Oct 2013 12:21:59 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id BE8195E6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Oct 2013 12:21:59 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id B39824C1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Oct 2013 12:21:59 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id B16943404E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Oct 2013 12:21:59 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Fri, 18 Oct 2013
	12:21:59 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 6FEF69C078; 
	Fri, 18 Oct 2013 12:21:59 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 18 Oct 2013 12:21:59 +0200
Message-ID: <1382091719-30603-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH v2] monitordisk: lower inode check warning to note
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
X-List-Received-Date: Fri, 18 Oct 2013 10:22:00 -0000
Content-Type: text/plain

Filesystems like btrfs and reiserfs sets the inode count to 0, since
they don't have an inode concept. This is expected, and having a warning
show up every time you run bitbake can cause undue concern.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
Fixes stupid typo in commit message. Thanks Chris!
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


