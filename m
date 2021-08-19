Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web09.72216.1629391611347417048
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Aug 2021 09:46:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FEoj2fhl;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id e15so5097620qtx.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Aug 2021 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6PDsshDrTPWIVGti+WxeXL/7LkE4lMNOpCtgJ//p6c=;
        b=FEoj2fhlp14jvXW8YL06AIacaoTEBuIWKKypQk5qRBJHnUHLbVZZXIt5QbpbRQgPP5
         LpjHR58PJW156rp07MnPIyv+6GMSszrB1NejghAAUoRYRwMe/26xkEGctMVtL5Q7Mln5
         OWpyiOoAOpinj4xniI8QqG5McpFM/tfQ2Gz+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6PDsshDrTPWIVGti+WxeXL/7LkE4lMNOpCtgJ//p6c=;
        b=Gx9iUS5PCx/5/oA/HjTa5tU4HjPpRCltrAQOKq9o7liBw90l2KWFzduzdQwYvjjs7G
         x/Bi2757/QZ0O5+lXqGtXQPQzLu6fSxmLybGfAI08G+BtqERTKufysgr2zBFT58IJ17/
         kknZ7waTL9sLlfWAOnnGzj8kXwFAwP7VFMU57kGxwjW4u5FvFy9XaOW11r7xubCMAURf
         NvoeVE16Ih3YCjbTSvz2mlnHhRqry+sPx2UQRPnKtb1ekyT9sHW6u0XDFCKygUp5BYO2
         CsUjOOj3M5h/N1cfBbqb21Li38X3kzO9OruzRql+e+t4ftHC4/XhcMuw2VNz/JFEGrbb
         YkJw==
X-Gm-Message-State: AOAM532vOqCMKx46eENtPYzJ7ypdz1R6T7rCEwuIg+D7Z8NdV8BdSXj3
	XbFjXnIWYL8gBt2HK5JbTrsUIxKc7uqQdQ==
X-Google-Smtp-Source: ABdhPJwhjj4WM3qPSMyg9dnmvSEkACTHjqDsnWgUnl/iZudUKJtXF70JILbOfMftc/WKiT/jVhaWjg==
X-Received: by 2002:a05:622a:96:: with SMTP id o22mr13661840qtw.79.1629391610077;
        Thu, 19 Aug 2021 09:46:50 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (192-0-174-222.cpe.teksavvy.com. [192.0.174.222])
        by smtp.gmail.com with ESMTPSA id c27sm1817987qkp.5.2021.08.19.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:46:49 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Paul Barker <paul@pbarker.dev>
Subject: [PATCH v6 0/4] Re-implement prserv on top of asyncrpc
Date: Thu, 19 Aug 2021 12:46:40 -0400
Message-Id: <cover.1629388054.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes replace the old XML-based RPC system in prserv with the
new asyncrpc implementation originally used by hashserv, and add a
read-only mode to match the hash equivalency server's support.

Note that an additional change to the PR export support code in
oe-core is being sent to its mailing list.  That change is also
required for any serious testing, as it resolves another hang
issue in the PR export selftest.

Changes from v5:
  * Added new patch from Joshua Watt to shift asyncio loop creation
    into the new server processes.  This fixes one of the hangs seen
    on the autobuilder.

  * New patch to always create and set the asyncio loop as default
    in both the asyncrpc client and server initialization.  In my
    testing this resolves a couple of different hang issues seen in
    the selftests.

  * Task cleanup on shutdown and exception handler patches from Paul
    dropped from stack, as testing showed the hang issues were not
    helped by the changes.

  * Patch to rebase PR server on asyncrpc code tweaked to split the
    new client code into a separate source file as is done in hashserv.

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

Joshua Watt (1):
  bitbake: asyncrpc: Defer all asyncio to child process

Paul Barker (2):
  prserv: Replace XML RPC with modern asyncrpc implementation
  prserv: Add read-only mode

Scott Murray (1):
  bitbake: asyncrpc: always create new asyncio loops

 bin/bitbake-prserv        |   4 +-
 lib/bb/asyncrpc/client.py |  10 ++
 lib/bb/asyncrpc/serv.py   | 134 +++++++++++++-------
 lib/hashserv/server.py    |   4 +-
 lib/prserv/client.py      |  48 ++++++++
 lib/prserv/db.py          |  65 +++++++---
 lib/prserv/serv.py        | 248 ++++++++++++++++++--------------------
 7 files changed, 319 insertions(+), 194 deletions(-)
 create mode 100644 lib/prserv/client.py

-- 
2.31.1

