Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 782D76BFC0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:41:09 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 09 Sep 2013 09:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,872,1371106800"; d="scan'208";a="292651245"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 09 Sep 2013 09:41:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 89E18561064; Mon,  9 Sep 2013 17:41:08 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon,  9 Sep 2013 17:41:02 +0100
Message-Id: <19f500f11ded389e89bec0d3963bdb7ebf2dec95.1378743829.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1378743829.git.alexandru.damian@intel.com>
References: <cover.1378743829.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 11/13] bitbake: event: adding an event to pass build file sizes
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
X-List-Received-Date: Mon, 09 Sep 2013 16:41:10 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding an event, ignored by default, that will pass
information about the content of each package file that
gets built.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/event.py     | 8 ++++++++
 bitbake/lib/bb/ui/knotty.py | 1 +
 2 files changed, 9 insertions(+)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 4be0e5b..781b8e7 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -601,6 +601,14 @@ class SinglePackageInfo(Event):
         Event.__init__(self)
         self._data = data
 
+class PackageFileSizes(Event):
+    """
+    Event that contains information about the file sizes contained in a package.
+    """
+    def __init__(self, data):
+        Event.__init__(self)
+        self._data = data
+
 class SanityCheck(Event):
     """
     Event to issue sanity check
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 010530a..1f09a55 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -473,6 +473,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
             # ignore
             if isinstance(event, (bb.event.BuildBase,
+                                  bb.event.PackageFileSizes,
                                   bb.event.SinglePackageInfo,
                                   bb.event.StampUpdate,
                                   bb.event.ConfigParsed,
-- 
1.8.1.2


