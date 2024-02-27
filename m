Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF210C54E49
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 06:18:48 +0000 (UTC)
Received: from esa6.hc324-48.eu.iphmx.com (esa6.hc324-48.eu.iphmx.com [207.54.71.69])
 by mx.groups.io with SMTP id smtpd.web10.6881.1709014723279126649
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Feb 2024 22:18:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=SXAvbuV5;
 spf=pass (domain: bmw.de, ip: 207.54.71.69, mailfrom: prvs=780903e03=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1709014723; x=1740550723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KKmzsMo0fUoGhsfkoJlwGvzmZvMAIcJ6cxjD0gyKrgs=;
  b=SXAvbuV5OLzZOjZe9Ksiw5PqhEgE39+VTUk7OVUEq0hRThNAsv/d7tOd
   WKV/smkCKjzcrqUz9RSINMmMIOx5nMZu3MRNliir6g1e8sCT5AYTzfRVX
   Iz92poe071huAlVU65XKqI7AIAJPSFr2+3OsKK3h5kX8OsvO6m5vilGay
   Q=;
X-CSE-ConnectionGUID: FO11hKMqRkWvTDgbSbKTqw==
X-CSE-MsgGUID: rM9Di7hjQaeF4uLrImeNUg==
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa6.hc324-48.eu.iphmx.com with ESMTP/TLS; 27 Feb 2024 07:18:40 +0100
Received: from esabb6.muc ([160.50.100.50])  by esagw2.muc with ESMTP/TLS;
 27 Feb 2024 07:18:40 +0100
Received: from smucmp10e.bmwgroup.net (HELO SMUCMP10E.europe.bmw.corp) ([10.30.13.87])
 by esabb6.muc with ESMTP/TLS; 27 Feb 2024 07:18:40 +0100
Received: from localhost.localdomain (10.30.85.207) by SMUCMP10E.europe.bmw.corp
 (2a03:1e80:a15:58f::2027) with Microsoft SMTP Server (version=TLS;
 Tue, 27 Feb 2024 07:18:40 +0100
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Paulo Neves <paulo@myneves.com>, Steve Sakoman <steve@sakoman.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>, Philip Lorenz
	<philip.lorenz@bmw.de>
Subject: [kirkstone][PATCH 1/3] tests/fetch: git-lfs restore _find_git_lfs
Date: Tue, 27 Feb 2024 07:18:06 +0100
Message-ID: <20240227061808.3394661-1-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCMP04G.europe.bmw.corp (2a03:1e80:a15:58f::217e) To
 SMUCMP10E.europe.bmw.corp (2a03:1e80:a15:58f::2027)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 06:18:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15961

From: Paulo Neves <paulo@myneves.com>

Not restoring the mocked _find_git_lfs leads to other tests
failing.

(cherry picked from commit 70f848631450bd723c223227c21c60e815ee033d)

Signed-off-by: Paulo Neves <paulo@myneves.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/tests/fetch.py | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 7bace415..743d3e3f 100644
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
2.43.2


