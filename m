Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A2CCD187
	for <webhook@archiver.kernel.org>; Sun, 12 Oct 2025 17:47:52 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.23229.1760291269114846896
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Oct 2025 10:47:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SRfS8DjM;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e52279279so24083895e9.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760291267; x=1760896067; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VmulNbziY8CyNaz5Que11l/0wsSPhqMZM8dN2p0RTNs=;
        b=SRfS8DjM2vsKbfwqNEftRaIBygIdki31Lyo4McIdfcGZRAwDo9UVOlujeRVUH0d/iK
         4BBc4b2/J2ON1mqbSi1+hhpo6WOtxMzOOrbmtvqvAqPLqRG/SC3IFIQ8+g9Q5JEE0PPJ
         IMSqWO3NnQh2QQlvRdyjbmgamvHSXdnAO4yjSWKUPKW4BzQRjFcHNurjZsOpaf5FRg9q
         fW3SU3NnjDVpxntBFqaPcliglDtnVLKGWvkqX3zohCoS8B5+TcTd17V2QDe2B6hcld7d
         uLT2Btz4mdiEx7C2RaFmQdcWzGc94VCkUJkMoT3E110aC2A/BQOSr4Elw9SkHQhTE5KN
         KU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760291267; x=1760896067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmulNbziY8CyNaz5Que11l/0wsSPhqMZM8dN2p0RTNs=;
        b=ceDFUZ4eJsLikz2OIDDc1MQ2mMYlzTWJvhlDK3TENsmo07xxLMn0tGBDdrr2Kdgsj6
         nQePPWVIc74TrE+TaN+SwCP7g02+gR6QK2IlIasxX3FYjic987XFdGeIvlfsvHP0dAqg
         h4OqZJYb0Lb1BhB0IGdtVBjDily6MzJ9HefzirwiK0BTMtm4Upv6o9JYLOJBHIIwjSwB
         SYUaFWolcgi5R+ZFfustXjk2XdsXDKowCpMRYwhLi+KXsFX5kCQnOvf9F603zonb/a81
         j0TphRrZ281rpeM3QoMJoZO2Ext9P/0lUptBQeco0B9IUD6FsIGzYcYytQDgIYp0muq1
         Vecw==
X-Gm-Message-State: AOJu0YxiWAJ6BFxulkTMmTfBMChYhPa96dU9agT+mTPMvvx4SA7JOSK1
	+C/JDGhHtpEpOcHB6lEH+m9PRPfO2PAtBrFVLWP1dAVE5rLZnc4qHCS8j2O3Jw==
X-Gm-Gg: ASbGncuiMC+ApNhdCfUUon68da3CvOftpg3TPw+giDmd0Ao6RQPG/HNAv7QR/zqQsZh
	eb/aOJ/SxtJKYUK32QdbvfZVO5B2967dvESddB9i0AmQ5HI1pYA2qNHCUdKWqnirYQtGgYNgi++
	4nNwhUKqhOQIpjLlb3F20+EyHPa++V6XYnZ2/VjQbbC9AMFqYQ0LcxKp/cmhob6Plye5VGjPb3W
	SKLEGKKDGDza4D4+JHk/XIwIZwNjv6vo35siHwXIZkFPZudp9gd1rv8rz/hDgeIqqtuMjq9Qowk
	Y+VsWC247g7zQqzxvRK0iX6eisvQPinjG6L1Fi3XFq01DFkCjjopFuieibtGUG28P/dykeeHifE
	T2KH4gHLlAzpeknbliWKRp44wTuG4cz55pLfhQ9VVRdwYEV7p6RQ8dpjLYo6yaODNWtxJlKMQ98
	NjYuUkT3nN9rQmBdiQ57J5jwfEDV6JM+65lqUp99XE+gOlfemTiP867eHuUBbXP/jIvJvWOw6zu
	J4GQC5U9h/EhHw=
X-Google-Smtp-Source: AGHT+IFNsApNukAOa3Ls1y822hSr7zRRpN5pCE6heYg498R0+zk/xh3TayS/v+C1bqBzA5fwLaAhhw==
X-Received: by 2002:a05:600c:1f93:b0:46e:376c:b1f0 with SMTP id 5b1f17b1804b1-46fa9a8ca9fmr130708715e9.7.1760291267395;
        Sun, 12 Oct 2025 10:47:47 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582abcsm14170160f8f.17.2025.10.12.10.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 10:47:46 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/5] bitbake-setup: correct 'setting' to 'settings' in a couple of help texts
Date: Sun, 12 Oct 2025 19:47:23 +0200
Message-Id: <20251012174727.4191604-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 17:47:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18175

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 71b5b8de9..f24d39481 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -787,7 +787,7 @@ def main():
     parser_settings.add_argument('key', nargs='?', help="Name of the setting")
     parser_settings.add_argument('value', nargs='?', help="Value of the setting")
     parser_settings.add_argument('--global', action='store_true', help="Modify the setting in a global settings file, rather than one specific to a top directory")
-    parser_settings.add_argument('--unset', nargs=2, help="Unset a setting, e.g. 'bitbake-setup setting --unset default registry' would revert to the registry setting in a global settings file")
+    parser_settings.add_argument('--unset', nargs=2, help="Unset a setting, e.g. 'bitbake-setup settings --unset default registry' would revert to the registry setting in a global settings file")
     parser_settings.add_argument('-l' ,'--list', action='store_true', help="List all settings with their values")
     parser_settings.set_defaults(func=settings_func)
 
@@ -834,7 +834,7 @@ def main():
             settings_func(top_dir, all_settings, args)
             return
 
-        print('Bitbake-setup is using {} as top directory ("bitbake-setup setting --help" shows how to change it).\n'.format(top_dir, global_settings_path(args)))
+        print('Bitbake-setup is using {} as top directory ("bitbake-setup settings --help" shows how to change it).\n'.format(top_dir, global_settings_path(args)))
 
         d = init_bb_cache(top_dir, all_settings, args)
         args.func(top_dir, all_settings, args, d)
-- 
2.39.5


