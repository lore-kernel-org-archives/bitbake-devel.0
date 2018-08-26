Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4E38779396
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Aug 2018 22:36:57 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w7QMaww5029568
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Aug 2018 15:36:58 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 26 Aug 2018 15:36:58 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 26 Aug 2018 15:33:31 -0700
Message-ID: <0612ce28717d921a927d2702c0a232400d4ff0d0.1535322629.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535322629.git.David.Reyna@windriver.com>
References: <cover.1535322629.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 8/9] toaster/layerdetails.js: don't hide local layer info
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
X-List-Received-Date: Sun, 26 Aug 2018 22:36:57 -0000
Content-Type: text/plain

From: Awais Belal <awais_belal@mentor.com>

The local layer info (provided through custom fixtures) should
not be hidden. It is better to handle it in the same manner
as an imported layer, otherwise the layer path and dependency
info is not shown. The layer editing fields are handled in the
html side of things appropriately so this does not harm that
implementation.

[YOCTO #12891]

Signed-off-by: Awais Belal <awais_belal@mentor.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 9ead393..933b65b 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -359,7 +359,8 @@ function layerDetailsPageInit (ctx) {
     if ($(this).is("dt")) {
       var dd = $(this).next("dd");
       if (!dd.children("form:visible")|| !dd.find(".current-value").html()){
-        if (ctx.layerVersion.layer_source == ctx.layerSourceTypes.TYPE_IMPORTED){
+        if (ctx.layerVersion.layer_source == ctx.layerSourceTypes.TYPE_IMPORTED ||
+            ctx.layerVersion.layer_source == ctx.layerSourceTypes.TYPE_LOCAL) {
         /* There's no current value and the layer is editable
          * so show the "Not set" and hide the delete icon
          */
-- 
1.9.1


