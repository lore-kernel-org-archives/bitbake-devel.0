Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CCDD1BDD3
	for <webhook@archiver.kernel.org>; Mon,  4 Nov 2024 17:36:06 +0000 (UTC)
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mx.groups.io with SMTP id smtpd.web11.1595.1730741763325179433
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Nov 2024 09:36:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=fm1 header.b=TYgyasmb;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=QbBdnaGF;
 spf=pass (domain: cold-front.org, ip: 202.12.124.155, mailfrom: jsbronder@cold-front.org)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 741E22540162;
	Mon,  4 Nov 2024 12:36:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 04 Nov 2024 12:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1730741762; x=1730828162; bh=IjIE6EoZl3
	DIAPHfHw0RXUSsrIBJr6EY+5gMWf4BuLA=; b=TYgyasmb94V/sT4e4MmD6jzb4V
	M8pQ9J0hafW8YxLPBGti3HdNDfW9GfcFR4HYwOEqPajtGL0Pmjo7HfHj59JaiTqZ
	/nzJ5dwYgO5RXsQpO904GEVQiRqmAGm/zURuT2Za8Hb/0s8fZF2BNuL9ULKA2WeU
	W3A0jBl2QBOnEz1amq6VP678EIn1smoQ8aZXaXO5BMK/X+JEnbaDiQe9PhPNp75v
	2Z7bGBZvqqKG3+7dVyyf6AmtZxc3CvrzRsPg8g6dtARJ7OuxmQOJ8SjQ4oXGi30c
	xrP2zCOKDE4BmLzSxZIgiCTw5wdL9e1SRF2inxcSsqU6HynGXGfJ65vj7g5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730741762; x=1730828162; bh=IjIE6EoZl3DIAPHfHw0RXUSsrIBJr6EY+5g
	MWf4BuLA=; b=QbBdnaGFovVOfzZx1ZXlZ5ZsG8t3yz4JuJ/vbpJAThvT7E2ZfiT
	hK0/DXptbzhI31X0Yp9RAxGaTXw7v719Csq4qZiWWteDAq0zjnzX527OQsEp5GW5
	GP+/jg1ZNBOLo9PFvXmtf5utl3/KyBsDNCgeNJVfqtluruq2jJSw/DjULwVrYHAV
	sdcPDadvTcJ6LPfg3sp3+ogO1QiTXNZ6w7nIPJlFElvIyeygoPde7tmA9hivAaV+
	hX5+nGzlwjcHB1zGi7Pa/D6jiDZ2/GDs/b1qTD8abIZSRJNCOXmOzlx/vX49YZSy
	c6SgMKhr+zX/2r1uTw4q9cqy4dn0I/QOotQ==
X-ME-Sender: <xms:AQYpZ3qC7hr1i5NsJ-cDC3KWgYOQGcJv_sGFJL0oAVjag4n4OzVDTw>
    <xme:AQYpZxpGNR1jf2HDwPWSyv_c15HBCSeXrai6W9tAXKJUxGzsOWRXAUQ9U382TxiGO
    s0aOI_PpALrkKZpfA>
X-ME-Received: <xmr:AQYpZ0ONAnBlG_QDYlj3vq-Q6IowEU_rttM41OMvmTZpQWplf0hKjPR73A6755KmQxWOggX6gsIGT_llPbCgnjOLqWS_ncy7MQfvqhYs6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomheplfhushhtihhnuceurhhonhguvghr
    uceojhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpeffudfgffefuedvuddttdfgfeehgfeikeffudfhgfehieefteefgedvieehvdeg
    vdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhssghrohhnuggvrhestgholhguqdhfrhho
    nhhtrdhorhhgpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggv
    ugdrohhrghdprhgtphhtthhopehjshgsrhhonhguvghrsegtohhlugdqfhhrohhnthdroh
    hrgh
X-ME-Proxy: <xmx:AQYpZ67Dp5R3uFyR09k8tfg6Fy-fGXlan2qN0Dna93Le46a-dk6Q3A>
    <xmx:AQYpZ25p6InmlcObQvZlw-mSM0xsByruw1tv1MIPNwd4Fl4rlQL6eQ>
    <xmx:AQYpZyhU_JwepJyr47hWCc8jHlv1akTIMYNDVo48AJ971F_pfCfWUA>
    <xmx:AQYpZ45WiUJNQiCoIuVjflDFP3jCXiQgEyp-io_JSMiGlc759Y8Zjw>
    <xmx:AgYpZ2H2IWyLmd_8Mp7UZB7VsucJoP1Gf8QBh1jYy6QAHpi_A8vlVqov>
Feedback-ID: iea0042cb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 12:36:01 -0500 (EST)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: Justin Bronder <jsbronder@cold-front.org>
Subject: [PATCH] bb: compress: use lz4 instead of lz4c
Date: Mon,  4 Nov 2024 12:35:57 -0500
Message-ID: <20241104173557.2712213-1-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Nov 2024 17:36:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16773

lz4c has been considered deprecated by upstream since at least 2018 [1]
and has been disabled by default recently [2].  openSUSE Tumbleweed is
no longer packaging the deprecated version and others will likely
follow.

Luckily, we're not using any legacy-specific options and, going back as
far as Ubuntu 16.04/Fedora 25, both lz4 and lz4cli are installed as part
of the same package

1. https://github.com/lz4/lz4/pull/553
2. https://github.com/lz4/lz4/pull/1479

Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 lib/bb/compress/lz4.py      | 4 ++--
 lib/bb/tests/compression.py | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/compress/lz4.py b/lib/bb/compress/lz4.py
index 88b098932..2a64681c8 100644
--- a/lib/bb/compress/lz4.py
+++ b/lib/bb/compress/lz4.py
@@ -13,7 +13,7 @@ def open(*args, **kwargs):
 
 class LZ4File(bb.compress._pipecompress.PipeFile):
     def get_compress(self):
-        return ["lz4c", "-z", "-c"]
+        return ["lz4", "-z", "-c"]
 
     def get_decompress(self):
-        return ["lz4c", "-d", "-c"]
+        return ["lz4", "-d", "-c"]
diff --git a/lib/bb/tests/compression.py b/lib/bb/tests/compression.py
index 95af3f96d..16c297b31 100644
--- a/lib/bb/tests/compression.py
+++ b/lib/bb/tests/compression.py
@@ -66,8 +66,8 @@ class CompressionTests(object):
 
 class LZ4Tests(CompressionTests, unittest.TestCase):
     def setUp(self):
-        if shutil.which("lz4c") is None:
-            self.skipTest("'lz4c' not found")
+        if shutil.which("lz4") is None:
+            self.skipTest("'lz4' not found")
         super().setUp()
 
     @contextlib.contextmanager
-- 
2.46.1


