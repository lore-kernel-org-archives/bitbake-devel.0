Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A3EC54F46
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:08 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.7439.1650460946168808984
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QMQ/FDwL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id c10so2276420wrb.1
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=G1flh5HXMK62lZGkrqe57PczKhRCq7n0oKGcHLpbzu0=;
        b=QMQ/FDwLYO2PBjor2LTFqCCp0LUxKcCZK/GtNIVe6dzqhq/rJwzGq2p+6FltsqzJ7h
         KCGqMcO+cCleiaY1mHOx40hY+y8tmmkYXB0ure/KHUR3ND4YbHJoKjAtF6ehTCTCk09Q
         JpsDDj+QXHUseu2xbmW6a6zWFXIDJpR7llqV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G1flh5HXMK62lZGkrqe57PczKhRCq7n0oKGcHLpbzu0=;
        b=IhmP8253vf3XR7hbw+eZNVcTobUwgIHHUiWO1C0LcdiGymX+FGkMnzTL6lgZSHLv01
         ph92MA5gZ5nAc5K4+VutrgR6cGsHDm6tcIDfgT4sxhU7tphyJ2e3nANsC+J1XIdJwYyb
         BRC5b6tR1R8Xv3yEx0frZ7cfVUZ7FOP4pyt2KDws6E00d0hicoyMOWd8i9sobBB3CfcC
         xi3mtMoLeIAn5gUhx82iNWSZm/BNusPe+q2kZfrGPhF+rBzvgk1t8wH+3xVAE+fMlKMt
         8R0x/tUMwVq9cWd6R8yQSdWgDgfPziHuye/oksA6FRu4+Gqx5OC0ja96/JSrq9wz99Lq
         fd5w==
X-Gm-Message-State: AOAM533sHdWz/waz/C3Q96mg36Id7YjlYEz5JvqlyTK0GM+hyFU5gHrY
	vtibNviyDi5Dia4ob1NLgEDXkFZaMHWoCw==
X-Google-Smtp-Source: 
 ABdhPJwi+BPkpyw2nMEaVq5AVFhYlJB5TqPFDuAP02kMKrQ17R69E+b51+xqmGVUusP4G5ItjDbAIg==
X-Received: by 2002:a5d:4085:0:b0:207:b13e:e8dd with SMTP id
 o5-20020a5d4085000000b00207b13ee8ddmr15527910wrp.557.1650460944265;
        Wed, 20 Apr 2022 06:22:24 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b00207982c7f4dsm15213265wrr.67.2022.04.20.06.22.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 11/11] buildinfohelper: Drop unused variables
Date: Wed, 20 Apr 2022 14:22:05 +0100
Message-Id: <20220420132205.2530591-11-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
References: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13653

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/buildinfohelper.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index c4ca267783..129bb329c3 100644
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
2.32.0


