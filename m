Return-Path: <elliot.smith@intel.com>
Received: from bongo.birch.relay.mailchannels.net
	(bongo.birch.relay.mailchannels.net [23.83.209.21])
	by mail.openembedded.org (Postfix) with ESMTP id EC7B3731B9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Aug 2016 15:42:53 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 107E6120E14;
	Mon, 22 Aug 2016 15:42:50 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-27-139-41.us-west-2.compute.internal [10.27.139.41])
	by relay.mailchannels.net (Postfix) with ESMTPA id 829BC121A77;
	Mon, 22 Aug 2016 15:42:48 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com ([TEMPUNAVAIL].
	[10.135.9.54]) (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.6); Mon, 22 Aug 2016 15:42:50 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1471880569846:4083408369
X-MC-Ingress-Time: 1471880569845
Received: from [176.249.240.35] (port=48672 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bbrN4-0002ZA-Ci; Mon, 22 Aug 2016 11:42:42 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Aug 2016 16:42:30 +0100
Message-Id: <1471880556-9232-3-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
References: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 3/9] toaster: update api to include local_source_dir
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
X-List-Received-Date: Mon, 22 Aug 2016 15:42:54 -0000

From: Sujith H <sujith.h@gmail.com>

Add an additional argument to the api to handle
local_source_dir which is the value user passes
to import non-git layers.

[YOCTO #9913]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/api.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/toastergui/api.py b/bitbake/lib/toaster/toastergui/api.py
index b57f670..8dde128 100644
--- a/bitbake/lib/toaster/toastergui/api.py
+++ b/bitbake/lib/toaster/toastergui/api.py
@@ -135,7 +135,7 @@ class XhrLayer(View):
           Method: POST
 
           Args:
-              vcs_url, dirpath, commit, up_branch, summary, description
+              vcs_url, dirpath, commit, up_branch, summary, description, local_source_dir
 
               add_dep = append a layerversion_id as a dependency
               rm_dep = remove a layerversion_id as a depedency
@@ -166,6 +166,8 @@ class XhrLayer(View):
             layer_version.layer.summary = request.POST["summary"]
         if "description" in request.POST:
             layer_version.layer.description = request.POST["description"]
+        if "local_source_dir" in request.POST:
+            layer_version.layer.local_source_dir = request.POST["local_source_dir"]
 
         if "add_dep" in request.POST:
             lvd = LayerVersionDependency(
-- 
2.7.4


