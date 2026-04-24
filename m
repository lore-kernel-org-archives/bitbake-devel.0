Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683B2FED3C3
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 12:47:37 +0000 (UTC)
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20017.1777034856300104270
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Apr 2026 05:47:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=TmPqupCy;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=asgsMHdc;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.148, mailfrom: paul@pbarker.dev)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F8D31D0018F;
	Fri, 24 Apr 2026 08:47:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 24 Apr 2026 08:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1777034855; x=1777121255; bh=wc
	gEi16ACyOCI/Re3rEDP9MUOYjJiETMo2wvN8cZ48A=; b=TmPqupCyDej9C0nMrO
	MkJpZ9zfh33TWzJ6uV00EqeHjuvzVkn4IrGtb50vPOk7sKyl309Iuc0iFCj0qfE7
	HNtrPgVgMSjbZ4V3nQNN332dxZRzy7U6cQsWPZOdYYOEotR0oQLNj3GE6iOA3BWY
	phTDThYWdMe+i9IPKd0tTga+Hn6X9e05BUIaeU57RqzfXXw3ubyuK0W5awLqInvw
	i6rX363ffzU7D0Gp9Jn+H+wkzfLBz+XuRdcWb98mTdHTlXO3A6BSI+K1gAHle0FN
	ytkeF/kqz6WWQG4GLoyjpdPmGzcgbBSLV++BmPCgM0EZaJ8tRKlRfCfnwq0JpAJ6
	iiIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1777034855; x=1777121255; bh=wcgEi16ACyOCI/Re3rEDP9MUOYjJ
	iETMo2wvN8cZ48A=; b=asgsMHdcmDNXjnalgymubcbnbHbvtZgTXfDs+RdKQ1Xs
	kqmPcJZD1QaOPoje+v7Wdcqz8fJgU/eViiFwe0oZ07rWPl99v/ZWYhEn9tLEKP12
	RUQBfZ2bblS2+GUJDrA86oj3AREtIdKaB7oOqWfENWa0naResLenPgvOvo6tBMNn
	Lx8PyamyF2+PXIUzNLtOeZFhg4HAfGHJAe8NWTnM/d8C4N+6yItfvo8H5LxRQ/ba
	WjyjIaZDuzo+wWfpLY6yU/9Sm5E5aZ5lVyYx6+dMSQux/JYNEs9Ql74thQQJRV8/
	eORsUq2Rk0WdmuzwCyAIkbZPCQYS3Pbaog9yFqB41A==
X-ME-Sender: <xms:ZmbraaCqjmLmNNDjguSV6wYsZi7tbGDHST1pOh50M-FFOsuFhOTfFA>
    <xme:ZmbracTpVBijam469d8keZlVSaE66CNYjhL-mTkZm194e7-OnIzUKyYmcwlefrLIE
    dktpnmTKIGvDvZz7EHaole7F9J4L9jpSYC9SX5sRlWfSpzWgUc4fSo>
X-ME-Received: <xmr:ZmbraQocP4muV72E1Mp1Ardsza5klCYP59lxSkN84EUAb6749o5JHDVDoRWBms77p4MSbAp0D1Buc_0yDazmEjHmAcopMWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghulhcuuegrrhhkvghruceophgruhhlsehpsggrrhhkvghrrdgu
    vghvqeenucggtffrrghtthgvrhhnpeejudeuvefftddujeegieffudfhfefgvdehhedtud
    eigfejleelledvtdekuefhjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtoh
    epfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgruhhlsehpsggrrhhkvghr
    rdguvghvpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvg
    hnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepughotghssehlihhsthhsrdihohgt
    thhophhrohhjvggtthdrohhrgh
X-ME-Proxy: <xmx:ZmbraWxt2bLsE5Qu3z6Y1vUUNlixdj795HbfRPCe000seL1Yphb6RA>
    <xmx:ZmbradKoRXSfwT4hmtcdPolFMIF3CC-DkpQG_kmAUyx59VolZ8UiCw>
    <xmx:ZmbraQJOHDjjsQ89DOd8e7wq6wlkUnzasPdT2rs5hAbuNrc3oNTwJg>
    <xmx:ZmbraasQ5WX0ZVbPnOHVWfIl7oj-pyjenM773vdD2O0-393wJxtW4g>
    <xmx:Z2braZU25zd0VINHhuBcc-ZLgc2CVWrxtdQ1AC_QWAMoqD8TwL-qfvtQ>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 08:47:34 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Subject: [PATCH 0/2] Drop git-make-shallow and update docs
Date: Fri, 24 Apr 2026 13:47:24 +0100
Message-Id: <20260424-make-shallow-v1-0-fc06b12ca344@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFxm62kC/yXMSQqAMAxA0atI1hZqncCriItqo8aZxgnEu1t1+
 Rb/X8BoCRky7wKLOzHNk0Pge1C1empQkHEGJVUiIxWJUfcouNXDMB8ilLFJtTJo0hpcslis6fx
 2efGbt7LDan0fcN8PT1FzF3AAAAA=
X-Change-ID: 20260424-make-shallow-305d7a2ded7f
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=763; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=XxuK9mfh4Y+dHhoTqLjjmmyTQWFj8E7HcfDyC2PcfXc=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWS+TkttsNpw+MQc1h27ri37tsl+v/C1SZIXs4zvTug7s
 sZlvcFjr45SFgYxLgZZMUWWzT1f7z/tdeTNCLmlADOHlQlkCAMXpwBM5PwPRoYDnDv2qx18nZ3I
 nSB2Vq9+m1Pe2s6NYW6LYoxjJrTe23uYkaGrblaE5+Nnj1bJ5KWfVSzb+Peo5MWXM12lBXhbWH9
 zrmYDAA==
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Apr 2026 12:47:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19387

The git-make-shallow command hasn't been in use since 2024. I've
confirmed this is not used anywhere else in bitbake or our core layers,
so it should be safe to drop.

---
Paul Barker (2):
      Drop git-make-shallow
      doc: Fix description of git shallow mirror tarball creation

 bin/git-make-shallow                               | 175 ---------------------
 .../bitbake-user-manual-ref-variables.rst          |   5 +-
 lib/bb/fetch2/git.py                               |   1 -
 lib/bb/tests/fetch.py                              |  87 ----------
 4 files changed, 3 insertions(+), 265 deletions(-)
---
base-commit: 941cfe74c19e01e977101e95b09425d21faf844d
change-id: 20260424-make-shallow-305d7a2ded7f

Best regards,
--  
Paul Barker


