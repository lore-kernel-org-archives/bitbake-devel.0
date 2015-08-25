Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 0BE4673E11
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Aug 2015 08:44:04 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 25 Aug 2015 01:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,744,1432623600"; d="scan'208";a="631733334"
Received: from hbilel-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.12.62])
	by orsmga003.jf.intel.com with ESMTP; 25 Aug 2015 01:44:01 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Aug 2015 09:32:15 +0100
Message-Id: <1440491535-25771-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
X-Mailman-Approved-At: Sat, 29 Aug 2015 12:40:56 +0000
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH] toaster: update directory tree expansion
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
X-List-Received-Date: Tue, 25 Aug 2015 08:44:11 -0000

From: David Reyna <David.Reyna@windriver.com>

The ajax query that fetches the directory data on an expand request
is now returning the response data already in an object form. so the
parseJSON() call is no longer needed (and is currently returning a
parse error).

[YOCTO #7810]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/dirinfo.html | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/dirinfo.html b/bitbake/lib/toaster/toastergui/templates/dirinfo.html
index 11c709a..a5bc481 100644
--- a/bitbake/lib/toaster/toastergui/templates/dirinfo.html
+++ b/bitbake/lib/toaster/toastergui/templates/dirinfo.html
@@ -40,8 +40,7 @@
                         url     : url,
                         data    : "start=" + start,
                         success : function(response) {
-                            var objects = $.parseJSON(response);
-                            addRows(n, objects)
+                            addRows(n, response)
                         },
                         error   : function(jqXHR, textStatus, errorThrown ) {alert(textStatus + ":" + errorThrown)},
                      });
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


