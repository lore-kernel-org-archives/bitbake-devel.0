Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CA5C636D7
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 22:20:21 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.187.1675290018120140412
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Feb 2023 14:20:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=OVaQC3Qq;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.42, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f42.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so23706pjb.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 14:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWrZeB/Xd0+B9SVmrKesxoO7xsGIQAnFNeeXfUbTjVo=;
        b=OVaQC3QqkNWdm28akjzHcyIZQbgy7wyluYbmaywv3PO2vW14OTT8JmIMlR+Aii77MV
         5ajtwprV0oAxEGSpFhsvQEjVs56GI8vBh0gN8Z+yYR2H2cVxYSp4v5nDn03tJbH25SU4
         dKkfnbjUyHQLekRee4pIWRxwTWcwzJA8m/eJYKWJW1NqDkQEWMwYGfbZvUMYeXL8Fo1C
         phP8Np5lKFhUmn8ui7idyrdFC22z1nc19KCaAoQXK0v5FEL8CfADDGLzklpgylsBE+2D
         /rdWyJEfsFbDf/wYSgeCnBmQAr5G7lvLcK2PyzCsSVvSW/WhcWoJgZ2idDxsZUfaGnxB
         BaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWrZeB/Xd0+B9SVmrKesxoO7xsGIQAnFNeeXfUbTjVo=;
        b=e2fbRkgvpJzBrxbafliZuHNUbfLpYPVBoKqo2zrnYYxUoMjBirDo3JbppezSI4LlZi
         nMdUfmre2w8eqibQINFKfMDJChETuzVH2h/u3AvHRrPBenikSwv6OhF5RtMZzzhe7dnO
         s89MGM3cPls91OVLcVbJk2cRffuCkV4h29Cq8oi7S7Gr1mryqdoNTEu/LqUCJcj8eOFs
         fShdjgJucS01yAKb0Lh+B6LECkYW7/5ZFMxQL5uL4CGUFHzpzaxK4dw/adMUfj/EvMGk
         65TCEo3DEm/13BEhWOrNxvtOMsD0bx5jRwkXyOYiLHxsAoFxRYr7dD9TDqvT2JVQpiQk
         qKjw==
X-Gm-Message-State: AO0yUKU96Hhqs84pIBBQIz5ThxBGl3M+jMI7rAM9Tb5m71zimV+fM238
	YkfAI2oPLq9gwwOB+zuzgRLNSv67npKt9u19ils=
X-Google-Smtp-Source: AK7set+a8xTdY8zEaaTgCtXc88o2vHIt2FD12ndi50/pcAuTg1zB0P7j3qyUHcgWnFCXrEfLUmdCvQ==
X-Received: by 2002:a17:902:c94b:b0:194:4196:7dae with SMTP id i11-20020a170902c94b00b0019441967daemr4088957pla.3.1675290017040;
        Wed, 01 Feb 2023 14:20:17 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id iw12-20020a170903044c00b00186acb14c4asm12294049plb.67.2023.02.01.14.20.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:20:16 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 2/2] fetch2/git: Clarify the meaning of namespace
Date: Wed,  1 Feb 2023 12:19:51 -1000
Message-Id: <86f2fa5261da959cda706c794a0047e5e89d4d6b.1675289845.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675289845.git.steve@sakoman.com>
References: <cover.1675289845.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 22:20:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14371

From: Marek Vasut <marex@denx.de>

Namespace in this context means a branch, a tag, etc., clarify
it in the description. Also, fix a typo "a any", replace with
plain "any".

This patch is based of feedback on new applied patch
d32e5b0e ("fetch2/git: Prevent git fetcher from fetching gitlab repository metadata")

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b4999425c812b25cb359d5163d11e3c1b030dc28)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 lib/bb/fetch2/git.py                                     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index e86a4d86..519aec9a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -424,8 +424,8 @@ This fetcher supports the following parameters:
 
 -  *"nobranch":* Tells the fetcher to not check the SHA validation for
    the branch when set to "1". The default is "0". Set this option for
-   the recipe that refers to the commit that is valid for a any namespace
-   instead of the branch.
+   the recipe that refers to the commit that is valid for any namespace
+   (branch, tag, ...) instead of the branch.
 
 -  *"bareclone":* Tells the fetcher to clone a bare clone into the
    destination directory without checking out a working tree. Only the
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 37b2a07d..5fff6966 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -44,7 +44,8 @@ Supported SRC_URI options are:
 
 - nobranch
    Don't check the SHA validation for branch. set this option for the recipe
-   referring to commit which is valid in any namespace instead of branch.
+   referring to commit which is valid in any namespace (branch, tag, ...)
+   instead of branch.
    The default is "0", set nobranch=1 if needed.
 
 - usehead
-- 
2.25.1


