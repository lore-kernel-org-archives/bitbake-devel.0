Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web11.4662.1596101065718990230
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2020 02:24:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: liezhi.yang@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 06U9NrMh003675
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2020 02:24:15 -0700
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 02:24:04 -0700
From: "Robert Yang" <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/3] utils.py: get_file_layer(): Exit the loop when file is matched
Date: Thu, 30 Jul 2020 02:23:41 -0700
Message-ID: <20200730092342.7420-2-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730092342.7420-1-liezhi.yang@windriver.com>
References: <20200730092342.7420-1-liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This can make "$ bitbake-layers show-recipes" save about 60% time (14min ->
6min) in my build (more than 3000 recipes)

The command "bitbake-layers show-recipes" calls bb.utils.get_file_layer() with
each recipe, and get_file_layer() compare the file with each item in BBFILES
which makes it very time consuming when there are a lot of recipes and items in
BBFILES. So exit when file is matched, it doesn't make sense to go on the loop
when file is matched.

And use fnmatchcase to replace of fnmatch since the comparison should be
case-sensitive.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 lib/bb/utils.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 50032e50c..03568474d 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1494,9 +1494,10 @@ def get_file_layer(filename, d):
     bbfiles = (d.getVar('BBFILES') or '').split()
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
2.26.2

