Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 469DB77D82
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 10:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491821454; x=1523357454; h=from:to:subject:date:message-id;
	bh=P6kOtlv6/kuRUplN82P3yCDtEAYVKgSjThEtTm9BOSE=;
	b=ACjh+OlqODcrA1n6osPSsv22AVHVOlL9QMT79ZyMKI9nz8avpcj2S563
	ejntvwXEwyllOIO0HUarpFQOj86YYw==;
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Apr 2017 03:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,182,1488873600"; d="scan'208";a="87212929"
Received: from ggalliga-mobl1.ger.corp.intel.com (HELO
	mqz-osx-suse64.fi.intel.com) ([10.252.16.55])
	by fmsmga006.fm.intel.com with ESMTP; 10 Apr 2017 03:50:51 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Apr 2017 13:50:41 +0300
Message-Id: <20170410105041.28282-1-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.12.0
Subject: [PATCH] bb.cache: prevent division-by-zero in load_cahefile()
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
X-List-Received-Date: Mon, 10 Apr 2017 10:50:52 -0000

[YOCTO 11315]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/cache.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 28e8a874..e7eeb4f5 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -462,6 +462,10 @@ class Cache(NoCache):
                         self.depends_cache[key] = [value]
                     # only fire events on even percentage boundaries
                     current_progress = cachefile.tell() + previous_progress
+                    if current_progress > cachesize:
+                        # we might have calculated incorrect total size because a file
+                        # might've been written out just after we checked its size
+                        cachesize = current_progress
                     current_percent = 100 * current_progress / cachesize
                     if current_percent > previous_percent:
                         previous_percent = current_percent
-- 
2.12.0


