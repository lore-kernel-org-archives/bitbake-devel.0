Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1378CD3EE95
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 16:53:51 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42246.1769100820929321716
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 08:53:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=N+SePImn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so893538f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 08:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1769100819; x=1769705619; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AriWRKzKPb8vSv7wXSUFHkdoNgE8LFU6/pXB4/jSaq8=;
        b=N+SePImnQcRbmHWei45V2n3A34gOoV/vicrizq2uKYVVKRst+2mVkYzjzoPxm34BEm
         J6dRx7xD3xNGmT2PCCa5djNn1wy33tm1w3FOTagrmvxXEccw0fQ0xS/gOPK7OkeX+kIf
         Xit8zo8LxknB4NPflOe+LrwZFoe1bXWP7/TAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100819; x=1769705619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AriWRKzKPb8vSv7wXSUFHkdoNgE8LFU6/pXB4/jSaq8=;
        b=JzjsXwktUhPZ4hrmiN0l26gyyZv/V0vY881aSFegqme52ZbdOqO7pQY6jLiXPdvu1U
         aL2fAPnB1+Kj6wSpf6tP+vVqIzevVAoF4zwXg9dgX95dCFvjA/FiriB98p1B5jWAh/7O
         wiBwU4JBOtTp/7glfRnFdVNZuBzLORjaQhkWg+U5931oyFun7G79YiUJN0BS0zqhsX8A
         Z3W7Kh8bWfjY45WYEVYtEwZx0YTtg+GdZvj3vyYg/qPgi+8DwcTIwhnp5alugvkY1qjc
         LOwlzCWIN2Df8CcY+6pba6y3p1CGsOpLCGpgwoAFAwYpS3lXSk5J82tKQ7EG0QZgTg69
         PCZQ==
X-Gm-Message-State: AOJu0YzC1gZ5Apg8bFCPGv/NG4p9ZLZP5pA8DsfGw9fQ1f17/L79apoL
	QE1o4S523M1i+CdlmSvqRIHC35ol/PWZLOqOLpxAbeCGwzFd08Ujnswik0Z3hwNaAXG3s6/mhb6
	KNzRj9QI=
X-Gm-Gg: AZuq6aIk/Ro9pheoPKLCtbxQgKNquCd5CAIgP53mgDeoQom71o2vl3iNnU9cXctyxtX
	WES8DokKOIgd5HSIqU/jKthf28HSBIIx499Qn3Ja7/pegxjZquWjoMEf32CfDVGyMjampUXm2rm
	/JbTnTGhPeQGyXxefP0tGs4KaPy6KrGKGkyq/RpplpCoAUhb8SMxPpyRD3SZpqH+GIPwZ04gQs7
	p7nXmUgw3/+w7131Q9ee4O0FQU2QDZEaj7tqYvQ7zIKrWToMVOoQUgdO6tE2tZJEHWDGKDASlkp
	bSl2tUtDe2BKN/fq5/OUiEMK4d3D6ZqNX5MKDlYmRq+4Qg6LaEPJLlTDnQmVIMwPYnPTn2jaT3j
	77QduWhUKjlQ9/1jE45rbsiVjHNn4UHvx9/DmoYO8zNK+GFgHI85LCqikAZYjH6WpYp8s3Q3JQP
	XT7qx/xE4t9Qzm63OiQdWyOAD5p2CBmdzVUT3Qp4c=
X-Received: by 2002:a5d:5d10:0:b0:435:b0e7:ea1 with SMTP id ffacd0b85a97d-435b15990c1mr275424f8f.19.1769100818550;
        Thu, 22 Jan 2026 08:53:38 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8ce7:5a61:b9e8:a245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992c6f2sm44182613f8f.19.2026.01.22.08.53.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:53:37 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v4] tests/fetch: Disable npm tests
Date: Thu, 22 Jan 2026 16:53:37 +0000
Message-ID: <20260122165337.1818686-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 16:53:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18853

Since the npm fetcher is disabled, we should skip the npm tests too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e027705bf40..e2a7eec9cbd 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2811,6 +2811,7 @@ class CrateTest(FetcherTest):
 
 class NPMTest(FetcherTest):
     def skipIfNoNpm():
+        return unittest.skip('npm disabled due to security issues')
         if not shutil.which('npm'):
             return unittest.skip('npm not installed')
         return lambda f: f
@@ -2937,6 +2938,7 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
 
     def test_npm_no_network_no_tarball(self):
+        return unittest.skip('npm disabled due to security issues')
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
         self.d.setVar('BB_NO_NETWORK', '1')
         fetcher = bb.fetch.Fetch(urls, self.d)
@@ -3033,6 +3035,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3069,6 +3072,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_git(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/cookie': {
@@ -3082,6 +3086,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_dev(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3110,6 +3115,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_destsuffix(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3125,6 +3131,7 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'foo', 'bar', 'node_modules', 'array-flatten', 'package.json')))
 
     def test_npmsw_no_network_no_tarball(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3164,6 +3171,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_npm_reusability(self):
+        return unittest.skip('npm disabled due to security issues')
         # Fetch once with npmsw
         swfile = self.create_shrinkwrap_file({
             'packages': {
@@ -3186,6 +3194,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_bad_checksum(self):
+        return unittest.skip('npm disabled due to security issues')
         # Try to fetch with bad checksum
         swfile = self.create_shrinkwrap_file({
             'packages': {
@@ -3282,6 +3291,7 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_bundled(self):
+        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {

