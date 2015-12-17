Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 6D9346FFE2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 16:49:07 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 17 Dec 2015 08:49:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,441,1444719600"; d="scan'208";a="15002711"
Received: from agusev-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.27.121])
	by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2015 08:49:07 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Dec 2015 16:48:51 +0000
Message-Id: <beedb977101917644948ac1b4775a0ec4eafc53f.1450370782.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
References: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
In-Reply-To: <cover.1450370782.git.elliot.smith@intel.com>
References: <cover.1450370782.git.elliot.smith@intel.com>
Subject: [PATCH 06/11] toaster: updated header of the toaster script
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
X-List-Received-Date: Thu, 17 Dec 2015 16:49:07 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Updated GPL information, years of development and
usage information. Removed outdated information about
2 ways of starting Toaster.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 087e3f9..40c3c35 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -1,5 +1,8 @@
 #!/bin/echo ERROR: This script needs to be sourced. Please run as .
-# (c) 2013 Intel Corp.
+
+# toaster - shell script to start Toaster
+
+# Copyright (C) 2013-2015 Intel Corp.
 
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -12,19 +15,10 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-
-
-# This script can be run in two modes.
-
-# When used with "source", from a build directory,
-# it enables toaster event logging and starts the bitbake resident server.
-# use as:  source toaster [start|stop] [noweb] [noui]
+# along with this program. If not, see http://www.gnu.org/licenses/.
 
-# When it is called as a stand-alone script, it starts just the
-# web server, and the building shall be done through the web interface.
-# As script, it will not return to the command prompt. Stop with Ctrl-C.
+# Usage: source toaster [start|stop|restart-bitbake] [webport=<port>]
+#                       [noui] [noweb] [nobrowser] [brbe=<BRBE>]
 
 # Helper function to kill a background toaster development server
 
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


