Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14203.1794493164417973693
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Nov 2026 06:19:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aeLRCcJ6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c505186727fso439522766b.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 06:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794493162; x=1795097962; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fVCQvd5+rtMV5DG/R8oJBel/CDnTkLmMflBL73+rI2Y=;
        b=aeLRCcJ6cQcd52sEH3+jvjXRo6Aqn7yU7NtiIy42KVKSU0KJmMAZM5Fuy1qS1GAtGI
         5TkySpsQouhaP2tZPIn3p3mJU+3KsO/vvkhHs5BxIPVMI+1CBDDzKtx1iWAXafrPz1x2
         /uXXEWcsKw0GTPAljZ1ENKcgtpzvmWSxMqBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493162; x=1795097962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fVCQvd5+rtMV5DG/R8oJBel/CDnTkLmMflBL73+rI2Y=;
        b=dxbqDzKjUmamb29gFup6XFgvx7KikddgZgORDq1WCUE2FEZmZY2ByjCDyW1CH3YNqN
         1jdeh5dbuQrxt8YmP1Jqg8WhQFRdORgGG5dqWl5DXy6RRDwPDraST/abVTip67OFNcuI
         ldtdDRBt2YxAcuYAhZt8yICOWU25V6iRbdaFPwD5YTvBQtf7kNjGcBBmbh3vQB5dsM0T
         hUUD39cSbkX9XODqch2xsk63nhv6p0wyQDbzgIrwevAh5WfJ12oDBmZCL6TiOqDF+1L4
         A3dG/oJq0RaBxBfHi0Q66ZfmqHhV+lyjVS+IRWeKg2LWwCGajFfUi/Fbx3RrPZxY3cK+
         +rSA==
X-Gm-Message-State: APuU4Z8q3xfyqvTUwvYgC8tDd5qYlYWeISAgmWHO/nJWv7YTe71p8fH8
	fx+poTyXcmt6n5YZO5NVcc5dHJK/x1gWZsrWzwwyZxOyx7cC1ac2DT40wt9qxY4PSHQEQuEibaC
	gImM3gxM=
X-Gm-Gg: AYBFou2XdKn1e4hDLcfPIj5ri6WrTN/WngQofnWGt88OsSed+g5mZFGSwIPWYNopHpd
	wsZsWh21tEk+q9a4j3BYHlhoFCFD98tA3YMKzeUQQ0sLrHWhD37qkG2Id3szfP4uewV6UhHdrdT
	IgxGXYEzcjj1rz0IxLA/vbLKBb8va9+okrfrsmbarLYz3SxdGO0lw4TBBMtf2q+O8Qt4s5LWiNa
	DrXYDbSTVuAyYLvB4sqzueUhLRdWLG2cuaXke1vS3epIh9sPa35NJg0QMTXUsuMnYM7x+muvtb6
	+VI4+DolIxemF24DfFbm/GvdQEd7YONR0mBxxTQJf0Jou5o7R8+GdztsfiTAWLBVfXbC+fF3yZC
	jtoTBPpEHMoWdYKkiUYsGwE8bJdXYEzumunt73n+xk5a38w6xUyYJs/2k2aEiWBozgQAtPPDOly
	mnWRxQ4AapZUqrXhnXYT3O75hTTfov5135zvLq3abtVKVtw7rv5p4jpGN2XtygIOUTygynrJfMr
	SbcAcKVZ9fkVpKSu/9Ll5/X7ylAK2mGgLgW6bqjP7Lt5vSoeSghFFN42pz7iXfy3vlNnZbcmrH/
	b9F4E8J0RAlE4GbnRJ7YLvgs8o4aTJlprHLp5zALs/FpHb2bnZaRf72Rkg==
X-Received: by 2002:a17:906:9c86:b0:c50:5996:5b89 with SMTP id a640c23a62f3a-c5066b3aa67mr493121566b.23.1794493162392;
        Thu, 12 Nov 2026 06:19:22 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1562:9f61:e354:1b51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bc9asm15864841f8f.29.2026.11.12.06.19.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:19:21 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] Revert "bitbake-setup: catch unexpected exceptions and show a clean error message"
Date: Thu, 12 Nov 2026 14:19:20 +0000
Message-ID: <20261112141920.3340431-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 14:19:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20424
Content-Type: text/plain; charset="utf-8"

This reverts commit 9fb6b0011bae34a7c1feb53281e13364d85ddee8.

When things fail, having a traceback is helpful and we're seeing cases such
as exceptions within exceptions where it is hard to tell why things are breaking.

I'd rather have debug data than not. Asking the user to rerun with --debug is hard
for example in CI and isn't how we do things in other areas.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-setup | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 02a7257a515..27c7da146b6 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1458,21 +1458,13 @@ def main():
 
         logger.info('Bitbake-setup is using {} as top directory.'.format(top_dir))
 
-        try:
-            if args.func == init_config:
-                init_config(top_dir, all_settings, args)
-            else:
-                d = init_bb_cache(top_dir, all_settings, args)
-                args.func(top_dir, all_settings, args, d)
+        if args.func == init_config:
+            init_config(top_dir, all_settings, args)
+        else:
+            d = init_bb_cache(top_dir, all_settings, args)
+            args.func(top_dir, all_settings, args, d)
 
-            save_bb_cache()
-        except (SystemExit, KeyboardInterrupt):
-            raise
-        except Exception as e:
-            if args.debug:
-                raise
-            logger.error(str(e))
-            sys.exit(1)
+        save_bb_cache()
     else:
         parser.print_help()
 
