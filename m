Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB708C433EF
	for <webhook@archiver.kernel.org>; Mon, 25 Oct 2021 14:16:12 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web12.32719.1635171372458297011
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 07:16:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="209759071"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="209759071"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:10 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="634754779"
Received: from syong7-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.249.78.45])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:09 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 6/9] bitbake-worker: Handle pseudo shutdown in Ctrl+C
 case
Date: Mon, 25 Oct 2021 22:15:53 +0800
Message-Id: 
 <4824dc0c5727a497a6785ca746a02c6cf0ed3b79.1635171215.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635171215.git.anuj.mittal@intel.com>
References: <cover.1635171215.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Oct 2021 14:16:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12823

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the build is interrupted, handle the shutdown of pseudo even in this
case to avoid data corruption inside docker containers.

[YOCTO #14555]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a2a04c6fe94bc56efcff299c669a151746e35916)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 bin/bitbake-worker | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index b3877b15c..4318ce611 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -286,10 +286,12 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
             try:
                 if dry_run:
                     return 0
-                ret = bb.build.exec_task(fn, taskname, the_data, cfg.profile)
-                if fakeroot:
-                    fakerootcmd = shlex.split(the_data.getVar("FAKEROOTCMD"))
-                    subprocess.run(fakerootcmd + ['-S'], check=True, stdout=subprocess.PIPE)
+                try:
+                    ret = bb.build.exec_task(fn, taskname, the_data, cfg.profile)
+                finally:
+                    if fakeroot:
+                        fakerootcmd = shlex.split(the_data.getVar("FAKEROOTCMD"))
+                        subprocess.run(fakerootcmd + ['-S'], check=True, stdout=subprocess.PIPE)
                 return ret
             except:
                 os._exit(1)
-- 
2.31.1


