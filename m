Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24FCFC6160
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 19:35:00 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11906.1767382491318692373
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 11:34:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Pu/Z35So;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b83b72508f3so278967166b.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382490; x=1767987290; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ai79dbCrAiLWsJnWE+bUJA1wiuZNABO3QUVYVWFTmo=;
        b=Pu/Z35SoUejoFWINmPkWCg9AYMZYg/W94WFgyoHXky7DapVtnL9OBlL0rfeSLU+Cgp
         3vCT/vNqhClWzQhyuYkEqLDL3XG+UUkHSjg9+A9wMbPq44TMJu2UUCJkSKkW7aGff4G4
         2isT4oOM0Ik0fajiKSIpfjHQsf6+AsRfPPXA3QdZhrj+yCWHUdn0E9DYcBVKUFANGYeN
         7L5kPNDuiO9c3PnG/sEp3F8cRSZHtEcE+dE/2xll0s+lQe0wkNpxAC0MI3py5dd2kMtO
         wFV4SXNnK2dHiPYZngdeVytPonmzmcb5MqvShwFleTUYdO3A9uMordKl7OGB7Lf9c4sR
         STPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382490; x=1767987290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ai79dbCrAiLWsJnWE+bUJA1wiuZNABO3QUVYVWFTmo=;
        b=dhqPAThqaENwWw9XjSn40mjsZiUopJNoVZNNl5S0CNsJdgAdk/O4G5jcMtkniWMw+8
         C45wSRUnCaYyTOA4a741mcsr/2/mzZY2mQ9TAEt6I/F5XZ6zP6ZrEvDUR1Uwe0VfQcs7
         l0p30Ym2ZksD5xPnI3GunArdfkSMt4risilpofSQkfYK7qUiS6bueeDdqu6vE7Ixp786
         EwcGHWWGmb8mJZKlDHZhbzfzsHccxxzC6Rm9KvTb6IXmOIdlIcbaLYRSf1usjky20OOH
         O8W1fDkN+wC7+c9X41sp1Ys/xuDceLd87x8oJkvCxN05xN2y5zygEejhevp8AXPmGevB
         Xupg==
X-Gm-Message-State: AOJu0YzJ8TrresRxBzcO44aD8wzyb1XD0spWHAQnRl893SdOZiDSLhAo
	gkz/2RWvlfCz5ZDZbDrX8eFKilbgbUy2bibjERqeh/PJ5+T5v1UizcVr0wufxA==
X-Gm-Gg: AY/fxX7drQYsoWy3g2ji5y7y38804KaLS9mPutmLth2Ywv1qbPFauLmMFgENLtbUnmM
	cDwh4H3BZkexH10n3gQ93PBsjcfHJffuQFbL7W7Zgzsr8Bzm6csn2K6J0DW5ydcpRssqaI5VzH5
	Rb2NUPLnhGB44kARWPalJvn2Zr4ZguYGeMpuWAgJnvA+O3+g43RlmR5UeJHWuO6qulYcvpQGiVb
	x3U4ECU5acYoB0hjsUiiHQ2Vgylaeai35W7C9cg43r4aaBBUEnCOVOKC5PHiuS1OzbLcB2emwHg
	i7fFLH0IUGRAlO1bs3XxtVPCEn9QIRvmr9RTVfLladvQpHnAS9HH3ugi5G/6anU3kYDV7E7Qd1v
	ZFq1MieGQ6HvIjQ84gJ7OUxx4GfboDxu0bwGcAo+20IdpMrRpTqrqMdm8+Jm6E10Lk/cZXvPlw2
	Jtuu2UNXSGom7M8OWemSpB0RN4vpasXFdI3c11RfMLBsm+97k=
X-Google-Smtp-Source: AGHT+IE1ejcZE5wWWE05CAnMyfpzReTON4S5H7JBqfjH2Kn6xRjj3rxyMsdgUSLafgyEvM/kmImsAQ==
X-Received: by 2002:a17:906:23e9:b0:b80:6ddc:83f8 with SMTP id a640c23a62f3a-b806ddc8a5emr2945325166b.32.1767382489504;
        Fri, 02 Jan 2026 11:34:49 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm4645615866b.39.2026.01.02.11.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:34:49 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 06/10] bitbake-setup: extend the tests for local sources with status/update sequence
Date: Fri,  2 Jan 2026 20:34:33 +0100
Message-ID: <20260102193438.2960561-6-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102193438.2960561-1-alex.kanavin@gmail.com>
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 19:35:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18676

From: Alexander Kanavin <alex@linutronix.de>

This checks for both issues fixed in two previous commits.

Split common local source checks into a function and extend it with a call
to status/update checker.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/tests/setup.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 55e9e50ec..30c8b31e3 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -407,6 +407,13 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             self.assertEqual(sums_before, sums_after)
 
         # check source overrides, local sources provided with symlinks, and custom setup dir name
+        def _check_local_sources(custom_setup_dir):
+            custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
+            custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
+            self.assertTrue(os.path.islink(custom_layer_path))
+            self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
+            self.config_is_unchanged(custom_setup_path)
+
         source_override_content = """
 {
     "sources": {
@@ -421,15 +428,9 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         custom_setup_dir = 'special-setup-dir'
         self.add_file_to_testrepo(override_filename, source_override_content)
         out = self.runbbsetup("init --non-interactive --source-overrides {} --setup-dir-name {} test-config-1 gadget".format(os.path.join(self.testrepopath, override_filename), custom_setup_dir))
-        custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
-        custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
-        self.assertTrue(os.path.islink(custom_layer_path))
-        self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
+        _check_local_sources(custom_setup_dir)
 
         # same but use command line options to specify local overrides
         custom_setup_dir = 'special-setup-dir-with-cmdline-overrides'
         out = self.runbbsetup("init --non-interactive -L test-repo {} --setup-dir-name {} test-config-1 gadget".format(self.testrepopath, custom_setup_dir))
-        custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
-        custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
-        self.assertTrue(os.path.islink(custom_layer_path))
-        self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
+        _check_local_sources(custom_setup_dir)
-- 
2.47.3


