Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093B2C54EE9
	for <webhook@archiver.kernel.org>; Wed,  7 Sep 2022 13:48:15 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web08.7882.1662558494306305693
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Sep 2022 06:48:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ALcf39KC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id d5so8778856wms.5
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Sep 2022 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=VqqWXN/VBQE9u/srcABe6VyK0Mjgtvq4ZVC/+0Xm3WA=;
        b=ALcf39KC1U2JdhL3QQ2QHHyK8OHcn6abGgmVKZzuJgbMtdsQgGsVPcKWGf0vb+0Fxj
         D2vosrECy8LC5o9jtSYTyHnrIooWaM7NEkoDHPL0FqpyUY2M5X/mYYXx7sJUce3eNCtd
         8oF970JhlnCelB9umHHH69xmvFRZdgJk5XU1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=VqqWXN/VBQE9u/srcABe6VyK0Mjgtvq4ZVC/+0Xm3WA=;
        b=PFl/NNGuoiMj8z+AsjL4+UDvAq8dk5qOqtu1s9iPfZybgvfcBBlMeBZ3zzFWImdlOq
         uKDUVp7wO/DXV1N5lsZqaOUGWZrF4zWEzX27JOImBvYznF3UMQmTCNdTwEZbPiQiIyrr
         Zheap8XId1S5u+3tT4tltSv0MW2zSNIr0z+RT7bs/YTnfjogzcYnggi7y23nlswyuHwI
         dA2ZDJ61SnsXuRjoLImZDp5fCL3LXutrnb7XPSu4/CgdB5ozc8AXZgCqgUczdx/v2qdw
         JA+r6ZQLNEOT6mC41ADQRw1ZD49fytUO3FQk5gDrnmWx30+wfYPMO2BuODqfK0U4D7XI
         DxlA==
X-Gm-Message-State: ACgBeo1tEyRdwxPEsfvLjOwIwTzw/4P92jaRm1y8DuqtlQ2jokvfvdlV
	eT7ILGznHK4EbZB0y/9be/hUrIyldMvIrQ==
X-Google-Smtp-Source: 
 AA6agR7LSsKQrRru43vji2zuMN5sv+hbwOZ5ONtDlFeH5sTBGU041xm6kXSDVJuw9Ra0XJCQqq2Ylw==
X-Received: by 2002:a05:600c:4e8d:b0:3a5:f7ed:873 with SMTP id
 f13-20020a05600c4e8d00b003a5f7ed0873mr17179119wmq.170.1662558492527;
        Wed, 07 Sep 2022 06:48:12 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:eb69:bb70:edb:6315])
        by smtp.gmail.com with ESMTPSA id
 n19-20020a05600c3b9300b003a846a014c1sm27605155wms.23.2022.09.07.06.48.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:48:12 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Ensure mirror tarballs don't enforce checksum
Date: Wed,  7 Sep 2022 14:48:11 +0100
Message-Id: <20220907134811.565440-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Sep 2022 13:48:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13960

local file fetches now validate checksums. The checksums for mirror
tarballs of repositories will not match so ignore these checksums.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e6dd79c4aa..893ec6f6bd 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -980,6 +980,7 @@ def build_mirroruris(origud, mirrors, ld):
 
                 try:
                     newud = FetchData(newuri, ld)
+                    newud.ignore_checksums = True
                     newud.setup_localpath(ld)
                 except bb.fetch2.BBFetchException as e:
                     logger.debug("Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
-- 
2.34.1


