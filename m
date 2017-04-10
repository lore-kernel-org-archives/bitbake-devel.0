Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id A560F60053
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 05:22:28 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v3A5MSJV004064
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 9 Apr 2017 22:22:29 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.216.91) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Sun, 9 Apr 2017 22:22:28 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 9 Apr 2017 22:12:57 -0700
Message-ID: <8fde29dcc8db14dfaf2c4f810c677b213b6ad898.1491801105.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1491801105.git.David.Reyna@windriver.com>
References: <cover.1491801105.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.216.91]
Subject: [PATCH 1/1] toaster: fix add layer button for Machines
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
X-List-Received-Date: Mon, 10 Apr 2017 05:22:28 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Fix a missing close quote in the layer add button, and
use the layer index for the xhr_layer call.

[YOCTO #11213]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/machine_btn.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/machine_btn.html b/lib/toaster/toastergui/templates/machine_btn.html
index 12b5c96..6debe65 100644
--- a/lib/toaster/toastergui/templates/machine_btn.html
+++ b/lib/toaster/toastergui/templates/machine_btn.html
@@ -7,8 +7,8 @@
 <a class="btn btn-default btn-block layerbtn
 layer-add-{{data.layer_version.id}}" data-layer='{ "id":
    {{data.layer_version.id}}, "name":  "{{data.layer_version.layer.name}}",
-   "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.id %},
-   "xhrLayerUrl": "{% url "xhr_layer" extra.pid data.pk %}",
+   "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.id %}",
+   "xhrLayerUrl": "{% url "xhr_layer" extra.pid data.layer_version.id %}"
    }' data-directive="add"
     {% if data.layer_version.pk in extra.current_layers %}
     style="display:none;"
-- 
1.9.1


