Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F175C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 13:19:25 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.11506.1742303956210578520
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 06:19:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OVfRI68n;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913d45a148so4908976f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742303954; x=1742908754; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0Ch3J28hss5Jtf5E1p0eznGN8uWCv0OlcA6J+j7Zyw=;
        b=OVfRI68nXadsT/+RCq7PIeLG2BznAY+po1CfWQW7xUYXfFb+gpDXWYRGZjCnt1xEFR
         JmsQdTBCvzVE+dGqquRfmOZulVQ/k3D6iXoNe7Nahz6WjDSivZAGNsgHsoi0wtMUL6bc
         UamDBSLnRg/J6ugga1uqOI38iQDmZvawriXrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303954; x=1742908754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0Ch3J28hss5Jtf5E1p0eznGN8uWCv0OlcA6J+j7Zyw=;
        b=byX+G2ah1L1ZjQdnKw7yas6Tl7rHxFPnr+eny1PsfpbqjQJThnKed5GPaoOKwHprS+
         aNF/RnWqaM9CR6s39xyt202NvXcA6ypWIuCz15LjnzK+hBdoj77rTLduiYjYb0vHV0ly
         /RwWx6UgUQqHf7eAwHCxkO2KOXGf3Cr9iPYYnnC4O3w4Qynh3WdEX6GybWSADwyj0n5R
         GXtVkUfuGWBJ1z7KHKamL7n+e0Pc3IkJf8wIok8bU1OdYHWmD7wjpOBlynBnzlRNoXyO
         FqO2AKPS4868s8SBRm6aE/YhMHEQ4AstFp4rJ8cbi8WhBvXwyQVTBRg5LaC4lRwMif1V
         ggIA==
X-Gm-Message-State: AOJu0YwAtpyH+MD76ZSUWWegVaz93M3MPBn9ma715okbQuem2V4KpiG2
	zu+y0A2g0isx10AbDwNGmlBA/aXiqbsUVOsx6Sc//rhPPWYTm8rbo52J5EYvP9itkWejZSie6QG
	b
X-Gm-Gg: ASbGncsCtv4v3e9v6pMm6Vw47OSv9Ju5m4egAV1/DitVmeuJc0EMWCV3f9hEXnJr/hf
	MyaGbP2cGZBcA0YUgINta9k+OH7FVSpR4gzpVkkwLzRYStIOp19AtylpWZEDM7WKo7j+v8GNL5p
	fYN8qNUwG1fE3lQ/lhLTbVyrURy9AbzbhkNPi+W6JrwZyPHdOzOVXjequQ3zesNXNz/rQY3aeet
	Yv9lBVuLjtw5dnbwS2nKbUh1op012nFszSwR0HGF8LASIuIV0hgHFeensTyXIho4wT/oOwB7avW
	/2yy/nKs56nxo4ryiRgSckxVNlKEqpOLgfLyPBzksxrlE5xdw+x2dbMCKiRD9kogAdiTxNwyBUY
	rsMJHrajy
X-Google-Smtp-Source: AGHT+IFJwOj9dtM0iAi/yJ4CEkTcAxX2ODsVKz/kdRT33Cf7nR+uiNnQiP/xBDsZvgEYX27a7lepIA==
X-Received: by 2002:a5d:64e7:0:b0:391:ba6:c069 with SMTP id ffacd0b85a97d-3971f033c1bmr16399962f8f.44.1742303953923;
        Tue, 18 Mar 2025 06:19:13 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:791f:f4e7:28a8:7096])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc49adsm134568005e9.24.2025.03.18.06.19.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:19:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Add git tag verification tests
Date: Tue, 18 Mar 2025 13:19:12 +0000
Message-ID: <20250318131912.4131187-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 13:19:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17459

Add tests for git tag verification in both standard and shallow clones.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 59 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 0c87730c5e..659a5b8ad7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3178,6 +3178,65 @@ class GitSharedTest(FetcherTest):
         alt = os.path.join(self.unpackdir, 'git/.git/objects/info/alternates')
         self.assertFalse(os.path.exists(alt))
 
+class GitTagVerificationTests(FetcherTest):
+
+    @skipIfNoNetwork()
+    def test_tag_rev_match(self):
+        # Test a url with rev= and tag= set works
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+    @skipIfNoNetwork()
+    def test_tag_rev_match2(self):
+        # Test a url with SRCREV and tag= set works
+        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;tag=2.8.7"], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+    @skipIfNoNetwork()
+    def test_tag_rev_match3(self):
+        # Test a url with SRCREV, rev= and tag= set works
+        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+    @skipIfNoNetwork()
+    def test_tag_rev_match4(self):
+        # Test a url with SRCREV and rev= mismatching errors
+        self.d.setVar('SRCREV', 'bade540fc31a1c26839efd2c7785a751ce24ebfb')
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+
+    @skipIfNoNetwork()
+    def test_tag_rev_match5(self):
+        # Test a url with SRCREV, rev= and tag= set works when using shallow clones
+        self.d.setVar('BB_GIT_SHALLOW', '1')
+        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+    @skipIfNoNetwork()
+    def test_tag_rev_match6(self):
+        # Test a url with SRCREV, rev= and a mismatched tag= when using shallow clones
+        self.d.setVar('BB_GIT_SHALLOW', '1')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.6"], self.d)
+        fetcher.download()
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.unpack(self.unpackdir)
+
+    @skipIfNoNetwork()
+    def test_tag_rev_match7(self):
+        # Test a url with SRCREV, rev= and a mismatched tag=
+        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.6"], self.d)
+        fetcher.download()
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.unpack(self.unpackdir)
+
 
 class FetchPremirroronlyLocalTest(FetcherTest):
 

