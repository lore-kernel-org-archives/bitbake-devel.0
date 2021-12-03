Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15619C433EF
	for <webhook@archiver.kernel.org>; Fri,  3 Dec 2021 18:27:31 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web12.15566.1638556050120848539
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Dec 2021 10:27:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=ly1nP1Kg;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.43,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f43.google.com with SMTP id
 gf14-20020a17090ac7ce00b001a7a2a0b5c3so5796369pjb.5
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Dec 2021 10:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VKvU+7EUKEEusv9H2iepDmaMAlqoM1W/q8L5fHqHWuA=;
        b=ly1nP1KgVrvvuveh+n667ZO+LpHle/Bt40Co4fK4XfNnGJebTiV4j7dtwXL/xT6T75
         zEYD65aTgAQocwiceFOsj/sd5/sCvV13mzYS9UNF2s9cFgDQYKKSA6MVV4UXpj0BS4/S
         k342VXZwCzqp6p3fV83W+m4crulEr6Vqpb2jl055Or3JN5auEczdespHX6vI8rjHMsIH
         OVrjqx3KHp7OOdpcfX3iLfW229PlXcgQbuY6PmMhigXBnlAD4AVVcV4f9miDevb0iA1F
         HNeZyny7bwwi13nYx7Po9aKKwdQaqGC6SOfOu8luAI+PCDlJGg+WIaNIRzR0V78eRNwB
         SBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VKvU+7EUKEEusv9H2iepDmaMAlqoM1W/q8L5fHqHWuA=;
        b=LScuM9L0TPMtIyFZf9e++Pak8B1eIMTO4jZENEH0+4wJZr5wbNGcV+ElvjMoN8p12A
         7yyJMTcqlMrtACAosIFoM9l/ZxRvWfILsKs7WTA0juLlzSrZjVi9zDvw88d9DXe3nDDE
         MmofqGxMP1bABtGxhlUTjFgn/pY4A/NXKO8tkh1BH1nWwApzYc41x091fuSt2xWxOjPA
         YOpdSA5jHvnCZxpYZf1+GtvVva0yc3/uUkSRl3HyfZII0MhIyx+/pxGOXj8XXXqGnV3T
         jJ6KA7hROIF7oXEk51HjOZslo+LCrZLhNMtkONCNMruLTFEbMPbmOMio4LClekc40fYZ
         8Zug==
X-Gm-Message-State: AOAM53135tFE3ymDISvTFduIk/XPgI4NFabGsYsjxF0V3470zinq5Uj/
	zkX9FqZ1jdM/K95q5Kw92pY04+sAZcmHFE8aiUI=
X-Google-Smtp-Source: 
 ABdhPJyKNQKn6PetcYYM4ipxZzyLct86gwRc7Q3G3AlEtNcWS+RwpTeCIN4yWKS14Wch04U1svku3w==
X-Received: by 2002:a17:902:c245:b0:141:f279:1c72 with SMTP id
 5-20020a170902c24500b00141f2791c72mr24543375plg.18.1638556048936;
        Fri, 03 Dec 2021 10:27:28 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 v1sm3785423pfg.169.2021.12.03.10.27.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 10:27:28 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/2] cooker: Ensure reparsing is
 handled correctly
Date: Fri,  3 Dec 2021 08:27:11 -1000
Message-Id: 
 <92cc71474b4e1b37b81028520c5d1664a4251fc6.1638555853.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638555853.git.steve@sakoman.com>
References: <cover.1638555853.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Dec 2021 18:27:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13128

From: Richard Purdie <richard.purdie@linuxfoundation.org>

From tinfoil, if you edit bblayers.conf and break it, then call
parseConfiguration (e.g. by adding a bad layer with bitbake-layers),
the system doens't show any parse error yet it should.

Add in a call to the updateCache function so that things really
are reparsed when requested.

Partially fixes [YOCTO #14054]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e655f9361b9c3b77906b8e06b5cc76bc5180640e)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cooker.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 000faf82..8d9ca680 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -411,6 +411,8 @@ class BBCooker:
             self.data.disableTracking()
 
     def parseConfiguration(self):
+        self.updateCacheSync()
+
         # Change nice level if we're asked to
         nice = self.data.getVar("BB_NICE_LEVEL")
         if nice:
-- 
2.25.1


