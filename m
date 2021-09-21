Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web08.4943.1632213324527270188
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Sep 2021 01:35:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210390167"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="210390167"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="701611415"
Received: from marsalan-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.172])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:23 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [hardknott][PATCH 1/8] cookerdata: Show error for no BBLAYERS in bblayers.conf
Date: Tue, 21 Sep 2021 16:35:09 +0800
Message-Id: <94646cd9f9423e8f6ac13634afafdb4bd40baddf.1632212181.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632212181.git.anuj.mittal@intel.com>
References: <cover.1632212181.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If there is no BBLAYERS set in bblayers.conf show a more helpful
error and exit.

[YOCTO #14340]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 97183e10faf9862b5d9489d6e2c27ac77c3b697d)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cookerdata.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 1c1e008c6..24002b879 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -342,6 +342,9 @@ class CookerDataBuilder(object):
             layers = (data.getVar('BBLAYERS') or "").split()
             broken_layers = []
 
+            if not layers:
+                bb.fatal("The bblayers.conf file doesn't contain any BBLAYERS definition")
+
             data = bb.data.createCopy(data)
             approved = bb.utils.approved_variables()
 
-- 
2.31.1

