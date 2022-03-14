Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58549C433FE
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 02:14:08 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web08.21884.1647224044035250454
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Mar 2022 19:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=maX8Wnjl;
 spf=pass (domain: intel.com, ip: 192.55.52.43,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647224048; x=1678760048;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=y28O2xmVVM67J3GtU1qB/vUObvwbmwDcHMQaNEaflEI=;
  b=maX8WnjlFrVX0Kmbc7o9ZYgq+RfFiCIR45OY9HyB5Tf1Jy4cx+MESQae
   6E+BixxHul9Gh34tKLvC1NYux0Tdi/r+C9iGoeO+1HN5ZqR6Jj6BAZl21
   RV+uN+TASk0QXCrwJvhrqj1pz2L59pR1QZGRPhavhMv+Rk0iVvgGg04PG
   e6A6drbnPKiR/MCwJIybBHy9jZfUdZg+t1wHKf4pgohIeKpVd0P0tEc7S
   7W5MF8gLMfrfuwOvG1OJ1vpcPpmWETKY0msabcJrCAlCt40UOSIZUneaK
   ZYYw+EIaL0UFCvlMSEX4ECu5RgeMSKhSqrLwxb4HRMQF0POQeiuNremtN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342344746"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="342344746"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="818562599"
Received: from lsim7-mobl1.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.229.232])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:06 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 3/5] cooker: Improve parsing failure from handled
 exception usability
Date: Mon, 14 Mar 2022 10:13:55 +0800
Message-Id: 
 <61d3f81169adf2d590b42cb87ebfdfc1df04e764.1647223687.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647223687.git.anuj.mittal@intel.com>
References: <cover.1647223687.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Mar 2022 02:14:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13479

From: Richard Purdie <richard.purdie@linuxfoundation.org>

When a recipe raises a BBHandledException, it means the error was already
shown to the user. Adding an additional one here isn't helpful. What is
helpful is to mention that parsing was halted.

Tweak the code to do this with improves the messages the user sees
and helps understand what happened.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit fdf6ebc8b603fcfd3ed7c64baf486a4adabd25be)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cooker.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 3688aa08..288d73fd 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2167,6 +2167,8 @@ class CookerParser(object):
                                             self.total)
 
             bb.event.fire(event, self.cfgdata)
+        else:
+            bb.error("Parsing halted due to errors")
 
         for process in self.processes:
             self.parser_quit.put(None)
@@ -2257,7 +2259,7 @@ class CookerParser(object):
             return False
         except bb.BBHandledException as exc:
             self.error += 1
-            logger.error('Failed to parse recipe: %s' % exc.recipe)
+            logger.debug('Failed to parse recipe: %s' % exc.recipe)
             self.shutdown(clean=False, force=True)
             return False
         except ParsingFailure as exc:
-- 
2.35.1


