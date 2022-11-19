Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4595BC4332F
	for <webhook@archiver.kernel.org>; Sat, 19 Nov 2022 17:51:38 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.26405.1668880289227084085
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Nov 2022 09:51:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=f6Rs+Cqi;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.169, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f169.google.com with SMTP id 130so7671964pgc.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 19 Nov 2022 09:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSXbPjcmOJ3DYY4TXNIkLElqUZzebLY4h891scQuK0I=;
        b=f6Rs+CqiVg8sAjhB3xnr2vbQAGYdoWsDUk1Mi7R5QC+zjuLlxEDQVSSa/MOVVWyVoo
         XoOW3O/nWki31EFzcxg7J+k2/X73+S/qxyOUrzzJxGLcAdmjxgC3eRljwUcfE/Kha19D
         ZZbfBLQG5/15p+o9tj+6qUGX5V3sdQqngNR7n9/taPfEkItUy45+DTg9LeNbGd+6NeyE
         /hhu5nLBzBCw9BzcPsNEOUtTd8Xml1gLWY72mP6GskFJP+iRyv8GxlCZnhEnoIc8xtmh
         EY71jMqlTa17QeDAx4+AQgKsXbAjBSqa7K9CNOC5wWhALUN+EDFBZs70HuPrRtfPW27T
         OU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSXbPjcmOJ3DYY4TXNIkLElqUZzebLY4h891scQuK0I=;
        b=dL5zGUkH9vJlm3SStbeKW77udAHxjzp4m5pZ9lDiUqKOJoQOr68Akjj6+ThjI+JxoA
         vwrfrl+A7eAAg8VZIoRAGPU4tCY+mk/q4Sn7zYtRrPEG1fTbL1WEYF2kYi709u5tHWSS
         0vYNZcHpHIYyJytFEreMZBFZNNltXqjYNLO91hqoJEaW1Jj0NtgfHFbVa5owajWhmDVa
         4aeag3Iw9NdjahFuG5+X5dqB5CkaI6kppOUxzfZ2yY2fjtoEJFogQwmTMysGzgONwdFw
         hgqKexG0KzjXI2MgW+jl3ybPIUz7F9oV30Lif71vJ6ZJ50oSOoTpCykPXtIh5ePbUFnI
         Jc1A==
X-Gm-Message-State: ANoB5pk+yEphHiK0HdWl7TljKbbdGnRQZd1r6Kc4wRYCtibWULJEVVuL
	2PP+vAOILgYCzLWgjSA0OsqlhyxS6hqFS9KyplY=
X-Google-Smtp-Source: AA0mqf5URO3Apt9SL8syFPxdBrBIk6igekUdMiwruXrc16R1/A9LcrJGDniN0aGUoeA/dxfVPRSwHQ==
X-Received: by 2002:a05:6a00:2908:b0:56b:d738:9b with SMTP id cg8-20020a056a00290800b0056bd738009bmr13208552pfb.61.1668880288266;
        Sat, 19 Nov 2022 09:51:28 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b0017f49b41c12sm6083789plh.173.2022.11.19.09.51.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 09:51:27 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Patch review
Date: Sat, 19 Nov 2022 07:51:12 -1000
Message-Id: <cover.1668880159.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Nov 2022 17:51:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14092

Please review this set of patches for dunfell/1.46 and have comments back by
end of day Tuesday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4512

The following changes since commit 8ea8e443005ad92f4ad264d9abd9e90e33fb5c17:

  tests/fetch: Allow handling of a file:// url within a submodule (2022-10-27 16:38:59 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (2):
  utils: Handle lockfile filenames that are too long for filesystems
  utils: Fix lockfile path length issues

 lib/bb/utils.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1


