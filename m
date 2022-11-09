Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B8AC433FE
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 14:29:51 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web08.3858.1668004189648359962
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Nov 2022 06:29:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=tYXeUEQV;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.44, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f44.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso2039599pjc.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 06:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a19N8rB0m/McO+pkJT7erioxuVvpFC0vJuotjapTKgM=;
        b=tYXeUEQVTe/ILVYqReHN+JZIFsb8FwWsTr1BJntpQCUV3gTDn4MWL37/ZsH4rugCkl
         24ZHtM6zN4RrD9EUDpmv5+TZfRAe7vpLqA7A0p8KoxT3q3WrDwZnbZfBbVVIIpp+Lea6
         99XWBmfRUih50GD549Bg3mB0zX0QUf2nVY8KmDYmGEzW2XYjkJvXVZC+VhiSOD1vWGcL
         2Jgef+gQB5NPKH1Z9qDj1ZfHW0z0/04ytU63c/r0n1HzkO4pyp1n1WzMlCMMQsWWlywV
         9VrhofHIfO/DkMSam6mGFrAfqenaPOoN9U6OFqc2UrXgvj0m7tEuTloatdf6axm0/TQE
         QRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a19N8rB0m/McO+pkJT7erioxuVvpFC0vJuotjapTKgM=;
        b=Sz9lE/reixNTnvj2lzwYuqvdIEdlrp9wsvw84z4VVq41lO67e3I8exdcY5cwSlju7h
         gKl8N6M7uacMwYywjz1AKyCdkBvHmwtct45zehZuaTmBpXtqIoIpONyyyWpk26Ex0Zq/
         I+Q9fcUcDH9Hh+F7xR+QaZOAOoB68YTnfNghbwV0g4ioI5K8j71Z05a6Nv4GWjSIpUCK
         t8aBeRt/oxnx0QiWhOSCS1qwov/CMS8P2a2jpCU8YuInsxCC7aHggZn7zh2mc9CzhaeV
         /gUryDiyo1cs6lMwza52QPG2F7+KblE4gxRtv1M3zucVUdYFn4SNectnOBb+2TCqX3uo
         L0JQ==
X-Gm-Message-State: ACrzQf1kYM5c/0nuGv7Ayljd485QiOY5EGebeUvxitUyUAH+1NI/M7sE
	DYLto05oh4mE7WScRyBPehpOVOMtvehhh1uV
X-Google-Smtp-Source: AMsMyM6P832c42OHckGw8AIj1zoZBT8wZON9HFp4SYtEYWHHMdWl6NTO8EDGZxKTbeiRbf/d4KExHQ==
X-Received: by 2002:a17:902:d2c9:b0:186:f355:a42b with SMTP id n9-20020a170902d2c900b00186f355a42bmr60511310plc.58.1668004188534;
        Wed, 09 Nov 2022 06:29:48 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id nn14-20020a17090b38ce00b00213d28a6dedsm1308611pjb.13.2022.11.09.06.29.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:29:48 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 0/4] Patch review
Date: Wed,  9 Nov 2022 04:29:32 -1000
Message-Id: <cover.1668003926.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 14:29:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14061

Please review this set of changes for 2.2/langdale and have comments back
by end of day Friday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4447

With the exception of a known autobuilder intermittent issue on qemumips64:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=14931

which passed on subsequent retest:

https://autobuilder.yoctoproject.org/typhoon/#/builders/74/builds/6080

The following changes since commit 209f7ba352b60722830157054e3fc56cb9c693eb:

  tests/fetch: Allow handling of a file:// url within a submodule (2022-10-26 23:01:35 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.2-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.2-nut

Justin Bronder (1):
  asyncrpc: serv: correct closed client socket detection

Mark Asselstine (1):
  bitbake: bitbake-layers: checkout layer(s) branch when clone exists

Michael Opdenacker (1):
  bitbake-user-manual: details about variable flags starting with
    underscore

Ross Burton (1):
  fetch2/git: don't set core.fsyncobjectfiles=0

 .../bitbake-user-manual-metadata.rst          |  6 +++++
 lib/bb/asyncrpc/serv.py                       |  4 +--
 lib/bb/fetch2/git.py                          |  2 +-
 lib/bblayers/layerindex.py                    | 25 +++++++++++++++++++
 4 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.25.1


