Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DBDD2C13E
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 15:42:53 +0000 (UTC)
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mx.groups.io with SMTP id smtpd.web10.23090.1730821367009366813
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Nov 2024 07:42:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=fm1 header.b=wljKYv3F;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=dxBW8/6j;
 spf=pass (domain: cold-front.org, ip: 103.168.172.146, mailfrom: jsbronder@cold-front.org)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3BED213800E0;
	Tue,  5 Nov 2024 10:42:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 05 Nov 2024 10:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1730821366; x=1730907766; bh=xotfwQKG4O
	57QP5P1zWMPsvCY30VHYk9p1mOU2+fUQY=; b=wljKYv3Fpt+4TQXKW5Y22yHT2i
	bNVjVGqCfyWu7XAtFiRUWk+8SVed9buX3bL60brV9QFWk7oITs0ytwStrPr9V4uw
	swmWTiQUXYJjK8eEyjsiat3vnHLzRiz1kpt1741MKQ6a+pTwBbY+uFlClwE7IKds
	HNEf1oOcLuUwfjbfVA8MvjZ2dzmo6lVFF8KQ9NhYru52QsrC0yPA4L7U9qc9ekn0
	fzLQbFdm8o/jj6Am8NdobmGJlsg0UNgAM9XwRXnkqQiunlSAhV96SM28L+UEZLDZ
	cBQzX10ZyPIN0ysZ9oO5xNEtQS03sCzRn5agSWRpZwGZRmdN+XjDw0UKmUew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730821366; x=1730907766; bh=xotfwQKG4O57QP5P1zWMPsvCY30VHYk9p1m
	OU2+fUQY=; b=dxBW8/6jkImOZwFvLFf+HAryOwMcxpDVuqKX95+RU45H6UAaGvs
	mNvpE3p3F/5yOVDcga2UICLQGabVkrnNXwH3ZH3d++0FB/PKCWE/Bi9qKdG5dAxH
	6//VjfempQKh5ldaosxcXdyF9aVYCWuAD834+0IHhzPzQhFqR6a/ocy0W3CXsvRS
	xFZ5dMV9CBj+OuzsPQAfK77tTC53NURUP2gstwZcbNds0zB7ht4kOis5m6OFvCHV
	z/sVS5v3XPGSr2C8J0PrW3CKmYZPYmgGEMtKmy9V5lS01uwfA03/tGL8R/tvqW8w
	4DPfT1rWJ/TsU4elqFZbaEuKrNFFhR/Xaug==
X-ME-Sender: <xms:9TwqZ803zC-1SDaPD7AgrLs_UmcN4N9twp-aIupMkPEyie7y0WWS3A>
    <xme:9TwqZ3EMCFNB2HgdbIWPWY-lSe2xUmBqX1a-5K1_TlcaJ1T6TClOhe3PFA5dxo7Db
    30WJQYjH40AYN2aqQ>
X-ME-Received: <xmr:9TwqZ04qJwM14hU5B5bACoeug3ULrOKG5fp4FVRbch76kIGPXJEgos6poI10hwosQ3LDYG9fgCyLMTZ4Fe8SJ_kIeAoXnozDBBEbH8WJFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddtgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgggfestdekredtredttdenucfhrhhomheplfhushhtihhnuceurhhonhguvghruceo
    jhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorhhgqeenucggtffrrghtthgvrh
    hnpedugffhvdekueehudduudfhueeiieekgeeflefhgfefjeegleehjefhfedtleehgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjshgsrh
    honhguvghrsegtohhlugdqfhhrohhnthdrohhrghdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhish
    htshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepjhhssghrohhnuggv
    rhestgholhguqdhfrhhonhhtrdhorhhg
X-ME-Proxy: <xmx:9jwqZ12DenBW54Qr345znHbQ0x3L8KBpKSS_S5FOQf8DTmxq8o4ZCg>
    <xmx:9jwqZ_FAL_IFXw5Zgmqb7P5vHVSsRFOjjc0d1oC1Kjg96MA_V2MgTw>
    <xmx:9jwqZ-_Iie9NtCOzUlPA9toweASKSX6W-kJJI0iRhnOSukWuK7lyjQ>
    <xmx:9jwqZ0nZIrn6Y2XaVF52b7EdbW6GKOCfBsKayiYSroC_H2NbwESZSA>
    <xmx:9jwqZ0QbDWBQHl2-cNsQlgZPnhuJZ0b53n8hCWJtOKOgwHwo2vFM95np>
Feedback-ID: iea0042cb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 10:42:45 -0500 (EST)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: Justin Bronder <jsbronder@cold-front.org>
Subject: [PATCH] asyncrpc: timeout attempting to create a TCP connection
Date: Tue,  5 Nov 2024 10:42:38 -0500
Message-ID: <20241105154238.3611453-1-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 15:42:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16778

Timeout when trying to connect to an upstream that may be filtering
connections (instead of waiting endlessly) and raise a ConnectionError
which will allow the caller to note that the client is not connected.
This, for instance, ensures that a firewalled BB_HASHSERVE_UPSTREAM will
trigger warnings.

Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 lib/bb/asyncrpc/client.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 9be49261c..92e140dfe 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -68,7 +68,12 @@ class AsyncClient(object):
 
     async def connect_tcp(self, address, port):
         async def connect_sock():
-            reader, writer = await asyncio.open_connection(address, port)
+            try:
+                reader, writer = await asyncio.wait_for(
+                        asyncio.open_connection(address, port),
+                        timeout=5)
+            except asyncio.TimeoutError as e:
+                raise ConnectionError(f"Timeout connecting to {address}:{port}") from e
             return StreamConnection(reader, writer, self.timeout, self.max_chunk)
 
         self._connect_sock = connect_sock
-- 
2.46.1


