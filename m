Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28086C44500
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 09:25:28 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33404.1769073926768096793
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 01:25:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZIvZmxMs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801bc328easo7909405e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 01:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1769073924; x=1769678724; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rIipPdLr64EA0gcOlQkSUmJDXu+MNNZNZD1bMq++D8o=;
        b=ZIvZmxMsHqQtcKrHI9hwGf7KJ/kkdBLF1wdOoX/ugQmW0uzHQbSN6zI8G2Nx80BtCX
         819sS8TDB/I/T/Qg9unEGXC0RZghjGIP+M/hwXvuGT4TpF0Hr7TI9iDtJMDHIVykQpw/
         cBz7yvOokIWf5FDTpH2VUC2KQ34qERYYam3Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769073924; x=1769678724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIipPdLr64EA0gcOlQkSUmJDXu+MNNZNZD1bMq++D8o=;
        b=Ie+Hv3MiTjCs4J6i/844H4YX0iLbF3l4mIIYBLKPN00JkinefErlJrVGylXHUFNv49
         TecG63ROegh2dKKvFt60Wkt/E0KdGVzXKZocexcNPL9Vgh9gisnf78BKDUBhptAn+yJQ
         NMcEFmU6bl1fg0fsGjsAIgfDIbRMY5XXx1siDqpHt2HWM2cAhw2amRqD3PWuze2JlD6H
         moRPZ74Jtczv7CZWQOghaufWiOSSsbVWSylQKNwMMI2Vmd8i1MgZXLiAq5hOtN5lbkZm
         yCfeyrXs/RccRP288fvBTzt/xCPCXwY8DbAouPKd5OKdmtAWxdhGx1PgtTFNTY4q0Cm5
         kMPQ==
X-Gm-Message-State: AOJu0YwSjgjvMGMiMKCpgnN52pZeaMpYZa69SD6ZTZ5aN+ydHaqZXieE
	1uyHhzwdp47QKap9YioPp63Sz3snXFRcE4A8e6GYxHiO2R0crRbeVkfruaDWooUrkyt93VsMkcq
	r2/cOGO8=
X-Gm-Gg: AZuq6aKpfVNxHDR6BhzcXvBD11xIYM/InzNvA6kF/7lxikBMRBBEEA6QOB4Rfu2xMq2
	i0M6vUaTUmuOJaOOItmlPYdq0gNF2TTuAfoQs9Cl+p4vDYYMNIjMGgzYrOnoR3j2jPBdExr6bYX
	DTbNZxRBqAoiAtjoE1jLA7eqo7cOo6QS5TcNEyT9dlbPa9zLubKNYyBDuL7GF/xjosVMBGxI3Bi
	xSpd5VjDUnXO4C0i9+gKMmx5he8f6qz3AsVF875rpb/AR3USPRgJx6BMzyuPuPGCIyWNW7GAC/j
	GIYUqZ4w1y9cDWLbLIIpwaktWPVBBkZbUXX4RByjI/+rikp8EegAIFKVThgcZos7kQ813FdOzZY
	d+UX8A7VcIt2w05TwDvahPUxWR1bF92WqY+vM7uQInE1q1Pw0QE4qZdUuYsueIEFi8s03YaXzfO
	aktsHBlU1/PIlmlTjFhHXNm2ssnRu3r2OHRkEelJgoyY3yOoqEGQ==
X-Received: by 2002:a05:600c:4e4e:b0:47e:e5c5:f3a3 with SMTP id 5b1f17b1804b1-4801eb03400mr309515355e9.24.1769073924118;
        Thu, 22 Jan 2026 01:25:24 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8ce7:5a61:b9e8:a245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804703b59esm53969155e9.4.2026.01.22.01.25.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 01:25:22 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Disable npm tests
Date: Thu, 22 Jan 2026 09:25:21 +0000
Message-ID: <20260122092521.1711964-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 09:25:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18843

Since the npm fetcher is disabled, we should skip the npm tests too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e027705bf40..a9fc6d3cb40 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2811,6 +2811,7 @@ class CrateTest(FetcherTest):
 
 class NPMTest(FetcherTest):
     def skipIfNoNpm():
+        return unittest.skip('npm disabled due to security issues')
         if not shutil.which('npm'):
             return unittest.skip('npm not installed')
         return lambda f: f
@@ -3033,6 +3034,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3069,6 +3071,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_git(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/cookie': {
@@ -3082,6 +3085,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_dev(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3110,6 +3114,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_destsuffix(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3125,6 +3130,7 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'foo', 'bar', 'node_modules', 'array-flatten', 'package.json')))
 
     def test_npmsw_no_network_no_tarball(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3164,6 +3170,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_npm_reusability(self):
+        return unittest.skip('npm disabled due to security issues')
         # Fetch once with npmsw
         swfile = self.create_shrinkwrap_file({
             'packages': {
@@ -3186,6 +3193,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_bad_checksum(self):
+        return unittest.skip('npm disabled due to security issues')
         # Try to fetch with bad checksum
         swfile = self.create_shrinkwrap_file({
             'packages': {
@@ -3282,6 +3290,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_bundled(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {

