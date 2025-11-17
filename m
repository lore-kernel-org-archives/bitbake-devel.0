Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AA8CE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 19:48:25 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18600.1763408899385805770
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 11:48:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WwPHj5cg;
 spf=pass (domain: gmail.com, ip: 209.85.166.169, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4331b4d5c6eso18861235ab.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 11:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763408898; x=1764013698; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGgI3WjJy7BhgbzMlDPV+vx0H0Lx3snES4t9d6gcuLY=;
        b=WwPHj5cg1viVlnQdFFKmR8+7LXNCkRXijE794pSBTowAuswDVWDyCV3Krf4RNpvCdr
         cF7t/GqO0T3t5JNveEsLOnvmDYfUUTdMoajVEcL+OaBg6dU5+yoU9DQbtQZpLNW14vc7
         saasWDlDBnJnm8W58bStozL63qVILUuaqvdrJKIol6m8GGIzR+GQfukEmgHpm69bkehb
         z/2Q3e3exUsynBCvNo4VVAZxxSNfbr+KaChlCremBaWHiPbf4nmNxIqB2q/ahGkerZ1u
         sDbPSybax55Ug3Dt/dBQtYFVdd3F8e2F0Rg/Su+OcII03roYDbg1RkZFLMhrsvBEVU+u
         gU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763408898; x=1764013698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QGgI3WjJy7BhgbzMlDPV+vx0H0Lx3snES4t9d6gcuLY=;
        b=LSPdVZ8W6r+v1MDhj2Tx+Bq8RIoFPaGg2zBXmk1/h3G9x70xZupoQEofuu+noZwB6i
         m7HTm3lOtG7j2blVx0v8i9MDeMh7EwOg4c3MniA8WBptKGAWn5KUY83JqcVPZ2CG88ob
         kUX3QxNRz3kx4NPfnRr5bwvC+helM8kWPZgxsxEqPi5q0KjXLwuV9jCL5F0X/lwtG74A
         4bj8gTvvqkuGyc2Md++WOpDkWJ0fnWocUF+Mdg0ihHeIgP51dJBst1QWxai5oOfgauUH
         yYFKQhzl2Tz+hcQd1DHsepZSFEcO0BNFyj2CGd/3R+Ic91BgKQ/6RefZ18v3H/vka2di
         klBQ==
X-Gm-Message-State: AOJu0YwrnR2mdYbHQJu3sKR9C38vkDLJt5XFl7pzKQMqm6BmFWl8VSEf
	Q3WzXuqsBvh4KMpTbp2G+tOMIrHmo2T6jGQdmD8jeH2eHUZfQK1tDxWqhdJbRg==
X-Gm-Gg: ASbGncuwtUR3BujInBCugX7lVFHf9rC2ZSFbqm7jFAqUhsvq/uB69Uv1V81uL5pC6XG
	nZEadPwvYFKVMsBkY699GEW6x7e2U0zSZ2pZ7OnkOuNR9n2JzYO4lBWLdCKuh1d2b+RDQA+uWf2
	U5bdKm450Qh2ZEDNQraBGThWFcdbhiNHIiZNuoB592au7kFipse3Lp/Fo9IHEbejj7S3CWjJQlk
	usXI/1DAsRHbEs4Nfr0MEgJV2NSNJo47FEaAoJXe2vHp/uSF0R3QLQenKTqQleX+j7FDIuDGwZ3
	x0qjUA94f/Bf26fI+TVoUK9VPMU2oN5+bKuAuJgmZhn5azB5DA+hY19o5Lx7Gk1OkCg3KYJw4le
	+w9aRFw8cYbikKj0Mue1GBTr9o7+A1E6oiOCukfBLF8VGb6GcC3hlSTNzMVYINDa3koVzPd5qTE
	0Ij1oTzNFF
X-Google-Smtp-Source: AGHT+IEnPWsGj6+Ih7byHfsNHNC7EfH+xcgR/0WV7ome5FBUnOC0ha9TLVIw8WlFO65LTitt2ZCOQA==
X-Received: by 2002:a05:6e02:96f:b0:434:a7ce:da4a with SMTP id e9e14a558f8ab-434a7de20damr48715755ab.30.1763408898348;
        Mon, 17 Nov 2025 11:48:18 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::9115])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434839e29a8sm74491765ab.34.2025.11.17.11.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 11:48:17 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] bitbake-setup: Tell the user what to do if they don't like the top dir
Date: Mon, 17 Nov 2025 12:48:05 -0700
Message-ID: <20251117194805.2322020-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113161524.4068231-1-JPEWhacker@gmail.com>
References: <20251113161524.4068231-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 19:48:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18436

If the top level directory look new (e.g. doesn't contain a site.conf
file), then instruct the user on how to choose a different directory if
they desire. This should help clarify what bitbake-setup is about to do
and how to change it if desired.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-setup | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 3a281defa..7e9491fac 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -671,7 +671,16 @@ def create_siteconf(top_dir, non_interactive, settings):
     if os.path.exists(siteconfpath):
         print('A site.conf file already exists. Please remove it if you would like to replace it with a default one')
     else:
-        print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
+        print(f'{top_dir} looks like a new top directory. If you would like to use a different directory, answer "n" below and either:')
+        print('\t1) Pass one or more options to bitbake-setup change the top level directory:')
+        print('\t\tbitbake-setup --setting default top-dir-prefix <PATH> ...')
+        print('\t\tbitbake-setup --setting default top-dir-name <NAME> ...')
+        print('\t2) Change the default bitbake-setup configuration with:')
+        print('\t\tbitbake-setup settings set default top-level-prefix <PATH>')
+        print('\t\tbitbake-setup settings set default top-level-name <NAME>')
+        print()
+
+        print('A common site.conf file will be created, please check it is correct before running builds\n    {}\n'.format(siteconfpath))
         if not non_interactive:
             y_or_n = input('Proceed? (y/N): ')
             if y_or_n != 'y':
@@ -896,7 +905,7 @@ def main():
             settings_func(top_dir, all_settings, args)
             return
 
-        print('Bitbake-setup is using {} as top directory ("bitbake-setup settings --help" shows how to change it).\n'.format(top_dir, global_settings_path(args)))
+        print('Bitbake-setup is using {} as top directory.\n'.format(top_dir, global_settings_path(args)))
 
         d = init_bb_cache(top_dir, all_settings, args)
         args.func(top_dir, all_settings, args, d)
-- 
2.51.1


