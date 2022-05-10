Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA82DC433EF
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:03 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.599.1652205961443775207
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=V8ULt6t7;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id i17so17422302pla.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+Io4D3j4RDNOeBmeMTEp7rcsGajf78di80K2TML4Yk=;
        b=V8ULt6t7Gh7n/LKnI4u0FSPLCb08jpz4oI//kegVWkbz95OlFVMWHXDXV1ROsO4BC3
         Dyl8fXvyOjxM/pDjy/kBx591+ufqDUwDBVQeEdhoPJIl/wfrSAurMdOMwYi+2eYFnJxT
         WZs5YeZ/lsvSiiERIjJq9gwZPTCsunhOcJ5dVM3qHq9c4lxjX1cIx3pXWEDjsrb+BhiH
         KL0w6bwYM5wTKBiUmd0W7NYVHKDBz469le0IJhHeKGGOX7KNxMkKip3MB0DhBtniYc9Y
         HgtFw67CDrfu/WGS/IEGXn+GSAlwBkI1/wCSDJc3PaUSVHGP/27v735IrJj/BVXUxgK5
         cvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+Io4D3j4RDNOeBmeMTEp7rcsGajf78di80K2TML4Yk=;
        b=woAgnARhUdkW6bvKebEvo03zOsZ6Stp6UbblSWdpqMcV2ISfE6sF9/0aumD8PoTLhq
         ru9fA1GQw3Tt5bOqw720cRG5+DQDIfRBKje9LVwy1+NNLeyF5xiApSg+1//uRQeqLQj+
         /Kz5P94UWDeRDhE5ZGPfOmPVZGtdvmOBWwIrp8hMV0HKzhzInPIIoapKOAU1dhmVvwAO
         XjCwdj5ts3gejHPJtEn0hYf2on5FwfzQoblst1tf1ETSKSTC6pdXUGTL6X7mFSwFn0bU
         swv4/afqcKfJsOzRUbnjY1Hi6cEnWjDBNHB02C7X5Irq3zZhjoU9T0ua6t3hAP2Twdnw
         ntiw==
X-Gm-Message-State: AOAM533l4BucqryrfWdgxfjoJNxFcl3OwORXofuFX/M2G9QmGClpxYy/
	RC/hHaUQoFzVqAXr3SQiUF0PX6UZEb9uVfBY
X-Google-Smtp-Source: 
 ABdhPJyO+2fG6dVyvoepeVhIS9GoLhNq+kL6fIWADzLCXId3bPuprfysyK/SSXnfkdFryXP9nrJAJw==
X-Received: by 2002:a17:903:2044:b0:15e:c057:d454 with SMTP id
 q4-20020a170903204400b0015ec057d454mr21413438pla.126.1652205960049;
        Tue, 10 May 2022 11:06:00 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.05.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:05:59 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 00/18] Patch review
Date: Tue, 10 May 2022 08:05:25 -1000
Message-Id: <cover.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13680

Please review this set of patches for 2.0/kirkstone and have comments back by
end of day Thursday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/3642

except for a known intermittent issue on the qemumips-alt test, which
passed on subsequent retest:

https://autobuilder.yoctoproject.org/typhoon/#/builders/102/builds/3028
The following changes since commit c212b0f3b542efa19f15782421196b7f4b64b0b9:

  fetch2/crate: fix logger.debug line (2022-04-15 09:41:19 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/2.0-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Matt Madison (1):
  providers: use local variable for packages_dynamic pattern

Richard Purdie (15):
  tests/parse: Fix one test overwriting another
  server/process: Drop unused import
  ui/buildinfohelper: Drop unused import
  cooker: Drop unused loop
  msg: Drop unused local variable
  buildinfohelper: Drop unused function
  fetch2/crate: Drop unused import
  siggen: Drop pointless break statement
  ui/knotty: Drop pointless pass statement
  persist_data: Use a valid exception for missing implementation
  runqueue: Drop pointless variable assignment
  buildinfohelper: Drop unused variables
  fetch2/osc: Add missing parameter
  runqueue: Fix sig file location when using multiconfig
  fetch/git : Use cat as pager

Robert Yang (1):
  fetch2/ssh.py: decode path back for ssh

Roland Hieber (1):
  cache: correctly handle file names containing colons

 lib/bb/cache.py              |  2 +-
 lib/bb/cooker.py             | 25 ++++++++++++-------------
 lib/bb/fetch2/crate.py       |  1 -
 lib/bb/fetch2/git.py         |  2 +-
 lib/bb/fetch2/osc.py         |  2 +-
 lib/bb/fetch2/ssh.py         |  6 ++++--
 lib/bb/msg.py                |  1 -
 lib/bb/persist_data.py       |  2 +-
 lib/bb/providers.py          |  6 +++---
 lib/bb/runqueue.py           |  3 +--
 lib/bb/server/process.py     |  1 -
 lib/bb/siggen.py             |  1 -
 lib/bb/tests/parse.py        |  2 +-
 lib/bb/ui/buildinfohelper.py | 27 +++------------------------
 lib/bb/ui/knotty.py          |  1 -
 15 files changed, 28 insertions(+), 54 deletions(-)

-- 
2.25.1


