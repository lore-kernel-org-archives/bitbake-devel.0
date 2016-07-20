Return-Path: <elliot.smith@intel.com>
Received: from bongo.birch.relay.mailchannels.net
	(bongo.birch.relay.mailchannels.net [23.83.209.21])
	by mail.openembedded.org (Postfix) with ESMTP id 79F67607A4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2016 16:37:17 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A65F6101051;
	Wed, 20 Jul 2016 16:37:14 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-220-3-24.us-west-2.compute.internal [10.220.3.24])
	by relay.mailchannels.net (Postfix) with ESMTPA id 1D96F101055;
	Wed, 20 Jul 2016 16:37:14 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.92.147.53])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.1); Wed, 20 Jul 2016 16:37:14 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1469032634359:1204498752
X-MC-Ingress-Time: 1469032634358
Received: from [176.249.240.35] (port=52136 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bPuUi-0000Xi-Ni; Wed, 20 Jul 2016 12:37:13 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jul 2016 17:37:04 +0100
Message-Id: <1469032624-484-2-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1469032624-484-1-git-send-email-elliot.smith@intel.com>
References: <1469032624-484-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 2/2] toaster-tests: fix URL given for Chromedriver download
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
X-List-Received-Date: Wed, 20 Jul 2016 16:37:18 -0000

The link to the Chromedriver downloads page is dead, so
put in the correct URL.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/tests/browser/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/tests/browser/README b/bitbake/lib/toaster/tests/browser/README
index 969f06c..6b09d20 100644
--- a/bitbake/lib/toaster/tests/browser/README
+++ b/bitbake/lib/toaster/tests/browser/README
@@ -13,7 +13,7 @@ a Selenium test report with a version-specific format.
 To run tests against Chrome:
 
 * Download chromedriver for your host OS from
-  https://code.google.com/p/chromedriver/downloads/list
+  https://sites.google.com/a/chromium.org/chromedriver/downloads
 * On *nix systems, put chromedriver on PATH
 * On Windows, put chromedriver.exe in the same directory as chrome.exe
 
-- 
2.7.4


