Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4EDC433FE
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 03:32:45 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web09.5192.1637033565529728957
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Nov 2021 19:32:45 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.88, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="257369167"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="257369167"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:44 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="506232226"
Received: from jli90-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.214.145.204])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:43 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 1/8] bitbake:toaster:test: Update SSTATE URL
Date: Tue, 16 Nov 2021 11:32:30 +0800
Message-Id: 
 <907f048f129420d5475836a6c9962c9745700fc3.1637033341.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637033341.git.anuj.mittal@intel.com>
References: <cover.1637033341.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 03:32:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13049

From: Jon Mason <jdmason@kudzu.us>

Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b3c0dbddd7eb3c87e3989977d7640f09b49a460b)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/toaster/tests/builds/buildtest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/builds/buildtest.py b/lib/toaster/tests/builds/buildtest.py
index 872bbd37..13b51fb0 100644
--- a/lib/toaster/tests/builds/buildtest.py
+++ b/lib/toaster/tests/builds/buildtest.py
@@ -119,7 +119,7 @@ class BuildTest(unittest.TestCase):
         if os.environ.get("TOASTER_TEST_USE_SSTATE_MIRROR"):
             ProjectVariable.objects.get_or_create(
                 name="SSTATE_MIRRORS",
-                value="file://.* http://autobuilder.yoctoproject.org/pub/sstate/PATH;downloadfilename=PATH",
+                value="file://.* http://sstate.yoctoproject.org/PATH;downloadfilename=PATH",
                 project=project)
 
         ProjectTarget.objects.create(project=project,
-- 
2.33.1


