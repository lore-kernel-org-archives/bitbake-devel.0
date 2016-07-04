Return-Path: <elliot.smith@intel.com>
Received: from bongo.tulip.relay.mailchannels.net
	(bongo.tulip.relay.mailchannels.net [23.83.218.21])
	by mail.openembedded.org (Postfix) with ESMTP id 3B6886011C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jul 2016 15:34:59 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1B511100905;
	Mon,  4 Jul 2016 15:34:57 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-213-0-221.us-west-2.compute.internal [10.213.0.221])
	by relay.mailchannels.net (Postfix) with ESMTPA id 6C2851010C3;
	Mon,  4 Jul 2016 15:34:54 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.21.150.52])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Mon, 04 Jul 2016 15:34:57 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467646494744:201310362
X-MC-Ingress-Time: 1467646494743
Received: from [176.251.41.101] (port=51684 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bK5wF-0007ND-As; Mon, 04 Jul 2016 11:37:35 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Jul 2016 16:34:45 +0100
Message-Id: <1467646486-3262-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
X-AuthUser: elliot@townx.org
Subject: [PATCH 1/2] toaster: layerBtn avoid connecting handler to other build buttons
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
X-List-Received-Date: Mon, 04 Jul 2016 15:35:03 -0000

From: Michael Wood <michael.g.wood@intel.com>

Some pages contain other build buttons which may have the same class
attached. Make sure that we only select the buttons in the tables where
layerBtn is used.

[YOCTO #9841]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/layerBtn.js | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/layerBtn.js b/bitbake/lib/toaster/toastergui/static/js/layerBtn.js
index 259271d..9f9eda1 100644
--- a/bitbake/lib/toaster/toastergui/static/js/layerBtn.js
+++ b/bitbake/lib/toaster/toastergui/static/js/layerBtn.js
@@ -55,8 +55,8 @@ function layerBtnsInit() {
     });
   });
 
-  $(".build-recipe-btn").unbind('click');
-  $(".build-recipe-btn").click(function(e){
+  $("td .build-recipe-btn").unbind('click');
+  $("td .build-recipe-btn").click(function(e){
     e.preventDefault();
     var recipe = $(this).data('recipe-name');
 
-- 
2.7.4


