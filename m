Return-Path: <kai.kang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 85F536004D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Aug 2018 02:57:52 +0000 (UTC)
Received: from ala-blade48.wrs.com (ala-blade48.wrs.com [147.11.105.68])
	by mail.windriver.com (8.15.2/8.15.1) with SMTP id w7A2vpbq007004
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Aug 2018 19:57:52 -0700 (PDT)
Received: by ala-blade48.wrs.com (sSMTP sendmail emulation);
	Thu, 09 Aug 2018 19:57:51 -0700
From: Kai Kang <kai.kang@windriver.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Aug 2018 19:57:50 -0700
Message-Id: <20180810025750.3857-1-kai.kang@windriver.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] event.py: fix typo
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
X-List-Received-Date: Fri, 10 Aug 2018 02:57:52 -0000

Signed-off-by: Kai Kang <kai.kang@windriver.com>
---
 bitbake/lib/bb/event.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 5d0049626d5..c0ec605209a 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -395,7 +395,7 @@ class RecipeEvent(Event):
         Event.__init__(self)
 
 class RecipePreFinalise(RecipeEvent):
-    """ Recipe Parsing Complete but not yet finialised"""
+    """ Recipe Parsing Complete but not yet finalised"""
 
 class RecipeTaskPreProcess(RecipeEvent):
     """
-- 
2.11.0


