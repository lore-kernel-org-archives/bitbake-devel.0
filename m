Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 46E286BDAF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 12:15:56 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 18 Sep 2013 05:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,929,1371106800"; d="scan'208";a="296360751"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 18 Sep 2013 05:15:56 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id A8209560902; Wed, 18 Sep 2013 13:15:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Wed, 18 Sep 2013 13:15:52 +0100
Message-Id: <02ce17946b69d5d0875828368df1a4a31b16568a.1379505533.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
	<89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 6/7] bitbake: event: adding generic event for metadata usage
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
X-List-Received-Date: Wed, 18 Sep 2013 12:15:57 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding the generic bb.event.MetadataEvent that is
targeted specifically at metadata usage. This is
needed in order to let the metadata code send and receive
events during asynchrous execution without having
to define each event specifically in Bitbake.

Metadata code should subscribe to and fire the MetadataEvent
in order to communicate asynchronously, and identify
the object using event.type field, and parse the
data in the event.data field.

Knotty UI will ignore these event by default.

This deprecates RequestPackageInfo/PackageInfo, and that
event pair will be removed in the future.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/event.py     | 10 ++++++++++
 bitbake/lib/bb/ui/knotty.py |  1 +
 2 files changed, 11 insertions(+)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 67cfcea..10eae5f 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -589,6 +589,16 @@ class PackageInfo(Event):
         Event.__init__(self)
         self._pkginfolist = pkginfolist
 
+class MetadataEvent(Event):
+    """
+    Generic event that target for OE-Core classes
+    to report information during asynchrous execution
+    """
+    def __init__(self, eventtype, eventdata):
+        Event.__init__(self)
+        self.type = eventtype
+        self.data = eventdata
+
 class SanityCheck(Event):
     """
     Event to issue sanity check
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 0211b50..c1ee9f52 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -477,6 +477,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
             # ignore
             if isinstance(event, (bb.event.BuildBase,
+                                  bb.event.MetadataEvent,
                                   bb.event.StampUpdate,
                                   bb.event.ConfigParsed,
                                   bb.event.RecipeParsed,
-- 
1.8.1.2


