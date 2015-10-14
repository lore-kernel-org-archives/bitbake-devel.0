Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 9162F73232
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 12:13:24 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga102.fm.intel.com with ESMTP; 14 Oct 2015 05:13:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,681,1437462000"; d="scan'208";a="826437049"
Received: from marcinko-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.22.75])
	by orsmga002.jf.intel.com with ESMTP; 14 Oct 2015 05:13:23 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 13:12:14 +0100
Message-Id: <1444824734-619-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: Improve directory structure layout
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
X-List-Received-Date: Wed, 14 Oct 2015 12:13:25 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

File names in the directory structure often wrap
due to big indenting for nested files and directories,
unnecessary width in certain columns, and not using
colspan when the symlink and package cells are empty.
The wrapping makes the table harder to read.

This patch reduces the amount of indenting, limits the
width of the 'Size', 'Permissions', 'Owner' and 'Group'
columns, and sets colspan to use the white space of the
symlink and package names when empty.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/static/css/default.css  |  4 ++++
 .../toaster/toastergui/static/js/jquery.treetable.js   |  2 +-
 bitbake/lib/toaster/toastergui/templates/dirinfo.html  | 18 +++++++++++-------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/css/default.css b/bitbake/lib/toaster/toastergui/static/css/default.css
index cce3e31..06d9976 100644
--- a/bitbake/lib/toaster/toastergui/static/css/default.css
+++ b/bitbake/lib/toaster/toastergui/static/css/default.css
@@ -164,6 +164,10 @@ table { table-layout: fixed; word-wrap: break-word; }
 /* Remove bottom margin for forms inside modal dialogs */
 #dependencies-modal-form { margin-bottom: 0px; }
 
+/* Custom column widths */
+.narrow-col { width: 8%; }
+.medium-col { width: 12%; }
+
 /* Configuration styles */
 .icon-trash { color: #B94A48; font-size: 16px; padding-left: 5px; }
 .icon-trash:hover { color: #943A38; text-decoration: none; cursor: pointer; }
diff --git a/bitbake/lib/toaster/toastergui/static/js/jquery.treetable.js b/bitbake/lib/toaster/toastergui/static/js/jquery.treetable.js
index 42e7427..794b902 100644
--- a/bitbake/lib/toaster/toastergui/static/js/jquery.treetable.js
+++ b/bitbake/lib/toaster/toastergui/static/js/jquery.treetable.js
@@ -421,7 +421,7 @@
         columnElType: "td", // i.e. 'td', 'th' or 'td,th'
         expandable: false,
         expanderTemplate: "<a href='#'>&nbsp;</a>",
-        indent: 19,
+        indent: 10,
         indenterTemplate: "<span class='indenter'></span>",
         initialState: "collapsed",
         nodeIdAttr: "ttId", // maps to data-tt-id
diff --git a/bitbake/lib/toaster/toastergui/templates/dirinfo.html b/bitbake/lib/toaster/toastergui/templates/dirinfo.html
index a5bc481..7819894 100644
--- a/bitbake/lib/toaster/toastergui/templates/dirinfo.html
+++ b/bitbake/lib/toaster/toastergui/templates/dirinfo.html
@@ -103,12 +103,16 @@
             name += '</td>';
         }
         else {
-            name = '<td>';
             if (o.link_to == null) {
-                name += '<i class="icon-file"></i>';
+                namespan = 2;
+                if (o.package == null) {
+                  namespan = 3;
+                }
+                var colspan = 'colspan="' + namespan + '"';
+                name = '<td ' + colspan + '><i class="icon-file"></i>';
             }
             else {
-                name += '<i class="icon-hand-right"></i>';
+                name = '<td><i class="icon-hand-right"></i>';
             }
             name += '&nbsp;' + o.name;
             name += '</td>';
@@ -207,10 +211,10 @@
                     <th>Directory / File</th>
                     <th>Symbolic link to</th>
                     <th>Source package</th>
-                    <th>Size</th>
-                    <th>Permissions</th>
-                    <th>Owner</th>
-                    <th>Group</th>
+                    <th class="narrow-col">Size</th>
+                    <th class="medium-col">Permissions</th>
+                    <th class="narrow-col">Owner</th>
+                    <th class="narrow-col">Group</th>
                 </tr>
             </thead>
             <tbody>
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


