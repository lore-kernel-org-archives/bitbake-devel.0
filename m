Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF4AC5478C
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 22:04:51 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web10.2143.1709071485648114572
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Feb 2024 14:04:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=lt2RoKVz;
 spf=softfail (domain: sakoman.com, ip: 209.85.167.173, mailfrom: steve@sakoman.com)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbc649c275so2438080b6e.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 14:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1709071485; x=1709676285; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skqpA8dwO4nqyqGt21HDGobZuOo8BOSXp1xQG2u+Xkc=;
        b=lt2RoKVzsje+h1zqcB++LNo9mIty0nxXKwctJmm2sudig+/7V1D4vvR0sZqmZBDTnN
         acDm2mr4ecgyOWyqNe+QiD5EbfE5431eWLGQ4nyocJ/ezC23B2/iaiAHToxoH7fWjySl
         nLvztmclePa/Kb4EhMp+XHwJFRjHCG6GmNJYxnMSt6eYqhG/rMQlo/oAtI8dNRxrQ578
         M5S+2Vly58rsxWRK8uKUkdQIq+o7EjoHbkAJ4/AMOAxnhA4e/HC9DyRCa5RJzjqUDffM
         tfs/JpWH364QdTfh1ug0QyzQ1IRBg3bxuarJyfPfYpSWjTs2Pim60KBGlhV7lj8pdstD
         VF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071485; x=1709676285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skqpA8dwO4nqyqGt21HDGobZuOo8BOSXp1xQG2u+Xkc=;
        b=E31JS0T7FzWQ8HTI9v0xbxAayuh8wttLQRo0ya0lmuwxU1q10M2kmCMduVqtyq+SEl
         oj3afCSt8fG5DX5IEZ1fmJKuDbWC2ehCi6xpcX7X/J8XmJy4zPsTiFmjVWfyU6KZfbYk
         2Ode//YUxQc1Y24xi6FPfoZEPhDKvCA5NOYGFqc3NPVYhqfyEln8QkTyd0xckHoPzR9J
         NkAYqaa2tABBdyfF95YQ6ajKcZHN0xE/vZ0esTHqEVOuiJAqO20HVfckguWzOOj4Slo/
         yTKj4bl4DPdlAwAxuZxydVN/4n669vPWrECBjyGmIJ42A7WqSZrTHc9rDWoUZ0P+Rr7m
         hrcw==
X-Gm-Message-State: AOJu0YxtICezay71zshn1+l8kAR2olsgUYf9BoSbzNu89lCMpXzE22qD
	PkWA0ALzj9CaQNNleeH3yMjOjxJ/V6NehsVF2hBJqm916jQ50kLc88+gNmQsn19PiFmsfQcqtZC
	+m3E=
X-Google-Smtp-Source: AGHT+IFChllsgextrgxBmXDijMNwgLYimcsNfp6RiITY5AOtchRRHoFK98K1F8/pKVwVCyVjqrATKQ==
X-Received: by 2002:a05:6808:14d1:b0:3c1:9333:9bf4 with SMTP id f17-20020a05680814d100b003c193339bf4mr3965038oiw.6.1709071483242;
        Tue, 27 Feb 2024 14:04:43 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id t13-20020a056a0021cd00b006e50c0d6421sm5059772pfj.11.2024.02.27.14.04.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:04:42 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 4/6] tests/fetch: git-lfs restore _find_git_lfs
Date: Tue, 27 Feb 2024 12:04:23 -1000
Message-Id: <1d5d4a46c772f44ab652f95b37f508b890828e67.1709071317.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709071317.git.steve@sakoman.com>
References: <cover.1709071317.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 22:04:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15970

From: Paulo Neves <paulo@myneves.com>

Not restoring the mocked _find_git_lfs leads to other tests
failing.

(cherry picked from commit 70f848631450bd723c223227c21c60e815ee033d)

Signed-off-by: Paulo Neves <paulo@myneves.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 7bace415d..743d3e3ff 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2210,12 +2210,16 @@ class GitLfsTest(FetcherTest):
             shutil.rmtree(self.gitdir, ignore_errors=True)
             fetcher.unpack(self.d.getVar('WORKDIR'))
 
-        # If git-lfs cannot be found, the unpack should throw an error
-        with self.assertRaises(bb.fetch2.FetchError):
-            fetcher.download()
-            ud.method._find_git_lfs = lambda d: False
-            shutil.rmtree(self.gitdir, ignore_errors=True)
-            fetcher.unpack(self.d.getVar('WORKDIR'))
+        old_find_git_lfs = ud.method._find_git_lfs
+        try:
+            # If git-lfs cannot be found, the unpack should throw an error
+            with self.assertRaises(bb.fetch2.FetchError):
+                fetcher.download()
+                ud.method._find_git_lfs = lambda d: False
+                shutil.rmtree(self.gitdir, ignore_errors=True)
+                fetcher.unpack(self.d.getVar('WORKDIR'))
+        finally:
+            ud.method._find_git_lfs = old_find_git_lfs
 
     def test_lfs_disabled(self):
         import shutil
@@ -2230,17 +2234,21 @@ class GitLfsTest(FetcherTest):
         fetcher, ud = self.fetch()
         self.assertIsNotNone(ud.method._find_git_lfs)
 
-        # If git-lfs can be found, the unpack should be successful. A
-        # live copy of git-lfs is not required for this case, so
-        # unconditionally forge its presence.
-        ud.method._find_git_lfs = lambda d: True
-        shutil.rmtree(self.gitdir, ignore_errors=True)
-        fetcher.unpack(self.d.getVar('WORKDIR'))
+        old_find_git_lfs = ud.method._find_git_lfs
+        try:
+            # If git-lfs can be found, the unpack should be successful. A
+            # live copy of git-lfs is not required for this case, so
+            # unconditionally forge its presence.
+            ud.method._find_git_lfs = lambda d: True
+            shutil.rmtree(self.gitdir, ignore_errors=True)
+            fetcher.unpack(self.d.getVar('WORKDIR'))
+            # If git-lfs cannot be found, the unpack should be successful
 
-        # If git-lfs cannot be found, the unpack should be successful
-        ud.method._find_git_lfs = lambda d: False
-        shutil.rmtree(self.gitdir, ignore_errors=True)
-        fetcher.unpack(self.d.getVar('WORKDIR'))
+            ud.method._find_git_lfs = lambda d: False
+            shutil.rmtree(self.gitdir, ignore_errors=True)
+            fetcher.unpack(self.d.getVar('WORKDIR'))
+        finally:
+            ud.method._find_git_lfs = old_find_git_lfs
 
 class GitURLWithSpacesTest(FetcherTest):
     test_git_urls = {
-- 
2.34.1


