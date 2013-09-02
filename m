Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 72B486BBDA
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Sep 2013 13:41:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r82DfP4M007294
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 2 Sep 2013 06:41:25 -0700 (PDT)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Mon, 2 Sep 2013 06:41:24 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 2 Sep 2013 09:41:19 -0400
Message-ID: <8dcf075be8c4d4884828bbb3ab482de444b9c1bc.1378121137.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1378121137.git.liezhi.yang@windriver.com>
References: <cover.1378121137.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] providers.py: enhance the runtime debug degbug messgae
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
X-List-Received-Date: Mon, 02 Sep 2013 13:41:24 -0000
Content-Type: text/plain

The runtime provider debug message is the same as the build time debug
message, make them different would be better.

[YOCTO #5067]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/providers.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index cac13ac..3a4f604 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -341,7 +341,7 @@ def filterProvidersRunTime(providers, item, cfgData, dataCache):
     if numberPreferred > 1:
         logger.error("Trying to resolve runtime dependency %s resulted in conflicting PREFERRED_PROVIDER entries being found.\nThe providers found were: %s\nThe PREFERRED_PROVIDER entries resulting in this conflict were: %s", item, preferred, preferred_vars)
 
-    logger.debug(1, "sorted providers for %s are: %s", item, eligible)
+    logger.debug(1, "sorted runtime providers for %s are: %s", item, eligible)
 
     return eligible, numberPreferred
 
-- 
1.7.10.4


