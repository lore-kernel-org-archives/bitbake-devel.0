Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73810E732F7
	for <webhook@archiver.kernel.org>; Thu, 28 Sep 2023 17:05:59 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.web11.18859.1695920758104860455
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Sep 2023 10:05:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gOu/9bJ+;
 spf=pass (domain: gmail.com, ip: 209.85.160.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1dd0526b5easo5457421fac.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 Sep 2023 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695920756; x=1696525556; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7yy0pTNyl7i9xVs9/QrwsJawAxOPGgORqjX1Gd4ugs=;
        b=gOu/9bJ+tJtIgFsaivucenJnHaPkNumN7Z+KfsiZi5phdQ7wXjFr1Tdx196w/vnjgj
         nwO+x/ZaqlJym0agNoSflghRLua1RSfUPX7JxAM3l/2VJRHFoccHcq9Dlt+brVvS7NhK
         nbRkZq90p9VTSjZey9XD5chKMFCa8LHtj8ZfPhuSwoGfm8VzcYUjpQxYRMDNLYvukxh3
         E4twCYRArQgfAPc9MiSR+XhJo+j9CsPE/UMyzaRPo2pQKUWUBUsQQrVizvmcDHKsgPUG
         zHWOt6+2gEFyMCKJWSPuOTyrWL/E9/1pXdsSNYe7hyvXCdgTUT+hYI3+PuCg6i1RGepn
         GaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695920756; x=1696525556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7yy0pTNyl7i9xVs9/QrwsJawAxOPGgORqjX1Gd4ugs=;
        b=CiPTicyUKIFJClZBSSmKzLfPgZqasfNHdmixHZYpZTF60F9WrvNUbbXk0SDYC7UQN6
         F9vRsItZXY22Y4pLCN8K5aNig/g9+W0GssKimTtXJQ2dNvlQFTV61JrlrIXwm1OZUG6c
         pgQMDCtZ5YE6Qiu32OvMu2lAg4tlMOjqfAMn9Yq+ynbU9F5pxO6f/YtIBwyIFjLEW3bQ
         EBM9Gt7ijLVEtHvH9rXf4zOtmgL9EJFLoD3ofmvOsnfb0zWGjOfN86lVnzhoi7qrevA2
         WrSru/wrFo6bnAFo4t1vfOidyNZqHggQV3QnRQYRbiLvyylsQg9y9MFZGUV1Bv5aHGU5
         shdA==
X-Gm-Message-State: AOJu0YzwMuq98C31602cv36bVSpe/GCPpP4mYOcW6OiPS+q764Hy+QAH
	xIh/7RuqirmFZ2jwLzIALATeDHcs1+4=
X-Google-Smtp-Source: AGHT+IEQSAyn0Zi96vB0h58XCoVC+PKQMJ04EBlpHFuXwONakmOtalNs0pfpL3bQKv4iEd89rP/E5Q==
X-Received: by 2002:a05:6870:d60b:b0:1b0:218b:8acc with SMTP id a11-20020a056870d60b00b001b0218b8accmr1994012oaq.7.1695920756256;
        Thu, 28 Sep 2023 10:05:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::f27c])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b001dd533c4bd1sm1389772oal.1.2023.09.28.10.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:05:55 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC 0/5] Bitbake Hash Server WebSockets Implementation
Date: Thu, 28 Sep 2023 11:05:46 -0600
Message-Id: <20230928170551.4193224-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Sep 2023 17:05:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15142

This patch series implements a websockets transport protocol for the
bitbake hash equivalence client. Note that while this uses the
websockets 3rd party python module, its use should only be actually
required if the user wants to use the websocket transport mechanism.

A websocket implementation is not added on the server side, as it is not
desired to add the websocket dependency there. In addition, there are
other server improvements that are desired, such as the ability to use
different database backends which also require other python modules. As
such, the websockets client can be test with the websocket hash
equivalence server implemented here:
https://github.com/JoshuaWatt/bb-hashserver

Joshua Watt (5):
  asyncrpc: Abstract client socket
  hashserv: Add remove API
  bitbake-hashclient: Add remove subcommand
  hashserv: tests: Add external database tests
  hashserv: Add websocket connection implementation

 bitbake/bin/bitbake-hashclient    |  13 +++
 bitbake/lib/bb/asyncrpc/client.py | 173 ++++++++++++++++++++----------
 bitbake/lib/hashserv/__init__.py  |   9 ++
 bitbake/lib/hashserv/client.py    |  30 +++---
 bitbake/lib/hashserv/server.py    |  29 +++++
 bitbake/lib/hashserv/tests.py     |  82 ++++++++++++--
 bitbake/lib/prserv/client.py      |   8 +-
 7 files changed, 262 insertions(+), 82 deletions(-)

-- 
2.34.1


