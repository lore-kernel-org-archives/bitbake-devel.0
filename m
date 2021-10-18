Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB09C433EF
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 19:02:01 +0000 (UTC)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by mx.groups.io with SMTP id smtpd.web08.18.1634583720007097667
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Oct 2021 12:02:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=mesmtp header.b=IyiELkJq;
 spf=pass (domain: cold-front.org, ip: 66.111.4.229,
 mailfrom: jsbronder@cold-front.org)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id 82D0A581056;
	Mon, 18 Oct 2021 15:01:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Oct 2021 15:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=mesmtp; bh=JYaIDzVP6J
	ihZXB0idVFP1dy+kPPn2aQFQ/W81+Znbg=; b=IyiELkJqfvD70qW0prB86RFxU6
	N+gsYktDSW+bcJihzfhD68m7ljCofsW0Efvw0s4F2bEOkCik+mPU3+iAb5TYerH1
	FIFbkTfmmy2gh4zqw9pBPZPIxwQkW+nijBh3RnQoX2kpW0yfx9Uqj6F3Duz6JeU4
	sH0wspPcyosAEoOnM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; bh=JYaIDzVP6JihZXB0idVFP1dy+kPPn2aQFQ/W81+Znbg=; b=eDF7g0Iq
	FW9wuhmS5tYVPxbf0NMQN1NdMp5I8vF+p78Cyayy12FLkW6DQuqEItOO0te/CPVu
	dGCehEwBOlg01bjdueEIAwNApzKNLguMquirBfB/tMRcnCnMYctv7y5gommM4U5g
	1z5bVq2ys/29QSxOdcEdG5CDNZKO+zuZDsEt7g4CtYzJo4KdFYE5AC2j5/b3Sv4u
	CHWVDF+CrvX06M6Cgf8HNvwwNFTQzyDxcHAkbRy/MGvv2saVIrLyht1jw5WhQdw+
	Em6RQCvcuxr1z8KKogWx5aw2l+z/4Sf9pqlApcKCx3Hmta56g2L/GZwUoTegbWM8
	l+o9DFx1KBWvOA==
X-ME-Sender: <xms:pcRtYYlfiSK3QXYrsB9DmfWGYzeQ-PRrBGdY7ajHNHHcRkkm6jbJQw>
    <xme:pcRtYX3flEgWojmMDGkZFNeZGZjlaDE0tssbK0oas1SP0oT3ALDmTHxvlgRDoaI6G
    m4VpyvvVBxUh5Gypw>
X-ME-Received: 
 <xmr:pcRtYWrOyQxz-Ci_eHgG_DfQnrcRMPmu4CY2fmnlppUM0AveacpQE_daeLYEBc5-DsSSciXKnA5GLwIKqB4oNoLuu6T4VHA18bxyYr6avpXy>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvtddrvddvtddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogevohgrshhtrghlqdfhgeduvddqtddvucdlud
    ehtddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefl
    uhhsthhinhcuuehrohhnuggvrhcuoehjshgsrhhonhguvghrsegtohhlugdqfhhrohhnth
    drohhrgheqnecuggftrfgrthhtvghrnhepgeelveffvefhvdfhudetteetueejhedugeeh
    gfffgfektdehueeujeefueeufedunecuffhomhgrihhnpehphihthhhonhdrohhrghdplh
    hoohhprdhruhhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepjhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorhhg
X-ME-Proxy: <xmx:pcRtYUmL-zstnJi3m3YsxMEhsxVOL4HLu7Yzk7IViQmV2JwKQ9oONQ>
    <xmx:pcRtYW2ozXr951PK-gOWJaJO4oMJKCJC958rdyRgBbtelwkX9WcvQA>
    <xmx:pcRtYbtARVq9GqJemDQsVjYRphYt6ufwpfLXJGV5Q6stdfxIzsmyWQ>
    <xmx:pcRtYb-O1tAKFM8R3mWWtPFpc7b-_SND91RcW4C02CMucBaeF15tPw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 15:01:57 -0400 (EDT)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: Justin Bronder <jsbronder@cold-front.org>
Subject: [1.46][PATCH 8/8] hashserv: let asyncio discover the running loop
Date: Mon, 18 Oct 2021 15:01:41 -0400
Message-Id: <20211018190141.15806-9-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018190141.15806-1-jsbronder@cold-front.org>
References: <20211018190141.15806-1-jsbronder@cold-front.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 19:02:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12801

From 3.10 documentation [1]:
    Deprecated since version 3.8, removed in version 3.10: The loop
    parameter. This function has been implicitly getting the current
    running loop since 3.7

This is fixed in master as a side-effect of
cf9bc0310b0092bf52b61057405aeb51c86ba137 which is more intrusive but
likewise drops the loop parameter.

1. https://docs.python.org/3/library/asyncio-stream.html#asyncio.open_connection

Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 lib/hashserv/server.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 81050715..56f354bd 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -420,7 +420,7 @@ class Server(object):
 
     def start_tcp_server(self, host, port):
         self.server = self.loop.run_until_complete(
-            asyncio.start_server(self.handle_client, host, port, loop=self.loop)
+            asyncio.start_server(self.handle_client, host, port)
         )
 
         for s in self.server.sockets:
@@ -445,7 +445,7 @@ class Server(object):
             # Work around path length limits in AF_UNIX
             os.chdir(os.path.dirname(path))
             self.server = self.loop.run_until_complete(
-                asyncio.start_unix_server(self.handle_client, os.path.basename(path), loop=self.loop)
+                asyncio.start_unix_server(self.handle_client, os.path.basename(path))
             )
         finally:
             os.chdir(cwd)
-- 
2.33.0


