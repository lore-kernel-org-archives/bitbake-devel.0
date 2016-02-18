Return-Path: <ismo.puustinen@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id D4500731FC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Feb 2016 11:34:42 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 18 Feb 2016 03:34:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,464,1449561600"; d="scan'208";a="748615131"
Received: from ipuustin-desk.fi.intel.com ([10.237.72.160])
	by orsmga003.jf.intel.com with ESMTP; 18 Feb 2016 03:34:41 -0800
From: Ismo Puustinen <ismo.puustinen@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Feb 2016 13:34:27 +0200
Message-Id: <1455795267-8780-1-git-send-email-ismo.puustinen@intel.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH] Do not suggest PREFERRED_PROVIDER for runtime providers.
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
X-List-Received-Date: Thu, 18 Feb 2016 11:34:43 -0000

PREFERRED_PROVIDER affects only build-time dependencies. Do not suggest
the user to set it if the multiple providers are for runtime packages.

Signed-off-by: Ismo Puustinen <ismo.puustinen@intel.com>
---
 lib/bb/ui/crumbs/runningbuild.py | 3 ++-
 lib/bb/ui/knotty.py              | 3 ++-
 lib/bb/ui/toasterui.py           | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index 16a955d..0eacd4a 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -386,7 +386,8 @@ class RunningBuild (gobject.GObject):
         elif isinstance(event, bb.event.MultipleProviders):
             self.emit("log", "info", "multiple providers are available for %s%s (%s)" \
                                      % (event._is_runtime and "runtime " or "", event._item, ", ".join(event._candidates)))
-            self.emit("log", "info", "consider defining a PREFERRED_PROVIDER entry to match %s" % (event._item))
+            if not event._is_runtime:
+                self.emit("log", "info", "consider defining a PREFERRED_PROVIDER entry to match %s" % (event._item))
         elif isinstance(event, bb.event.NoProvider):
             msg = ""
             if event._runtime:
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index dff92bc..eb64963 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -452,7 +452,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 logger.info("multiple providers are available for %s%s (%s)", event._is_runtime and "runtime " or "",
                             event._item,
                             ", ".join(event._candidates))
-                logger.info("consider defining a PREFERRED_PROVIDER entry to match %s", event._item)
+                if not event._is_runtime:
+                    logger.info("consider defining a PREFERRED_PROVIDER entry to match %s", event._item)
                 continue
             if isinstance(event, bb.event.NoProvider):
                 if event._runtime:
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 32b1889..f7a2f38 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -257,7 +257,8 @@ def main(server, eventHandler, params):
                 logger.info("multiple providers are available for %s%s (%s)", event._is_runtime and "runtime " or "",
                             event._item,
                             ", ".join(event._candidates))
-                logger.info("consider defining a PREFERRED_PROVIDER entry to match %s", event._item)
+                if not event._is_runtime:
+                    logger.info("consider defining a PREFERRED_PROVIDER entry to match %s", event._item)
                 continue
 
             if isinstance(event, bb.event.NoProvider):
-- 
2.5.0


