Return-Path: <peter.kjellerstedt@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id 6D9E66AD3B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 09:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 0C57E11F13
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id krPNiU-3PSPW for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:02 +0200 (CEST)
Received: from boulder.localdomain (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id 6247811E03
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:02 +0200 (CEST)
Received: from boulder.localdomain (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 4538F477
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:02 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.localdomain (Postfix) with ESMTP id 3A50E35E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:02 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 38A6E3423A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:02 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id r5K9a2CG025427
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:02 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id r5K9a2qK025426
	for bitbake-devel@lists.openembedded.org;
	Thu, 20 Jun 2013 11:36:02 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Jun 2013 11:35:48 +0200
Message-Id: <181c937f5e0cf7cd626b25438eb4c3dfaad7f306.1371720878.git.pkj@axis.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <cover.1371720878.git.pkj@axis.com>
References: <cover.1371720878.git.pkj@axis.com>
In-Reply-To: <cover.1371720878.git.pkj@axis.com>
References: <cover.1371720878.git.pkj@axis.com>
Subject: [PATCH 1/2] Allow checksums to be used for files retrieved using SFTP
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 20 Jun 2013 09:36:08 -0000

---
 bitbake/lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index dd1cc93..bf0ec45 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -976,13 +976,13 @@ class FetchData(object):
             self.sha256_name = "sha256sum"
         if self.md5_name in self.parm:
             self.md5_expected = self.parm[self.md5_name]
-        elif self.type not in ["http", "https", "ftp", "ftps"]:
+        elif self.type not in ["http", "https", "ftp", "ftps", "sftp"]:
             self.md5_expected = None
         else:
             self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name)
         if self.sha256_name in self.parm:
             self.sha256_expected = self.parm[self.sha256_name]
-        elif self.type not in ["http", "https", "ftp", "ftps"]:
+        elif self.type not in ["http", "https", "ftp", "ftps", "sftp"]:
             self.sha256_expected = None
         else:
             self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name)
-- 
1.8.2.1


