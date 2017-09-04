Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 17C57780C8
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Sep 2017 04:10:40 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v844Agjo020231
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 3 Sep 2017 21:10:42 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sun, 3 Sep 2017 21:10:41 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 3 Sep 2017 21:02:23 -0700
Message-ID: <9dd81ceabfaa9a115f9fde3df555ddab57eb3a44.1504496902.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1504496902.git.David.Reyna@windriver.com>
References: <cover.1504496902.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 3/3] toaster: edit column list not sorted
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
X-List-Received-Date: Mon, 04 Sep 2017 04:10:41 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The list of columns in the many 'Edit Columns' pop-ups became unsorted
with the 'Toaster Table' implementation. These entries need to be
gathered and sorted in the column processing.

[YOCTO #12004]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/static/js/table.js | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 1bbc8d1..abcb5ca 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -202,6 +202,7 @@ function tableInit(ctx){
     }
 
     /* Add table header and column toggle menu */
+    var column_edit_entries = [];
     for (var i in tableData.columns){
       var col = tableData.columns[i];
       if (col.displayable === false) {
@@ -293,9 +294,17 @@ function tableInit(ctx){
         defaultHiddenCols.push(col.field_name);
       }
 
-      editColMenu.append(toggler);
+      /* Gather the Edit Column entries */
+      column_edit_entries.push({'title':col.title,'html':toggler});
+
     } /* End for each column */
 
+    /* Append the sorted Edit Column toggler entries */
+    column_edit_entries.sort(function(a,b) {return (a.title > b.title) ? 1 : ((b.title > a.title) ? -1 : 0);} );
+    for (var col in column_edit_entries){
+      editColMenu.append(column_edit_entries[col].html);
+    }
+
     tableChromeDone = true;
   }
 
-- 
1.9.1


