Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD2BC4332F
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:27 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web11.10715.1698853341441885685
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Fwc/tbRg;
 spf=pass (domain: gmail.com, ip: 209.85.167.178, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b565e35fedso1068663b6e.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853339; x=1699458139; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV21Tc9K7Ycy9sDVTfl2gIoV0yNJO+Q5v06xn+Y7oM4=;
        b=Fwc/tbRgwh7pYkxTGjDi6MOhOIoERfthqKpLuAQ9Ke+UGSTzzciGR/1MByqnKxCjUk
         zNNStIjKj7b7H//aXU85NTfoUXYcBch42bGAJv5jFX+6Gs7Xn/M9LuE+c32B+WhUyRRt
         ZrEtlQwRIfBd4V0Yy2c/4wyzkMlk1q4e/NDQc82bkO7d7Bw+MGTCjt5q0t6GRTg3tu84
         sI2g0GJQ7t2lEFxa6d7j0TPEVIm4yI35cJZRdz3r1zq+CF9D9KGvxBjYqqRxaC66hKE9
         AfLUQB9jfz4uWmkgu4HxKgx7Xk26GenDA0BqVpAudFKLq+pwV3a0ZFXnIGzraGOmRhQs
         dQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853339; x=1699458139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kV21Tc9K7Ycy9sDVTfl2gIoV0yNJO+Q5v06xn+Y7oM4=;
        b=TGykiWAq7UguRoBpVnwmbMAM9l1Hyb3EcUEn8gDeGYOlOVU0i4hhp8O5DYLa25MlgJ
         O4tS8YrH64pFI2bmmUwuUQYOztjwBAOmTfAsVztT1EGU5r5U3jysWd6Z6XFJ3KMckPP/
         loJ4qDUpw0L10PKJhjp2X0mGSMHXbb2IllSB/x94EvKIznz9Y38Fw/r0x36BoER3lDo5
         dFeeL+yGV+6vd1tSyy6/uF+fhb25XmAN7j0B+Fs1hBIjrIZJFtCR/WfkR8QiMKaaGylh
         7C9SNFVHjIy3PdTrsgZ6XGLIcfoOK1f3kP6Bg9MkyA+4GfUPXlIalOjzdcRtplCoJpkC
         qjMA==
X-Gm-Message-State: AOJu0YwEg0iSB3Q+kDJ0gpL94pdmGrOGC+MzIjcjaa/tZzWW0qnt+oAZ
	d2iJxFKF1Gp3LlpyRECS/9tS3qwZfxI=
X-Google-Smtp-Source: AGHT+IHJdfyTiqB9EjWID2+ly/5rzvCmwqv7pZKIjlWORjxOnHe3ufYN3uydup/kHY3u+fRssNIVog==
X-Received: by 2002:a05:6808:6381:b0:3a4:ccf:6a63 with SMTP id ec1-20020a056808638100b003a40ccf6a63mr15776543oib.55.1698853339578;
        Wed, 01 Nov 2023 08:42:19 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:19 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 00/22] Bitbake Hash Server WebSockets, Alternate Database Backend, and User Management
Date: Wed,  1 Nov 2023 09:41:54 -0600
Message-Id: <20231101154216.2758185-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15382

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
V5: Fixed compatibility with Python 3.8

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
 lib/bb/asyncrpc/serv.py       | 359 ++++++++-----
 lib/hashserv/__init__.py      | 190 +++----
 lib/hashserv/client.py        | 147 +++++-
 lib/hashserv/server.py        | 951 +++++++++++++++++++++-------------
 lib/hashserv/sqlalchemy.py    | 427 +++++++++++++++
 lib/hashserv/sqlite.py        | 408 +++++++++++++++
 lib/hashserv/tests.py         | 736 +++++++++++++++++++++++++-
 lib/prserv/client.py          |   8 +-
 lib/prserv/serv.py            |  37 +-
 15 files changed, 3053 insertions(+), 807 deletions(-)
 create mode 100644 lib/bb/asyncrpc/connection.py
 create mode 100644 lib/bb/asyncrpc/exceptions.py
 create mode 100644 lib/hashserv/sqlalchemy.py
 create mode 100644 lib/hashserv/sqlite.py

-- 
2.34.1


