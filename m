Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F30C61DA4
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 02:38:02 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.4581.1675996680195229238
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Feb 2023 18:38:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=q3Xtofr8;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.51, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f51.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso8359253pjj.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Feb 2023 18:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDDqUSIven7VRYTaciUIEyZN3/ZpzwyD75cnDjgSV6E=;
        b=q3Xtofr8HmiRloOLgNMzy8PQ/djydOjaM3Q2L9eFO0Ia4F5oMK3EqL2CZWrQGGnH3/
         bgc6fzZOLZfjylGvGslD1VqbQ1TsZmTC0rwpLdrXbpYRXlaCKHqbmQI5tJoU/Xl1c7mQ
         HUQ1zILNY32Gtulp7Pw5h3riedSc9jTUHa0/kOyetewT5vY75aXhfPHTP5PQ7m1qvxO0
         25lPCTmL5G+gL+v102GlJ6ZsefPQCKGgE39T7yAT5gx+0DXe3X9bO5OaJHlyRPw/41RY
         ld2zgwjjofs9LsesXHhT8JCwDTrP65TNCzCErxZOx+VZURlbz1DY09aBdXeUWgmra4zQ
         ++eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDDqUSIven7VRYTaciUIEyZN3/ZpzwyD75cnDjgSV6E=;
        b=4p2gd3l1FUQdlWOIsqoZm7areg/KCB2FBbcu9pj+F/Iwyx2v2AHumxIWrGrMAYkla5
         uO+5VyoI33AVRfPiDlzUqLWSgNSEabzx7JKbacB4ho+aeJkVoDte8bd2nFCtwbcn6GcN
         nwnuxR5MLKbIM4BYLp9tzbrIeH6g7vAJQh7B6MX7XVf8aBYrqXj1JBSDTcKdfcFfuwCE
         Ajqe23BH13ynS3LQIekahGAukGKiDQFIL2LNW7aeTJ1lIqFqT/XdZdCKcHOixODu2fR/
         59XzpCtIS+/o3wS9HYwIZfkpjVeARahTzq7b63OZBPY7auyPpwtCxZkKgpXZ64xIvWn9
         LbHg==
X-Gm-Message-State: AO0yUKWEaBIXAGVtostOY2smudJB6Xp5BsWDDhVgquni91SKd+ZvnH2i
	U3bIXS+Y84gT4EwoSpsZUJltsAoReME+vZI6LAw=
X-Google-Smtp-Source: AK7set/i5BRLIgFr1sujeLCn7NhePm8YFd6swmRIb4S48SrHgkPpV4WHes3vvxgEj3kHeC3ft7GRLw==
X-Received: by 2002:a17:90a:7f98:b0:230:f874:3600 with SMTP id m24-20020a17090a7f9800b00230f8743600mr12757832pjl.28.1675996678994;
        Thu, 09 Feb 2023 18:37:58 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id p13-20020a63fe0d000000b004facf728b19sm1974224pgh.4.2023.02.09.18.37.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 18:37:58 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/3] Pull request (cover letter only)
Date: Thu,  9 Feb 2023 16:37:55 -1000
Message-Id: <cover.1675996551.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Feb 2023 02:38:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14390

This should be the final pull request for the dunfell 3.1.23 release.

The following changes since commit c16d364dbf68d2a500fecaf8d6e6d62b11475d9f:

  bb/utils: include SSL certificate paths in export_proxies (2023-02-06 23:42:50 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Charlie Davies (1):
  bitbake: fetch/git: use shlex.quote() to support spaces in SRC_URI url

Marek Vasut (2):
  fetch2/git: Prevent git fetcher from fetching gitlab repository
    metadata
  fetch2/git: Clarify the meaning of namespace

 .../bitbake-user-manual-fetching.rst          |  4 ++--
 lib/bb/fetch2/git.py                          | 20 ++++++++++++-------
 2 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.25.1


