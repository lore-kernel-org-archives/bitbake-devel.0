Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web11.4658.1596101055425068632
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2020 02:24:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: liezhi.yang@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 06U9NrMd003675
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2020 02:24:03 -0700
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 02:23:42 -0700
From: "Robert Yang" <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/3] cooker.py: Save prioritized BBFILES
Date: Thu, 30 Jul 2020 02:23:40 -0700
Message-ID: <20200730092342.7420-1-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The original code saved BBFILES back to BBFILES without changes, I think that
it was for avoiding undefined BBFILES. Now save prioritized BBFILES back which
is more usable for the one which requires it such as bb.utils.get_file_layer().

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 3a58a3a33..5571e5312 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1738,10 +1738,10 @@ class CookerCollectFiles(object):
         collectlog.debug(1, "collecting .bb files")
 
         files = (config.getVar( "BBFILES") or "").split()
-        config.setVar("BBFILES", " ".join(files))
 
         # Sort files by priority
         files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem)[0] )
+        config.setVar("BBFILES", " ".join(files))
 
         if not len(files):
             files = self.get_bbfiles()
-- 
2.26.2

