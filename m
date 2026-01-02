Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6F2FA375A
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 19:34:50 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11904.1767382488530939037
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 11:34:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=foDmoSqK;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7ffa5d1b80so1571945266b.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382487; x=1767987287; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGnHNMj4wrW4+b/3IfY5d1qVTc9C6XP6HyxlqMq5pI8=;
        b=foDmoSqKilxAOZHGkChiwwoUxAhkI6ukH3g/W4gJcLvFhWFr3Mcjg1OFO+oX414LVk
         zx9PDujVGdBu5PFN81CG1j8ApgGvwcr1WTCsAxRML+cWNTVekqW5zc1nXpZVIjZ7ExDy
         cpUPaDnvQ1L/xTiBpEJYev1feiDN4nutwCbnkAIqWgg8dwlZfouice7p+PuyWyZFT7Ky
         Nid+9z/aajJNmq5mAHU9d+lpMGCfIQ4UN2nXfAg/Yr6kzq9EF4d8HeSCaycSgnbFvREG
         COQm6Q91toQmnTtvyKQsVHFYr330VEAP8N4I3nDA3CIfj7TgBuDB7BTmKw9/ElKkFhj4
         14yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382487; x=1767987287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGnHNMj4wrW4+b/3IfY5d1qVTc9C6XP6HyxlqMq5pI8=;
        b=SxEJ20EdMbRjO6ECHmYb3t3fPL2kddg04Hn2ZVnwMfT5emRBJ8ohNYXRaUPa61OXUV
         gNIKpbKRAiEpkKq959/jFj42qttC7rNaa9oxTf47Y6t9C94Eb0eAi13266TIuVSoTB3/
         s9ODdXPuNkQwVGtltPpaLA6E8+gq/98/gLpdUtArwsthG7lMqTdqG+pVTurryINnWgnD
         tR8pM2YMLzvcM8TzYJpwdnK4qLAFb8PnpnVnwIiDf1ChZ28V9BNVkMlM2/Tf1h9Rhg1a
         NWtid5symb9l3+UKTWSvBAde5QQ5piNZ1v2KjkPJO0pvZ32Fjapn7jhxxRr9I+tZMA7n
         6yiQ==
X-Gm-Message-State: AOJu0Yx5uLJHh2BNN+Szt29cNvJSUMEG/+qbIs4GOIyMcjo86f7G+CBF
	Vfw1jsBz7aCMd3hbMwYnemQaqbXOiw8VNacdcyktyGR72R33K1x0JrIqnyldGw==
X-Gm-Gg: AY/fxX46wAKrAlBME9oOKPpkqu7CjsDcEE8mTpELDcVaTeEakVCKBSwT4OAChseYiPR
	mQg0+Kp80AOVvo8cH2r8OhDoBgJ5hs/h9xk/rBycXRiIPo1a/+Ee79eN3YTkXoFJWphl4nNjZW3
	3L+dasMw+XLO/ewLKEa/hEtHVTZlPxDK6R+pcpiIBig+iGd7kc3P5etNS+jhkl2oqKFuakLPrZm
	IyL0y9zsn0MSFRVMXcD/Pnmlbw/Pln/eaEpc7fvVlndpnMrHsR5zF2qe5NSZo/Mr3kOuoP5wzIR
	n4cmA+ZvoeB65SHfiFOqlYLOn8Iy8NDxzlwSr+/TFVZDFdaF3bf7UapqyLtmsVV08rsZQM/gerB
	6zkte6A4eTlgwctHUlKLMH8i+R2D8soBxcokvWt1uVeop9sQqeRdVNJJwIpAb3o7PQdNXRSmkIJ
	gnz5CUfFu76lBMbHV9gIcJND8W5yAwu4f1E1W+jm8VDaI4z6M=
X-Google-Smtp-Source: AGHT+IESK+vbX4JLTmXcZ24czRS/nmEDEvF7CIZDWm8sM8kzDWu7uijfNwk+nvjXqrunokiKS8DuiA==
X-Received: by 2002:a17:907:97c7:b0:b79:d24b:474d with SMTP id a640c23a62f3a-b8036f56569mr4694162066b.16.1767382486640;
        Fri, 02 Jan 2026 11:34:46 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm4645615866b.39.2026.01.02.11.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:34:46 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 02/10] bitbake-setup: consistently add configuration commits at the end of updates
Date: Fri,  2 Jan 2026 20:34:29 +0100
Message-ID: <20260102193438.2960561-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102193438.2960561-1-alex.kanavin@gmail.com>
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 19:34:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18672

From: Alexander Kanavin <alex@linutronix.de>

bitbake-setup tracks configuration history under setup directory in config/.

Making commits in there wasn't consistently done in all init/update scenarios
sometimes leaving uncommitted files. Move the commit creation to the end of
update_build() function, ensuring it always happens.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 73f734e73..a0d1aaeda 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -342,6 +342,7 @@ def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
     setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
     write_sources_fixed_revisions(confdir, sources_fixed_revisions)
+    commit_config(confdir)
 
 def int_input(allowed_values, prompt=''):
     n = None
@@ -581,7 +582,6 @@ def init_config(top_dir, settings, args):
 
     write_upstream_config(confdir, upstream_config)
     update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes")
-    commit_config(confdir)
 
     bb.event.remove("bb.build.TaskProgress", None)
 
@@ -648,7 +648,6 @@ def build_status(top_dir, settings, args, d, update=False):
     if config_diff:
         logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
         if update:
-            commit_config(confdir)
             update_build(new_upstream_config, confdir, setupdir, layerdir, d,
                          update_bb_conf=args.update_bb_conf)
         else:
-- 
2.47.3


