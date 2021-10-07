Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A2C43217
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 15:06:34 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web09.13168.1633619193465319079
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=cOtkVMh/;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.222.179,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qk1-f179.google.com with SMTP id g21so6225713qki.11
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SlqRBoUJsvd8ckBHYJ0CxVrjYNLgPLBFLxwRwSJDKos=;
        b=cOtkVMh/+MGlLaIMwcshiR3DTusvprtBpLSE8GJcnocrewl1aXdBXtpZuCEPs4fX6u
         ntynSJ0gXgLeE/g/BfRiYbC0xK6dIeDz1q7JTg5EhoCbMC7iR5jB5pwCIkpLZlBbD3ea
         cmsXn83o71sKUQGogU5vMs4k/CYv/dIvxWDZBxImJH5Yt4L3bZ3m3oG3sPB2J+z+CY67
         Ei1p2xq/EkPoe1kwsv8kYslDpMhMUw8lSYeFlLzXE2kPdxceSkp2BUK1Mc+HStZoEX31
         caUh7m6FYZ+hZG7JSkS9G8PstLOkkmveS/vQQlDh6CAOKY/n+dM37Sb5NE3OIUfuYrSf
         SPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SlqRBoUJsvd8ckBHYJ0CxVrjYNLgPLBFLxwRwSJDKos=;
        b=2QQM7bCldvU4+GebEt0OPUqE9rfSmQlzNCswBw1bOokN19d6bWvu3BY19X3o0SDekb
         BOSL2mzvd2TNUHBTeFhViwFRpqTeiv85gyetSmiQp6Kv2RruR3JAzbs9173XzgGhIe7W
         SSgQWOtXnPqdeYdeOq+wMQAqhaCMWyrScj9+xujBKFIp6rDjt+IXFqLKAbFXeYjGNQid
         Tac3rtMtwPvcVfshzRUAMhwDPf7xyStfEONSf8UnvoWn6z3PoAJOz3+SkeL+7QYoW8tY
         IEL1zmbZSuo7gNR3vjkktoT9gHqUqWc7vTk4Ns1UUVHWFSm8wUmabPbPmsvKB5OBJlNt
         Lf5Q==
X-Gm-Message-State: AOAM532TZTkvWAix0Oelgkxg3haZUAD9qlsNWeuvEHivuk+jlQ+MDrIl
	yX8EiD27e/50HqjGyk8uS7crXg==
X-Google-Smtp-Source: 
 ABdhPJwSVPu1uToq6lN9E5DsYA799QJjzo84U4qroIKTMObwbB+Qmt5CKj5oigt6mrkxlA2/+GdkIg==
X-Received: by 2002:a37:bf81:: with SMTP id
 p123mr3790869qkf.439.1633619192675;
        Thu, 07 Oct 2021 08:06:32 -0700 (PDT)
Received: from localhost ([2605:a601:a650:b700:9937:f30b:7d2e:fddf])
        by smtp.gmail.com with ESMTPSA id
 x18sm14001413qkx.94.2021.10.07.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:06:32 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: openembedded-core@lists.openembedded.org,
	docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/8] bitbake:toaster:test: Update SSTATE URL
Date: Thu,  7 Oct 2021 11:06:24 -0400
Message-Id: <20211007150630.22138-3-jdmason@kudzu.us>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211007150630.22138-1-jdmason@kudzu.us>
References: <20211007150630.22138-1-jdmason@kudzu.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 15:06:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12743

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 bitbake/lib/toaster/tests/builds/buildtest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/tests/builds/buildtest.py b/bitbake/lib/toaster/tests/builds/buildtest.py
index 872bbd377510..13b51fb0d8e4 100644
--- a/bitbake/lib/toaster/tests/builds/buildtest.py
+++ b/bitbake/lib/toaster/tests/builds/buildtest.py
@@ -119,7 +119,7 @@ class BuildTest(unittest.TestCase):
         if os.environ.get("TOASTER_TEST_USE_SSTATE_MIRROR"):
             ProjectVariable.objects.get_or_create(
                 name="SSTATE_MIRRORS",
-                value="file://.* http://autobuilder.yoctoproject.org/pub/sstate/PATH;downloadfilename=PATH",
+                value="file://.* http://sstate.yoctoproject.org/PATH;downloadfilename=PATH",
                 project=project)
 
         ProjectTarget.objects.create(project=project,
-- 
2.20.1


