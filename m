Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 443626D99E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Dec 2013 13:52:06 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 04 Dec 2013 05:52:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,824,1378882800"; d="scan'208";a="446739258"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by orsmga002.jf.intel.com with ESMTP; 04 Dec 2013 05:52:04 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Dec 2013 15:58:06 +0200
Message-Id: <1386165486-25470-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] toaster: exclude "set in documentation.conf" from variable history
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
X-List-Received-Date: Wed, 04 Dec 2013 13:52:06 -0000

That has no impact on the builds themselves, so we should just
remove that line from the variable history.

[YOCTO #5561]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 61149fa..c99a511 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -245,10 +245,11 @@ class ORMWrapper(object):
                     variable_value = value,
                     description = desc)
                 for vh in vardump[k]['history']:
-                    VariableHistory.objects.create( variable = variable_obj,
-                            file_name = vh['file'],
-                            line_number = vh['line'],
-                            operation = vh['op'])
+                    if not 'documentation.conf' in vh['file']:
+                        VariableHistory.objects.create( variable = variable_obj,
+                                file_name = vh['file'],
+                                line_number = vh['line'],
+                                operation = vh['op'])
 
 class BuildInfoHelper(object):
     """ This class gathers the build information from the server and sends it
-- 
1.7.9.5


