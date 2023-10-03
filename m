Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C54FE7AD5E
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 14:53:02 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web11.110203.1696344773124958208
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 07:52:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BEcHrpzO;
 spf=pass (domain: gmail.com, ip: 209.85.160.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1e141f543b2so2159114fac.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344772; x=1696949572; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kERUDbZMuSqaX/6J5tLL7e3IUSF0OTjYfBOARC3ACxY=;
        b=BEcHrpzO20Mxlps+LyJkk4M8vctvOX2I8hCvf/Wqhtjg4SB7vBxMWEOc5INda9uuKw
         2yqd3EwIwleo6pfqX97eUF0E/g5AGCmLlvqMwF7XFCnwjlqp6ZcIcLK1C2eaGPVnYPdb
         79eCVQ8iYBDa1lu8/Nos7DFzYbYH8c0BRZ3yhVQ1a06lOtHajHVz+7TjBLZJGkAvK/+Y
         JbjKxafBB9MtFLDgoOM+LxXYnTnciNyDV54OYcS4cjob2ZzAafL9SKuxqmFxlPyqeLWn
         mLP1OEO8b4fBoVPXfhXItjvmHajOzCa/QBiJg30E9bhkjM+uwUMfShFZ0y+75etmOxMp
         i5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344772; x=1696949572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kERUDbZMuSqaX/6J5tLL7e3IUSF0OTjYfBOARC3ACxY=;
        b=VtO4SHhst0m+iI5NFm0S9R1/55+PXfcuBitivr46IYt3UdlpZ+8Fmf6OTJ3Zvd/g0Y
         eNCldP3VCf01czF70Zy5Fu1oOTh7mPJN0rwqNBbpnIQwRfM50MwrLn1VymEsuvXZbf0D
         OaC7HWE7zqc2gWBwEKo9as2u1oPnxeOnciemqO7wgj73NbPvCrZeg7QNA9btSBKbkCyX
         6lOdT/wBj/kHe6aYYAnoO5Vy0iUDF/DHKXTaR39LcnT4eEHhvv80q1vE5nXbtwXrSD+M
         U6m8D93wihrNSgecebOdven3UasYXkbHOTlaIzSYJrolj2zVXH/oakpM3nUikhXSYxW0
         4yZQ==
X-Gm-Message-State: AOJu0YyJI+/dWth1pKq3C4s67GhMNqqMDenTKJrfKMChlrUelseFWMu5
	3QIqi/TIrVV36AY3DNfjc4GDlF6yUEw=
X-Google-Smtp-Source: AGHT+IGLRVPQ1r1HQoAc9KGWW9pQ1CcxuwBA05ZZN41bJ5gtbyF896ircBJFShccHXP2weZKVYjJ8w==
X-Received: by 2002:a05:6870:b688:b0:1dd:5556:2d39 with SMTP id cy8-20020a056870b68800b001dd55562d39mr1431159oab.1.1696344771617;
        Tue, 03 Oct 2023 07:52:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::589])
        by smtp.gmail.com with ESMTPSA id du28-20020a0568703a1c00b001dd2b869a26sm253477oab.17.2023.10.03.07.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:52:50 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 00/12] Bitbake Hash Server WebSockets and Alternate Database Backend
Date: Tue,  3 Oct 2023 08:52:37 -0600
Message-Id: <20231003145249.1166276-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928170551.4193224-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 14:53:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15161

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



Joshua Watt (12):
  asyncrpc: Abstract sockets
  hashserv: Add remove API
  bitbake-hashclient: Add remove subcommand
  hashserv: Add websocket connection implementation
  asyncrpc: Add context manager API
  hashserv: tests: Add external database tests
  asyncrpc: Prefix log messages with client info
  bitbake-hashserv: Allow arguments from environment
  hashserv: Abstract database
  hashserv: Add SQLalchemy backend
  contrib: Update hashserv Dockerfile
  contrib: hashserv: Add docker-compose

 bitbake/bin/bitbake-hashclient               |  49 +-
 bitbake/bin/bitbake-hashserv                 |  87 ++-
 bitbake/contrib/hashserv/Dockerfile          |  33 +-
 bitbake/contrib/hashserv/docker-compose      |  11 +
 bitbake/contrib/hashserv/docker-compose.yaml |  36 ++
 bitbake/contrib/hashserv/requirements.txt    |   5 +
 bitbake/lib/bb/asyncrpc/__init__.py          |  32 +-
 bitbake/lib/bb/asyncrpc/client.py            | 100 ++--
 bitbake/lib/bb/asyncrpc/connection.py        | 146 ++++++
 bitbake/lib/bb/asyncrpc/exceptions.py        |  17 +
 bitbake/lib/bb/asyncrpc/serv.py              | 349 +++++++-----
 bitbake/lib/hashserv/__init__.py             | 137 ++---
 bitbake/lib/hashserv/client.py               |  40 +-
 bitbake/lib/hashserv/server.py               | 525 +++++++------------
 bitbake/lib/hashserv/sqlalchemy.py           | 268 ++++++++++
 bitbake/lib/hashserv/sqlite.py               | 229 ++++++++
 bitbake/lib/hashserv/tests.py                | 123 ++++-
 bitbake/lib/prserv/client.py                 |   8 +-
 bitbake/lib/prserv/serv.py                   |  37 +-
 19 files changed, 1495 insertions(+), 737 deletions(-)
 create mode 100755 bitbake/contrib/hashserv/docker-compose
 create mode 100644 bitbake/contrib/hashserv/docker-compose.yaml
 create mode 100644 bitbake/contrib/hashserv/requirements.txt
 create mode 100644 bitbake/lib/bb/asyncrpc/connection.py
 create mode 100644 bitbake/lib/bb/asyncrpc/exceptions.py
 create mode 100644 bitbake/lib/hashserv/sqlalchemy.py
 create mode 100644 bitbake/lib/hashserv/sqlite.py

-- 
2.34.1


