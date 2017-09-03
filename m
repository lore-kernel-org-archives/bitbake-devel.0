Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id CC8E67836A
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  3 Sep 2017 05:32:27 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v835WOkW019892
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 2 Sep 2017 22:32:28 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sat, 2 Sep 2017 22:32:23 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 2 Sep 2017 22:24:04 -0700
Message-ID: <5d5eb41c8a5abecb6fedeeee3f58ba9f7653a067.1504416112.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1504416112.git.David.Reyna@windriver.com>
References: <cover.1504416112.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/4] toaster: display error when the fstype select is empty
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
X-List-Received-Date: Sun, 03 Sep 2017 05:32:27 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

There must be at least one FSTYPE selected in the Toaster bitbake
variable editor page. When the user deselects all the "Save"
button gets disabled, but the error message is missing.

[YOCTO #8126]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/projectconf.html | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index fcf6df2..0e9712b 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -63,6 +63,7 @@
         <button id="cancel-change-image_fstypes" type="button" class="btn btn-link">Cancel</button>
       </div>
       <p class="help-block text-danger" style="display:none;" id="hintError-image-fs_type">A valid image type cannot include underscores</p>
+      <p class="help-block text-danger" style="display:none;" id="fstypes-error-message">You must select at least one image type</p>
       <label>Or choose from known image types:</label>
       <input id="filter-image_fstypes" type="text" placeholder="Search image types" class="form-control">
       <div id="all-image_fstypes" class="scrolling"></div>
@@ -716,8 +717,10 @@ $(document).ready(function() {
     }
     if ($('#new-imagefs_types').val().length === 0) {
       $("#apply-change-image_fstypes").prop("disabled", true);
+      $('#fstypes-error-message').show();
     } else {
       $("#apply-change-image_fstypes").prop("disabled", false);
+      $('#fstypes-error-message').hide();
     }
   });
 
-- 
1.9.1


