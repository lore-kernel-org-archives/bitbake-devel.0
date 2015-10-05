Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 5D6B1755F4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Oct 2015 11:08:51 +0000 (UTC)
Received: by wicfx3 with SMTP id fx3so114164802wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Oct 2015 04:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=uO6q4E0/7LeUihc0Agi+jtovC/HJettW79xG06tT9WQ=;
	b=fLfewktHhdWf55vTkKB4NOqzv3xxzVLwiguI5lcg/CytSG9a8FkhtvjBxQEKxSfS1d
	GGNhhWRJQ3z2MULxlskExNzrKr9LppGACz1eXLQaUmzh8w2etdeRLAXn6QInsXYwmz7G
	ahteoOEAIZn1vAXDI2kWGnEQ5h7HKvv+OGipiqUU4loz8Kn+lPLtb/+IU/mTYJwih6Cm
	7lft4Ke85u/f9CyVH7xjaHvZ/MTfO/X0eEMLehZ3Q4EPLIu68f+fQwWduzlF7Q0Akx5v
	0WuQo0CKvBz9JPQIMAE4E7lJubmibXb6aP6JlcTT62Zd8RO3PXMPbdtXZu/SFQv9M+ny
	Q6OA==
X-Gm-Message-State: ALoCoQmh5bS13Vpa8g1wPNBQh4QPl2qIMHnTbTIJOfHIOdEOuhqvQFe74n/1KsHVIkJc70hMb5G8
X-Received: by 10.194.187.17 with SMTP id fo17mr27819204wjc.130.1444043331435; 
	Mon, 05 Oct 2015 04:08:51 -0700 (PDT)
Received: from localhost.localdomain ([2.218.205.118])
	by smtp.gmail.com with ESMTPSA id
	jf3sm14040527wic.8.2015.10.05.04.08.50
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Oct 2015 04:08:50 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Oct 2015 12:08:31 +0100
Message-Id: <1444043312-7618-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 1/2] toaster: Don't add new history entries when table data loads
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
X-List-Received-Date: Mon, 05 Oct 2015 11:08:55 -0000

From: Elliot Smith <elliot.smith@intel.com>

When ToasterTable data is loaded into the UI, a new entry is
added to the browser history. This means that pressing the back
button appears to have no effect, as you end up at the same page,
possibly with slightly different data.

Instead, use replaceState(), so that the browser history doesn't
grow, but the page context still gets updated.

[YOCTO #7660]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/table.js | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index f18034d..bc81e67 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -33,14 +33,6 @@ function tableInit(ctx){
 
   loadData(tableParams);
 
-  window.onpopstate = function(event){
-    if (event.state){
-      tableParams = event.state.tableParams;
-      /* We skip loadData and just update the table */
-      updateTable(event.state.tableData);
-    }
-  };
-
   function loadData(tableParams){
     $.ajax({
         type: "GET",
@@ -49,10 +41,8 @@ function tableInit(ctx){
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function(tableData) {
           updateTable(tableData);
-          window.history.pushState({
-              tableData: tableData,
-              tableParams: tableParams
-          }, null, libtoaster.dumpsUrlParams(tableParams));
+          window.history.replaceState(null, null,
+            libtoaster.dumpsUrlParams(tableParams));
         }
     });
   }
-- 
2.1.4


