Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45523C433F5
	for <webhook@archiver.kernel.org>; Sat,  2 Oct 2021 22:28:22 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web09.16293.1633213701525637583
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Oct 2021 15:28:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aYxxWFX4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id b192so9937794wmb.2
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Oct 2021 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzGT++JornGh706qmLJ7ktZtucHQUvG5VlgE4ubQ14s=;
        b=aYxxWFX4VDsFauQd0HKhOiMcjT4sSb9pQsaHTKBWrvqmHBmjkr+MN/+3XW0IvJmgRR
         KoZzdZO74VpiOLmt9RpAwiQfMNAt/38RMdibkThCD2twPwcUMcBZ7N8ERAWHJ6C6/RvE
         6qXvk3VJqTY8l+R4eGdrUuq3+np3oxOUI0F6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzGT++JornGh706qmLJ7ktZtucHQUvG5VlgE4ubQ14s=;
        b=Jb1I9rV/rZHpVJHAswnMxlKXKgAwJuSdmNmAUj34ZbacRV1H9oWQsQrq1LSEinoMKr
         s3eO8iuu1B+4qoiWcQKDbGzBBh5c8xASkXXfKMpbuSHBh5UTd/Cp71e7LFEnrZqmBM87
         4ufqXLQn2HfwnCli7gEIqXlS2GTFH7b9jG4VHE58iRQvMV7r2D9PGgEAkchGI86XZGij
         hIm6WZVhQYAqVooCcgYuTfaNMceTpHJhEWphUNzSfTEfuJfW3BHnQeDyGWN9Pbv/kyMA
         mse+fv0+FcQ5bOCfFuUqA4MuF+IV1CPgbY7f7Hqtm71X1k80YOSrHMcD40JKOhBnkTKm
         +arQ==
X-Gm-Message-State: AOAM532tpLHfrbpx/Un95Adu4FDCM1q8tDgsAQ8jx+Fl97beJ1UlDoFG
	41lEpziAUN8ycanxRsMeDLA0ntwh3mhAzShX
X-Google-Smtp-Source: 
 ABdhPJw4oZkmNUgurqtZYECdsCXbwG25EeYl8NQjUSoOCEhTdCc7dMqrhUatUef4Ml3qCM/ffSQReA==
X-Received: by 2002:a1c:2785:: with SMTP id
 n127mr10675655wmn.155.1633213699790;
        Sat, 02 Oct 2021 15:28:19 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:8657:7fac:b2bf:59a6])
        by smtp.gmail.com with ESMTPSA id e5sm9702669wrd.1.2021.10.02.15.28.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 15:28:19 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data: Ensure functions are defined in a deterministic order
Date: Sat,  2 Oct 2021 23:28:18 +0100
Message-Id: <20211002222818.2283977-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 02 Oct 2021 22:28:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12722

When writing functions into shell scripts, write then in a deterministic
order. This is unlikely to affect anything at runtime but it does change
the signatures of the generated useradd postinst scripts in OE-Core and is
a good thing to be consistent about in general.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 97022853ca..9d18b1e2bf 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -226,7 +226,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
         deps = newdeps
         seen |= deps
         newdeps = set()
-        for dep in deps:
+        for dep in sorted(deps):
             if d.getVarFlag(dep, "func", False) and not d.getVarFlag(dep, "python", False):
                emit_var(dep, o, d, False) and o.write('\n')
                newdeps |=  bb.codeparser.ShellParser(dep, logger).parse_shell(d.getVar(dep))
-- 
2.32.0


