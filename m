Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web10.6393.1627353487455799352
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 19:38:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=G88vykrb;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id c18so11019235qke.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jul 2021 19:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1FwJAlY7tR23iXVZq8zdVHyczw4a4XV5lo4XkSgskc=;
        b=G88vykrb9AD5tCjSEEIM5rtrhhyZ4kn9dz4MBlLb9qi9baUgFMaiIvEFYgBRN9kCiX
         fiE4xzowrhE78YG9GmrUgcLL14aJequpoah5h7MXkRFAEWP8CtQrpQT0l/EqMPJbMRPM
         Ibnb7FV39rmFXlzSTfhIjXs7akcAhsujTCm1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1FwJAlY7tR23iXVZq8zdVHyczw4a4XV5lo4XkSgskc=;
        b=o72BcPKx5UEgm8s7UOV9ZYz0DUYQ75GgvPE6TAG10qwNmj52djMdtuUky4J6zU9+IU
         Ptsv3F+c2d9m9VrIRgK6sJge6iSdGOmkLxUZw7XFMzoovE66K9uM/dd+I7jxxozMNYvK
         FDL85A8bhAdE5Q0OSXBqkKApebECs9V6F4lUfVUsaWqkDzgbzE8IXybcI8Zm4MNAV5+Z
         FCF8949qcEdt/tiRLayvrxD8n4upbFVGWWEITGpXSAP3TTPoy58quJi6BORowSyZwm5z
         4CEAL06Ul3YmUX2zvd6OEJggxvaLJsa3tG7OkKEH/yrGZDOQ5w1MubPqfq/8VVAC1xaA
         24rg==
X-Gm-Message-State: AOAM533Oj1qKoRVdtMzxIP6O7bR4/z44bTDiDWi0z5PfoLvLlKp2vp1V
	DzJfbdFA0O8gHSdQqnvTcJd6A/6PEoy5lg==
X-Google-Smtp-Source: ABdhPJwLcYZmfOKAHVtIf5/olj8K7ASI8ikrga7kF9Lr1A6SxlwqNrym+IDyHBfLZ9lSHVWG34wJtg==
X-Received: by 2002:a05:620a:70a:: with SMTP id 10mr20446939qkc.177.1627353486398;
        Mon, 26 Jul 2021 19:38:06 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (198-84-179-103.cpe.teksavvy.com. [198.84.179.103])
        by smtp.gmail.com with ESMTPSA id h10sm974887qka.83.2021.07.26.19.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 19:38:06 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v4 0/5] Re-implement prserv on top of asyncrpc
Date: Mon, 26 Jul 2021 22:37:51 -0400
Message-Id: <cover.1627352176.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes replace the old XML-based RPC system in prserv with the
new asyncrpc implementation originally used by hashserv, and add a
read-only mode to match the hash equivalency server's support.

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
 lib/bb/asyncrpc/serv.py   |  34 ++++-
 lib/prserv/db.py          |  65 +++++++--
 lib/prserv/serv.py        | 286 ++++++++++++++++++++------------------
 5 files changed, 239 insertions(+), 153 deletions(-)

-- 
2.31.1

