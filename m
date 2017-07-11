Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 87C0D781F2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 22:04:48 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v6BM4nnu005872
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 15:04:49 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Tue, 11 Jul 2017 15:04:48 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Jul 2017 14:56:10 -0700
Message-ID: <b3f416485f0690019ef4fec86a9949e4524e9903.1499809423.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1499809423.git.David.Reyna@windriver.com>
References: <cover.1499809423.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 3/3] toaster: trim build target input
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
X-List-Received-Date: Tue, 11 Jul 2017 22:04:48 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Trim the entered built target value so that Toaster is not
confused with no real targets nor a ghost second target.

[YOCTO #11727]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/static/js/projecttopbar.js | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/projecttopbar.js b/lib/toaster/toastergui/static/js/projecttopbar.js
index 92ab2d6..69220aa 100644
--- a/lib/toaster/toastergui/static/js/projecttopbar.js
+++ b/lib/toaster/toastergui/static/js/projecttopbar.js
@@ -73,14 +73,14 @@ function projectTopBarInit(ctx) {
 
   newBuildTargetBuildBtn.click(function (e) {
     e.preventDefault();
-    if (!newBuildTargetInput.val()) {
+    if (!newBuildTargetInput.val().trim()) {
       return;
     }
     /* We use the value of the input field so as to maintain any command also
      * added e.g. core-image-minimal:clean and because we can build targets
      * that toaster doesn't yet know about
      */
-    selectedTarget = { name: newBuildTargetInput.val() };
+    selectedTarget = { name: newBuildTargetInput.val().trim() };
 
     /* Fire off the build */
     libtoaster.startABuild(null, selectedTarget.name,
-- 
1.9.1


