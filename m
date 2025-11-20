Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63468CF8845
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 11:24:45 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32115.1763637881234958622
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Nov 2025 03:24:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GTHjG6vI;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a1c28778so9065275e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Nov 2025 03:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763637880; x=1764242680; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yNx6nXwn0s2uHkUP0acvzKYUImRjmXaswVsA83ZeFQ=;
        b=GTHjG6vImOcPNMThm+DmhoZnvhX4aGIBqHIzIJkzKmggG3ryV9XN+7SwHoibb2rhmc
         OVFN2Api7yMNWsu8Ce7U7/c1Z+4Hc1ZzV+/xDtHcEZNnp3uonwoHgiom2HPOFKomrkcS
         z1k3VN/avVnY29u/S0+WnfxkYr0wELr912PlO6tjFs2PwU6IYG4yMoFW+TU+awqavSTf
         kkudtpWwXMHrdA/L1ERh/WbEnmQ9wYlALPIDHJPZ3l7cHrYOZh6IaiJjBvpWQUmHn2lu
         EmWrffU9LmRQfYoYox/g3X5cfLTrvLFEG0782tqbDE7l72H0vdfBVpHLSpXY7e+VYShA
         0GqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763637880; x=1764242680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yNx6nXwn0s2uHkUP0acvzKYUImRjmXaswVsA83ZeFQ=;
        b=eFJHDsFqkbbZCmQOM/pT0N1O65NyXyMCdAkPrEsMFiCpuOvS7GhhMl17F0EEVnthaM
         nkAf+PW/LtyvRpHlosBPjsexTwNTzcC2/0uorU42bdysLsLSi5O5mPQFNGdwrRRdNdQC
         b/aJHxOdo1rxtDzaNtEY7DkIVy/xiCRRpSjo8wh3zfvvr7vHqA93NLCWwImOnCjiPc9+
         qKBrRdLwdXQhwYEs2lJ4/QdlOAIj6RflJQ3GQ13brgagR38wEkQbraihXNtU2G1UD3VJ
         ifn1peqdgc2O+rHdipTVxULsEAG9aB4jzZXPXQfLma8m8+tSGM4bNckW/tygxZjR8CtB
         w8hg==
X-Gm-Message-State: AOJu0YyvE9N73xz4lz6yCNKZXADJ7vl+33a/n7/xp84OF/y6gu7pLELs
	HC4q5y4DT18Jk97ROFipuOp/sM1piYCAqshwzZQysESNl9+clxVIYZWRHoIIMw==
X-Gm-Gg: ASbGncsZRIaLKSDr2gdqPtvY4YaK0lfj7dlR0V7jTLi/7JOMh2hHwW70zjSsDEWTPGV
	6F4pI0sZwHWXEjX15XlBSpreTRPyIpSAOycgVwnj5KlhtD1ghFG8jbI5CWGWG7gY1RlWmTxJbuW
	L+DC0bNYNcxrBIirYewUqGVRB24r5EJ2uIDEm6pDThX0r3arA53E5RgzXAt6VmpfGkJDmd1DCNd
	PDaC9WhQsmcEMEJ57Z483ZIL7d4aEDRYpP0HpE7MYNKDmB0z34zFkRk9nVTN5VVC7C9mjItwTkq
	US9Gy3uqUwxbPP8uiq7FoW3RXVzosRCxWYrT3EpKg0zxltdBK/beME2TW+YRY80gabfRHJ/aLUC
	ZQNn+I6Att5CQUWUGootmD2FPWQEcfoqmIgPXIx/u3G+GWkZpGZ6dWetEgKDiM/JI+3eZAsTg8w
	JoDlQA9eC8yRhc5IxDZUd07HHG8IyjFRsxZge8mhNlCbyYO4c=
X-Google-Smtp-Source: AGHT+IFJ3XcJTkKraiOvdDSfq41iC96psPQiVY+qffe6dc0LOzpsCnPldM09HwCQwmdE4z+ZVGQgpg==
X-Received: by 2002:a05:600c:19ce:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-477b8a89ed0mr28640615e9.17.1763637879511;
        Thu, 20 Nov 2025 03:24:39 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1025707sm98845305e9.6.2025.11.20.03.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 03:24:39 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: do not write comments into toolcfg.conf
Date: Thu, 20 Nov 2025 12:24:34 +0100
Message-Id: <20251120112434.137764-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Nov 2025 11:24:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18469

From: Alexander Kanavin <alex@linutronix.de>

This is the job of bitbake-config-build, it's already placing
a comment of its own into the file, and so this additional information
will be added to that (in a patch to oe-core).

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 792f5579f..436456a47 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -259,12 +259,6 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
     shell = "bash"
     fragments = bitbake_config.get("oe-fragments", []) + sorted(bitbake_config.get("oe-fragment-choices",{}).values())
     if fragments:
-        toolcfg_file = os.path.join(bitbake_builddir,'conf/toolcfg.conf')
-        toolcfg_comment = """# Run 'bitbake-config-build enable-fragment <fragment-name>' to enable additional fragments
-# or replace built-in ones (e.g. machine/<name> or distro/<name> to change MACHINE or DISTRO).
-"""
-        with open(toolcfg_file, 'w') as f:
-            f.write(toolcfg_comment)
         bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
 
     if os.path.exists(backup_bitbake_confdir):
-- 
2.39.5


