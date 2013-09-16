Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 8819C6C878
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 13:33:36 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 16 Sep 2013 06:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,915,1371106800"; d="scan'208";a="402395583"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 16 Sep 2013 06:33:25 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 51F5B5609BA; Mon, 16 Sep 2013 14:33:19 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 16 Sep 2013 14:33:16 +0100
Message-Id: <389466a059c3e6ba345bec88bb710f9dd3311189.1379338189.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379338189.git.alexandru.damian@intel.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 6/7] bitbake: event: adding events to allow bbclasses to push custom info
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
X-List-Received-Date: Mon, 16 Sep 2013 13:33:36 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add a new event that will be triggered by the
package-building class, containing the information
about the currently built package.

Adding an event that will passi information about the
content of each package file that gets built.

Knotty UI will ignore these events by default.

Maybe a mechanism for using a single generic event is in order ?

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/event.py     | 16 ++++++++++++++++
 bitbake/lib/bb/ui/knotty.py |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 67cfcea..7dd9236 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -589,6 +589,22 @@ class PackageInfo(Event):
         Event.__init__(self)
         self._pkginfolist = pkginfolist
 
+class SinglePackageInfo(Event):
+    """
+    Single Package Information sent on emit_pkgdata
+    """
+    def __init__(self, data):
+        Event.__init__(self)
+        self._data = data
+
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
index 0211b50..03baa75 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -477,6 +477,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
             # ignore
             if isinstance(event, (bb.event.BuildBase,
+                                  bb.event.PackageFileSizes,
+                                  bb.event.SinglePackageInfo,
                                   bb.event.StampUpdate,
                                   bb.event.ConfigParsed,
                                   bb.event.RecipeParsed,
-- 
1.8.1.2


