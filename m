Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22292D5B16E
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:51:45 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47793.1765803099575927937
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 04:51:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JRGAT7HL;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb2314f52so1505280f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 04:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765803098; x=1766407898; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HNK/TxNpJubyDtqPcCZV8/we3jKM3rhzgOwlqyknJE=;
        b=JRGAT7HLG5NZlFHRCFXfkc+IHcmaOnGYatDQdGQ00Dq84Xg2A79ctuVDHaT/p/PDld
         vlM+NtKHb4ZAbuTB5EjZURBjDfNjU+oujaAOe65DcIdNHRnBbm2hvMshmYR7/FYi26IB
         0/Lo15lxLkk4PCKE+4jjcG4SEtNgJY3e8QohKlVwuD8SQc7HKSuVaJ2FO+Jn8ZxKqUey
         +D29goVSw/Q3c2pjHXSUtLmRoi55/I0XF2BUcQ284FeK3SxEzM493JuApLYugvMf0QTz
         9VYw0quH1r/rJ6beyq/ER+BCKopr51Tf0vmeTiYj9c9VM4Q/8HgwpaqhXC8I4hZVNoXQ
         dO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765803098; x=1766407898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HNK/TxNpJubyDtqPcCZV8/we3jKM3rhzgOwlqyknJE=;
        b=Hs9yI0/KyefBPUJLtGUhyl66DJDkOxygTe2HazSq6eweQZBG5iobu1kyk6SBp1509H
         OO8O1eTLcphSk0OqgtGLSEp30dwT3MUs2WL6M/k+iGc89Fe4svIV/7cQojkGHobzsPHi
         bqX9cin62So77IfdhjuESRcMC56vmQLGbfiwTWOX2oNSidev8O+RtC1f/8+KOCniopD/
         ayS44grQW1Qy65Ge/iFh5PWHRk1XXFCzidq4nUFd5Q6qWk1JlcnZEOlBzoFSNgdC2CJ+
         26W/t6cnqhHJGW9nqt+b9FlYsqxAPSPbzAHF42dahALofqALFb+GGTrGRWfPKHuUnn9F
         5ERQ==
X-Gm-Message-State: AOJu0Yzm6Nn8kR6N4PR+42wrT4qaLUpCgujADrxFUGbKAyMh4GLExkKp
	lgS784LKwcL+IL9BDSDeHcrUNfuHG6XaakVBYd8AFLBXO/OZBUlfMBHe3iPJJA==
X-Gm-Gg: AY/fxX5YkQY/JdtxZdxADS8Qd5VR4TdznJNwEFqlW0FqJ9pYPN6UUQtPPiO8e6p09Vs
	mhMX0v1z8DCoEli/ymmaraReeEWQ8VJ1ZLs4MbZZx/H75dSr5V/aWLpEjHQLMg4yBFMYevZkeHf
	rQ1DKYqJmB+uOecjpLNT4YGo8yMNwOBSGU8hqFKCjgfuZnns2M8NGW9k1bQO8l63rB8UFp7d8AQ
	amVKLhJiBgT86YsLcIkQHYoSn4Tkk6ihDbdCjMOzqYVlvFc5/qNdDUE8qYLs2G/Ub74Hmhky+kT
	5f9JCB/jwtL85ryJuqt47O0OxADW6j+2H7GnUcqy7xC8U3xjLQYoC7dHp0AyHvAyESg82/WgMcN
	PWhnB5Uxjvvtcev4zcOgxyoO9YvC6RQ1U9CRb54h1/tbCta5pGz6ZWPZo4o0lvNh5xjpioOmYM4
	s5Hpr5cFQerbXbIv/Jp0MXAhwlWMp52LjEvQQpiJTjwtPTDsV9Wb2DqdFXTA==
X-Google-Smtp-Source: AGHT+IH5TjsMon0tTo3RfOPpPILBaHXf2VJd/sbFTveYh2VSZI8J0L6vPyXh0pbOBu8SiJXW/xq29w==
X-Received: by 2002:a05:6000:1ac9:b0:430:8583:d182 with SMTP id ffacd0b85a97d-4308583d321mr9259639f8f.29.1765803097797;
        Mon, 15 Dec 2025 04:51:37 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a09fbesm29303342f8f.0.2025.12.15.04.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 04:51:37 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	antonin.godard@bootlin.com,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 3/5] bitbake-setup: use separate functions for git-specific operations
Date: Mon, 15 Dec 2025 13:51:25 +0100
Message-ID: <20251215125127.2660714-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215125127.2660714-1-alex.kanavin@gmail.com>
References: <20251215125127.2660714-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 12:51:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18593

From: Alexander Kanavin <alex@linutronix.de>

This prepares the code for adding different type of sources than git remotes:

- put git-specific operations into their own functions (no behavior changes)

- call them only if a git-remote entry actually exists in the configuration;
do not assume it is always there.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 8d4e9769a..1f83b1b2a 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -90,16 +90,7 @@ def _write_layer_list(dest, repodirs):
         json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
 
 def checkout_layers(layers, layerdir, d):
-    layers_fixed_revisions = copy.deepcopy(layers)
-    repodirs = []
-    oesetupbuild = None
-    print("Fetching layer/tool repositories into {}".format(layerdir))
-    for r_name in layers:
-        r_data = layers[r_name]
-        repodir = r_data.get("path", r_name)
-        repodirs.append(repodir)
-
-        r_remote = r_data['git-remote']
+    def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
         remotes = r_remote['remotes']
@@ -118,6 +109,19 @@ def checkout_layers(layers, layerdir, d):
             revision = urldata.revision
             layers_fixed_revisions[r_name]['git-remote']['rev'] = revision
 
+    layers_fixed_revisions = copy.deepcopy(layers)
+    repodirs = []
+    oesetupbuild = None
+    print("Fetching layer/tool repositories into {}".format(layerdir))
+    for r_name in layers:
+        r_data = layers[r_name]
+        repodir = r_data.get("path", r_name)
+        repodirs.append(repodir)
+
+        r_remote = r_data.get('git-remote')
+        if r_remote:
+            _checkout_git_remote(r_remote, repodir, layers_fixed_revisions)
+
         if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
             oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
             oeinitbuildenvdir = os.path.join(layerdir, repodir)
@@ -563,12 +567,8 @@ def get_diff(file1, file2):
     return None
 
 def are_layers_changed(layers, layerdir, d):
-    changed = False
-    for r_name in layers:
-        r_data = layers[r_name]
-        repodir = r_data.get("path", r_name)
-
-        r_remote = r_data['git-remote']
+    def _is_git_remote_changed(r_remote, repodir):
+        changed = False
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
         remotes = r_remote['remotes']
@@ -586,6 +586,16 @@ def are_layers_changed(layers, layerdir, d):
             if upstream_revision != local_revision:
                 changed = True
                 print('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remotes[remote]["uri"], os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
+        return changed
+
+    changed = False
+    for r_name in layers:
+        r_data = layers[r_name]
+        repodir = r_data.get("path", r_name)
+
+        git_remote = r_data.get('git-remote', repodir)
+        if git_remote:
+            changed = changed | _is_git_remote_changed(git_remote, repodir)
 
     return changed
 
-- 
2.47.3


