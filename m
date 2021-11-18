Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA18BC433EF
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 16:26:53 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web09.3896.1637252812776066952
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 08:26:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=dDqvr0vC;
 spf=pass (domain: gmail.com, ip: 209.85.167.54,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id z34so28820839lfu.8
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 08:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxBI0RkVLFYV/uBtLbbtrSaXWF6lteCI5VfXNs/VUlQ=;
        b=dDqvr0vCUrrljEBrTdAPhJqLjuhWpP1/LclLVpXaKtx5jxPfvKxQ+36hUzrLw0vtDE
         imgs/UjvwkqwP+XyUsHFbiWPifarLLVNo4FcpAggIaY6Fo2L3CtUvhfa/8E3PsXpsi4t
         gQDd2BsIeoVkBrsLPsLCgb791VLJg+jaTYqEAHyKPNKYdp44I+UqjOoD3URmVeWqxaQC
         kcixfa/uu8t6ddrfsbvuOIymg9kOFkTs3JW0SIY0JXoNF31KFwXZ6jI2W/1oGezzqw55
         ASXnbrlyB05Ll99RwGJa7fb2jg7W+5b4ChqsEtfLqXuqbooqrp9kG/uUdTXG5z0Fytu8
         UHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxBI0RkVLFYV/uBtLbbtrSaXWF6lteCI5VfXNs/VUlQ=;
        b=oIXPxQh/Jp6LNBq97SMkH7U9RKl195lFWa2i9Y5nuYqsuQllNV7pvBfT7W1ukETAsm
         7XrUgRZqruiw84JlTT7TDpabj9wNdQZ/G2GIFGccHmfG8IJ9AOIdKpFWXnzg+Hl4e7Wc
         tBEFmI9QjlbrMBtCL08zzXj4oazpVi0pxxCnLQf2LNztUWcDaiy9JACKTy3vHsmAgRxb
         QHTKs/1VvUx+LMPSZZSLAy1KaTzxgd0MtZSNgWC+uJC0E9/Tre+oj/2NgyUbQlMNAL8J
         37jojZEEYqPKQvRAm7fVJgFuFc7KiiN6QJGXqiJl1ueI7W9qmmgWLOTldJERu8TNbgdd
         tPaA==
X-Gm-Message-State: AOAM533bKtHgb0fObBv8JBkN5O0kqM/DLmYXHpDn1WLk6P4FNR9zuiQY
	BDQirMNhCyvr7LuEB4/8zk5JaKl1Abv/Sw==
X-Google-Smtp-Source: 
 ABdhPJx3cMpOcWG+Cg3kTFUZThlB/2SRgLYIuFXepN2EK+MyCuj7HXYJU+4yLZ2awYoUruylgC2F5w==
X-Received: by 2002:a2e:95cb:: with SMTP id
 y11mr18152167ljh.461.1637252810600;
        Thu, 18 Nov 2021 08:26:50 -0800 (PST)
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se.
 [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id
 p17sm37252lfs.292.2021.11.18.08.26.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 08:26:50 -0800 (PST)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/4] Backport fixes for python 3.10
Date: Thu, 18 Nov 2021 17:26:19 +0100
Message-Id: <20211118162623.3117035-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Nov 2021 16:26:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13068

Backport fixes for running bitbake on Fedora 35, which ships with
python 3.10.

Alexander Kanavin (3):
  bitbake: correct the collections vs collections.abc deprecation
  bitbake: adjust parser error check for python 3.10 compatibility
  bitbake: correct deprecation warning in process.py

Justin Bronder (1):
  hashserv: let asyncio discover the running loop

 lib/bb/cache.py          | 3 ++-
 lib/bb/data_smart.py     | 4 ++--
 lib/bb/persist_data.py   | 5 +++--
 lib/bb/server/process.py | 2 +-
 lib/hashserv/server.py   | 4 ++--
 5 files changed, 10 insertions(+), 8 deletions(-)


