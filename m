Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964CAC10DC1
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 14:45:08 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.33045.1701873898382294775
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 06:44:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ux75JgHr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c09f4814eso49862455e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 06:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701873896; x=1702478696; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELMe/b8cOQqlW+JgiUPMrzLGv6Oelc6p0MG9lDZ0QIE=;
        b=Ux75JgHr+HxJUk6oY41T1eQSqUUMkxw+SEbyIb7a5QivNqSToc2xF1iQgozbAjV5Hb
         ODroSdsFnakOvJ6H8QI9nh/RBtNTHnlfLHLYbZVsIUu9eM+ETdLHtLe2TwG9FomycvP+
         fYaZqkBYQGHlLUYCnY14UNSpGuVv7l1RS83Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873896; x=1702478696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELMe/b8cOQqlW+JgiUPMrzLGv6Oelc6p0MG9lDZ0QIE=;
        b=MSy6Bz5fuUmBtFxl5h1f16xKHI7dm5Z3cPq9N9Lrk21K6dPP8xQ+JzwD8jY4OzUZ7e
         lDs/ITXoSKtXXNgtMKs+AKygSN3RiSYLNbimuH3uG7oZ8YrkuhSs2Ew3Zl0U4KT266vq
         vMIomosKmJ8r2JUJel2K5RVuFzmnKzIwb7IxNqN8GSUp3WKpZ5VWAD6uo/Tn73aSn/97
         7kSt5e48oI7mp9ZZvE4MQ2g5P3xH/XJQVMrGYpjOp+N/TrLOrD6jslmHoqxZy4xCuh+/
         J4zVkBBB3RrF26WHJ9ny59kz3GtHCTB37vGw2h780iqeQaArUs5BSdXd+lWGmSff4Eph
         eH7g==
X-Gm-Message-State: AOJu0Yy3dMVeKlBqg6cuv/LJX7YQr7EPf+2CB9Op/nApZH9rxQs7x5W4
	zPCx/zT2vklfO1rPCZFBEONE+qhLqA45ZZAIJVs=
X-Google-Smtp-Source: AGHT+IF1uBI6JXpLDh2isCejDZedFmxrZLaTmGOU754jHgWjK9Jn40s9xrEsEcS4qPVW7pJZFTvd8g==
X-Received: by 2002:a1c:7914:0:b0:40b:5e59:ccd8 with SMTP id l20-20020a1c7914000000b0040b5e59ccd8mr822256wme.185.1701873896397;
        Wed, 06 Dec 2023 06:44:56 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3cca:8f76:d5f9:e02c])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b0040b4b66110csm22108082wmo.22.2023.12.06.06.44.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:44:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] bb/toaster: Fix assertEquals deprecation warnings
Date: Wed,  6 Dec 2023 14:44:53 +0000
Message-Id: <20231206144455.1604879-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 14:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15618

Fix:
    DeprecationWarning: Please use assertEqual instead

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/codeparser.py                                | 2 +-
 lib/toaster/tests/browser/test_all_builds_page.py         | 8 ++++----
 .../tests/browser/test_builddashboard_page_artifacts.py   | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index b6f2b77ee3..f6585fb3aa 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -467,6 +467,6 @@ esac
     #    self.d.setVar("oe_libinstall", "echo test")
     #    self.d.setVar("FOO", "foo=oe_libinstall; eval $foo")
     #    self.d.setVarFlag("FOO", "vardeps", "oe_*")
-    #    self.assertEquals(deps, set(["oe_libinstall"]))
+    #    self.assertEqual(deps, set(["oe_libinstall"]))
 
 
diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toaster/tests/browser/test_all_builds_page.py
index 228a62be7d..bfd8f3a439 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -259,25 +259,25 @@ class TestAllBuildsPage(SeleniumTestCase):
         element = self._get_build_time_element(build1)
         links = element.find_elements(By.CSS_SELECTOR, 'a')
         msg = 'should be a link on the build time for a successful recent build'
-        self.assertEquals(len(links), 1, msg)
+        self.assertEqual(len(links), 1, msg)
 
         # test recent builds area for failed build
         element = self._get_build_time_element(build2)
         links = element.find_elements(By.CSS_SELECTOR, 'a')
         msg = 'should not be a link on the build time for a failed recent build'
-        self.assertEquals(len(links), 0, msg)
+        self.assertEqual(len(links), 0, msg)
 
         # test the time column for successful build
         build1_row = self._get_row_for_build(build1)
         links = build1_row.find_elements(By.CSS_SELECTOR, 'td.time a')
         msg = 'should be a link on the build time for a successful build'
-        self.assertEquals(len(links), 1, msg)
+        self.assertEqual(len(links), 1, msg)
 
         # test the time column for failed build
         build2_row = self._get_row_for_build(build2)
         links = build2_row.find_elements(By.CSS_SELECTOR, 'td.time a')
         msg = 'should not be a link on the build time for a failed build'
-        self.assertEquals(len(links), 0, msg)
+        self.assertEqual(len(links), 0, msg)
 
     def test_builds_table_search_box(self):
         """ Test the search box in the builds table on the all builds page """
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
index c6226d60eb..adea2edb0a 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
@@ -197,12 +197,12 @@ class TestBuildDashboardPageArtifacts(SeleniumTestCase):
         # check package count and size, link on target name
         selector = '[data-value="target-package-count"]'
         element = self.find(selector)
-        self.assertEquals(element.text, '1',
+        self.assertEqual(element.text, '1',
             'package count should be shown for image builds')
 
         selector = '[data-value="target-package-size"]'
         element = self.find(selector)
-        self.assertEquals(element.text, '1.0 KB',
+        self.assertEqual(element.text, '1.0 KB',
             'package size should be shown for image builds')
 
         selector = '[data-link="target-packages"]'
-- 
2.39.2


