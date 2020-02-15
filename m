Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id 3156C60221
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Feb 2020 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=axis.com; l=2439; q=dns/txt; s=axis-central1;
	t=1581737401; x=1613273401;
	h=from:to:subject:date:message-id:in-reply-to:references:
	mime-version:content-transfer-encoding;
	bh=tV/FXSxcCPj2V/SEh9GbdpPtFPRXyJ/wAE+5V0l7Nuc=;
	b=X9Gyxe0Ty0B0cKwyPwR/x97EaVznC4Dwq46epyZec9FBOUQ3TX+FHP0f
	y2PZUowBqdsEBpH+sVEg/2CP4fpG9ahVIewzvH7UebLDqNG10Odbib8q0
	UWazHuDihRpqKbp/Qg8mArlWVaUTLZXlXMVlzivPdz5AgpSbVZl2ElNIS
	6HVIEHMvrUHCUutpPXG4dQswzQzyhjPfySFCJsB59DQ5vSwbayWGu0kJ5
	W9m0UsLglcXE79+yxRait22RX0phn5wx0mNsmVm4qeb9mP0QKBmEeBBZS
	L5FZstivcUBR/2+OSOj8SPL8jP5FqjCUx6+uO3AocBjQYnKzUWmqwnSKo Q==;
IronPort-SDR: uOSfZrTT5gDWC6YSR+kGpiEutWo/zefZ6YxiQvufgxCB+8IY3FfA5tl5ELmKwJQLl+wUp3Xq+u
	PMzYlGF2xlgkQwM22eIQhepJCDWmf3xAUSwU3cfqgcYIfk6l7R6JyJYHUfUC3MXm9dR1eBdkTh
	Uwz8paTlSs4v0LTczVic7d5qRUxA2vmSRgevs1DyPP5WtEwOei/VbQhr2TyrUbig/qCCp4stxT
	ExXsO31rBNmodQQcdu4P7RHii0cCjkFqAQUFP8WaG+/xZYluTsphTORH07+g2kGIKTTWvYJGND
	gXA=
X-IronPort-AV: E=Sophos;i="5.70,443,1574118000"; 
   d="scan'208";a="5300874"
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 15 Feb 2020 04:29:54 +0100
Message-ID: <20200215032955.3958-2-pkj@axis.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215032955.3958-1-pkj@axis.com>
References: <20200215032955.3958-1-pkj@axis.com>
MIME-Version: 1.0
Subject: [master][zeus][PATCH 2/3] fetch2: Make fetcher_compare_revisions() work
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
X-List-Received-Date: Sat, 15 Feb 2020 03:29:59 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This seems to have been broken for a very long time. Now it also works
regardless of BB_SRCREV_POLICY.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 33 +++++++++++++------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 1b7f573642..56462767e5 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -485,17 +485,22 @@ def fetcher_init(d):
     Called to initialize the fetchers once the configuration data is known.
     Calls before this must not hit the cache.
     """
+
+    revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
+    try:
+        # fetcher_init is called multiple times, so make sure we only save the
+        # revs the first time it is called.
+        if not bb.fetch2.saved_headrevs:
+            bb.fetch2.saved_headrevs = dict(revs)
+    except:
+        pass
+
     # When to drop SCM head revisions controlled by user policy
     srcrev_policy = d.getVar('BB_SRCREV_POLICY') or "clear"
     if srcrev_policy == "cache":
         logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
     elif srcrev_policy == "clear":
         logger.debug(1, "Clearing SRCREV cache due to cache policy of: %s", srcrev_policy)
-        revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
-        try:
-            bb.fetch2.saved_headrevs = revs.items()
-        except:
-            pass
         revs.clear()
     else:
         raise FetchError("Invalid SRCREV cache policy of: %s" % srcrev_policy)
@@ -514,22 +519,12 @@ def fetcher_parse_done():
 
 def fetcher_compare_revisions(d):
     """
-    Compare the revisions in the persistant cache with current values and
-    return true/false on whether they've changed.
+    Compare the revisions in the persistent cache with the saved values from
+    when bitbake was started and return true if they have changed.
     """
 
-    data = bb.persist_data.persist('BB_URI_HEADREVS', d).items()
-    data2 = bb.fetch2.saved_headrevs
-
-    changed = False
-    for key in data:
-        if key not in data2 or data2[key] != data[key]:
-            logger.debug(1, "%s changed", key)
-            changed = True
-            return True
-        else:
-            logger.debug(2, "%s did not change", key)
-    return False
+    headrevs = dict(bb.persist_data.persist('BB_URI_HEADREVS', d))
+    return headrevs != bb.fetch2.saved_headrevs
 
 def mirror_from_string(data):
     mirrors = (data or "").replace('\\n',' ').split()
-- 
2.21.1


