Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C0BCCF9E5
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 14:16:35 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.33923.1761574593023370913
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Oct 2025 07:16:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hhEcOflk;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47118259fd8so35349615e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761574591; x=1762179391; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EvDmq2K4Z++4OnuxytNkB4kLj3A0AgJ+iceWN1Zb34=;
        b=hhEcOflkXd68nKQbfw7I3T3wagY7X12IWG+hDntf8HuO+73s+wdD6DScBH9N7URiH3
         o8vaH3o1uPFx53ZQdcEVqhZcJ4ANJay7WLKgIydjICM7otfddBu0BUzV3zWj0AqHxYV7
         62qn9oSZCY4J0OBZ7o6ZED2lwHUNJJKRI9qVwfqF/4egmN50Z+qOY/QPsCcNiO+MQ21w
         I2MtNzNPpSr0klXH7FhTUu0iktZWWv96VDzU8f2yJPCSK4d+aDmpss/AVPIboGw6uA5x
         QSUfKeNaRYsYio0eBzQmaoWjHMqGOTeTf//gw/I6Gz5GkL3scOrZpL1RUJSKany4IKDb
         eX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574591; x=1762179391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EvDmq2K4Z++4OnuxytNkB4kLj3A0AgJ+iceWN1Zb34=;
        b=YyKv5IKw7YaH/HAbtX7DSbfwvwRvAJaHvORmO5Vz42bidaLboDP5hd6FKm27WyV0kf
         uBzHGooynrWbYS0TFI93XZihzMGsVdU0ihiB1l8QKu78KjsR65lqZohCwI3u8XN3Wmy4
         R79h+nw8m/NTNpZOgrDSWjmtUcXQcBBXUX9MB5HfOpf/zCx+YobhilerwSVkiMkNlfWI
         5zzLlLRKfeLH+OadumzQRCH90gM9nTmrpEXSkQEY66GZSvTe0UH9OiicP81ri9ammuFL
         PSXGqv6o0c4N0+Rq1TUZkHV2XmT4ceBNQ2d/zh6hF4COOW8TCq/to2nbexfefSnyem8L
         V/Mg==
X-Gm-Message-State: AOJu0YwO5Pn7dfW94pljXv8xGYXri3c5b4EJw+rfFDV3iuFCrMSSlCNt
	fzaPUl8tcj4yzf89iBaCS/0EBGZWIwi+vaE9yZK6Ch7PFkeOZ2BZs/Ewwm46sg==
X-Gm-Gg: ASbGncsGmawZh8w1VWD0SbCg+JYf9ocnmW30M77X3LqF41jdt5qye+Ubv/bhMGr/1QZ
	izlM3mw+X/JEqHayOrxnd2dX1uAwtGaIu5ChIjZODyEYHZIhsecMWfWSOngQ8K7NHUlzz5VJ6wl
	c5/Q8KpB3DHvfdTYr0lxf80l1B4f58hJLgsF2sIhRiqVrWUMTwXj2mEgaPT5QST8sQg8p9O3+FI
	jPqgj2AQgKqVvi+e4BpMVJmkLUNC5edxxcyYC8z6hL7OEQmn/fq429c8mpNyXFSuBS4aos7V548
	6RNZY+i7scjM1UPZBAVpIpfEL2zzgUTW131pwMNxRgdf6PWK5s+sX1wT8Dgy4Ne1nhClomTWNTb
	iHbX8/4mp/PSCrCHmWu3LhZYCetFnB2XH0ULEO02cX+YXcjYnOaJaip675/pX4L1bRxD8umrwzQ
	l8mo9BMdJExL4yhSaMuVbNftCtx3nvJL5loRYuWgi1cZ8/JtiiFgpjDK0Mxbv2GJg7MZYF2bvdL
	CXZrPltxf+E9hQHNEConwYOUTsKrg8/KVatR6uSg7At5cMt1Q==
X-Google-Smtp-Source: AGHT+IEacXPJ9wuRffy+3u2pnF2AR150ieE/GYGNdF/NuOwwPfuBSdBTDiv4t9i9uE769U2u4AYZtw==
X-Received: by 2002:a05:600d:634f:b0:475:d952:342f with SMTP id 5b1f17b1804b1-475d9523a1amr57774635e9.39.1761574591150;
        Mon, 27 Oct 2025 07:16:31 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbb20sm14458247f8f.18.2025.10.27.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:16:30 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: correctly define --global argument for settings management
Date: Mon, 27 Oct 2025 15:16:27 +0100
Message-Id: <20251027141627.3724031-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 14:16:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18221

From: Alexander Kanavin <alex@linutronix.de>

--global was defined twice (for settings command as a whole, and specifically
for set/unset sub-commands), which caused 'settings --global set ...' to
be allowed, and at the same time not have any effect. 'settings set --global'
is the only valid form after this change.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 38bb8099f..a0426005f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -785,7 +785,7 @@ def main():
     parser_settings_arg_global = argparse.ArgumentParser(add_help=False)
     parser_settings_arg_global.add_argument('--global', action='store_true', help="Modify the setting in a global settings file, rather than one specific to a top directory")
 
-    parser_settings = subparsers.add_parser('settings', parents=[parser_settings_arg_global],
+    parser_settings = subparsers.add_parser('settings',
                                             help='List current settings, or set or unset a setting in a settings file (e.g. the default prefix and name of the top directory, the location of build configuration registry, downloads directory and other settings specific to a top directory)')
     parser_settings.set_defaults(func=settings_func)
 
-- 
2.39.5


