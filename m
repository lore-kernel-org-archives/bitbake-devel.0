Return-Path: <bhstalel@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E1DD6C291
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 19:58:22 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web11.31207.1732046296558597844
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Nov 2024 11:58:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OvFxxTuu;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: bhstalel@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460a612d867so6264931cf.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Nov 2024 11:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732046295; x=1732651095; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+geYj9ss6C57pBB5iH/uv5OwLrYskBiepcJKzY9VlE=;
        b=OvFxxTuu2A+IBXFFzU8AAje6BijbIgIKNPbpCOi13BfwXr2CHry8V1N1m35UZOVuko
         tI4/x3WwaQ6VG/ydXSqLbptlPO1vRVOoOM6HJukq3BRGCgJtXe6MxLwU2KKQ2ibwd2vv
         blnb+6miav0AR/+BAENP7iO/Ib/MCcDiqUcpsmRp1CZxDDn1n3iGxasAYIW87l05Bf5s
         TwiXX2OI9d4bLDAWIopuShcIrnnHBn6l3RkMpzX4r0v2xGzaOSwRplq6GfXGC26mIGWB
         g8M0GxcfRc9LgOpVw96a7wG8Vrnhf2gqimVPQHmOcIphVJmeskT1eX8BMspFaTEkZHCR
         383w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732046295; x=1732651095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+geYj9ss6C57pBB5iH/uv5OwLrYskBiepcJKzY9VlE=;
        b=mnr+XmRquM+nGYJsRaAgvlUj/8biuPdNvMDI3zRy58g0QoFd2YlxZoPTAx/2hFysK6
         SS8I+HaIHCkJql9zs8uZZQM9W7tqcYYGhJ9BW6s7qeyYfn7y1P/fRiv8+MLgpcBlKzU+
         TH7pi5XCHk9PMTz4ae/GV+zJBV3HYTlGQaAMvM7NftVP4HUQZLn4E+ABe5WRf8b6rllS
         X2sr0Rpf3pIzTz2qSz4qOmpAc4s5pcKGUlvG7em5ovt81r19AXg5FibSPEUK8u3ALJMx
         jZ0kYt93VsnYyhVfavBJTm61O3aWaJUwruM2L1QNIi0eNJgSfiwXgvESyqpXJ4jO9t0P
         3qag==
X-Gm-Message-State: AOJu0Yz4zhSSvOUdX/MwPiddcYXW9kmM9CnKjJvk/kk59oUfSIescL4H
	2ZHrhdPEve/vxkLEHxfup/oBKJKuVwkHSKePHzyuoOOcUWXVQXw2t//YYA==
X-Gm-Gg: ASbGnctCsGd2LWvB0V4eFM3uDihW5M2PL+FdOVA1QERZpN/pg8Uhmc8R65CweNLCwRY
	08N75TuBi1TdMZoadadQlvl929Q4KsBoBXCxXxSeLkApK930xfQbGEuajHpYe/qznDA/QwsqLmD
	SDuovGB03KIKC66psFxI2ZS8wFz+XDziAFbsS/+XAFNZR9HKx0qjneBbYc9aKULFQUIn9CjERzJ
	CfIU4LmtMZS7WzyQiaU0rBJdqKYWl1moNPS4GhRAMDl
X-Google-Smtp-Source: AGHT+IGW5C3Se/DqFwFFavws8P0qbYwozBHE8M3z2FQD2ZSMRrFpZbPyQ8BTULTbSU2WBrTrU9Yf8Q==
X-Received: by 2002:a05:622a:287:b0:461:1fc9:61a3 with SMTP id d75a77b69052e-46363e31109mr91761711cf.9.1732046295235;
        Tue, 19 Nov 2024 11:58:15 -0800 (PST)
Received: from bhstpc.. ([196.176.166.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392ba9967sm15176201cf.25.2024.11.19.11.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 11:58:14 -0800 (PST)
From: Talel BELHAJSALEM <bhstalel@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Talel BELHAJSALEM <bhstalel@gmail.com>
Subject: [PATCH] bitbake-getvar: Catch NoProvider exception
Date: Tue, 19 Nov 2024 20:58:01 +0100
Message-ID: <20241119195801.16071-1-bhstalel@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Nov 2024 19:58:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16813

When the recipe provided by (-r, --recipe) is not found
tinfoil raises an exception that is not catched for
readability, example:

Traceback (most recent call last):
  File "/.../poky/bitbake/bin/bitbake-getvar", line 45, in <module>
    d = tinfoil.parse_recipe(args.recipe)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/.../poky/bitbake/lib/bb/tinfoil.py", line 633, in parse_recipe
    fn = self.get_recipe_file(pn)
         ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/.../poky/bitbake/lib/bb/tinfoil.py", line 550, in get_recipe_file
    raise bb.providers.NoProvider('Unable to find any recipe file matching "%s"' % pn)
bb.providers.NoProvider: Unable to find any recipe file matching "aaa"

Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
---
 bitbake/bin/bitbake-getvar | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 20c0b696f7..a97fdfa719 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -16,6 +16,7 @@ bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)
 sys.path[0:0] = [os.path.join(topdir, 'lib')]
 
+import bb.providers
 import bb.tinfoil
 
 if __name__ == "__main__":
@@ -40,7 +41,10 @@ if __name__ == "__main__":
     with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not quiet) as tinfoil:
         if args.recipe:
             tinfoil.prepare(quiet=3 if quiet else 2)
-            d = tinfoil.parse_recipe(args.recipe)
+            try:
+                d = tinfoil.parse_recipe(args.recipe)
+            except bb.providers.NoProvider as e:
+                sys.exit(f"{e}")
         else:
             tinfoil.prepare(quiet=2, config_only=True)
             # Expand keys and run anonymous functions to get identical result to
-- 
2.43.0


