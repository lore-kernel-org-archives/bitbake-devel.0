Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 by mx.groups.io with SMTP id smtpd.web11.11727.1599652539476434891
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2020 04:55:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.1.11, mailfrom: liezhi.yang@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 089BtcxG002798
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Wed, 9 Sep 2020 04:55:39 -0700 (PDT)
Received: from ala-lpggp3.wrs.com (147.11.105.124) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 04:55:37 -0700
From: "Robert Yang" <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v3 1/3] cooker.py: Save prioritized BBFILES to BBFILES_PRIORITIZED
Date: Wed, 9 Sep 2020 04:55:18 -0700
Message-ID: <39bfa5aed67c182e030d1fc275d2b1b1d29e8e54.1599652176.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1599652176.git.liezhi.yang@windriver.com>
References: <cover.1599652176.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain

The original code saved BBFILES back to BBFILES without any changes which isn't
usefule, so remove that line. Now save prioritized BBFILES to
BBFILES_PRIORITIZED which can accelerate the query a lot for the one which
relies on it such as bb.utils.get_file_layer().

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f3ff4274ad..e45755206e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1761,10 +1761,10 @@ class CookerCollectFiles(object):
         collectlog.debug(1, "collecting .bb files")
 
         files = (config.getVar( "BBFILES") or "").split()
-        config.setVar("BBFILES", " ".join(files))
 
         # Sort files by priority
         files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem)[0] )
+        config.setVar("BBFILES_PRIORITIZED", " ".join(files))
 
         if not len(files):
             files = self.get_bbfiles()
-- 
2.17.1

