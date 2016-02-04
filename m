Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 11650602D9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Feb 2016 11:36:04 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 04 Feb 2016 03:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,395,1449561600"; 
	d="scan'208,217";a="908359608"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2016 03:36:05 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 1426A6A4002;
	Thu,  4 Feb 2016 04:23:56 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  4 Feb 2016 11:26:20 +0200
Message-Id: <1454577980-21630-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] toaster: reinstate ID on edit columns button
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
X-List-Received-Date: Thu, 04 Feb 2016 11:36:05 -0000

From: Elliot Smith <elliot.smith@intel.com>

The ID was omitted from the "edit columns" button on the
"projects", "all builds" and "project builds" tables when they
were converted to ToasterTable. This caused the QA tests to fail.

Reinstate the ID so the tests can identify the "edit columns" button
correctly.

[YOCTO #9051]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/templates/toastertable.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/toastertable.html b/bitbake/lib/toaster/toastergui/templates/toastertable.html
index f0a3aed..9099b30 100644
--- a/bitbake/lib/toaster/toastergui/templates/toastertable.html
+++ b/bitbake/lib/toaster/toastergui/templates/toastertable.html
@@ -57,7 +57,7 @@
 
       <div class="pull-right">
         <div class="btn-group">
-          <button class="btn dropdown-toggle" data-toggle="dropdown">Edit columns
+          <button id="edit-columns-button" class="btn dropdown-toggle" data-toggle="dropdown">Edit columns
             <span class="caret"></span>
           </button>
           <ul class="dropdown-menu editcol">
-- 
2.1.4


