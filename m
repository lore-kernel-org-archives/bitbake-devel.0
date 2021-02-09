Received: from mga12.intel.com (mga12.intel.com [])
 by mx.groups.io with SMTP id smtpd.web09.12314.1612886220938659827
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Feb 2021 07:57:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: intel.com, ip: <nil>, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: HkrypXwcAP17TgQvrI3Xf5OelAJ/GQ7stLsDjDbVQlWuPOZmOVPofpqj4rATjROJ8HuBMCEA5d
 7N3E3RXbi0UQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161054055"
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="161054055"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 07:57:01 -0800
IronPort-SDR: ascTNC2gADRBTKyh6lNKL4K4AY8vn0vVUl8puXE1ZEW1UF3FMLypG2cpjEKkffJyIC0QjpwDF3
 ZqBvDwQJinEA==
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="419866454"
Received: from ytee-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.255.146.52])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 07:57:00 -0800
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.48][PATCH 1/1] lib/bb/fetch2/__init__.py: drop _PYTHON_SYSCONFIGDATA_NAME unsetting
Date: Tue,  9 Feb 2021 23:56:54 +0800
Message-Id: <26656167f80cd49790c292ad439ecde7376aa268.1612886078.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612886078.git.anuj.mittal@intel.com>
References: <cover.1612886078.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Kanavin <alex.kanavin@gmail.com>

With introduction of python3targetconfig class in core this is no longer
needed.

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 47b64cfacd7c498ef9ed5486d117f2d69a39f225)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/__init__.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 551bfb70f..524165bd5 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -853,11 +853,6 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
         if val:
             cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
 
-    # Ensure that a _PYTHON_SYSCONFIGDATA_NAME value set by a recipe
-    # (for example via python3native.bbclass since warrior) is not set for
-    # host Python (otherwise tools like git-make-shallow will fail)
-    cmd = 'unset _PYTHON_SYSCONFIGDATA_NAME; ' + cmd
-
     # Disable pseudo as it may affect ssh, potentially causing it to hang.
     cmd = 'export PSEUDO_DISABLED=1; ' + cmd
 
-- 
2.29.2

