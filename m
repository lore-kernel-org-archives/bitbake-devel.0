Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81DCC32771
	for <webhook@archiver.kernel.org>; Fri, 19 Aug 2022 20:59:42 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web11.285.1660942779704172156
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Aug 2022 13:59:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=bNGC/8Wl;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.174,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f174.google.com with SMTP id f4so2738357pgc.12
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Aug 2022 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=hg1uQdZ/S7JS9csHVKffe1ZuJTnpx0gjsNgBuEe7uUA=;
        b=bNGC/8Wl2XoSP0G2+CnO6zkwZbq9I5UYXq8G6imfyI2crm9vCjmGZXRjAp/oakKjlJ
         rfYVjMOdPstMZnRe38B/mpqc/W/b7dz4+Ga6LJ32VSTvKBXaDhzuQC6xa5aLnqJp6kbp
         eia0ZCmb34147dbUyiaBC36VjVVvLG/bKGB3LvXHAkdPQdsEvWYN7z5PqnYwC2YUMdpV
         3g5V8Z/hU9syKGGElPlky9TlhJwqv77w+0T62kANJTuS1zssz7YFiQXvjiGUKD48YN8L
         /gjHQhIW3o7+h/A8wRvu32hlRF1X/S6V2LX5bNoZeeNjkqqq8GQ6i1cu7mLuEci6rB+0
         eCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=hg1uQdZ/S7JS9csHVKffe1ZuJTnpx0gjsNgBuEe7uUA=;
        b=HtnWa9k6npIhGX5QWsT7q/cSSMNebJBA/RH8haTyIGDgkJZ+o8ABbJ3LnDyXToOLFg
         BJshbMGK+mEAgjyyuNOVfzkjF+JQe89IdgTzOEtqjpQIOrsDeUTz42epF05R5PPApL/H
         VAdP5ko3DgQM5oAs4rQCvk0jMkFtAvvSSWd7VvxYQk9OEtl9WLjIPfK8/xeMk8hGVn/k
         0Bt9VI9zLCA1pIxK6Hs9u+pAPOGkB3tF63MKzAEF5VSGtRRTCsOk7/QinslI3xqMkpF/
         gjGiZU1WYZ1ocicy62mRoHTFy1JMeEfde9JophHlK7C5rjOj/pRs52GsQVXEDt2zzXL7
         f0hQ==
X-Gm-Message-State: ACgBeo1KChYrS+DmkJBZXbrlmwU520TBaT0VIH5TYLTUztRjSgrH/cAo
	fm6H1ItAYHM5OaBynd9cKCxEej7RwugdZhSc
X-Google-Smtp-Source: 
 AA6agR65LywR2LIxjLCAO7bLinwuDQFjds4i8+Hz8m/zyVojWrn1jXexoG5lPlUwbHHeaTNFr/wLCQ==
X-Received: by 2002:a63:b07:0:b0:429:411a:ff51 with SMTP id
 7-20020a630b07000000b00429411aff51mr7494726pgl.207.1660942778362;
        Fri, 19 Aug 2022 13:59:38 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 q12-20020a170902dacc00b0017269cc60d7sm3556879plx.214.2022.08.19.13.59.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:59:37 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/2] Patch review
Date: Fri, 19 Aug 2022 10:59:21 -1000
Message-Id: <cover.1660942636.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Aug 2022 20:59:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13905

Please review this set of patches for kirkstone/2.0

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4106

The following changes since commit b8fd6f5d9959d27176ea016c249cf6d35ac8ba03:

  server/process: Fix logging issues where only the first message was displayed (2022-06-26 22:55:33 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/2.0-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Aryaman Gupta (2):
  bitbake: runqueue: add cpu/io pressure regulation
  bitbake: runqueue: add memory pressure regulation

 lib/bb/runqueue.py | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

-- 
2.25.1


