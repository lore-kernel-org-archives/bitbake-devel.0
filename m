Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFB5CDC17D
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:10:49 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88565.1767701439557138628
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:10:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RXPxm7BT;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8010b8f078so147161366b.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 04:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701438; x=1768306238; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGnHNMj4wrW4+b/3IfY5d1qVTc9C6XP6HyxlqMq5pI8=;
        b=RXPxm7BTfTvZ415ordC0Nyym/Yg3rWbBlSlsRu6+BmTZxQOaXfPmW2PtKAx6K2WldB
         9lYAp9U15Gscb+upAzb6/PR4uitDCOMHi7e0rHmonf+0Pj+w0UliMGOZeSepu7hR3Ch6
         S4oOVtOojo6Zy8tHkFSUFuPygYmrzMAKoeemVIfTeFdYDEzz0Nl5GZiyHddw1hI1S1iH
         /d6DigHbVkT1fPYkz00E6eZLPL3MH+P3EpWnYNADtjwWUKFAHi+3lY4RULUf1/1SsrD5
         RYpmshlVwy8HVpyE5X+7N+pq7UxWtHjfnQv4z0l+m7M0hDdWUBnrVLDUK+Tr407lRpxq
         GFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701438; x=1768306238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGnHNMj4wrW4+b/3IfY5d1qVTc9C6XP6HyxlqMq5pI8=;
        b=Km2VtybX7GpUNv6oAzkPgEVdck2Hag8oJh/UuZRqu1kJ6AXvQ4E9rpHp7QICKp+16O
         7Uy3jEah4aQuXidAUxYah7HocinSAb164QbMLeHkMbZ9xcf6TadYUjyTZPe7FL1y4leK
         RomC2G97Qehuu4wSUgZKDv1F+saz5UXq8y2ut9Mlb8lws0ecow7/iePS9VKnzU5NRODE
         CQrXhz8G/QDI0sLyTv6NoSisk6eaB0ynIqOV3sWIf0p+gOwyQLjHmm11CQVaoYoSAcFL
         QH3K/60Kil0r/BJipslDCv7qq0hHbknaJKjbHc26AYS7WsD3GvZLXLDgoEvVrc5u52C0
         ursg==
X-Gm-Message-State: AOJu0Ywi6xaIIhO6mfPinvhiJFBe9f9RizDgHLi7OP0L89dCig+4uRQ7
	lqrz0Smx4tH8aPzwy2tGOSPbLpwIVqwhIEpxR6UEHAFQQszlPrGyZS4KNmHygg==
X-Gm-Gg: AY/fxX6YsgtEyTt15oGpV1zxs6hKyWmEqD5sn0LTlY97m48cEBPIVDlPVEqOdJteSUx
	2vtqLhJac2Xkvx5stdPD7UKKZ00AK6OlwoFRtufdZs6J9Sw5obLI1UYbyBeDoXR5Ye/N3t0LSuk
	mZE9ETL11ykzN0DGkRaMVPtHK506/gGKZx03IX2d7yomLu6JuGg1KokIbsbn2f/JL/wL9/aEaLf
	0QCNNQdYN2s5v/28bS0+ARN0BUw9HV5bxPrOAH+dAO45GGU2LprXwY/eDPS689dKjCKa6gbzt8D
	lrEZOCGjCPU7zi/woYqMSXk8WugDazD0cdpTlZRI4z7F5tj3y5tmQiJuh/30lLDyOe8e/SCXFxo
	n0IQ05o4m1sTXj1y4qRIQuVo3Pz8L3U5rLlPzGFXciWNFrrmjfXaBuOI6tgFW06Og7zY3yoc3nn
	W7ruNqB2RUDJYW1v6oxGA3WgAgySRQDIxft2sHMpe04ivyuxjeJo+ANxUAOQ==
X-Google-Smtp-Source: AGHT+IE1SoyfEYAdZ8j3HlXW88eO/EtoQw3UOwr6aMhKjhv4u0cbdGPPNfZIfbrALUONuKYMAtiZzw==
X-Received: by 2002:a17:906:4788:b0:b73:845f:4432 with SMTP id a640c23a62f3a-b8426bb964fmr342031366b.32.1767701437742;
        Tue, 06 Jan 2026 04:10:37 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm223329466b.0.2026.01.06.04.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:10:37 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 02/10] bitbake-setup: consistently add configuration commits at the end of updates
Date: Tue,  6 Jan 2026 13:10:24 +0100
Message-ID: <20260106121033.3892596-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106121033.3892596-1-alex.kanavin@gmail.com>
References: <20260106121033.3892596-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:10:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18692

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


