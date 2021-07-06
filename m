Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by mx.groups.io with SMTP id smtpd.web12.3496.1625560228958076642
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jul 2021 01:30:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.24, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="209032003"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="209032003"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 01:30:28 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="559876406"
Received: from sho7-mobl2.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.255.151.151])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 01:30:27 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 1/2] fetch/svn: Fix parsing revision of SVN repos with redirects
Date: Tue,  6 Jul 2021 16:30:20 +0800
Message-Id: <5707818e42ae8bb06f28c27bd1e1f8fbcdfd507b.1625560113.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625560113.git.anuj.mittal@intel.com>
References: <cover.1625560113.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harald Brinkmann <harald.brinkmann@detectomat.com>

svn was printing a message when encountering HTTP redirects.
This confused the revision parser.

Signed-off-by: Harald Brinkmann <Harald.Brinkmann@detectomat.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a944a335f8f4c4fe5df55f3d7d8e757bd2835146)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/svn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 8856ef1c6..80102b44f 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -86,7 +86,7 @@ class Svn(FetchMethod):
         if command == "info":
             svncmd = "%s info %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
         elif command == "log1":
-            svncmd = "%s log --limit 1 %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
+            svncmd = "%s log --limit 1 --quiet %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
         else:
             suffix = ""
 
-- 
2.31.1

