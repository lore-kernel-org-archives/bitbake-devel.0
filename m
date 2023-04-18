Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA9C77B75
	for <webhook@archiver.kernel.org>; Tue, 18 Apr 2023 16:50:04 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.15093.1681836594972915032
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Apr 2023 09:49:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@sakoman-com.20221208.gappssmtp.com header.s=20221208 header.b=hFrusqul;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.51, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2471214cdd3so1387080a91.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Apr 2023 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20221208.gappssmtp.com; s=20221208; t=1681836594; x=1684428594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pQ7Kfki6944bjXyuw6ITCyQWTjXS6MBIzE4DhbCsh4=;
        b=hFrusqulk5RBbevMhIOyWVvM5xt4etjYjY4Y2+pghbb+EyO7ukg0OVadZsJin0wabX
         9+VO+eAqnqnnWI7eSqqtY2SD6Py6YyZjxsmX1DXbaDi8TQ/k4slV/9M0Wv8ziO8HwaUC
         VFyy34tq246blmdiZ68pes4ybt3kxJH79LbYGYeFGeMBlFX/6scrfg14KLVLAt344OER
         D1cKnFQOGAmcGtFuXCweohMyqAIECJ2Ns2clel9a9MaSehbOjEFsEcUja3SmwWJcdFWq
         OFhXCSFJZxtTjEG2JHKWEUYNjKzCiBFCwwZJyy70+9SsJsjzpB5N8ekna6hNEjEYtpv7
         L4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681836594; x=1684428594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pQ7Kfki6944bjXyuw6ITCyQWTjXS6MBIzE4DhbCsh4=;
        b=donirW+/X4J+iXCCA8ZT4IP74PX9H6a8YZJvhsv3W8Bye0Rq6lfxu9N71UPlKH1M7T
         MpQzCq9W74XdT+9CudjTjkKUmRoRQJajVV8fkSQLRGMukhfwvOKAntBCVyY4E6bCqIfk
         J9f96NMo2sT7mlSLV0h0u7ixW/rWIhAykUu0A8kaPajRVhj7BQEtESzhYbq7N1K8n2kq
         4v8eIeeHEyBxuZM11jbUZK85I1HOb6pQ4miZI+NChrTrH57rV1MXBOFMG0+LRwD32T2W
         gcPyRWU980p8WN68oWvew/pmtNoRKiQKPUAnXT3DIogkb+QDi/t02/HoHr56gu5QzhuM
         PUzg==
X-Gm-Message-State: AAQBX9emCBk7mp2wMAyfdGOHFJjX+b2JdjSjVF5pTgHtDatlB3bZtV7f
	ILWVI/C6x5Ju+H3xDCFP5mxr7YiZ5hru4SXLs7k=
X-Google-Smtp-Source: AKy350aa+WEgFpeMwu8uL2uRmbhnjLkuZeSkV1RCJSpbkVkvaDBBti0pIrlw79erWq5hi1VHZi7C4Q==
X-Received: by 2002:a17:90b:1b50:b0:244:9385:807f with SMTP id nv16-20020a17090b1b5000b002449385807fmr236650pjb.44.1681836593935;
        Tue, 18 Apr 2023 09:49:53 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090ac98300b00227223c58ecsm8832513pjt.42.2023.04.18.09.49.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:49:53 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Tue, 18 Apr 2023 06:49:48 -1000
Message-Id: <cover.1681836544.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Apr 2023 16:50:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14716

The following changes since commit 2802adb572eb73a3eb2725a74a9bbdaafc543fa7:

  fetch/git: Fix local clone url to make it work with repo (2023-03-31 04:28:22 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Frank de Brabander (1):
  bin/utils: Ensure locale en_US.UTF-8 is available on the system

 bin/bitbake        |  3 +--
 bin/bitbake-server |  5 +++--
 bin/bitbake-worker |  3 +--
 lib/bb/utils.py    | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.34.1


