Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19724CD8C9C
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 16:15:30 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27793.1763050528895863790
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 08:15:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=N1eP3+bK;
 spf=pass (domain: gmail.com, ip: 209.85.166.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-93e7e87c21bso41737839f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763050528; x=1763655328; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3CHf5j0Fwi8+LG+0NebuELOBZCMOiDh68Azy91WPyk=;
        b=N1eP3+bKoLRfkKirkOzmGdOXMR/WXjJ0tZRjXoXItrGKOrd3TY15a91TFu24kdqCle
         yM+3kMp2ecXk+hP0m4loZyYrq2s5e/jDJbjhbZC+eUIfCP833GTzUBblmnkQrGIRTOXf
         TayGj467VQtF0WCBh8KXunFyWxehvLGCvVt3P7YTw4LUKKJhwEScR8jboNYvmtzYBo7L
         PjIljCIBzPa6wGqjH/N38yPlKJ+KXNRJgztJISrCEP4iQ7SbNQfhfwCNSjyB1NUTlfm9
         SFuxYLLZNwW14ib3zwUOcvYpQkeexAz4YGc5hZljl4KvibPrSqO2MLPIvBSh/HxkTRaX
         sJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050528; x=1763655328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p3CHf5j0Fwi8+LG+0NebuELOBZCMOiDh68Azy91WPyk=;
        b=u8tkTTY2siECIXivdpbaw8Rb5hEs+wnyRi0ND8TZRqEOXUznCd0pUMCcRzOrnrCHhi
         acTaOuJct69iLkG3PwUT0QB3OK2qawN/gobh5am8Z92x6s+kN/vDXYBBQRqK9XLBdvH1
         j0haMhSHygB5dex6IMKLK+5LbPUqkRDODhdlznB19JdED3MK9jvlGaJWf2GlIuNB44RK
         /waqbKz1JTzgyJYdXrm1qcm7xmF5kEBwjGl/+1fqS05S0kefKbpV9SnjU1cnwnR+9at9
         a/PPaaghzoK09ARgESxb+UOtLxfe5Ra+g3xY2l0huqcRJsoYlSPexGJ/Cd/6+mb76XXq
         BjDQ==
X-Gm-Message-State: AOJu0YxZ1uCBk6Eyf9xXLLp9uGNKMnKjcVbzx7Yjn/EBU00wtyRbuA9p
	Hze4PGVy6VW/Ap6dBptJhTu5C7q1S9bKpnNu4J0IXnYfIwGQmZxls5IHjf8kuQ==
X-Gm-Gg: ASbGnctUIT01GPasdF2y+aef2gasJStr3Oo9ggOLvyyDjto/aW7CE6t4X2JpKmccJ4f
	GX52GUn36o6ugWeD71Ls9AmmiI1oUFwuAzQtiPq61ZIz+wuhaxwhRUfDiz3obzSbyrlsQxe7x/J
	UQQCPKP9lejThOWkUvEGnMtpUrrWzt//1dNci/r6qXF0UtqpWiG2JNqlMkcOU8YhOV441BSAdfx
	j2jnzSIcsHw75iycae6L+dQvd683HqTaZ3ACgJ/xG+DoOEO/WPTtDw7fuNzZbijs2ZFOxlE+rYO
	HVKDME8K7k2PUxfJzNUU7yCNU1E2ziTrz7D+B3H73fpqCzNLA1hjZqZBV6OXmxFP9O7UE/JisIF
	dVHekBVD2g71iA6EzAqyhg0mDRmd2KqkqBJ3dg0C3ARTRvuwt95rMF76oy+OGiP4OPrbTyi5hjQ
	==
X-Google-Smtp-Source: AGHT+IHCzAHvVSea9wvWGDntG7zXY9cvacg5pJsRcqE102fr8aesA7O9175SQ2VJC9YZi/OGXlv7Pw==
X-Received: by 2002:a05:6e02:1c2f:b0:433:74c1:2edb with SMTP id e9e14a558f8ab-4348c866360mr1090235ab.14.1763050527689;
        Thu, 13 Nov 2025 08:15:27 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::51c7])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434833e9102sm7920395ab.8.2025.11.13.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:15:27 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] bitbake-setup: Tell the user what to do if they don't like the top dir
Date: Thu, 13 Nov 2025 09:15:24 -0700
Message-ID: <20251113161524.4068231-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112154121.3750738-2-JPEWhacker@gmail.com>
References: <20251112154121.3750738-2-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 16:15:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18379

If the top level directory look new (e.g. doesn't contain a site.conf
file), then instruct the user on how to choose a different directory if
they desire. This should help clarify what bitbake-setup is about to do
and how to change it if desired.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-setup | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 3a281defa..b54e98ba2 100755
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
-- 
2.51.1


