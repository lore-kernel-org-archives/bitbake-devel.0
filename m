Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FB0C43334
	for <webhook@archiver.kernel.org>; Tue, 21 Jun 2022 18:21:16 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.46483.1655835673500309700
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:21:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=CkaYInMl;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.176,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f176.google.com with SMTP id 23so7686646pgc.8
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZeKPePAqVRYS0wp1poAT4NZlkj911TIIZBMtQC5pCc=;
        b=CkaYInMlD/3xv1AE9tJFBd+sc15ve4AljJah0T8U9c/itiEYEVUT9b6rK0cYCyc9ZM
         llxIDNdynxbh22kzd3UOYL/YwnzwmGt+G0zqz8pHoxE5Pcdjk26IltvcWIgVVYRU+ujI
         Rm10gb17hXePZkTjH/om7DyR44dhzKeXJttEzR+6QMGkaNy49A1gp93sQytMl6DE5jWz
         jFcEYvwPrRAibgyP/ocHQ43NIOsCVahKghWb6FQLzNeaaadb+ckvI0BIkHpxKPfdNXvP
         +CgI+32lSdVTy4I0eKdQ1LDo+i5NqWd7s7Yk/C9pT1s4LG2juzoYu3GJTu1f4utnz3tO
         AdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZeKPePAqVRYS0wp1poAT4NZlkj911TIIZBMtQC5pCc=;
        b=XFI8YJXjVnnf4jHv3k6IMqG+DVXxpxoWwB8LxuLQHojwaktyPDXsfw/+/gx8QH6PaD
         FzrPusmY7efJlLw5zoGhXKOAEa7Ab2vkfMIQJp0CA6erhPs5RtZALxnZ7PDuTLRY3TXH
         DtkflyrTLuse4YIZ8MvZs6mqaoVzLEDTmk33hxkgQHmRBrpP2mBa7A8RNjs93Lv/neUG
         UJs/QGXL9aQJjTB0Itr8yzOScl0i46YJG+WISvbF0mCZBi18O/PJLFg1Uygk155ES1EZ
         B+1FheWH+TwOdo678iiMC/7gopg7HFUfvrICofFbeanbg1rQfF6z0bUIkHtNUWxAswv+
         OHeQ==
X-Gm-Message-State: AJIora+kb8yEZzh6j0YzAuzlqF8QXQi0oQs+BolQ/MUc8mY+WSxifQse
	ZgznuKHFbrlrHqWY9V+K192f3a+Z2L0843x9
X-Google-Smtp-Source: 
 AGRyM1tJBF2OG3KLDWQTQLOfgdusP4oGUzLNb4Vl+pCbNTYX+ubKD790/TCZ7hvfbKz3mgTXS4BNDA==
X-Received: by 2002:aa7:930e:0:b0:525:360e:eae9 with SMTP id
 cz14-20020aa7930e000000b00525360eeae9mr4949944pfb.67.1655835672251;
        Tue, 21 Jun 2022 11:21:12 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 t13-20020a1709027fcd00b0016392bd5060sm9755503plb.142.2022.06.21.11.21.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:21:11 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/5] Patch review
Date: Tue, 21 Jun 2022 08:20:56 -1000
Message-Id: <cover.1655835530.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jun 2022 18:21:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13778

Please review this set of patches for 1.46/dunfell and have comments back by
end of day Thursday/

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/3805

The following changes since commit d8c2175f6a7b5fdf111d6a073b2c3dbd3c0b061d:

  fetch2: add check for empty SRC_URI hash string (2022-04-05 20:49:37 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (3):
  server/process: Disable gc around critical section
  tinfoil/data_smart: Allow variable history emit() to function remotely
  bin/bitbake-getvar: Add a new command to query a variable value (with
    history)

Ross Burton (2):
  knotty: display active tasks when printing keepAlive() message
  knotty: reduce keep-alive timeout from 5000s (83 minutes) to 10
    minutes

 bin/bitbake-getvar       | 48 ++++++++++++++++++++++++++++++++++++++++
 lib/bb/command.py        | 12 ++++++++++
 lib/bb/server/process.py |  3 +++
 lib/bb/tinfoil.py        |  4 ++++
 lib/bb/ui/knotty.py      | 11 +++++----
 5 files changed, 74 insertions(+), 4 deletions(-)
 create mode 100755 bin/bitbake-getvar

-- 
2.25.1


