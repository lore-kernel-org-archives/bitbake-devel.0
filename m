Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F399D59D8C
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 19:08:53 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1160.1765566529873683751
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 11:08:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EbNWsCrP;
 spf=pass (domain: gmail.com, ip: 209.85.208.51, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-649820b4b3aso2354884a12.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 11:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765566528; x=1766171328; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0JPzdKXc5KmqJpt7gwokOzzoC5/TkLLgG9eJg9GdHU=;
        b=EbNWsCrP3k9Pnmb0sKN3aBejxiLTpCEwqGnbpDNmZYmW1Ih3MkORHjt4YxAlrqruH+
         xgDdjGlVB7M2Df4zM/R9Q5Vf7s0iHAgS32LKsF2N83bwYKtg0IkJ4aq3bhkXHDJ8w7MW
         pOMGZAaKxooB6YJ1iQtmNzehMIq9RwFZ83IkIfWkMKOnwuMmVJqePJk7k5GbzcZZM0HH
         olxihsGo5LTKTPRf1hcBZyGOuI4XEBNVs3X6VQUZW+Oo/vbRPDRetWa5aOIi7zVH2XqC
         pS57wjH4Od03EZ4TFGu6HjVR2ReR/R2rfNhjCmoXaNChhFe4CJvCjDPjgiwPnLm3GxJq
         GMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765566528; x=1766171328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0JPzdKXc5KmqJpt7gwokOzzoC5/TkLLgG9eJg9GdHU=;
        b=SQOT91kd2fmeWd/fNMPdoK+dDHt9pI2cEe8eZGTHVTSfPVZfWozZln72ymJUUYnkNg
         4kejYXxSHNnC/YzQmKBTkhccg5sLip8w8IsQ14i0PgnDw16kdv8KgV3vyw38eArADqJ/
         0eOVwlwr4EDTYYw5tdqhSNhTUpKYV+dTbh+Cy5HrMaiv9GkjbdkAJ9L9OZIFMwvvnGUV
         ih9vbCsYuU3BzX2ht13HIKiBFEjS/Q/enbiqAX4A5sSkTozgctgPJY36ALkLE25xM9SM
         ELVsmvQbsfAV+Dn+W2bGfhm0YtR3aVRlJz/+E+8Ky32q7dyzD73SjqLYFIPy2Qs2wPYN
         OYJQ==
X-Gm-Message-State: AOJu0YwyOjMB1cDQoNGACY3CL5Z2mWMJIGQdUroGN2OLkdxfEc7h2SqF
	oiM2tt3PnylaExFA9F5OG6ex2b55IwSMOHoFI7xdvFuZJhd+6V5fcgz9xwJJfg==
X-Gm-Gg: AY/fxX7ctDl76pX4BneFNOv19q7xqEeXlGgpTFiVy0WFVqBs/YnuM9nfqqgJkco2f0r
	7Ywl5J9GcBCF0gyQxaLZXYeLw8ttWV5BcLAp3FrowYkOF7lkeuk1bs5AsOw8RfHv/HFDWy8vb2v
	jw1pVDiQLdQr8Y7LtqQpPBqWE1Crfng4L7E1g0H0dhqEsaDW4w//nl7uOMptSbBb8yvHXHJiIxn
	IMl1Oe/DYKezgPnbccrbvg7Hxpb/lKLAAGLnJ2izOwvDnkMtOHiKwWAqgJL7zGW6fQ1FPJknZm+
	a2ahaMwQGr6Gdgj3v3elxiuhg8a774ZD5T/SHB9Q4rcXV3sOgmnytgbqOztvNb/ueyzbbLTF4Mw
	4tg3ATGD9MwmtJ7Pjc8lVQp8J/A42MLYgAb4HFv2tXGJ0jm7wT239pFt+aYfSIAv7+gWhy3Zjoe
	Bq3ItyREVJzOZw3lM=
X-Google-Smtp-Source: AGHT+IHmku2k5qnupwBK5KfjWBtllrb7YWdfuWcOJA0eQcUNWeBvUNTqPBIa10/1KxLlvAzqPwyOJA==
X-Received: by 2002:a05:6402:1ec4:b0:640:a9b1:870b with SMTP id 4fb4d7f45d1cf-6499b19b438mr2926308a12.14.1765566528218;
        Fri, 12 Dec 2025 11:08:48 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:1401:37b6:6a29:b0c5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210de23sm6147003a12.28.2025.12.12.11.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 11:08:47 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 2/4] bitbake-layers: layerindex-fetch: Fix branch detection method
Date: Fri, 12 Dec 2025 20:08:04 +0100
Message-ID: <20251212190806.32476-3-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212190806.32476-1-osama.abdelkader@gmail.com>
References: <20251212190806.32476-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 19:08:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18581

Replace fragile parsing of 'git branch' output with the more reliable
'git rev-parse --abbrev-ref HEAD' command to get the current branch name.
This avoids parsing issues and is the recommended way to get the current branch name.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 lib/bblayers/layerindex.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 0ffc95822b..1c6511889d 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -55,13 +55,15 @@ class LayerIndexPlugin(ActionPlugin):
             switching branches if necessary and possible.
             """
             base_cmd = ['git', '--git-dir=%s/.git' % repodir, '--work-tree=%s' % repodir]
-            cmd = base_cmd + ['branch']
+            # Get current branch name
+            cmd = base_cmd + ['rev-parse', '--abbrev-ref', 'HEAD']
             completed_proc = subprocess.run(cmd, text=True, capture_output=True)
             if completed_proc.returncode:
                 logger.error("Unable to validate repo %s (%s)" % (repodir, completed_proc.stderr))
                 return None, None, None
             else:
-                if branch != completed_proc.stdout[2:-1]:
+                current_branch = completed_proc.stdout.strip()
+                if branch != current_branch:
                     cmd = base_cmd + ['status', '--short']
                     completed_proc = subprocess.run(cmd, text=True, capture_output=True)
                     if completed_proc.stdout.count('\n') != 0:
-- 
2.43.0


