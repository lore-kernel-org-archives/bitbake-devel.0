Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web08.4943.1632213324527270188
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Sep 2021 01:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210390172"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="210390172"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:26 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="701611418"
Received: from marsalan-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.172])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:25 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [hardknott][PATCH 2/8] cookerdata: Improve missing core layer error message
Date: Tue, 21 Sep 2021 16:35:10 +0800
Message-Id: <6bf5d9647c82db761c26166440bff031110b0f67.1632212181.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632212181.git.anuj.mittal@intel.com>
References: <cover.1632212181.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the core layer is missing from bblayers.conf, the message the user sees is
hard to understand. Improve it.

[YOCTO #14340]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 5815a7258ebb8a989e0c6f5798853559d9413f02)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cookerdata.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 24002b879..d6206b731 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -399,6 +399,8 @@ class CookerDataBuilder(object):
                 if c in collections_tmp:
                     bb.fatal("Found duplicated BBFILE_COLLECTIONS '%s', check bblayers.conf or layer.conf to fix it." % c)
                 compat = set((data.getVar("LAYERSERIES_COMPAT_%s" % c) or "").split())
+                if compat and not layerseries:
+                    bb.fatal("No core layer found to work with layer '%s'. Missing entry in bblayers.conf?" % c)
                 if compat and not (compat & layerseries):
                     bb.fatal("Layer %s is not compatible with the core layer which only supports these series: %s (layer is compatible with %s)"
                               % (c, " ".join(layerseries), " ".join(compat)))
-- 
2.31.1

