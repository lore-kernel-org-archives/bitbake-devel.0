Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373B4C6FD19
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 16:47:06 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.24959.1678726016831748181
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Mar 2023 09:46:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=5MvLeQAn;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.42, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f42.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso2088631pjb.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 13 Mar 2023 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112; t=1678726016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gZEDvMj/dsPEeHjEU9CWi4IxbJLYfNCssaygxZOWH4=;
        b=5MvLeQAnlKnv++2o48ZIwtHXCfDH2GjJZK4EOWIgTLwxUxl5x7bFpjqxPTHwcmZ0tU
         H/kkMRwwmI158WZ8vYHncESum3DI8ywC8fk7FfX+VXIWzU7aHa+fOfK4s8YzvBvoWrXE
         2DZGQ3+X4dkHlQgKSPWXHZhgU1f0hJQTzyyFo/OYmDkqe0bo1zrDBv80saaRXQX4wphe
         m3BWw8pG4MvwENFSbqR5CDERl7ZihkMQ4ad6d25oAcO3PTxBPpuISnjujJZ8U5yjybSq
         cKrgWTtl00AouD6mBzBtW9AZfPxvgAEXz6U9ILuTK68H72vUqFP8Jjvwso9dQHRwZxa9
         M5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678726016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gZEDvMj/dsPEeHjEU9CWi4IxbJLYfNCssaygxZOWH4=;
        b=q79Mc2NbEPxR5zYQWUDwElCIDthHmmn45SBgBkRAVJkXmCumrDbtXkv2drZ66S+Hh7
         teuKNGjo64lBdhHwzqsOuZCvfmLAmwYbxavAxDfwZI6JE2sG7IO97aL77/7eKNg2X0q6
         jfZgFeb/sMDWOzZnBLhdWNfR84aLtmUQUrwA1FyO6LMmmQvFcLiED0syTFjI8LaqSS8b
         P37JWGbZFm5gSOVuci2KLxYICbThpv6PCegZZeIx03EFnayx1YEHcL/GguD83Vvf25bI
         xbRgCtA/eIP940O/OWjs1aK09Gq1hJizBtSmH3dxH5Eh5eJsHHK1J3hFoB/QYt/ms/ok
         zPAw==
X-Gm-Message-State: AO0yUKWhOJpf2FZjiVhfnk4kehfqBkuHMe0fz5EsJquGXUd7T1r/U9eQ
	3n5P18xDDvLhJXVLgFJTLoh6OYyHQFZubk+bNtA=
X-Google-Smtp-Source: AK7set9JIS4tcBAebVrdYY3LWshrRBpEylbLRAJP0CNkJ9dJv3qRtDUH9iKbOeD4WuGpBmSS6VMqOA==
X-Received: by 2002:a17:902:b48b:b0:19c:ff5d:1fd2 with SMTP id y11-20020a170902b48b00b0019cff5d1fd2mr7925132plr.8.1678726015639;
        Mon, 13 Mar 2023 09:46:55 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902740300b0019a8530c063sm113690pll.102.2023.03.13.09.46.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:46:55 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 0/5] Pull request (cover letter only)
Date: Mon, 13 Mar 2023 06:46:50 -1000
Message-Id: <cover.1678725774.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Mar 2023 16:47:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14552

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/5030

With the exception of a transient failure on oe-selftest-arm due to a
temporary outage at gitlab.gnome.org.  Passed on subsequent retest.

The following changes since commit 592ee222a1c6da42925fb56801f226884b6724ec:

  siggen: Fix inefficient string concatenation (2023-02-06 04:34:02 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.2-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.2-next

Frank de Brabander (1):
  bin/utils: Ensure locale en_US.UTF-8 is available on the system

Richard Purdie (4):
  utils: Allow to_boolean to support int values
  cookerdata: Remove incorrect SystemExit usage
  cookerdata: Improve early exception handling
  cookerdata: Drop dubious exception handling code

 bin/bitbake          |  3 +--
 bin/bitbake-server   |  5 +++--
 bin/bitbake-worker   |  3 +--
 lib/bb/cookerdata.py | 17 ++---------------
 lib/bb/utils.py      | 19 +++++++++++++++++++
 5 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.34.1


