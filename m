Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id E16C66FFD8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jan 2016 15:42:54 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 18 Jan 2016 07:42:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,312,1449561600"; d="scan'208";a="893055596"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 18 Jan 2016 07:42:54 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id EC6742C8001
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jan 2016 08:30:49 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jan 2016 15:45:09 +0200
Message-Id: <9abd5fe436a154ba39b4810ed85cd809b2912d49.1453124453.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1453124453.git.ed.bartosh@linux.intel.com>
References: <cover.1453124453.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1453124453.git.ed.bartosh@linux.intel.com>
References: <cover.1453124453.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 2/3] toaster: toasterui: log OSErrorException metadata events
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
X-List-Received-Date: Mon, 18 Jan 2016 15:42:55 -0000

From: Elliot Smith <elliot.smith@intel.com>

OSErrors occurring in toaster.bbclass are converted to
OSErrorException metadata events. They were then being swallowed
as unprocessed events by toasterui, which made them difficult
to spot.

Explicitly catch OSErrorException events and log them so they
are easier to spot and debug.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/bb/ui/toasterui.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 19be623..32b1889 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -366,6 +366,8 @@ def main(server, eventHandler, params):
                     buildinfohelper.store_license_manifest_path(event)
                 elif event.type == "SetBRBE":
                     buildinfohelper.brbe = buildinfohelper._get_data_from_event(event)
+                elif event.type == "OSErrorException":
+                    logger.error(event)
                 else:
                     logger.error("Unprocessed MetadataEvent %s ", str(event))
                 continue
-- 
2.1.4


