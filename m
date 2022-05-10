Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD8C4332F
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:43 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web10.607.1652205995786449277
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=xDhL2C6Q;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.182,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f182.google.com with SMTP id 15so15262166pgf.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i4JX2FIE8z2GHfYLrQ3C60x4EdVG08opUO5KVHDrXG0=;
        b=xDhL2C6QggGXwSzuz8JlWA8vuL08JKp9rT8/csTQulJlAt51UdqKmjS/WK8A5gWCLI
         kxJll84tqmUHOGc4CRKrDPPpyeVQJxYicxcctvRmVgRagvz4UiTMjWRCchXK66VBCg80
         VoxufZrqg2IJec+9c0JscplHpbSUcl7Q90t+FdBdAEvOa2ckNevdmyY8ddho7D/hxvtU
         9WxOI7MZlIbWbBYeU4ydzNvbQgH6OLvMJaBayAu5OiHI1lsU1RY2cUHaG5yk+VpK7hYw
         ZBWb2ITwiYw/q+nPsyeMyn1Ki2O/0Nj8Bup7HYweJMgIpsO6zOGnRISsWStl8fQplETd
         xX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4JX2FIE8z2GHfYLrQ3C60x4EdVG08opUO5KVHDrXG0=;
        b=uZXngrwFCj2X/ypFA3BP1hRcsClOrpuJEGUIj51LOjTxbcFYx11Po9YoC2zLjeTir+
         0jPDkHGSaEMg7MoHBdQVJd1GuPFpe0VQG9hPW7ygEJztZLdEM6m38ZyDE4Zzio8+9J3s
         b6M2SgSqbUFuBLZ5uqnfK4QwvuDgqM/FWuEk5MpUCuLChf5aIXal5ybIusxQdu3dRfTe
         b4qxob0mvZQOFerECZNpDu5+ZiCFJGk+mdXOp5qFYmRAflSZluxMloKSgQF/RVHkUYtI
         txTE5i7J7lTgplk5N1zJKKXKLekY3hqn42FyF/sa/UUS7eu159trPuPwH3smE3sNOfLY
         Vmpg==
X-Gm-Message-State: AOAM531SafLsXAuwTJMpNyI7MdjbL0yKdLpPXgjNbhtvQRZKw3iJUtst
	J7B6sONHruzXgeAFEhpXAgLKA2oJAggR1B3m
X-Google-Smtp-Source: 
 ABdhPJx6C7aYxPCFhale5P8wRK1Cf+z6h62QcFJUd3qwVbIo2R0RKkaX6/bHGcC7OUyq4A3NQJyZxg==
X-Received: by 2002:a05:6a00:1941:b0:50d:807d:530b with SMTP id
 s1-20020a056a00194100b0050d807d530bmr21469460pfk.17.1652205994688;
        Tue, 10 May 2022 11:06:34 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:34 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 13/18] buildinfohelper: Drop unused
 variables
Date: Tue, 10 May 2022 08:05:38 -1000
Message-Id: 
 <3ca8346167c381a6b6c1db2fb68ca266e87abd74.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13693

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d720dfa40620e64a557edef527148d58fcb1d858)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/buildinfohelper.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index c4ca2677..129bb329 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -496,7 +496,7 @@ class ORMWrapper(object):
             if not parent_path:
                 parent_path = "/"
             parent_obj = self._cached_get(Target_File, target = target_obj, path = parent_path, inodetype = Target_File.ITYPE_DIRECTORY)
-            tf_obj = Target_File.objects.create(
+            Target_File.objects.create(
                         target = target_obj,
                         path = path,
                         size = size,
@@ -561,7 +561,7 @@ class ORMWrapper(object):
 
             parent_obj = Target_File.objects.get(target = target_obj, path = parent_path, inodetype = Target_File.ITYPE_DIRECTORY)
 
-            tf_obj = Target_File.objects.create(
+            Target_File.objects.create(
                         target = target_obj,
                         path = path,
                         size = size,
-- 
2.25.1


