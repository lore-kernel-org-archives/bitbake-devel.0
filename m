Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B491DC433F5
	for <webhook@archiver.kernel.org>; Fri, 31 Dec 2021 00:22:05 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mx.groups.io with SMTP id smtpd.web11.5667.1640910121693805729
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Dec 2021 16:22:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=dAEpKu9s;
 spf=pass (domain: intel.com, ip: 134.134.136.100,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640910125; x=1672446125;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=E0N2XOuQX3+5/jIWoFEyLkS7UODsHqdV7Gmjodxg5uc=;
  b=dAEpKu9sB2k/pjhvbZtpJ4uB9ttyC1ceXhhC4mmxzChuImP6pFhAGYI2
   EGAWnSSPOW1CX3RXFORBgxl9m8GS4AMT3dekPD9crGpjtcdjkEyO6TOVK
   CjKEEXLjlpCeopTk6EQiEFN5pXYiW6BiUZL3f4SjID153oMarQsAngcGs
   5rH7M7q00vNByisFu6gxzCYK3DEXMYo/HSTtzxMduMzg85mX/79WOnl9K
   hZWH7PCM05fxP9XxSqx0IXezwRjdhI0i7DVCPbMEcWVzVYsxbDjts3R8m
   rZolg2g7WuWaz9KzlpjyYl7zcixd9Qj7pWriGc4b8+5wc7cueYII+2eLn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="305110481"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600";
   d="scan'208";a="305110481"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 16:22:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600";
   d="scan'208";a="468943779"
Received: from jiayingk-mobl2.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.231.141])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 16:22:03 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 3/4] fetch: npm: Use temporary file for empty user
 config
Date: Fri, 31 Dec 2021 08:21:54 +0800
Message-Id: 
 <56f6e7b5f86f1dc630c50a67e9027c1798a56a34.1640910042.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640910042.git.anuj.mittal@intel.com>
References: <cover.1640910042.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 Dec 2021 00:22:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13207

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Always use a temporary file for the user config 'NPM_CONFIG_USERCONFIG'
because npm otherwise failed if configs and npmrc aren't set:

double-loading config "/dev/null" as "global", previously loaded as "user"

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9f272ad7f76c1559e745e9af686d0a529f917659)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/npm.py | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index d9daec20..b3a3a444 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -79,16 +79,12 @@ class NpmEnvironment(object):
     Using a npm config file seems more reliable than using cli arguments.
     This class allows to create a controlled environment for npm commands.
     """
-    def __init__(self, d, configs=None, npmrc=None):
+    def __init__(self, d, configs=[], npmrc=None):
         self.d = d
 
-        if configs:
-            self.user_config = tempfile.NamedTemporaryFile(mode="w", buffering=1)
-            self.user_config_name = self.user_config.name
-            for key, value in configs:
-                self.user_config.write("%s=%s\n" % (key, value))
-        else:
-            self.user_config_name = "/dev/null"
+        self.user_config = tempfile.NamedTemporaryFile(mode="w", buffering=1)
+        for key, value in configs:
+            self.user_config.write("%s=%s\n" % (key, value))
 
         if npmrc:
             self.global_config_name = npmrc
@@ -109,7 +105,7 @@ class NpmEnvironment(object):
                 workdir = tmpdir
 
             def _run(cmd):
-                cmd = "NPM_CONFIG_USERCONFIG=%s " % (self.user_config_name) + cmd
+                cmd = "NPM_CONFIG_USERCONFIG=%s " % (self.user_config.name) + cmd
                 cmd = "NPM_CONFIG_GLOBALCONFIG=%s " % (self.global_config_name) + cmd
                 return runfetchcmd(cmd, d, workdir=workdir)
 
-- 
2.33.1


