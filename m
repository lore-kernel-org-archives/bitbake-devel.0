Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413B3C64EC4
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 15:10:12 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.85637.1675782609086244198
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Feb 2023 07:10:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=EzhcCLOs;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id ge21-20020a17090b0e1500b002308aac5b5eso9108897pjb.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 07:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xqpizSzM1AkkGmNiKYIAUPg1U6L6t+q83XT4RkmlX0=;
        b=EzhcCLOstq1ev1FVwY9TFc88KxVeP2g1Ue0GfQ0puniPTsT9iF6UoGfHiDHh6328E2
         OK2W/vY4eTzf63V7zx1/YWFGCEWoazmQRZq8u5hliF9L15jjqXHcvwBZEFN+RgKmOe+X
         iEcpykYYfSSHxZH/qQfasak8GRhrjZ0VpAkYgNTV03ZAuz3I585kG17KLx5ziY6Q8CGL
         aLAbeJMu+tGE4dzPUdl0L43T5Nv+1VyVuQ4ZWBMr9KpIOP7XJycwyIBidyDJXm5S9V6P
         Em6mZwsYXvJltrE0Mt0hdjbJRUKEmkQ/2t63MQ9x4BqiFVCUF13XwRaCHKGlDx/aVe9Z
         vnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xqpizSzM1AkkGmNiKYIAUPg1U6L6t+q83XT4RkmlX0=;
        b=3NptjAowDA11t8i/4AT34dLvqGLLEEDGVKEOhEawPy0GsIbMwifVE9TLa98e+qgyGu
         SXU3KXAoOE+bfF71yovM5Dx6XXdQS2qxcjne7daXQEMgZ3nM2iciEoKesZfVdNUlQ5tr
         jusqXK6qiNNc9f+YV7DDSFUy1KwHtlYLCpKtsplfXDMlSvlIgzDmARH7niN/Ex+YG/dO
         21B0vumFaQBKxx4zq8eedDYOXqMw/fA2PMvslhEpifTtU2FBw/S6jnaMidPSFqmN38NY
         pru3+fqjIn2yK0bITyjzd/fMjC0WiyKVs61CFgToF6rN6mufVpjjaQmMtrpE3jFs5Mbg
         arfQ==
X-Gm-Message-State: AO0yUKXxfpvLgIl0uRHMCQjzFhYpEdS2wXcRIFovl6yJsVK06m4RHKkC
	YgBjcV6zwrXBY/F0lzcRAeYoRzioH8c1LJqW5o8=
X-Google-Smtp-Source: AK7set/xjPiIzscBn5rS8KgxbRcMsg1pb+v9dQu5y9cX3CDkf9CoHYIBOASfgMBgQjNGxLTft6FuCQ==
X-Received: by 2002:a05:6a20:9596:b0:b5:ae83:2ba4 with SMTP id iu22-20020a056a20959600b000b5ae832ba4mr2649799pzb.56.1675782608119;
        Tue, 07 Feb 2023 07:10:08 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id g28-20020aa796bc000000b005895f9657ebsm9243444pfk.70.2023.02.07.07.10.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:10:07 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 3/3] fetch2/git: Clarify the meaning of namespace
Date: Tue,  7 Feb 2023 05:09:55 -1000
Message-Id: <d57053915fa9b2f55e477899cae7a3d71bf5c488.1675782497.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675782497.git.steve@sakoman.com>
References: <cover.1675782497.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 15:10:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14383

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
index 37c7bcc8..75e8dd69 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -405,8 +405,8 @@ This fetcher supports the following parameters:
 
 -  *"nobranch":* Tells the fetcher to not check the SHA validation for
    the branch when set to "1". The default is "0". Set this option for
-   the recipe that refers to the commit that is valid for a any namespace
-   instead of the branch.
+   the recipe that refers to the commit that is valid for any namespace
+   (branch, tag, ...) instead of the branch.
 
 -  *"bareclone":* Tells the fetcher to clone a bare clone into the
    destination directory without checking out a working tree. Only the
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b8e00ced..cad1ae82 100644
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


