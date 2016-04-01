Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 3309E75D4B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 11:56:01 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 01 Apr 2016 04:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,427,1455004800"; 
	d="scan'208,217";a="776140015"
Received: from cmjones2-mobl3.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.22.222])
	by orsmga003.jf.intel.com with ESMTP; 01 Apr 2016 04:55:43 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Apr 2016 12:55:40 +0100
Message-Id: <1459511740-1996-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH] toaster: Correct typo on build form help text
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
X-List-Received-Date: Fri, 01 Apr 2016 11:56:02 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

The help text said to append a semicolon and a task name to a target to
run a task other than do_build. What you need to append is a colon.

[YOCTO #9326]

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/projecttopbar.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/projecttopbar.html b/bitbake/lib/toaster/toastergui/templates/projecttopbar.html
index 268a99e..007de06 100644
--- a/bitbake/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/bitbake/lib/toaster/toastergui/templates/projecttopbar.html
@@ -66,7 +66,7 @@
       </li>
       <li class="pull-right">
         <form class="form-inline" style="margin-bottom:0px;">
-          <i class="icon-question-sign get-help heading-help" data-placement="left" title="" data-original-title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to the recipe name, like so: <code>busybox:clean</code>"></i>
+          <i class="icon-question-sign get-help heading-help" data-placement="left" title="" data-original-title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a colon and a task name to the recipe name, like so: <code>busybox:clean</code>"></i>
           <div class="input-append">
             <input id="build-input" type="text" class="input-xlarge input-lg build-target-input" placeholder="Type the recipe you want to build" autocomplete="off" disabled>
             <button id="build-button" class="btn btn-primary btn-large build-button" data-project-id="{{project.id}}" disabled>Build</button>
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


