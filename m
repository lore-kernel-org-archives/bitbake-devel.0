Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B57CC433F5
	for <webhook@archiver.kernel.org>; Wed, 29 Sep 2021 14:57:29 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by mx.groups.io with SMTP id smtpd.web12.10124.1632927446831175783
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Sep 2021 07:57:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.93, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="221752904"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200";
   d="scan'208";a="221752904"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 07:57:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200";
   d="scan'208";a="437663379"
Received: from zkeh-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.213.143.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 07:57:26 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 3/3] build: Handle SystemExit in python tasks correctly
Date: Wed, 29 Sep 2021 22:57:13 +0800
Message-Id: 
 <c3158b8800362376722096ea47c2d0be1e604306.1632902709.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632902709.git.anuj.mittal@intel.com>
References: <cover.1632902709.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Sep 2021 14:57:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12716

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If a python task fails with sys.exit(), we currently see no TaskFailed event.
The high level code does detect the exit code and fail the task but it can
leave the UI inconsistent with log output.

Fix this be intercepting SystemExit explicitly. This makes python
task failures consistent with shell task failures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9eee9fd4f2f96789ad2b037e74d561bdc1426856)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 39e7dba02..ad031cc70 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -694,7 +694,7 @@ def _exec_task(fn, task, d, quieterr):
         except bb.BBHandledException:
             event.fire(TaskFailed(task, fn, logfn, localdata, True), localdata)
             return 1
-        except Exception as exc:
+        except (Exception, SystemExit) as exc:
             if quieterr:
                 event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
             else:
-- 
2.31.1


