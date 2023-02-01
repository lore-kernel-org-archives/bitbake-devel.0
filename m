Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE0EC636CD
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 14:24:32 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.24676.1675261464914751877
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Feb 2023 06:24:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=kbJEie15;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id m13so6691831plx.13
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 06:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxwoxsvB1u/cAWvsx5xzs1Zvt8jb5yFQryyIIosCh0Y=;
        b=kbJEie15kKeS2omNnRMr0XFFttfXKWrlBIy5wMhL5zF1d4VEolnxb8wK1i6eNXa6Lt
         0gCcnUtWlerEXLkwNIzgdWuK+SvXg7U5qi4Ql/VXnIhfH4LYB4CtwH7/s+8GYcFYC1Vp
         szcuuyCLuUNQUAOvxpgMK5DgebkDvRA9s8vCP15d1GOJ2/Pb2M29AeH0mHZOs3ZZINZD
         VCHISrLLuZmGYlGsjRL1mygbiPBCzJ2NEsr78QGKwjuoe59KC+gul3Ktktg2ClJUW4DI
         lA/vS2m4mJzJZN3WBr41Tjhf7VXP4yAX65GGK4LMFhHh/FaFrYHXac1icF9pZ6iFZO8G
         atFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxwoxsvB1u/cAWvsx5xzs1Zvt8jb5yFQryyIIosCh0Y=;
        b=qieKKuQ32g8lWU6j7NapmGmFgIpQmBXctrBIGgZ7Ep1y+42Nve+CpOU+5TqLlkmyKf
         B0Vu6yFzgm3tUvflkv00XI8eTTvPVpk5UOvCFFc6hkesWnffAnhFffIhUU905oorn3G3
         46quk5Oy+AwA+f3R0NBzu17PNCNl323XAbX+66Q3eVgsquExhkuq5klbDUmMzDlu4f5m
         KyMbvUBxNTIjX36lP7yxmzS20wPhBsHZDGKk5ppdn0pw0PclC6cC0pVMKHbR16I5S4nk
         X9iJwECHEeJCCrTv2XeEp+n2wZ+SpfGTqnbcogzbiBres4D+fv0wF8oZQiST45TD6qYB
         U9Hw==
X-Gm-Message-State: AO0yUKWqpEO2rfP2uLrzmoIQXEFYrS8D+GCSxiTDQYnv05DHN2AdXfFz
	JkkeManLt8jukhTOS3AcLOaso0a6AmFFzjRGj/U=
X-Google-Smtp-Source: AK7set8sRCMDlsQMlRF0r/sRUxAPwKCWW8OW2GtfbHfReH0mB3tzggVJDsDo9j4ayKyJOg1evgMU7Q==
X-Received: by 2002:a17:903:11c7:b0:196:489a:a79f with SMTP id q7-20020a17090311c700b00196489aa79fmr3502422plh.6.1675261463903;
        Wed, 01 Feb 2023 06:24:23 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902744200b00186b7443082sm11788834plt.195.2023.02.01.06.24.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:24:23 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 2/2] fetch2/git: Clarify the meaning of namespace
Date: Wed,  1 Feb 2023 04:24:13 -1000
Message-Id: <a40fc6a3f774bcb28cf72701ac146ceb7ae8061a.1675261340.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675261340.git.steve@sakoman.com>
References: <cover.1675261340.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 14:24:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14367

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
index c80e8e5c..2e3d3251 100644
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


