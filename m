Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380E7C6FA8A
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:30 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.5461.1663079240676361703
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=uP9YsjLi;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.170,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f170.google.com with SMTP id b75so6690634pfb.7
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=4q+21DAOjF8kMoYjP0/X2MrRB7sqDfyCY7Y3L6Wimq4=;
        b=uP9YsjLiwSqO8C0WSs1LiWXMz7hce7XvH0a9b/jLC2jsOYC7v9c6qBN4FwlLUtH0Nv
         o5623w28msb+0jGouKakoeS7zlwEfv3wHb8oBDUw35VlxLXVehaf3JsLAzmcDyCvKtzK
         hV3Ehenmak8w9JkhVSDEkyBK822cSLqnsDepNh+suUDVcneq468ZZgQI0M+P/QQGHIal
         MEyAf0+zleuzl1byCZjYJJ9OS/ZQWiYlBTuOn5PUc70Ufab4OQH0lKUzylCw53yPa1gf
         CtAtc8MvslKljPrKiBB7Lw9xNP2aCmUHtQBnE0aIlt0/tcaWZmApcgG8z+W+eImAOb7M
         17ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4q+21DAOjF8kMoYjP0/X2MrRB7sqDfyCY7Y3L6Wimq4=;
        b=cfMatb5oMuXvfOc536o52G6Ik/MB3McCfzF+GouWy5cpro4XC8xe1+aZwkCE6gqC5v
         TmESGI1h9E0VP4qE5TUyIMj6PdCS4jfNncg7Gwyesl7+F9OJ6UCgqA8jJPOdNFGr9MT6
         y7lU2a49DnGx2r8BN9LQlknql/stC1ZKmoy7qZM1cNoaazLbGk9mWNp9Dgwj/wHpAMIz
         khTOYU/pSnv39umFXcVSuTGf4UHmBRWg+eASXxs9LQQPNSsdzkCIlaZBbC1a+PXHqzo/
         9xQgK2DqVMi7Gzsn9M7KY67PWkIoOnY//kBYCuPPBA6JmuhlmSEsr9S6w+7b7XHzdQl8
         vaCw==
X-Gm-Message-State: ACgBeo1Vh7Az2H7/94gubcc8i8N8P5vQbyMggHWwV9rRQPdlPXpBU64+
	HRIfekFiVwwNghb/04FYttdqmCHjZCRE7es/
X-Google-Smtp-Source: 
 AA6agR570G2rS5BM74YL+XxHB8lAZfLfsxtRWD2QqM5fYotu9RUwpwbt1PUQfpYrQ8zjgz8Eu8BomA==
X-Received: by 2002:a05:6a00:e16:b0:537:40a7:b095 with SMTP id
 bq22-20020a056a000e1600b0053740a7b095mr33312469pfb.64.1663079239524;
        Tue, 13 Sep 2022 07:27:19 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:18 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 08/14] fetch2: gitsm: fix incorrect
 handling of git submodule relative urls
Date: Tue, 13 Sep 2022 04:26:38 -1000
Message-Id: 
 <394bcd8d4b8f596cbfeef7ab9a5b043c209c81dd.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13969

From: Gennaro Iorio <gen.iorio92@gmail.com>

As specified by git submodule manual relative urls can start either
with '..' or './', second case was incorrectly managed leading to an
interpretation of urls starting with './' as absoulte urls.

Signed-off-by: Gennaro Iorio <gennaro.iorio@schindler.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 4a0bd3bcd1f7fc25364df8bbf185ff64881c015b)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index c5c23d52..c1950e48 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -88,7 +88,7 @@ class GitSM(Git):
                 subrevision[m] = module_hash.split()[2]
 
                 # Convert relative to absolute uri based on parent uri
-                if uris[m].startswith('..'):
+                if  uris[m].startswith('..') or uris[m].startswith('./'):
                     newud = copy.copy(ud)
                     newud.path = os.path.realpath(os.path.join(newud.path, uris[m]))
                     uris[m] = Git._get_repo_url(self, newud)
-- 
2.25.1


