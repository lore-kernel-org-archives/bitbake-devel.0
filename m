Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E7DCDC18F
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:10:49 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88568.1767701442488230727
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:10:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ghxgWlhW;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b79e7112398so150851666b.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 04:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701441; x=1768306241; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ai79dbCrAiLWsJnWE+bUJA1wiuZNABO3QUVYVWFTmo=;
        b=ghxgWlhWY3cUS66PuNbvTgRUnBWWhlpoy7wzXFapRvIyPImSqZFUr4J5bTAX8p5Lgw
         LKvduU/jKc/KYh3UcMcLByp2rOPPmdPQrtHq8Zyh3Vd1FmIFYDwYaV54OSL/X1tmQCBW
         92vpfqGjSd4vSf294ClGiC5vV/y1wVPfVNkdOQOi2BNv0BHSKYIYD0svy1zSEc385N/s
         JefR4tkvy9qfCGoZdvUDnFjytHsTCopZkY9pWCmAJ/kelXuwyhZ5suCrbR/Fp/6rqRD3
         7fFEwqHmmwH6ILNnZagUgYRMcueHrXHwio9vMWLDEgsFDuvttWtCF2JE+Ww3LEXXgDum
         eV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701441; x=1768306241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ai79dbCrAiLWsJnWE+bUJA1wiuZNABO3QUVYVWFTmo=;
        b=nHrmpmJCTVZeAFcu85GrITWcgFYKFnkTfGodCZc7RWT/dBd7ATn5Mzxe/X1rc8Oepf
         GFjgLHF3dv8yFibNk3q/bMZFhwHSeOeuI9EClmSLLIlDLGreak0SyA4UhTbZCp0vwPgN
         F7REMCEvK3+hyvewPxKQ6juelJYajNFuWeoDui58J//SiT8lJKLs1NjGOQUM6uer/dKp
         FrZl5N1jsvRpA3b2oxQMDaUt99OB0qL3HpjZrYBLnTKPeEnIrLUzLjZN1gIkisn005FY
         aHxaBiT5DLdBdSHv5rU6cOv4lPf7qbJYnGrE8QCJF2HxWc36N/bEjdn/MDO5aKgfjxLL
         mw1w==
X-Gm-Message-State: AOJu0YxCyvTxy6fPofCzJ/Ge7Tz2n4tP7w8KkqdKr1a+DrrTcdYuVPn8
	sm+m47gx7T2lvXeXsd5/Bv2ZiAb7Sssw+NDZg+6QiHW/SarxjQDRagWv+mFXeA==
X-Gm-Gg: AY/fxX7XeXoS0b/QekvajPTMRmohJR/jFYa5JnqKBoHRzRBsdNh2eVFKT6Fg+UZo1jq
	98isoI92JtOABUE8wkap0ic2Z/63M4qLVR3ANPmT1P22u2+XuYCv+ThhBZN5q8yT3ef7MuMybH9
	ZHKJMRv80/lbQKnwKoLzhg2uPxg2EpaewrFx4dLPvcAb/gJAyUfVLwHN5XA5Xx1HrBikB8mg1P7
	oe0c6LvBu0UbF2tclcaSS/YwsA5jDjLzb3KAG9sC4ZKckqjRtTz5S2JPO7sqk7x1rYEUkmogY4v
	R4c5vYedevNet6yILisF2O6fDyAfwlA0HqU4oekbnhhTK9UCQiVMvpyd0CxNZADmLVIhncLO977
	41KV4SnKE7yAZwRXp5aRiSYJ186OFuWDmSzxMA5RnIzoT8goePX3AMAIYSzHsA2/Pz961aRbzxZ
	+AlDNdH8M+0Z85ELESEIDCCFFoTEQawMNkH4DdLxtmRXUuXN4=
X-Google-Smtp-Source: AGHT+IEWPfz+qWSGCwU863FroPCxNAIJRmmeqcgqvGNpSeHwczvNqJBYlXunJTphgeqbYWv1gfUeAQ==
X-Received: by 2002:a17:906:d54d:b0:b73:3028:93a1 with SMTP id a640c23a62f3a-b8426a4ed9emr281409566b.9.1767701440576;
        Tue, 06 Jan 2026 04:10:40 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm223329466b.0.2026.01.06.04.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:10:40 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 06/10] bitbake-setup: extend the tests for local sources with status/update sequence
Date: Tue,  6 Jan 2026 13:10:28 +0100
Message-ID: <20260106121033.3892596-6-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106121033.3892596-1-alex.kanavin@gmail.com>
References: <20260106121033.3892596-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:10:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18696

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


