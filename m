Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63842C7619A
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 12:21:48 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web10.128366.1680697294712201288
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 05:21:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=bbVufIez;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 335CLV3r1308760
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 5 Apr 2023 14:21:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1680697292;
	bh=2XjsGxQkDVedLcTZGfx1j/yc1y0oM2nwQp+72ITIIJE=; l=3040;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bbVufIezIdRjIfEqMFh6jw3bbut9FcbqqLhqJaYyHfKt684WRHvYBlZSF629q7GbF
	 ylIumMr26yFoaTxOck2WV+384cQOTtQZmtje4CiollneC8qsrULPTvn10mXzrZ/ZI7
	 YAt7DQT+wuwhZkSS2v1NS8nVwiY1+/LzOMOirxiyoSKqfMNZZcf1lsyOyw2oppFP4r
	 EX8+8kaVDiDesUaIUU4tb55fSr9kZfxS7gQq74vlHpEzIwlyFadpiubsEsqjljjxZ9
	 AEELBT5tlnxmbY+RT4xuLyZKM67ojZyZr8tXI/z42q42xTXaZE7gfh9KXzJXoJZtJZ
	 08wsZNrvmr7YQ==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 335CLTY2402581
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 5 Apr 2023 14:21:30 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ([192.168.12.72])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id QVHZQKIE3J; Wed, 05 Apr 2023 14:21:28 +0200
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 335CLS1E1270256
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 5 Apr 2023 14:21:28 +0200
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.96)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1pk28m-00E5pF-1S;
	Wed, 05 Apr 2023 14:21:28 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH, v2] fetch2/crate: create versioned 'name' entries
Date: Wed,  5 Apr 2023 14:21:25 +0200
Message-Id: <20230405122125.3358972-1-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 642d67c85038ce378780cbe6
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 12:21:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14652

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

It is common for rust packages to depend on different versions of the
same crate.  E.g.

|    crate://crates.io/windows_x86_64_msvc/0.42.2 \
|    crate://crates.io/windows_x86_64_msvc/0.48.0 \

Identification only by the plain crate name makes the sha256sum
ambiguous

| SRC_URI[windows_x86_64_msvc.sha256sum] = "9aec5da331524158c6d1a4ac0ab1541149c0b9505fde06423b02f5ef0106b9f0"
| SRC_URI[windows_x86_64_msvc.sha256sum] = "1a515f5799fe4961cb532f983ce2b23082366b898e52ffbce459c86f67c8378a"

and requires lot of manual work to fix the SRC_URI list.

Making the 'name' property unique by appending the version allows
direct copy & paste of reported sha256sum errors to complete the
crates list.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 lib/bb/fetch2/crate.py | 2 +-
 lib/bb/tests/fetch.py  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index 590dc9c12681..a7021e5b367c 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -72,7 +72,7 @@ class Crate(Wget):
         ud.url = "https://%s/%s/%s/download" % (host, name, version)
         ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
         if 'name' not in ud.parm:
-            ud.parm['name'] = name
+            ud.parm['name'] = '%s-%s' % (name, version)
 
         logger.debug2("Fetching %s to %s" % (ud.url, ud.parm['downloadfilename']))
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index da6716890070..6ef0836f2be9 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2380,7 +2380,7 @@ class CrateTest(FetcherTest):
         ud = fetcher.ud[fetcher.urls[0]]
 
         self.assertIn("name", ud.parm)
-        self.assertEqual(ud.parm["name"], "glob")
+        self.assertEqual(ud.parm["name"], "glob-0.2.11")
         self.assertIn("downloadfilename", ud.parm)
         self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate")
 
@@ -2428,13 +2428,13 @@ class CrateTest(FetcherTest):
         ud = fetcher.ud[fetcher.urls[0]]
 
         self.assertIn("name", ud.parm)
-        self.assertEqual(ud.parm["name"], "glob")
+        self.assertEqual(ud.parm["name"], "glob-0.2.11")
         self.assertIn("downloadfilename", ud.parm)
         self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate")
 
         ud = fetcher.ud[fetcher.urls[1]]
         self.assertIn("name", ud.parm)
-        self.assertEqual(ud.parm["name"], "time")
+        self.assertEqual(ud.parm["name"], "time-0.1.35")
         self.assertIn("downloadfilename", ud.parm)
         self.assertEqual(ud.parm["downloadfilename"], "time-0.1.35.crate")
 
@@ -2451,7 +2451,7 @@ class CrateTest(FetcherTest):
     def test_crate_incorrect_cksum(self):
         uri = "crate://crates.io/aho-corasick/0.7.20"
         self.d.setVar('SRC_URI', uri)
-        self.d.setVarFlag("SRC_URI", "aho-corasick.sha256sum", hashlib.sha256("Invalid".encode("utf-8")).hexdigest())
+        self.d.setVarFlag("SRC_URI", "aho-corasick-0.7.20.sha256sum", hashlib.sha256("Invalid".encode("utf-8")).hexdigest())
 
         uris = self.d.getVar('SRC_URI').split()
 
-- 
2.39.2


