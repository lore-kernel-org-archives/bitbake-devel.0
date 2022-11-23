Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C0BC4332F
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 14:15:25 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.20984.1669212914907332865
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Nov 2022 06:15:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=ZeZH4BXU;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.169, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f169.google.com with SMTP id r18so16833141pgr.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Nov 2022 06:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kaxxp4tkyxwqVWVqJQi6h0im+J/maEUQsImwh3wLe8w=;
        b=ZeZH4BXUd5ExsAZqss5TkOvIvSQ3Tnoe9icJgGeyOqUvffaBS3df9GEZ960yruON1Z
         44siwBKE8Ccx9PcCzg6trHcFvMz0DNWX/k83FVAn32T8C+sEy0JuPA8FxEZhSk54mdZw
         f86XRVsvG8SOKNAqORAfmgB8IzskK/2AF19ZURrlF8+uSfEoa9zMzrxt6k2VAhrhZcRd
         s8Fp8PXmZmT6osXuWxWDsY/tBdimFXlgIcW9JEZHfNwgf1alVz14I87wyqXQGO7NBZo2
         zB6pRX2/XA4FK5fy2uorODlQkgqbOTBZUjjW1B4acfNednNfiUYKMBM44IJxv9V9OCg7
         S9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kaxxp4tkyxwqVWVqJQi6h0im+J/maEUQsImwh3wLe8w=;
        b=vNUTWf8ZGbuhA714oBVGHlX18eUdOkFU8lTvBIxIg9yE4pkcvxu6BG5LdcpvRRB5h7
         mYfJxtCew7qeFZA40yvHbis14tGUCWaCjl6CgixO+xZXVdg0eZCJI6GAByi2MNALsHlM
         R7zV9nE60LyOdLYDiYv5U6z1vSNX6AwjnvnTH8od3yd9xNk15L8563CulAlAvFJH5vzK
         QATukqrjRZhhgMZXgjM2XCAzkFwKxCslaNI3pvg/UPvuq+f7Wk3sLgDXyHkfLYvA0qby
         g7bP9nR+y0umDTbwlAB0C2WlhgsMZfSrC/Hoy/dN+Ap+g48OwvBFlpG8A8dGROYj3vUY
         5kiA==
X-Gm-Message-State: ANoB5pnnbe19PbR6+W6keKTrvO8KlJ7Izd37b4oEPncazxDfhIUfsFJK
	8gVorovyyTq7PBogtjPfdsIAaX+VuGxn+paZUeg=
X-Google-Smtp-Source: AA0mqf6uBlWwvG5z4kc+neAR8E63IX8MBHbJZpHiOQQy5Xh0GvIzdnNDvZToYJF1doKvnarvt2S8cQ==
X-Received: by 2002:a63:444b:0:b0:46f:eb81:c997 with SMTP id t11-20020a63444b000000b0046feb81c997mr10061433pgk.379.1669212913883;
        Wed, 23 Nov 2022 06:15:13 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b0017f8094a52asm14249618pld.29.2022.11.23.06.15.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:15:13 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 0/1] Pull request (cover letter only)
Date: Wed, 23 Nov 2022 04:15:08 -1000
Message-Id: <cover.1669212850.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Nov 2022 14:15:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14104

The following changes since commit 138dd7883ee2c521900b29985b6d24a23d96563c:

  bitbake: bitbake-layers: checkout layer(s) branch when clone exists (2022-11-10 14:43:24 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.2-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.2-next

Richard Purdie (1):
  runqueue: Fix race issues around hash equivalence and sstate reuse

 lib/bb/runqueue.py | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
2.25.1


