Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C45C4332F
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:17:43 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web11.158477.1698693456422297445
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:17:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Cp/3hwvI;
 spf=pass (domain: gmail.com, ip: 209.85.210.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6c0b8f42409so3353330a34.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693455; x=1699298255; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX3suebB3xk5/vkFS3CoZlXw4vAQiSCXZ15ee6MqFzY=;
        b=Cp/3hwvIhzbl0nwYZbineyLOgEpK47s2qa9ZmdhHwIHGzlXx5JJTGU+592KqWkeMZm
         VLWFEZL5byioeASmZM2o62IUgGCGDFlJGlbxUmIGXL+uk44wtfWif75j5qquy7gw845q
         29kw8pKuEdCyNGA0qo5VqA9B1W/l4RvCROVSKcWf+uwCnITKF+1Fd57UHoMwn5YIxbuf
         1EgprTary24PzIymWJ8qdRj0+etQps12Xj6Ghz3KC0vUhjjiZ+QXPMO1BCBjP5c+8Bfn
         4hP6ybbd12IhbbRRuYvGJRGefh6SArZtJ/i087tL2+8XdG8dBEB77ULgkVGOM44dhLK9
         ALxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693455; x=1699298255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX3suebB3xk5/vkFS3CoZlXw4vAQiSCXZ15ee6MqFzY=;
        b=XEL1rCGYnTHNM2BTYkzLTEsR210bTrppL5G9Y87XqIOZgKX7O4lU1RyeyubP1A2G3i
         h1UzIcBRAZyVIckiKYFhEgKxBqaDFDNLaAJY3yAkgBE6LtP0gUO2CZLsw1RFozFSVhji
         DLS9kRjY+xJUsKkdARMmHyCb12kuRqfkcJDB5z4U/HLIbFs7rhEI0Hn9Qlx0hzi7b07/
         B+2gJO4+jaO3FqBbsATtNADIyw0IYWpZZJJnr/0mRNFKoCme3/cpNaNzApXVR222Waw7
         Sa6GUWOiF0eskQDhvMqCAr2vDphbyy/5XlnkFc1+T05Q5uoAzZt0GqBOQkF22VezXlos
         aUTQ==
X-Gm-Message-State: AOJu0YzX54xCVGBTsPd+GXwwOasXnh6toEdqcfJWPfwrYhkAzhidE6y0
	adIaM0FPY2rlh7wUbnM8g2OILgbsST8=
X-Google-Smtp-Source: AGHT+IHT3huiOUuYvChz/QuIk6bf3QXAZLJXZPLDQhXbPp9qFw8tVBMY1ggsoGUe/dxVBKp+3NNuDA==
X-Received: by 2002:a05:6830:4412:b0:6b9:e35e:8dd with SMTP id q18-20020a056830441200b006b9e35e08ddmr13516176otv.2.1698693455121;
        Mon, 30 Oct 2023 12:17:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:17:34 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 00/22] Bitbake Hash Server WebSockets, Alternate Database Backend, and User Management
Date: Mon, 30 Oct 2023 13:17:06 -0600
Message-Id: <20231030191728.1276805-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:17:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15302

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
 lib/bb/asyncrpc/serv.py       | 354 ++++++++-----
 lib/hashserv/__init__.py      | 190 +++----
 lib/hashserv/client.py        | 151 +++++-
 lib/hashserv/server.py        | 951 +++++++++++++++++++++-------------
 lib/hashserv/sqlalchemy.py    | 427 +++++++++++++++
 lib/hashserv/sqlite.py        | 391 ++++++++++++++
 lib/hashserv/tests.py         | 736 +++++++++++++++++++++++++-
 lib/prserv/client.py          |   8 +-
 lib/prserv/serv.py            |  37 +-
 15 files changed, 3038 insertions(+), 804 deletions(-)
 create mode 100644 lib/bb/asyncrpc/connection.py
 create mode 100644 lib/bb/asyncrpc/exceptions.py
 create mode 100644 lib/hashserv/sqlalchemy.py
 create mode 100644 lib/hashserv/sqlite.py

-- 
2.34.1


