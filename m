Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D51EC43219
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 23:30:17 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web12.52.1668382210015956533
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Nov 2022 15:30:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ppMJPzTs;
 spf=pass (domain: gmail.com, ip: 209.85.215.182, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f182.google.com with SMTP id b62so8904328pgc.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 13 Nov 2022 15:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hCS9TojtQ1k52g/vNOk+wIAWV6x5sOHKJAGTtGLTf8w=;
        b=ppMJPzTs556BxWGS2YiA9Lq9NoKQ8be/RjNZ9BpcHVHLUrQLMa9a3RCVIYfaSrWtc9
         BJ4CiVNVs01s4w0w/a2UG6JTiKrEEE1vO5CZK2retb8ei9+5u44Kso2s+00EmXPwTnKd
         FCqpYV44YUwP9peuiOVoCfqwq7Z+oRucdobiyandMC9aswHVy2naaixiFWqwZt0AQ0E5
         +JSJuEEhwPVB4d5ACczHPxgwvNUGs6L4cBKz0YEMaIinpS1kKxCpA7SUu9elXaqwyiNe
         qduq+6EOVN2DcRRqyI8sT2Hbd5w1LBcz+KFqvYiFm+fDYhmjRXoJONhcIxtISMx0uNXg
         Bcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCS9TojtQ1k52g/vNOk+wIAWV6x5sOHKJAGTtGLTf8w=;
        b=U0pax02QxlybzoLMyNhDQQI+b9y3wmKAWIuMhtVknbGZykYxxqtv/zGzFLB8Z0gzgR
         j4IJTej/LATRsrgR0wWs6654V+Zs8Q0wdxeEOkkvcdjtnuDniMYgDAEIYJcCY2oh9o/1
         MaCLAE6WTcNpHD1YpkUDKDQH2cbh1s4afae5CvTPrRW/IEBprl4E8WQD9tJ9na7ITc+i
         54Nlb+pl6RwWDa5JaQIONb16XMd112dgT8i/an4KLibBzFFzkeSWY4ktL9dEdwMCPxhP
         7/mce/UeOqKUFdFJ8khpFrC9/dGd3geeps+n2yKDS71xW/mXxr3ox3aW63GBDRM/8A2y
         eGHQ==
X-Gm-Message-State: ANoB5plw/xLuzHE+1RZdRwqNE01zmqiSCDGMO8HzkYPio6AQPVxRjGPJ
	RqwWwBYty4akCVbMZjaopXcztsiph4Sc3Q==
X-Google-Smtp-Source: AA0mqf5Jh/K/WFsNDtklrdidqL7JirLzU7lsvrBMdRFpaRimqL0qgcjRTNQq6znk4FZaSLhJf7bkLQ==
X-Received: by 2002:a63:5d0d:0:b0:470:8922:6f08 with SMTP id r13-20020a635d0d000000b0047089226f08mr9608106pgb.142.1668382208588;
        Sun, 13 Nov 2022 15:30:08 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:4998:ee9c:6c85:68ed])
        by smtp.gmail.com with ESMTPSA id c129-20020a621c87000000b00561b3ee73f6sm5404438pfc.144.2022.11.13.15.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 15:30:08 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [PATCH 0/3] toaster: update fixtures
Date: Sun, 13 Nov 2022 15:30:00 -0800
Message-Id: <cover.1668381699.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 13 Nov 2022 23:30:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14077

This series updates the lib/toaster/orm/fixtures to the currently supported releases.
Dunfell is commented out in gen_fixtures.py because it currently crashes:
  Bitbake crash
  Traceback (most recent call last):
    File "/home/usersetup/poky/bitbake/lib/bb/ui/toasterui.py", line 337, in main
      buildinfohelper.update_and_store_task(event)
    File "/home/usersetup/poky/bitbake/lib/bb/ui/buildinfohelper.py", line 1267, in update_and_store_task
      assert identifier in self.internal_state['taskdata']
  AssertionError

  If you want to try dunfell see: 
     https://git.yoctoproject.org/poky-contrib/log/?h=timo/toaster-fixtures
     https://git.openembedded.org/bitbake-contrib timo/2.2-toaster-fixtures

The following changes since commit 94e49b9b9e409c29eb04603b1305d96ebe661a4b:

  data_smart: allow python snippets to include a dictionary (2022-11-10 14:43:03 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib timo/2.2-toaster-fixtures-v2
  http://cgit.openembedded.org/bitbake-contrib/log/?h=timo/2.2-toaster-fixtures-v2

Tim Orling (3):
  toaster: fixtures/README: django 1.8 -> 3.2
  toaster: fixtures/gen_fixtures.py: update branches
  toaster: Add refreshed oe-core and poky fixtures

 lib/toaster/orm/fixtures/README          |  2 +-
 lib/toaster/orm/fixtures/gen_fixtures.py | 19 ++++--
 lib/toaster/orm/fixtures/oe-core.xml     | 30 +++------
 lib/toaster/orm/fixtures/poky.xml        | 80 +++++-------------------
 4 files changed, 39 insertions(+), 92 deletions(-)

-- 
2.34.1


