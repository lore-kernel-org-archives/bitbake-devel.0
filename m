Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9610FC6166
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 19:35:00 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11908.1767382492732362525
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 11:34:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eCVLCfdX;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b728a43e410so2367317066b.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382491; x=1767987291; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJIQXmnQborxnXi2eTFT8le2aN/8gtl9AvwqxeK31H4=;
        b=eCVLCfdXeBuFK2tW02A787y2a4K2A0WifRXOyKtfYYwUmjCrOXSx/+8TtG1Jpg0T9Y
         2e8o1kUsUcVqwx7luEubTsgq4JT/hXoEIKZ9qYmRa9ZGNEwuz8mf/C5BAMLz7ZBTO2JI
         YzTU23dZnyIl4qErEbRwMyL/vEstvNqyqDIgyavZbGJ79rj70wOm0ItMX+caC1lhwgua
         +JJvXB5A0c6MjPNPIFUr/XB3GfOviwMQedy2zy+B5jKwmkq12qKWHb0V9yX8HR2UjRjP
         qvmCt9cBtInaVOHNxdgkFLNtlNyaPFG6T4dz6v3DUb17754hOhjxAQNt1kn+MRBXfb7W
         gPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382491; x=1767987291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJIQXmnQborxnXi2eTFT8le2aN/8gtl9AvwqxeK31H4=;
        b=WghxHP/z7+cqIBItePbRw91hA++5CkNqJaQc5SMcAmw8gAItTf41EEYXPwlED1zH4Q
         rT+S0kVpm7JT1RmEORQO8X3VeqbuoI0a6PHMkz86SvUNVN7Z5iHTwYF2BkWO6AR7qwhV
         Dy3aqj+5bpuiuNUQS3CYbJ5rRr8yphijo1YRR0LnWuObsZoHrgPTgWqTISSPja/nSm0u
         W1SGx6WuFaZux3k9/zK1NTdAlIA/WalOpV9l+mSXwwrcziA8yGF6ib9wiscPmZBe/QfF
         TBEIxM1N9u0EH3bt233zp1X91G1bE8saI7th9OlmB2AxwEdrLwjc1Qd2syMPxBcoLMak
         4fcg==
X-Gm-Message-State: AOJu0Yw4k7cdZE6QXn541KnQ8I8MLbnjstcmLtaG8jRGF3aqA57Iqq2P
	S/vEUOzrZ1FU9omIeR3b3VmC5p2eadmuXa+0Cdhpa9soVeYVxscKvs6Wdn4Mmg==
X-Gm-Gg: AY/fxX4KGpM7aaaE/6LAYwhw8H6DaiDfuxUL5EKax/ZDLnODPsI1odWOP0uMp4xZJqA
	4wSip7QcgqbZwzuqVq6OIYGLQo2Qo5JtSwJkPGbZFV0pb0qEbObUbXLZXh/2fbONB/aRYkw1loh
	ILMtsdYXjEN4Bz/DfSk9yGlrDW3MjmwHKpxTGpfJtZVzjNXtd6Jo+4zGRv2YeFoCFu4XuKwa9wk
	Oom/P18V1usaUcM0nPh74STrwk7PMCIA8goC/MB/TVqjnGuxQdhMhYYxo2WPiwrM3YN2p4qnQtc
	HRUNewOBQU4x0J+qwv1s2qjQfACt5kbE+z3+DhgBV0omfHEIjPkFSQuyDuRsyc4lXMtu1nak7TU
	ynpTurxB2NuJWxGn3pzqULOi246wC6xEEFIcJBxSQS4dmR9O9kV10Wi8vcrGh1BfW5uctsMvDol
	aiQICL8QD7OWeje1j3A2YSSWP3f5jn3fZiuZJWRUt3gR+Kg20=
X-Google-Smtp-Source: AGHT+IGQguScuA+Cwrn4nxEq7/xag/cWdLpJFdWrSaWfoV1pvzUI/jdqg45J3Dkf20sgIzwj9XfnMQ==
X-Received: by 2002:a17:907:2d94:b0:b73:7a44:b4d5 with SMTP id a640c23a62f3a-b8037051a07mr4503718166b.41.1767382490925;
        Fri, 02 Jan 2026 11:34:50 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm4645615866b.39.2026.01.02.11.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:34:50 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 08/10] bitbake-setup: symlink json with fixed revisions into layers/
Date: Fri,  2 Jan 2026 20:34:35 +0100
Message-ID: <20260102193438.2960561-8-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102193438.2960561-1-alex.kanavin@gmail.com>
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 19:35:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18678

From: Alexander Kanavin <alex@linutronix.de>

This makes the file more visible for users, and allows easier
checks of layers current content against what was checked out
by bitbake-setup (to ensure local modifications aren't wiped out).

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 0d33f0896..06255b112 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -69,11 +69,15 @@ def write_upstream_config(config_dir, config_data):
     with open(os.path.join(config_dir, "config-upstream.json"),'w') as s:
         json.dump(config_data, s, sort_keys=True, indent=4)
 
-def write_sources_fixed_revisions(config_dir, config_data):
+def write_sources_fixed_revisions(config_dir, layer_dir, config_data):
+    json_path = os.path.join(config_dir, "sources-fixed-revisions.json")
+    json_link = os.path.join(layer_dir, "sources-fixed-revisions.json")
     sources = {}
     sources['sources'] = config_data
     with open(os.path.join(config_dir, "sources-fixed-revisions.json"),'w') as s:
         json.dump(sources, s, sort_keys=True, indent=4)
+    if not os.path.lexists(json_link):
+        os.symlink(os.path.relpath(json_path ,layer_dir), json_link)
 
 def commit_config(config_dir):
     bb.process.run("git -C {} add .".format(config_dir))
@@ -344,7 +348,7 @@ def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
     setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
-    write_sources_fixed_revisions(confdir, sources_fixed_revisions)
+    write_sources_fixed_revisions(confdir, layerdir, sources_fixed_revisions)
     commit_config(confdir)
 
 def int_input(allowed_values, prompt=''):
-- 
2.47.3


