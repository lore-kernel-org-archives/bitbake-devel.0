Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B2BC4332F
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 22:49:54 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.4754.1670539793380821372
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Dec 2022 14:49:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=s9zeIA4L;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.51, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f51.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so6177128pjs.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 14:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9QKvu2qULAvEMutkhcjOfJMmdU3PWR2iofWF1+5IlY=;
        b=s9zeIA4L2fffGEfihHvFI/z6vOlwYw2uhJGUZpRlYeyvcd8YD2iL2SE/XWot2xuT1N
         keaNr0XM9jLQI0iOIEVdKCPfD0JV4SPAtvirURSYnkTjnBtRlGVFQJ+QIQ9pUYFMuVQj
         6whlnY3WIKyat/OwQf8wLmSTG6W2+r5pfYokswhoBIJx/Rk5+ysoYuqXO/Q+iXnUvJZ3
         JTvRNTQmK963r0iVFOIxWG/JGcS0gmAQRAEhPpPP9WP5t//uRM9MCab9LUwpQ7H1W5sM
         NgdNgne5sq/9D2NNwJLvy7nE2E7eVoY9rm2dBprmkXEed41LmyF1ynDCDxYnbOBSNZ3u
         1RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9QKvu2qULAvEMutkhcjOfJMmdU3PWR2iofWF1+5IlY=;
        b=mQl/e09fAnbdarzGmajFYFr0I0PMbUc6rSZ7Aw72wjYw/wTzp4wKJwnWrrBBwAJ3xv
         Lmg+9v+Op9iPPz5kIOuVCdaJNUEtrHtsakdPzypqAYnGEpUaDDkZ5ZrrncCn5zw9fZ5g
         F8u1endbT1HtMKQIK27FH0N8lWuKUmEw2wSzYV6PYumvGBJBY44QshPt9e8SODK2Qu8e
         r+uvt2kvn6IOYfyf4ehTNS5al6Qsy+Kv3lLIBvknjZCfyIscfrrxPhlz2iMdMre1Rlwx
         zkdyneayZxDlpzLKb8bc5CRIU9al9dG7mcPHVSj7hKsqOqgAq9eCX1fO9nQjewHx0eFm
         l4bQ==
X-Gm-Message-State: ANoB5pmj8AzekOIvejQ8cMX7bhph+9K/PMFEAJDw8HUvqfXtf7xxTA+7
	ewhz8en4Hdh8gXupGAYBLzUH31GNUaB3uddZ043wMw==
X-Google-Smtp-Source: AA0mqf4D55SvajSapsBmaT/I2qPgajJqfL8I66MZnWZh/AHL/vuPruyjp7AR21DiipYMhfAdBTMtGQ==
X-Received: by 2002:a17:902:ce09:b0:189:c02e:fb3e with SMTP id k9-20020a170902ce0900b00189c02efb3emr3909133plg.67.1670539792213;
        Thu, 08 Dec 2022 14:49:52 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902710300b0018963b8e131sm7776336pll.290.2022.12.08.14.49.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 14:49:51 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Thu,  8 Dec 2022 12:49:46 -1000
Message-Id: <cover.1670539712.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 22:49:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14157

The following changes since commit 72a3afd99e8b785cb2a2f687e71a58e08cdd9c74:

  runqueue: Fix race issues around hash equivalence and sstate reuse (2022-11-22 09:21:04 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Pavel Zhukov (1):
  gitsm: Fix regression in gitsm submodule path parsing

 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1


