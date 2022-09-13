Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B73C6FA82
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:30 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web08.5358.1663079233557791317
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=mYcC/rJ3;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id d12so11989904plr.6
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=SbD6Nb0691aKTcJHMUT+bExdrjdTQwBU6QYNP4ZYdk8=;
        b=mYcC/rJ33sPpvXdpYyvL4/646fItVxX0nEAos8vTLUP4vlVGN/vOuCnSFi5pkclmvQ
         /RcztXwiNDrQHcJlLWT1ZkHehrEmbEEq37EjJ1FjfK0F2Qq1NC+fn0dxdM+Z0XDO4Krm
         7qtBHkd8BvXEo6ohHhLVatzRVMznxIMXY1+8/kDa9Y4sm1YDoX95/s5aD4x54Ai9/ZNj
         psvgAatzNdWbkAmIpaZet6ru9emupq4HEfWH0QkrC4hNujyp5vlNajweo2+UsAkiPE0f
         +VqBvj1mjjB5XcdexSiSiOROCH34oe+5lNeJcWpUcTijJ153MbxMx4sS2L7NJTV0A1SC
         G44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SbD6Nb0691aKTcJHMUT+bExdrjdTQwBU6QYNP4ZYdk8=;
        b=VJgjouM8ARS/uFgDm4n2SL/FgVZm7ylIG/Ek1ljuFBQ3QABq/FWOyoJ2fULZj8n8VB
         LfFvW0sl29rUM9fl0Dje49+qOSRRlFNG/ieq0e43ROU0rLAVkAUfLrLVXJa7ukQ1QlTt
         jeZP15wt5EiSrEHm0T6UCT7cU7TVVONekYNkLqavUF/pB/K3ZwGSHeyXh1lgmpCx6K4f
         Vh0qHctotJrpFmzEl1nRctXGgatz/h0VmIFsPcMi+KWmg40pSBNMM7ywfH9LXRdBghCy
         FLD+n5habrSo0TjSiNSE3C80QDi6kGDO7JXMA21N6mb/eJFd3Ev2PEPqmgWa0o4Iuw9K
         zi8w==
X-Gm-Message-State: ACgBeo2whPu8vEUgyyWzJhmPWQ8V21Ew0Bz7MNOBQcZjiZ0KH6Owx/C4
	FqvzLpvLbhdGulnRlMeTeIuvI/AlukQJMWyj
X-Google-Smtp-Source: 
 AA6agR4rc4QuIQuA+Kwq01K6wYHxiGiwtji/4Y41RUQrRFG6swlOrPflMqoCq0LSa9Y4I8d9t1sJUQ==
X-Received: by 2002:a17:90a:fa8e:b0:200:b4b9:c6f3 with SMTP id
 cu14-20020a17090afa8e00b00200b4b9c6f3mr4320019pjb.190.1663079244301;
        Tue, 13 Sep 2022 07:27:24 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:23 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 10/14] fetch2: Ensure directory
 exists before creating symlink
Date: Tue, 13 Sep 2022 04:26:40 -1000
Message-Id: 
 <4f75814ee6580f61a27b71ed9169582e7ddd1559.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13971

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the mirrors code is trying to create a symlink and the
parent directory doesn't exist, as might be the case for sstate
mirrors where the fetch is into a subdir, it can silently fail.

Ensure the directory exists in this case to avoid issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit eff16e474ee7dc49ae433420a4c8d15d3314a618)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ac557176..a3140626 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1097,6 +1097,8 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
 
 def ensure_symlink(target, link_name):
     if not os.path.exists(link_name):
+        dirname = os.path.dirname(link_name)
+        bb.utils.mkdirhier(dirname)
         if os.path.islink(link_name):
             # Broken symbolic link
             os.unlink(link_name)
-- 
2.25.1


