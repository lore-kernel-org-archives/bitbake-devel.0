Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 by mx.groups.io with SMTP id smtpd.web10.5780.1586425707026739706
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Apr 2020 02:48:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.146.13, mailfrom: changqing.li@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 0399mLcw011033
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
	Thu, 9 Apr 2020 02:48:21 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Thu, 9 Apr 2020 02:48:20 -0700
From: "Changqing Li" <changqing.li@windriver.com>
To: <bitbake-devel@lists.openembedded.org>, <naveen.kumar.saini@intel.com>
Subject: [RFC][PATCH] fetch2/git.py: update way to check contains lfs
Date: Thu, 9 Apr 2020 17:48:18 +0800
Message-ID: <1586425698-355751-1-git-send-email-changqing.li@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain

From: Changqing Li <changqing.li@windriver.com>

Fix below do_unpack failure since "_contains_lfs" check
result is wrong:
Fetcher failure: Repository ... has LFS content, install git-lfs on host
to download (or set lfs=0 to ignore it)

Take recipe freeradius as example:
current freeradius is version 3.0.20, and branch is v3.0.x.
and it don't contains lfs. but since we checked HEAD, which is
point to master by default, _contains_lfs will think it contains lfs
since the master contains lfs, and meantime, we don't have
git-lfs on host, so unpack will failed.

Fixed by check on the configured branch.

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 5b3793a..3c5e200 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -563,8 +563,8 @@ class Git(FetchMethod):
         """
         Check if the repository has 'lfs' (large file) content
         """
-        cmd = "%s grep lfs HEAD:.gitattributes | wc -l" % (
-                ud.basecmd)
+        cmd = "%s grep lfs origin/%s:.gitattributes | wc -l" % (
+                ud.basecmd, ud.branches[ud.names[0]])
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
             if int(output) > 0:
-- 
2.7.4

