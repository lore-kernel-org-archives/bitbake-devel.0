Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B502AC433EF
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 16:27:12 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web11.297.1637080031078195453
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Nov 2021 08:27:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220613336"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800";
   d="scan'208";a="220613336"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 08:27:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800";
   d="scan'208";a="506500479"
Received: from mmohdso1-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.237.91])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 08:27:08 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 2/4] cooker: Remove debug code, oops :(
Date: Wed, 17 Nov 2021 00:26:58 +0800
Message-Id: 
 <ae1bfbf9523e8f6155bb43ee3adba17af3ec9630.1637079892.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637079892.git.anuj.mittal@intel.com>
References: <cover.1637079892.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 16:27:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13059

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 19291665fa8b6cc331290f2542af3e8e653203f1)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cooker.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 8ae8e4ec..9be6603f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2040,7 +2040,6 @@ class Parser(multiprocessing.Process):
                 result = pending.pop()
             else:
                 try:
-                    time.sleep(0.25)
                     job = self.jobs.pop()
                 except IndexError:
                     self.results.close()
-- 
2.33.1


