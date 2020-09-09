Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 by mx.groups.io with SMTP id smtpd.web10.11785.1599652540603482000
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2020 04:55:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.146.13, mailfrom: liezhi.yang@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 089Btdgg029350
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Wed, 9 Sep 2020 04:55:40 -0700 (PDT)
Received: from ala-lpggp3.wrs.com (147.11.105.124) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 04:55:39 -0700
From: "Robert Yang" <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v3 2/3] utils.py: get_file_layer(): Exit the loop when file is matched
Date: Wed, 9 Sep 2020 04:55:19 -0700
Message-ID: <63718406751e3727dceae45aafd19dac448a836f.1599652176.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1599652176.git.liezhi.yang@windriver.com>
References: <cover.1599652176.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain

This can make "$ bitbake-layers show-recipes" save about 60% time (14min ->
6min) in my build (more than 3000 recipes)

The command "bitbake-layers show-recipes" calls bb.utils.get_file_layer() with
each recipe, and get_file_layer() compare the file with each item in BBFILES
which makes it very time consuming when there are a lot of recipes and items in
BBFILES. So use BBFILES_PRIORITIZED and exit when file is matched, it doesn't
make sense to go on the loop when file is matched.

And use fnmatchcase to replace of fnmatch since the comparison should be
case-sensitive.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/utils.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index e51b8ca508..5722fced97 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1477,12 +1477,13 @@ def get_file_layer(filename, d):
         return match
 
     result = None
-    bbfiles = (d.getVar('BBFILES') or '').split()
+    bbfiles = (d.getVar('BBFILES_PRIORITIZED') or '').split()
     bbfilesmatch = False
     for bbfilesentry in bbfiles:
-        if fnmatch.fnmatch(filename, bbfilesentry):
+        if fnmatch.fnmatchcase(filename, bbfilesentry):
             bbfilesmatch = True
             result = path_to_layer(bbfilesentry)
+            break
 
     if not bbfilesmatch:
         # Probably a bbclass
-- 
2.17.1

