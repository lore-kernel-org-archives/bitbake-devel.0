Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DC5C61DA4
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 13:24:20 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.17209.1677245056661421938
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Feb 2023 05:24:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KAuXhQsh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id l1so13618577wry.10
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 05:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/PlncnAjXYanyKfG/Z8vLHi/wc0MFeg5PpYqKeZIqs=;
        b=KAuXhQsha4cBSXXH6T9wttNTjkVYr4DXBGYJtWQak7WOLXfrnAsRrKwOiK4LmMPznt
         lQlqiZDwvAFQqh5orcxOIehomizgz0waf0wPcPikh1olRuJKfn+/V/nw6CuR7vJ7cx/E
         DHs+LQX52twgF2RreX6maiVH2KZckJVdbpM+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/PlncnAjXYanyKfG/Z8vLHi/wc0MFeg5PpYqKeZIqs=;
        b=C39bU/YpBP8EgZuOZqoi0nNaTnqkNYEBcmX+YzEkMwPxofFicKVr+WXR2xWU7XNolU
         50FvN3a/nRAXuuV7oWHjPfJOCDoOB6K+58JWfHc0q1LtvwCvdU5RdsqL4Quz7nQzNVIX
         vcPnGJM+vY2RquL7lWs0gnT2tLKKEAcP/kzPlfiD86/6S7beGebzIxg8PpOWAOgYaH5u
         9AvKWTsZeLvDbNKrZcjI+RGoyHlutg+r7inASR8sfa0AD0QMrLyYcXbRIZ7xSCDk1+r2
         EORvi1aLewt59xyIm8bT6SmmUfL9PCl8PHw6MwcORR2RZD6xrUDW5o9DnNb8Z2uFLg5p
         FVBQ==
X-Gm-Message-State: AO0yUKV4J+edf7Z9e1SiDIXae9aciafBwvqwnZx5sM8/OR0JQ8suZhZg
	0QJKQRhVf0PjT9kJa6BGATz0eGhWKxb+LI3d
X-Google-Smtp-Source: AK7set/j2nWUERzgyNfKTPvAEF8KdlpWsy6LfRRdamUNPGFAEE+BUEbsRBb9gYTLTG4z3gi/3blaCg==
X-Received: by 2002:a5d:5104:0:b0:2c5:eaba:b4dc with SMTP id s4-20020a5d5104000000b002c5eabab4dcmr12357301wrt.56.1677245054698;
        Fri, 24 Feb 2023 05:24:14 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:639b:9979:fd5f:bbb7])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600001cd00b002c6d0462163sm11957705wrx.100.2023.02.24.05.24.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:24:14 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Fix memory resident cache invalidation issue
Date: Fri, 24 Feb 2023 13:24:13 +0000
Message-Id: <20230224132413.310546-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 13:24:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14485

We've been seeing weird PRServ failures on the autobuilder. These had
one failure always followed by a second. Whilst I can't reproduce the first,
if I made that test fail, I could reproduce the second with memory resident
bitbake. This was with the tests:

prservice.BitbakePrTests.test_import_export_replace_db
and then
prservice.BitbakePrTests.test_pr_service_deb_arch_dep

which was giving a strange looking error:

NOTE: Running task 1053 of 1055 (/home/pokybuild/yocto-worker/oe-selftest-debian/build/meta/recipes-devtools/m4/m4_1.4.19.bb:do_package_write_rpm)
NOTE: Running task 1054 of 1055 (/home/pokybuild/yocto-worker/oe-selftest-debian/build/meta/recipes-devtools/m4/m4_1.4.19.bb:do_package_qa)
ERROR: No such task: do_package_write_rpm
ERROR: Task (/home/pokybuild/yocto-worker/oe-selftest-debian/build/meta/recipes-devtools/m4/m4_1.4.19.bb:do_package_write_rpm) failed with exit code '1'

where the issue is that selftest.inc written by the test framework
and containing PACKAGE_CLASSES = "package_deb" was being ignored.

The issue is the cached_statements{} within BBHandler() is not being
invalidated at the right time.

This patch changes the code to ensure base configuration is not parsed
until inotify updates have been processed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c631ec7e6d..1797a1d4ca 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -339,6 +339,14 @@ class BBCooker:
                         providerlog.error("Root privilege is required to modify max_user_watches.")
                     raise
 
+    def handle_inotify_updates(self):
+        # reload files for which we got notifications
+        for p in self.inotify_modified_files:
+            bb.parse.update_cache(p)
+            if p in bb.parse.BBHandler.cached_statements:
+                del bb.parse.BBHandler.cached_statements[p]
+        self.inotify_modified_files = []
+
     def sigterm_exception(self, signum, stackframe):
         if signum == signal.SIGTERM:
             bb.warn("Cooker received SIGTERM, shutting down...")
@@ -368,6 +376,7 @@ class BBCooker:
             if mod not in self.orig_sysmodules:
                 del sys.modules[mod]
 
+        self.handle_inotify_updates()
         self.setupConfigWatcher()
 
         # Need to preserve BB_CONSOLELOG over resets
@@ -1614,12 +1623,7 @@ class BBCooker:
         if self.state == state.running:
             return
 
-        # reload files for which we got notifications
-        for p in self.inotify_modified_files:
-            bb.parse.update_cache(p)
-            if p in bb.parse.BBHandler.cached_statements:
-                del bb.parse.BBHandler.cached_statements[p]
-        self.inotify_modified_files = []
+        self.handle_inotify_updates()
 
         if not self.baseconfig_valid:
             logger.debug("Reloading base configuration data")
-- 
2.37.2


