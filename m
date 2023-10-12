Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FA1CDB474
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:05 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
 by mx.groups.io with SMTP id smtpd.web10.25770.1697149021876977994
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GGzBr5o8;
 spf=pass (domain: gmail.com, ip: 209.85.160.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1dcfb21f9d9so852287fac.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149020; x=1697753820; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9XBRbyyuD86fToLx+s838Sk0+Yg04PLWM2l0Kl2VNQ=;
        b=GGzBr5o8m1fms95/bg0XL2zmy3m+quIwrAiulffrO9trC0HdKFbxpN/+oTv6hiHh2w
         5D0StE7nnM/rYQPPX6a2dZvjwgl1InuiHWNsSKcpEYqracmf/3lr/u8Qex5qgZftE4Xo
         YsXATWldxH7xzWttWBEkL/qRpQCpWzm8C1OVvW9OTOiAz6SaFcxJaUPwxgjTqq0t8KW3
         tGRtC2SydDvO9oPyElJXB1xlw1he+tf6KOWjRS8DOk37ULbSv1Rea5q3l7tC9jhbLX5m
         BizKmeiCXJ3U+a1bc8lRbNQTzdMfCgnc8WjJekipLKitAXDveNE7VccfAUtQmtwOfdC7
         7B/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149020; x=1697753820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9XBRbyyuD86fToLx+s838Sk0+Yg04PLWM2l0Kl2VNQ=;
        b=jGQ3aaBGFH1h4z373SJn1xuePZJB7RJYI7Y3xXbRhw0Xq3cu5rHgdBKji0X4zg0PJ7
         QkOi/hdRJheBkK+p9+PsyjFzFTjdT1bZ06MUth0NGPQIqyy0Z7AuLvEtMP6k950iuV1B
         sod7nctBCYtRk/jp6j8MWelEI5ensRigTews2GHZQ6041rA/Ge0Uj/TvK+rA7ACo7jsC
         9Uhbagce1Z3pHuNORazntCp8gmqqOgzN7xt7QtJiSsjJ0hGHtRvD72hqx2+GIHiW0A47
         WJs0pjlwIQwMSbFyoObLOk6DOiW9XZhDth7DLq2dxArKu9mVfxGPNyk1zmpByt2F4N+L
         liOA==
X-Gm-Message-State: AOJu0YzEvqMFRm1c78Ix1lWxjjZvDNOzCbHa1j3SwmlnaIBV4qMgxEYh
	2tRnYjqd7iKLTB2RG00y2vgMj9VhcIk=
X-Google-Smtp-Source: AGHT+IHvGh/Zpl9tYxGdbbUpje0NbBpVOdHOxJbibbGqv98OHDSaB5gUEiGlRg+8my2yYRBcejkMjw==
X-Received: by 2002:a05:6870:7d1c:b0:1e9:6566:bc7a with SMTP id os28-20020a0568707d1c00b001e96566bc7amr9343187oab.22.1697149020404;
        Thu, 12 Oct 2023 15:17:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:16:59 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 00/18] Bitbake Hash Server WebSockets, Alternate Database Backend, and User Management
Date: Thu, 12 Oct 2023 16:16:37 -0600
Message-Id: <20231012221655.632637-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003145249.1166276-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15218

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

Joshua Watt (18):
  asyncrpc: Abstract sockets
  hashserv: Add websocket connection implementation
  asyncrpc: Add context manager API
  hashserv: tests: Add external database tests
  asyncrpc: Prefix log messages with client info
  bitbake-hashserv: Allow arguments from environment
  hashserv: Abstract database
  hashserv: Add SQLalchemy backend
  contrib: Update hashserv Dockerfile
  contrib: hashserv: Add docker-compose
  hashserv: Implement read-only version of "report" RPC
  asyncrpc: Add InvokeError
  asyncrpc: client: Prevent double closing of loop
  asyncrpc: client: Add disconnect API
  hashserv: Add user permissions
  hashserv: Add become-user API
  hashserv: Add db-usage API
  hashserv: Add database column query API

 bin/bitbake-hashclient               | 139 +++-
 bin/bitbake-hashserv                 | 129 +++-
 contrib/hashserv/Dockerfile          |  33 +-
 contrib/hashserv/docker-compose      |  11 +
 contrib/hashserv/docker-compose.yaml |  36 +
 contrib/hashserv/requirements.txt    |   5 +
 lib/bb/asyncrpc/__init__.py          |  33 +-
 lib/bb/asyncrpc/client.py            | 120 ++--
 lib/bb/asyncrpc/connection.py        | 146 ++++
 lib/bb/asyncrpc/exceptions.py        |  21 +
 lib/bb/asyncrpc/serv.py              | 354 ++++++----
 lib/hashserv/__init__.py             | 190 +++---
 lib/hashserv/client.py               | 151 ++++-
 lib/hashserv/server.py               | 950 ++++++++++++++++-----------
 lib/hashserv/sqlalchemy.py           | 427 ++++++++++++
 lib/hashserv/sqlite.py               | 391 +++++++++++
 lib/hashserv/tests.py                | 418 +++++++++++-
 lib/prserv/client.py                 |   8 +-
 lib/prserv/serv.py                   |  37 +-
 19 files changed, 2792 insertions(+), 807 deletions(-)
 create mode 100755 contrib/hashserv/docker-compose
 create mode 100644 contrib/hashserv/docker-compose.yaml
 create mode 100644 contrib/hashserv/requirements.txt
 create mode 100644 lib/bb/asyncrpc/connection.py
 create mode 100644 lib/bb/asyncrpc/exceptions.py
 create mode 100644 lib/hashserv/sqlalchemy.py
 create mode 100644 lib/hashserv/sqlite.py

-- 
2.34.1


