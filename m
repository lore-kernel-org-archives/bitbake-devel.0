Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id B674E6A5A1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Jul 2013 09:17:56 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 08 Jul 2013 02:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,1019,1363158000"; d="scan'208";a="366743475"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.28])
	by fmsmga002.fm.intel.com with ESMTP; 08 Jul 2013 02:17:56 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Jul 2013 10:17:51 +0100
Message-Id: <1373275071-17012-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [1.18][PATCH] Allow checksums to be used for files retrieved using SFTP
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
X-List-Received-Date: Mon, 08 Jul 2013 09:17:57 -0000

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

(Bitbake master rev: fd438a334d1f90ff07dded61c9648987da42c34f)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2eb5ae9..377fa01 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -989,13 +989,13 @@ class FetchData(object):
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
1.8.1.2


