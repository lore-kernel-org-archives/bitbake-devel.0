Return-Path: <peter.kjellerstedt@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 8CCA8607F9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 09:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 14B3419DE1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id m01Drd2sbvSE for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:03 +0200 (CEST)
Received: from boulder.localdomain (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 4A8B019DE7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:03 +0200 (CEST)
Received: from boulder.localdomain (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 34C98B9E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:03 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.localdomain (Postfix) with ESMTP id 29F91B44
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:03 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 288473423A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:03 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id r5K9a3t3025431
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:03 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id r5K9a39c025430
	for bitbake-devel@lists.openembedded.org;
	Thu, 20 Jun 2013 11:36:03 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Jun 2013 11:35:49 +0200
Message-Id: <79edf20a7b81a6b1cb57f6056ff25f3bf449ffd2.1371720878.git.pkj@axis.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <cover.1371720878.git.pkj@axis.com>
References: <cover.1371720878.git.pkj@axis.com>
In-Reply-To: <cover.1371720878.git.pkj@axis.com>
References: <cover.1371720878.git.pkj@axis.com>
Subject: [PATCH 2/2] Correct a typo
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
X-List-Received-Date: Thu, 20 Jun 2013 09:36:05 -0000

---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index bf0ec45..ecd9b40 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1091,7 +1091,7 @@ class FetchMethod(object):
     def recommends_checksum(self, urldata):
         """
         Is the backend on where checksumming is recommended (should warnings 
-        by displayed if there is no checksum)?
+        be displayed if there is no checksum)?
         """
         return False
 
-- 
1.8.2.1


