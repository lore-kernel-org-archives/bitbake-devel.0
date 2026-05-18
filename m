Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E01CD4F52
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 09:15:47 +0000 (UTC)
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4744.1779095737949820548
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 May 2026 02:15:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=wkOZWzad;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=lEAyNU0m;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.151, mailfrom: paul@pbarker.dev)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 333EC1D00115;
	Mon, 18 May 2026 05:15:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 18 May 2026 05:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1779095736; x=1779182136; bh=Hg
	7qFKBnR1KubTHNkdMTWU0oyk/dUO5i3T7mOx7PEOw=; b=wkOZWzadGqTmpoemY6
	karrblHinlQKwJxtRCdSNVxwtVvzJkHl6dZRNDU5BGFPZsBoy8bCR9xdLBlhlSTd
	lcVGSPk8lVFRbe6ZikWoD+DTEKXUGvKo4iKyHduiPWL28Wg01hnMnuEgBJdrRX+h
	v7HhEujCnqZVW2H/3rdnT8rcKjUtBWnZ4S9UqBxylweUxndL84unXe3DtGa2lvXs
	nrU/yMI3gWpEADSIlxl8t+xHxZe9fuXFEAFgDqYz0NwUAvRttE3tMCQ+6rNN9LiA
	zq281abN6Of16Yb+jZ/IBMlwtpxkjqRLT/1FZuiPBmuOhsmoawRzySatskgscqQ+
	+MAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1779095736; x=1779182136; bh=Hg7qFKBnR1KubTHNkdMTWU0oyk/d
	UO5i3T7mOx7PEOw=; b=lEAyNU0mEebKXJTe/NFUlru2n30ZKoJr9Xgc/bmoyOvJ
	MzahUdbawXVrrZrF/StWUf2ePPQKITxHFfDd6VcvE8XXga+/rSWZGcJESCF0obGS
	jI1S+Zw3rmHQECIFpG1ZMpMAmshjrqUtpgZ9+VYugb2VX4y4JlSMmox2LPapu5aQ
	a+37Cbx9WnOMfeOdRC07NDXtzAdCzispKKyOMhVxC3h9VHybJbU7SexCKNfA6b+9
	8ZBD0aKeX/x6uxAIhwbdhT1XOZPAjefeQEaKYxgBkdvpjk3n+3p8QHTbomxLbZlI
	nKHXrlEcCHa3Cdusfv0/LSgaawAVDAYWasSCta0M3w==
X-ME-Sender: <xms:uNgKaiecc30lHbne3_7NEdA0RVBXVxn46KsHb7BuZfWb6NWJXTXA6Q>
    <xme:uNgKaiMmDOcuO97FZsMIgvhuNSkzO5BX2LvaPYDICOXnI1J6jhzlKi2qOa83SPlyC
    EwLPvJfZDpnpLRV61MANWmICrouAn7mxqO4EAyWc7XVs4UaUUKwafjD>
X-ME-Received: <xmr:uNgKahKl_AClJAwqGbDGx2kKPyxvhxW-ViDnPOY9yP_3Ic_L1uz5KF7PGSzwCoXjIMusNILVm8ZL8DFZnGjv7BgU2zAaiKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkvfevofesthejredtre
    dtjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhepjeelteefleetkeduueefteffgeeltdeguefgve
    etteekveetieektdfftedtkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtth
    hopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhesphgsrghrkhgv
    rhdruggvvhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhoph
    gvnhgvmhgsvgguuggvugdrohhrgh
X-ME-Proxy: <xmx:uNgKarG9Uljh0Lhus3B8IfvHlt-PzkSQC18msAyKxJpI6dKdJUcXlw>
    <xmx:uNgKahRImjgJcTFWR2R91QxHrUi5kd2ktlpe8nHA6vjBzAwM5Ei7Vg>
    <xmx:uNgKavGTeh6bcTINnFhpOb5J6L-lcdkcwwSOiibgMBIBCz5BDIx-3w>
    <xmx:uNgKal823FYyL-umtgsczXBXtf-mEMmFgXHbc4K1X9Teyf_WNjkc6A>
    <xmx:uNgKamAq-jbdd2Enbl0qEyv6fDIPilrkis3xeD6Tp3BuEtejU1UEegHY>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:15:36 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Mon, 18 May 2026 10:15:33 +0100
Subject: [PATCH] prserv/Dockerfile: Update to Alpine 3.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-prserv-v1-1-9625c3239954@pbarker.dev>
X-B4-Tracking: v=1; b=H4sIALTYCmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0ML3YIioI4yXTNLC+OUlFQzS1NTYyWg4oKi1LTMCrBB0bEQfnFpUlZ
 qcglIt1JtLQDPGJbZagAAAA==
X-Change-ID: 20260518-prserv-6983dde69553
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=663; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=4+0hT+vsfOPiiMTd5oEMB/BBkGHkh8jgeU05jnINr8U=;
 b=kA0DAAoWq2NU7J269G4ByyZiAGoK2LeifSHlYoj1CHgOF0HUsQm+5gvcsaqtsem1FlBvq4XI2
 Yh1BAAWCgAdFiEEs4z13+WNQQ1oVNogq2NU7J269G4FAmoK2LcACgkQq2NU7J269G73MQEA+cDl
 UX8cyDqE2TK0/SFhY3PBOrLKVdmgkyHzwguoxT4A/1jZT7WDfd3nZBIRLVfqMHiJX/c7RZ6SktT
 tQy2XZyUA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 09:15:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19534

Alpine 3.13 is long obsolete, update to use the current version of
Alpine as our base image

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 contrib/prserv/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/prserv/Dockerfile b/contrib/prserv/Dockerfile
index 9585fe3f076c..c630ce99722f 100644
--- a/contrib/prserv/Dockerfile
+++ b/contrib/prserv/Dockerfile
@@ -28,7 +28,7 @@
 # prserv
 #
 
-FROM alpine:3.14.4
+FROM alpine:3.23
 
 RUN apk add --no-cache python3
 

---
base-commit: f903a5595c5f22f15530304bd5f058026390c4e2
change-id: 20260518-prserv-6983dde69553

Best regards,
--  
Paul Barker


