Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web11.4953.1632213334869589697
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Sep 2021 01:35:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210390196"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="210390196"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:33 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="701611436"
Received: from marsalan-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.172])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:32 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [hardknott][PATCH 7/8] cookerdata: Show a readable error for invalid multiconfig name
Date: Tue, 21 Sep 2021 16:35:15 +0800
Message-Id: <636bf8aa0c5a61bfafd25fba7335092a9925e2f9.1632212181.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632212181.git.anuj.mittal@intel.com>
References: <cover.1632212181.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If a multiconfig starts with a digit, users would see pages of
errors as we use the multiconfig as a python function name prefix
and python functions cannot start with a digit. We could avoid doing
that but it is easier just to ask users to name multiconfigs not
starting with digits.

This tweak ensures the user sees an easier to understand error.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f9cddaeef35b2ea0dadf717101ed896f6b857abd)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cookerdata.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index d6206b731..ba657c03b 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -291,6 +291,8 @@ class CookerDataBuilder(object):
 
             multiconfig = (self.data.getVar("BBMULTICONFIG") or "").split()
             for config in multiconfig:
+                if config[0].isdigit():
+                    bb.fatal("Multiconfig name '%s' is invalid as multiconfigs cannot start with a digit" % config)
                 mcdata = self.parseConfigurationFiles(self.prefiles, self.postfiles, config)
                 bb.event.fire(bb.event.ConfigParsed(), mcdata)
                 self.mcdata[config] = mcdata
-- 
2.31.1

