Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A50C41535
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:21:52 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web10.1605.1698772906994185567
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:21:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=d0NkxOAP;
 spf=pass (domain: gmail.com, ip: 209.85.210.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6cd1918afb2so3441671a34.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772905; x=1699377705; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5pbbquth54vpte/xSeKvvbYGWq8C4eN6cfRRKv8puU=;
        b=d0NkxOAPpL2JtuJLb9ijtzwVKLx9A1vNMfcy+Vd2FZ0YXCOrokxvKFj5uZT63W+ZvV
         zi1j53SwVsfo9HjCobNGnyCvMoHhJfMZ8MZTSLH1eedI59iLPH/sFBdrwGuPI4hQZV4j
         oXEBW8FMgKGAnnyDhJEEz7p29bvkuvWaCcKNLcxhmF6B9Dzf92LNKbutP32i9dfsRZX8
         xGLYBMIaZEZxlsS62K4rRTVbmevmRpKw+0zTgYqi4SzJzKZxuG/ovi73LleooChkiXKT
         LHOQOIIUD5/pBGau2iChd5p98ipmjJZVTTN8ms//wez7d/U09sQUF7Chm5SxHbKSvh/I
         T6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772905; x=1699377705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5pbbquth54vpte/xSeKvvbYGWq8C4eN6cfRRKv8puU=;
        b=Tnvv3ICFlA9BELQQdcQWhg/83ulGh718+Ir3KDIRD2Nk7JVilEJeGUaLAdHK+b2j8z
         v2Rf0LptvDcnFQKOkPFm4hebCnr2nfXGKbhw+VFDVvxrH2kd+ZBT/lAbuCqF4nyVoUi9
         S8tHlEwNelumXJB4eREZATm2e1MHOMrdIx8NRKNmhAp5CuZhTzAzrG9Xz2/Y8n/PIpLG
         VHMKEv7Q3ORWlet6JwdUmMEm3jVJ1s0H6usu/Y9hTiUlDRuD3oi9KvPRb8cqTw01zq7n
         5cxWSEynG6GIZ4kl9w+zYsbwH6Tf1ogv8UC2yVUHwIbAQJZ17ot1W1I/ZczrJp4WRKYU
         8Afw==
X-Gm-Message-State: AOJu0YxmET/ZB9oz5GIgxwRPpCVkB7eARzVSbAm+4LP2Ric7YBlMbAXA
	VKimkalIygRgft/qkmggmIVG28gDglw=
X-Google-Smtp-Source: AGHT+IGVTy7EiMA5GWCRZCreSPkMIB14Duj0KV9aQDYShk8RR+tmuoeKBD9KFxc1NkXXoBj3qKX3fg==
X-Received: by 2002:a05:6830:14d6:b0:6c6:3ea5:cdbf with SMTP id t22-20020a05683014d600b006c63ea5cdbfmr13280973otq.28.1698772905143;
        Tue, 31 Oct 2023 10:21:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:21:44 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 00/22] Bitbake Hash Server WebSockets, Alternate Database Backend, and User Management
Date: Tue, 31 Oct 2023 11:21:16 -0600
Message-Id: <20231031172138.3577199-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:21:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15350

This patch series reworks the bitbake asyncrpc API to add a WebSockets
implementation for both the client and server. The hash equivalence
server is updated to allow using this new API (the PR server can also be
updated in the future if desired).

In addition, the database backed for the hash equivalence server is
abstracted so that sqlalchemy can optionally be used instead of sqlite.
This allows using "big metal" databases as the backend, which allows the
hash equivalence server to scale to a large number of queries.

Note that both websockets and sqlalchemy require 3rd party python
modules to function. However, these modules are optional unless the user
desires to use the APIs.

Also, user management is added. This allows user accounts to be
registered with the server and users can be given permissions to do
certain operations on the server. Users are not (necessarily) required
to login to access the server, as permissions can granted to anonymous
users. The default permissions will give anonymous users the same
permissions that they would have before user accounts were added so as
to retain backward compatibility, but server admins will likely want to
change this.

V3: Remove RFC status; patches are ready for review
V4: Fixed protocol breakage with mixing older and newer clients/servers

Joshua Watt (22):
  asyncrpc: Abstract sockets
  hashserv: Add websocket connection implementation
  asyncrpc: Add context manager API
  hashserv: tests: Add external database tests
  asyncrpc: Prefix log messages with client info
  bitbake-hashserv: Allow arguments from environment
  hashserv: Abstract database
  hashserv: Add SQLalchemy backend
  hashserv: Implement read-only version of "report" RPC
  asyncrpc: Add InvokeError
  asyncrpc: client: Prevent double closing of loop
  asyncrpc: client: Add disconnect API
  hashserv: Add user permissions
  hashserv: Add become-user API
  hashserv: Add db-usage API
  hashserv: Add database column query API
  hashserv: test: Add bitbake-hashclient tests
  bitbake-hashclient: Output stats in JSON format
  bitbake-hashserver: Allow anonymous permissions to be space separated
  hashserv: tests: Allow authentication for external server tests
  hashserv: Allow self-service deletion
  hashserv: server: Add owner if user is logged in

 bin/bitbake-hashclient        | 145 +++++-
 bin/bitbake-hashserv          | 132 ++++-
 lib/bb/asyncrpc/__init__.py   |  33 +-
 lib/bb/asyncrpc/client.py     | 120 ++---
 lib/bb/asyncrpc/connection.py | 146 ++++++
 lib/bb/asyncrpc/exceptions.py |  21 +
 lib/bb/asyncrpc/serv.py       | 356 ++++++++-----
 lib/hashserv/__init__.py      | 190 +++----
 lib/hashserv/client.py        | 147 +++++-
 lib/hashserv/server.py        | 951 +++++++++++++++++++++-------------
 lib/hashserv/sqlalchemy.py    | 427 +++++++++++++++
 lib/hashserv/sqlite.py        | 391 ++++++++++++++
 lib/hashserv/tests.py         | 736 +++++++++++++++++++++++++-
 lib/prserv/client.py          |   8 +-
 lib/prserv/serv.py            |  37 +-
 15 files changed, 3034 insertions(+), 806 deletions(-)
 create mode 100644 lib/bb/asyncrpc/connection.py
 create mode 100644 lib/bb/asyncrpc/exceptions.py
 create mode 100644 lib/hashserv/sqlalchemy.py
 create mode 100644 lib/hashserv/sqlite.py

-- 
2.34.1


