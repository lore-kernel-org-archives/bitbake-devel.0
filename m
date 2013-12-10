Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 3386C6DE03
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 15:09:45 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rBAF9ioN006905
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 07:09:44 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Tue, 10 Dec 2013 07:09:44 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Dec 2013 10:09:36 -0500
Message-ID: <02a2448f1d0d687107f674f4fa3d9e6bba902772.1386680149.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1386680149.git.liezhi.yang@windriver.com>
References: <cover.1386680149.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/5] [dora] bitbake: monitordisk: lower inode check warning to note
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
X-List-Received-Date: Tue, 10 Dec 2013 15:09:45 -0000
Content-Type: text/plain

From: Olof Johansson <olof.johansson@axis.com>

Filesystems like btrfs and reiserfs sets the inode count to 0, since
they don't have an inode concept. This is expected, and having a warning
show up every time you run bitbake can cause undue concern.

(Bitbake master rev: f3ac2d3678f48c68a250a0a20c08cf8687322d38)

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/monitordisk.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index 3e6ecbd..fca43ee 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
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


