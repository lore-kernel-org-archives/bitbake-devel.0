Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A08CC67871
	for <webhook@archiver.kernel.org>; Mon, 24 Oct 2022 20:07:55 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
 by mx.groups.io with SMTP id smtpd.web09.942.1666642065885509627
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Oct 2022 13:07:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@cold-front.org header.s=mesmtp header.b=RWAO26B8;
 spf=pass (domain: cold-front.org, ip: 66.111.4.25, mailfrom: jsbronder@cold-front.org)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2DBE95C00FE;
	Mon, 24 Oct 2022 16:07:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 24 Oct 2022 16:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=cc:cc:content-transfer-encoding:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=mesmtp; t=1666642065; x=1666728465; bh=0UqOLrX
	gMfl5a28I+ARAFTtb6VL0Mce9l4fvK9HapDg=; b=RWAO26B80PONFaWUxL502mm
	1sQArJwy1PgfypMItao0ESJnC84tEvDcz18Wg1lrV8D8p8LuEjjlBxmIIxA0+X8Z
	cw8OWikBEmx/ghFv6vlZub7IETM3h4z0iaAdC5pTfSt4AJ3MLkBAp+aQrNFO6eco
	DnFCN8NfE2T2BNfwSZYM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1666642065; x=1666728465; bh=0UqOLrXgMfl5a28I+ARAFTtb6VL0Mce9l4f
	vK9HapDg=; b=olz4MaFgmiQhom+jbv+Er+wRQiY+xHTQeSvlySuZevCgAmb/T97
	qoE9d5JXPVrQoMOeLBfRvlW7ZOuUtNBuUxWQ4EXjNBR7QzuEvVmJNVO7SWSQR8qq
	XLFp8K1R3gCcIJBalvYn2MJOK+NHEsy5NTXZd9BRm3ctx7N9sAPr6GnT6MPlH2wQ
	LS1gwvsfm7N50ZmW1JCFIf5EACTNYHRKThCVPkGHlPbRX37BNpBGxueaCfeYxKl9
	5LMDjEZnNadRHXoXoc19ddWdgjcVeQ4UR7QSR7T47t8gJsHfZMT84GxegCWQ9TS7
	DXDmfx53nKqJMF8WufdeAt1XyKl8gtUVwWw==
X-ME-Sender: <xms:kPBWY8l4eUBYSUXwYNLkyw2DBzBmyu1aeI4b-Amo_Fl2JYD_73v5BQ>
    <xme:kPBWY70ff4VoMcwWtjgnxT4px4qeX2418nPUZH7SXN24OJo9BNt1t6ZPOeJkx9YhS
    h46b_o8AmhIheS15A>
X-ME-Received: <xmr:kPBWY6qpQC1hbtvSjHgvCwcvuG20-RZjdXcMsRr4Kms5doL0Jy8sQYM4K6uQ00riMRBGWJGWiwkyHh1xBtdCZhuz4nvWOA3ySySGl4-jVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomheplfhushhtihhnuceurhhonhguvghruceojhhssghrohhnuggv
    rhestgholhguqdhfrhhonhhtrdhorhhgqeenucggtffrrghtthgvrhhnpedugffhvdekue
    ehudduudfhueeiieekgeeflefhgfefjeegleehjefhfedtleehgeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjshgsrhhonhguvghrsegtoh
    hlugdqfhhrohhnthdrohhrgh
X-ME-Proxy: <xmx:kPBWY4llknZAwBNb2UXBMEVmJc6QD5wm0l0g9J9y1TkvYmTALr8ERA>
    <xmx:kPBWY60VHqgmB3bgo3TD9YfqSfnQqjy2m9ZbS1sqiGJD8NnKv8xCfQ>
    <xmx:kPBWY_tEqx63xnBNJbkVC1er1LABj1jh3KLoBz0UkyXhJmJ4bPiD9g>
    <xmx:kfBWY_-RlUKPc98kFP7n1dxNY-X5kR6NsXYUgmrAAJqXUyx-8l5xWg>
Feedback-ID: iea0042cb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Oct 2022 16:07:44 -0400 (EDT)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: Justin Bronder <jsbronder@cold-front.org>
Subject: [PATCH] asyncrpc: serv: correct closed client socket detection
Date: Mon, 24 Oct 2022 16:07:41 -0400
Message-Id: <20221024200741.23646-1-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Oct 2022 20:07:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14048

If the client socket is closed, asyncio.StreamReader.readline() will
return an empty bytes object, not None.

This prevents multiple tracebacks being logged by bitbake-hashserv each
time bitbake is started and performs a connection check.

Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 lib/bb/asyncrpc/serv.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 5cf45f908..d2de4891b 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -42,7 +42,7 @@ class AsyncServerConnection(object):
 
             # Read protocol and version
             client_protocol = await self.reader.readline()
-            if client_protocol is None:
+            if not client_protocol:
                 return
 
             (client_proto_name, client_proto_version) = client_protocol.decode('utf-8').rstrip().split()
@@ -59,7 +59,7 @@ class AsyncServerConnection(object):
             # an empty line to signal the end of the headers
             while True:
                 line = await self.reader.readline()
-                if line is None:
+                if not line:
                     return
 
                 line = line.decode('utf-8').rstrip()
-- 
2.38.0


