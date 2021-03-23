Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web12.6103.1616489451996517380
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Mar 2021 01:50:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: amikan@ilbers.de)
Received: from localhost.localdomain (mm-65-41-120-178.brest.dynamic.pppoe.byfly.by [178.120.41.65])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8) with ESMTPSA id 12N8omGB025621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 09:50:49 +0100
From: "Anton Mikanovich" <amikan@ilbers.de>
To: bitbake-devel@lists.openembedded.org
Cc: Anton Mikanovich <amikan@ilbers.de>
Subject: [PATCH] fetch2/__init__.py: Use relative symlink for mirrors
Date: Tue, 23 Mar 2021 11:50:39 +0300
Message-Id: <20210323085039.168551-1-amikan@ilbers.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on shymkent.ilbers.de
Content-Transfer-Encoding: 8bit

When running bitbake in chroot with external DL_DIR mounted to other
location symlink for repo obtained from MIRRORS point to wrong location.
There is no need in absolute path here, because destination will always
be in the same directory. So it is better to use relative symlink.

Signed-off-by: Anton Mikanovich <amikan@ilbers.de>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index cf0201c4..ac7a6748 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1066,7 +1066,7 @@ def ensure_symlink(target, link_name):
         # same time, in which case we do not want the second task to
         # fail when the link has already been created by the first task.
         try:
-            os.symlink(target, link_name)
+            os.symlink(os.path.basename(target), link_name)
         except FileExistsError:
             pass
 
-- 
2.25.1

