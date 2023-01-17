Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AFCC6379F
	for <webhook@archiver.kernel.org>; Tue, 17 Jan 2023 15:37:05 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
 by mx.groups.io with SMTP id smtpd.web11.199752.1673969823677355135
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Jan 2023 07:37:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm3 header.b=xv7Uq/tg;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.29, mailfrom: pavel@zhukoff.net)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id EAAA95C017C;
	Tue, 17 Jan 2023 10:37:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 17 Jan 2023 10:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1673969822; x=1674056222; bh=8AUyGqJVAAgAXPney4S4NulbB
	psUlxzFaVRpA3YSIU8=; b=xv7Uq/tg3G1hNeXCshKwto1OeqqyON/i4gxn7ViPk
	PDDGCvLTPOC/R4QaeuXyup6hZNqHhY8l6W4sve9MnB6Ck8C0aO1hM11A4iRWeU4v
	PolgjZbqtSNFLISdj8oTpJbsEqLYKMpksS33HdOej+wPj1eUf6ZEpU5MLd7dOMTg
	/zvPb5a5M5+FY3LATDjJH4Z706yn0MfZViETAxIJp5YNHzMguXe0LCDvmzSuY46k
	JZOhVWt5pEOjUEc+VFxS2kk5LuJZzz5svcnGLW1CH1RhUygF9gQqmWtjH3uvFXYs
	bK1ULKyKepGntGWKvyFpj27JHtansM26iVot9KStgwXGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1673969822; x=1674056222; bh=8AUyGqJVAAgAXPney4S4NulbBpsUlxzFaVR
	pA3YSIU8=; b=VfCxiziggHvPtCLQiDkBY9Cik2wMCoRi4VCNkUecpSWuE+J4N1w
	jquxd+Ad1/TvqnNyX46AukPmsHWAnkqj0126gfg2Vmw1dCOtP7LMXYVbZlIsVsar
	S3F023ferT5DXaB1TuXx+nWcOY4e+3AwOcJUx4oTWXF7xJLkFefTDM4BKQ7P0Hwb
	tBx1/hnBRaB0KhqNkaNZlZuPy2z9Dr2/76KIfx98HmwToBpcx15BP5Rh+WyNrNWu
	zEDytwFRkbyiWCyUqAGOyPvl23Go6GKSn6fYmTrtmFMt9OkUqkytFSY26dqV7PVB
	wAxK+D8s30pb2hMFdtr1vjAMhYKKRVR7QRQ==
X-ME-Sender: <xms:nsDGY7EAvGRFvOJEoUYQcIE0dbgiIiWNOln-jGva8gbujTuZ8G8TmQ>
    <xme:nsDGY4VtzTWSL83_zPkgB3J5kdy9U_RE84ufY_kw_Mci6gcJz-Ztz6t4Ku-qofETO
    EbfCBdkELMOyZ1U5cg>
X-ME-Received: <xmr:nsDGY9J32bzUfq8zC9ZtMCPClE3FtpxTH1g73g7CqKro7VcNPXL659YljP5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtiedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefrrghvvghlucgkhhhukhhovhcuoehprghvvghlseiihhhukhho
    fhhfrdhnvghtqeenucggtffrrghtthgvrhhnpeevfeejkeejudegledtkeejhfettdefje
    euffehieekvddugfdtffffledvvdefhfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehprghvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:nsDGY5EcuqB2GBFxNJftEh8aQJgtM1MhnFMGpheu7Fb-G6MpotcOFg>
    <xmx:nsDGYxU02PQBcwJe6az0nVyKMwfgwvc1vLy6af8tSpXEU_t1ft02Vw>
    <xmx:nsDGY0OnGzmQX7LS0ES9Y7N3tgT027I4w9Fbn-ThDPoZb0au2301UQ>
    <xmx:nsDGYyf9GlEHf1lTco4rJdih3HjE6WC7RQCwwnB4-p0mxJnLDYOR9Q>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jan 2023 10:37:02 -0500 (EST)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>
Subject: [PATCH 1/2] fetch2: kill parameters in uri_find_decoded
Date: Tue, 17 Jan 2023 16:36:42 +0100
Message-Id: <20230117153643.21716-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Jan 2023 15:37:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14318

Fixes:
  File "/bitbake/./lib/bb/fetch2/__init__.py", line 446, in uri_replace
    if uri_decoded[loc][k] != uri_find_decoded[loc][k]:
KeyError: 'module'

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
---
 bitbake/lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 893ec6f6bd..b1cd6b25c2 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -469,6 +469,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     basename = os.path.basename(mirrortarball)
                     # Kill parameters, they make no sense for mirror tarballs
                     uri_decoded[5] = {}
+                    uri_find_decoded[5] = {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
                     basename = os.path.basename(ud.localpath)
                 if basename:
-- 
2.39.0


