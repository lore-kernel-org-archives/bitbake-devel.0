Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB7EC433F5
	for <webhook@archiver.kernel.org>; Fri, 29 Apr 2022 11:19:47 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by mx.groups.io with SMTP id smtpd.web09.8783.1651231177220696368
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Apr 2022 04:19:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=KNnA/wwY;
 spf=pass (domain: intel.com, ip: 134.134.136.65,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651231177; x=1682767177;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=vKUF3079qzUsy+yuxOc2VMpdXFVUf5C+ubDiYMT62Zo=;
  b=KNnA/wwYIMIvsufdt+NyFn618P4oTkzfh0R4izzyOW0oNhiB9oW+MASw
   hliQd4d/QAhv6FO0flbnaE7zjoN3DsDROerbOM54m/Rj6XxZ97cD9qwmX
   01TPUfnF2WtzQwXb/v5Ci3MiOLpZgl6hjwhAKz/Hsyml0KlwT/eRZEefw
   DiZoHaG7Mfnq/KTiqRGl7VPkxL01qn4fMPCmPFJA/XSvRnYlCCdST7QxE
   bPxvNRkAr3AI+mt72rTMzCztuhsAkK4l+EI3rDtWWjswj/dr0rotDcbE9
   V5pkLUI6us151pCMj2BWnbSlT4Ca4rH3nHr7ThxzIqgdDpIuzyxhf+n4+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266430836"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600";
   d="scan'208";a="266430836"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 04:15:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600";
   d="scan'208";a="597282356"
Received: from fsuhimi-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.146.39])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 04:15:44 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 1/2] bitbake: knotty: display active tasks when printing
 keepAlive() message
Date: Fri, 29 Apr 2022 19:15:37 +0800
Message-Id: 
 <6717c132c88d903bed60573c54b354811a213cea.1651230735.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651230735.git.anuj.mittal@intel.com>
References: <cover.1651230735.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Apr 2022 11:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13665

From: Ross Burton <ross@burtonini.com>

In interactive bitbake sessions it is obvious what tasks are running
when one of them hangs or otherwise takes a long time. However, in
non-interactive sessions (such as automated builds) bitbake just prints
a message saying that it is "still alive" with no clues as to what tasks
are active still.

By simply listing the active tasks when printing the keep alive message,
we don't need to parse the bitbake log to identify which of the tasks
is still active and has presumably hung.

(Bitbake rev: f9f57fb7d2c8a13df1eb9d5b9766f15e229dcf97)

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 30f6c3f175617beea8e8bb75dcf255611e3fc2fd)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/ui/knotty.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 484545a6..64e33d81 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -228,7 +228,9 @@ class TerminalFilter(object):
 
     def keepAlive(self, t):
         if not self.cuu:
-            print("Bitbake still alive (%ds)" % t)
+            print("Bitbake still alive (no events for %ds). Active tasks:" % t)
+            for t in self.helper.running_tasks:
+                print(t)
             sys.stdout.flush()
 
     def updateFooter(self):
-- 
2.35.1


