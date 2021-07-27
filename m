Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.4429.1627406518042910418
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jul 2021 10:21:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pYjWceUJ;
 spf=pass (domain: konsulko.com, ip: 209.85.160.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f169.google.com with SMTP id a19so10102840qtx.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jul 2021 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gmP3UdMzORZ/wZElAWdBblpg1QQZQWOanQ58W9J8HH0=;
        b=pYjWceUJjO22oqOl5OXM4+xitHmb1Q7gCd0gPTHYWI2JYlPwlbhnHYtHsm8qmTMOlx
         cAc0Iz26wu49YA+RX0NlXjJzigTwf+Z9BVBhU2ep7UHWNbaT8lV8HRXXakbyOQN64wvH
         qKuHSAGczDz7cRwaCY7e+aTiBGYvANrxwmb0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gmP3UdMzORZ/wZElAWdBblpg1QQZQWOanQ58W9J8HH0=;
        b=LbWNlwXI6qvJA5TrkLJuj+EBLMxuVB2ELybHJuzB4K7U8N4r/WZKp0tUkiusCV7PQi
         GzIh32KMZLzGmcnoVrH2opUl1dwjqilB4HtiZ5wV/j2sIh7gysKAm4BDjHqxUnQ/BAfQ
         LY3QW1rV98dSO4VCAztfiVS1f/j4z+kD6bYwV5fVPCB17JKusDimZVZXPeLN6pfqkS83
         l3ZeCzXj1MHteebUfUZnmM45Cwav6UOlKCBBAXNmbihDVyDvZevySaKMFGYgKCiVJwfN
         Knx6BFvL96XzcbRtV/qokPw8XPx2ykJ+GObcvSRW5saJrxFe5gREMEPAq3932afu6dnR
         j35g==
X-Gm-Message-State: AOAM531NC/tOq7aV0Ds9pzW1C+Xru4K5Sc8gE2jx5M8iptrzDm3lTMm6
	PmgFmOJyZfhEVElt0stdj4dC5J94CNQeyg==
X-Google-Smtp-Source: ABdhPJzU4OvHXHUCPp4mJ+wSLe7zwaCzLic9VJNnTsN51UTxdKyesZ54E8oWBIR6rGe2JIMvryEgZw==
X-Received: by 2002:ac8:6611:: with SMTP id c17mr20058123qtp.392.1627406516853;
        Tue, 27 Jul 2021 10:21:56 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (198-84-179-103.cpe.teksavvy.com. [198.84.179.103])
        by smtp.gmail.com with ESMTPSA id f2sm1648719qth.11.2021.07.27.10.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 10:21:56 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Paul Barker <paul@pbarker.dev>
Subject: [PATCH v5 0/5] Re-implement prserv on top of asyncrpc
Date: Tue, 27 Jul 2021 13:21:40 -0400
Message-Id: <cover.1627405824.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes replace the old XML-based RPC system in prserv with the
new asyncrpc implementation originally used by hashserv, and add a
read-only mode to match the hash equivalency server's support.

Changes from v4:
  * Patch 2 updated to conditionalize all_tasks/current_task usage
    from asyncio vs asyncio.Task based on Python version.  This fixes
    running against Python 3.9 where they were finally removed from
    asyncio.Task.

Changes from v3:
  * Scott Murray taking over upstreaming effort from Paul Barker.

  * Dropped patches which are currently applied to master-next, this
    series should be applied on top of the current master-next branch.

  * Patches 2-4 updated by Scott Murray to rebase on top of 3983643
    ("bitbake: asyncrpc: Catch early SIGTERM").

  * Read-only PR server support patch added to stack to get it into
    the review process.

Paul Barker (5):
  asyncrpc: Wait on writers to close with Python 3.7+
  asyncrpc: Ensure that asyncio shutdown is clean
  asyncrpc: Handle exceptions
  prserv: Replace XML RPC with modern asyncrpc implementation
  prserv: Add read-only mode

 bin/bitbake-prserv        |   4 +-
 lib/bb/asyncrpc/client.py |   3 +
 lib/bb/asyncrpc/serv.py   |  38 ++++-
 lib/prserv/db.py          |  65 +++++++--
 lib/prserv/serv.py        | 286 ++++++++++++++++++++------------------
 5 files changed, 243 insertions(+), 153 deletions(-)

-- 
2.20.1

