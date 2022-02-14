Return-Path: <daniel@qtec.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E65C433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Feb 2022 12:52:02 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web12.33536.1644843120402915881
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Feb 2022 04:52:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qtec.com header.s=google header.b=Q6Xd7GD9;
 spf=pass (domain: qtec.com, ip: 209.85.208.49, mailfrom: daniel@qtec.com)
Received: by mail-ed1-f49.google.com with SMTP id f17so26908657edd.2
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Feb 2022 04:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5s4VZU/2YY3bBwh2IfLl9xHQpqm3pBVrj8KoTEq/kk=;
        b=Q6Xd7GD9JzR6HxAlOxelmKER9Q9AT3zRnfYN3oHLkK1QyMJ+X/iuSneIvYGoWzlZ8y
         hdj1lW8hmuGZbDN+HD5G/CKbG2EgLpad+yBmLqiRjCB6TlhV6lKnx1TyUxMHj2w/TsCN
         Gzk38m+XrkjnfBBly+De0otVILcG4ZpecB1f0wiZevS9pRuyfC8rKIWv3Cbj6Lt2Xmq0
         RAhdaTG1scGmGglHGVY8xEze8YLumfRn6xIWAV34kv3dJRuSRW7pO9fXUQUqTXRGp/un
         aK7Da/mwKH2iBjnoH/5rx67ZLrVIL0i3wv9c0+Im4w5HaSFqcDBqUkEx1g7osHh5Cjo1
         XuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5s4VZU/2YY3bBwh2IfLl9xHQpqm3pBVrj8KoTEq/kk=;
        b=U/YMylhnj6Sq8/0QhnRcQ6rL8sP6YfOOPx8KgqTOaefiHJzWOXxFzT+KoVFYAcJ1uY
         /TXUN1jON4nC4fs2CgquBjLeAbVT3n4VTnzSDkFCOH5Jx87vw1akqKSwrGTjhcXz0ahs
         xRJA6P1sxaM092eWL826TLsAL3FRPwrPpRpyGn6e5jwNAw2fjWLAL6/WAe8M/iYwWcEq
         7ixUbGMRi53EbF6ip2efwrA+w5ZMVlAeQaCpVgh4woOGM8GTEzS/TEigY4rAH0qdgC9L
         Mylhs5p5c9rKDSHJItakvMDi1Zx5GzpCUPA3jo0aOETPZLsGK+PZ9qe81ICcdvUyrNIf
         59rA==
X-Gm-Message-State: AOAM533D96tHiCBoRBKVDzrEsgRCmsft91uJ5cxWO8SCPEU3QPKZgULE
	JRPcNyX/LZQi6GAlmLkQPbDHGI7oUBMzqWBhZRe7EDAgS1eJgCTdFMItunQqTZcTOnmVoxVLMY5
	oCOkN55KRB4+V61R9LLbSLh7d2NCzRSKSGJjnxEFrdopIadF4NttAnuXaYCSQBx7aXpjuTtOJDz
	Nr1jn96e0=
X-Google-Smtp-Source: 
 ABdhPJyBXkF+goUw2yLsEbL2qOcDU101556WSLuTtcX1im6PnEwwPhv2+09C9OQPBcCzFrmGCps41A==
X-Received: by 2002:a05:6402:5285:: with SMTP id
 en5mr15209076edb.108.1644843118386;
        Mon, 14 Feb 2022 04:51:58 -0800 (PST)
Received: from datops.qtec.com (cpe.ge-3-0-8-100.ryvnqe10.dk.customer.tdc.net.
 [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id r5sm625038ejy.51.2022.02.14.04.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 04:51:58 -0800 (PST)
From: Daniel Gomez <daniel@qtec.com>
To: bitbake-devel@lists.openembedded.org
Cc: dagmcr@gmail.com,
	Daniel Gomez <daniel@qtec.com>
Subject: [PATCH] asyncrpc: Fix attribute errors
Date: Mon, 14 Feb 2022 13:51:48 +0100
Message-Id: <20220214125148.393076-1-daniel@qtec.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Feb 2022 12:52:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13347

Export ClientError and ServerError classes from bb.asyncrpc.serv as
required by lib/hashserv/server.py module.

Error:
Client ('192.168.2.184', 51142) connected
Error from client: module 'bb.asyncrpc' has no attribute 'ClientError'
Traceback (most recent call last):
  File "/opt/bbhashserv/lib/bb/asyncrpc/serv.py", line 192, in handle_client
    await client.process_requests()
  File "/opt/bbhashserv/lib/hashserv/server.py", line 200, in process_requests
    await super().process_requests()
  File "/opt/bbhashserv/lib/bb/asyncrpc/serv.py", line 72, in process_requests
    await self.dispatch_message(d)
  File "/opt/bbhashserv/lib/hashserv/server.py", line 217, in dispatch_message
    raise bb.asyncrpc.ClientError("Unrecognized command %r" % msg)
AttributeError: module 'bb.asyncrpc' has no attribute 'ClientError'

Signed-off-by: Daniel Gomez <daniel@qtec.com>
---
 lib/bb/asyncrpc/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/__init__.py b/lib/bb/asyncrpc/__init__.py
index b2bec31a..c2f2b3c0 100644
--- a/lib/bb/asyncrpc/__init__.py
+++ b/lib/bb/asyncrpc/__init__.py
@@ -28,4 +28,4 @@ def chunkify(msg, max_chunk):


 from .client import AsyncClient, Client
-from .serv import AsyncServer, AsyncServerConnection
+from .serv import AsyncServer, AsyncServerConnection, ClientError, ServerError
--
2.34.1


