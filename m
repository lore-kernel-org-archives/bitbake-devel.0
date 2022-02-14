Return-Path: <daniel@qtec.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E450C433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Feb 2022 12:32:03 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.32882.1644841920958920492
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Feb 2022 04:32:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qtec.com header.s=google header.b=ghdc9LiQ;
 spf=pass (domain: qtec.com, ip: 209.85.218.47, mailfrom: daniel@qtec.com)
Received: by mail-ej1-f47.google.com with SMTP id d10so37050772eje.10
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Feb 2022 04:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G2ovASVy3vWCvaS6K+2AJqY4izPJGyFWPoa+McmAf+Y=;
        b=ghdc9LiQQLddD7H3Z6b1M+4fPq9Esoh7xcB4LGd6jz3ku0gBRpqHX2Z1cO5upZy3lR
         jXJZYU4s6t+IBdhLvycDDsvww/k/8eJkPsgck0XuKfWZdscglwK9Jd25HawZKdJl8WO+
         LoXkKgyhWCTEs2IysicCnWj4r8ghQnTgxmRDSYnzNEXNEKF/z4PkIdn2VMAV0lEcneJj
         Racy6egb+6xgbH/GeIyu2nXE6pt2CrucINm1kAWBXCyGqrIN83ghqzE27JvVxzs5VjO8
         xAY1GCT+5+JuPvbyeMQFPQzEiXKP1bngY4oZl7U7Z3CJTKliJetnJAsVxyCxw8WjkwRy
         u0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G2ovASVy3vWCvaS6K+2AJqY4izPJGyFWPoa+McmAf+Y=;
        b=KzIEMlj1kR8if1HvKQMbQYkL3i+7hqogoodblg03SsD6X/rN8Cq0su1GfdaVwCEt1f
         64MiJx92MNOm6OIpNbE7MLuXX0qoMAbmTXCWLIt/eg0Pd06GwgJN/spHWzq2C3nbMskG
         20+kdUZoJrMQh+0hB+yZ8MN2ZwFpvhIcE20NX/e5DG1je3PusVlQEOpO9/ZIS5nMkDol
         Vru6dVvhJGJEfSR8hxPPa4bY6N3g0AsytY/f9vn2KMlqs3AxPDFJG7lpT2CiZ5iAd7zx
         XZ2ojCyW+nqt50FZ90b1ktJs5E5UsN/2HLzPuvuBBq0qvNd8Fh2lv4Zv2HxXICGfSS5h
         W4pg==
X-Gm-Message-State: AOAM531xMWtMQtRWZIIlHW+0fKkp6UTFFylJ4wnmDjtfILXkflhUZwYN
	KfoDtSNrnU4SCnC58hD5HGJEGCldA/x/P+uo1xZ+CMRBuiIwPNoB6idvRBs6TwO/8POoyIQDcaK
	eRtQfJsuTZG5I6lCx3gfm7I3OWZRVmgMkak1NJxYnm0JIv+V9hhNIeESafgHznuQaeBZX6SzJW0
	pT05KHgps=
X-Google-Smtp-Source: 
 ABdhPJwFEDSf1P13ODPyLuRc6iy5aH0XagjBZEzvwyPegFvdKbwPCSNXbRyiBbT3Wbcy7ZANQKeroQ==
X-Received: by 2002:a17:907:6d9b:: with SMTP id
 sb27mr11328212ejc.85.1644841918446;
        Mon, 14 Feb 2022 04:31:58 -0800 (PST)
Received: from datops.qtec.com (cpe.ge-3-0-8-100.ryvnqe10.dk.customer.tdc.net.
 [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id
 w22sm10533357ejc.137.2022.02.14.04.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 04:31:58 -0800 (PST)
From: Daniel Gomez <daniel@qtec.com>
To: bitbake-devel@lists.openembedded.org
Cc: dagmcr@gmail.com,
	Daniel Gomez <daniel@qtec.com>
Subject: [PATCH] contrib: Fix hash server Dockerfile dependencies
Date: Mon, 14 Feb 2022 13:31:39 +0100
Message-Id: <20220214123139.355759-1-daniel@qtec.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Feb 2022 12:32:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13345

When building the Hash Equivalence server Dockerfile, some
dependencies are missing in order to run the hash server properly:

Traceback errors:

Traceback (most recent call last):
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
    ret = main()
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
    server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
  File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
    from . import server
  File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
    import bb.asyncrpc
ModuleNotFoundError: No module named 'bb'

Traceback (most recent call last):
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
    ret = main()
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
    server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
  File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
    from . import server
  File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
    import bb.asyncrpc
  File "/opt/bbhashserv/lib/bb/__init__.py", line 128, in <module>
    from bb import fetch2 as fetch
  File "/opt/bbhashserv/lib/bb/fetch2/__init__.py", line 1930, in <module>
    from . import git
  File "/opt/bbhashserv/lib/bb/fetch2/git.py", line 70, in <module>
    import bb.progress
  File "/opt/bbhashserv/lib/bb/progress.py", line 14, in <module>
    import bb.build
  File "/opt/bbhashserv/lib/bb/build.py", line 27, in <module>
    from bb import data, event, utils
  File "/opt/bbhashserv/lib/bb/data.py", line 36, in <module>
    from bb import data_smart
  File "/opt/bbhashserv/lib/bb/data_smart.py", line 23, in <module>
    import bb, bb.codeparser
  File "/opt/bbhashserv/lib/bb/codeparser.py", line 26, in <module>
    import codegen
ModuleNotFoundError: No module named 'codegen'

Traceback (most recent call last):
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
    ret = main()
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
    server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
  File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
    from . import server
  File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
    import bb.asyncrpc
  File "/opt/bbhashserv/lib/bb/__init__.py", line 128, in <module>
    from bb import fetch2 as fetch
  File "/opt/bbhashserv/lib/bb/fetch2/__init__.py", line 1930, in <module>
    from . import git
  File "/opt/bbhashserv/lib/bb/fetch2/git.py", line 70, in <module>
    import bb.progress
  File "/opt/bbhashserv/lib/bb/progress.py", line 14, in <module>
    import bb.build
  File "/opt/bbhashserv/lib/bb/build.py", line 27, in <module>
    from bb import data, event, utils
  File "/opt/bbhashserv/lib/bb/data.py", line 36, in <module>
    from bb import data_smart
  File "/opt/bbhashserv/lib/bb/data_smart.py", line 23, in <module>
    import bb, bb.codeparser
  File "/opt/bbhashserv/lib/bb/codeparser.py", line 32, in <module>
    from bb.pysh import pyshyacc, pyshlex
  File "/opt/bbhashserv/lib/bb/pysh/pyshyacc.py", line 13, in <module>
    import bb.pysh.pyshlex as pyshlex
  File "/opt/bbhashserv/lib/bb/pysh/pyshlex.py", line 17, in <module>
    from ply import lex
ModuleNotFoundError: No module named 'ply'

Traceback (most recent call last):
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
    ret = main()
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
    server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
  File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
    from . import server
  File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
    import bb.asyncrpc
  File "/opt/bbhashserv/lib/bb/__init__.py", line 128, in <module>
    from bb import fetch2 as fetch
  File "/opt/bbhashserv/lib/bb/fetch2/__init__.py", line 1935, in <module>
    from . import wget
  File "/opt/bbhashserv/lib/bb/fetch2/wget.py", line 30, in <module>
    from   bs4 import BeautifulSoup
ModuleNotFoundError: No module named 'bs4'
---
 contrib/hashserv/Dockerfile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfile
index d6fc728f..74b4a3be 100644
--- a/contrib/hashserv/Dockerfile
+++ b/contrib/hashserv/Dockerfile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: MIT
 #
 # Copyright (c) 2021 Joshua Watt <JPEWhacker@gmail.com>
-# 
+#
 # Dockerfile to build a bitbake hash equivalence server container
 #
 # From the root of the bitbake repository, run:
@@ -15,5 +15,9 @@ RUN apk add --no-cache python3
 
 COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
 COPY lib/hashserv /opt/bbhashserv/lib/hashserv/
+COPY lib/bb /opt/bbhashserv/lib/bb/
+COPY lib/codegen.py /opt/bbhashserv/lib/codegen.py
+COPY lib/ply /opt/bbhashserv/lib/ply/
+COPY lib/bs4 /opt/bbhashserv/lib/bs4/
 
 ENTRYPOINT ["/opt/bbhashserv/bin/bitbake-hashserv"]
-- 
2.34.1


