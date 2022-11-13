Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D06C4332F
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 10:47:13 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
 by mx.groups.io with SMTP id smtpd.web08.1547.1668336426485952623
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Nov 2022 02:47:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1 header.b=Tsq8qmuO;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.21, mailfrom: pavel@zhukoff.net)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 7B2693200392;
	Sun, 13 Nov 2022 05:47:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 13 Nov 2022 05:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1668336425; x=1668422825; bh=HBwWWpy46m4z4crz9grzC32nE
	vSTV2Py9mlmCP+MzX0=; b=Tsq8qmuOONZXubM+IxqWAverTLtbAwTQ2SJvFxtvJ
	K69K3TQvbZ+MalhOz6j/N2nYfOb4FJ53kMGRw52tTttE/rCfx/td4SL45Z6DFo/R
	z1inHpcJOI/mW1mzOkc5SFNXNTYwpZuxCdpKeon1Fr4v8g2/eZBtgvrWtD9p0jx8
	7hrwMEZ4193x8c8NoO8HiCWvYcGBd2bz+2YjrUrVeugqi4vbp/+q5suExMu3awVG
	kg7n3ZA4/kGwMX2QI9xMZQ7nmHmh8dG7lFRtgE0a72x6zLVpfuPn5ZVXPERDMl2Q
	9AEWe3BGA8DXyTNkqStgZbDnW64dWw4mguoOd3ecJR16g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1668336425; x=1668422825; bh=HBwWWpy46m4z4crz9grzC32nEvSTV2Py9ml
	mCP+MzX0=; b=hW84F/CaxwOci7kXRKt2WoW6SUTgfaWXEezk1MoSCeh2Umbkn/T
	0YYpDe68pjREt3W7SmvYRWFrHTb5KpUQWs/mf31qG6OjKrhRw38vYIxQaNVob7vg
	N9ZyR3k2tgYIYmbkAlR3Vq2XFRgBxJH9RXKSPvrhserSILGrUTjEzpHMlXJHoFzg
	L80EVBXb+WzxoX8Ybj7iJ5n5NjnnNVb9snnoXVb9DUuQQJ2OzcvSs5MLbVdWDsUU
	BSSeO6wA3JK1Hd6frN73qxHVgbkcHoa+xnvefRPR6PVcIlHTFOo5CM8FJJB8p+WO
	93wyEMU2jiqigIyd1koEqbp6XKTDIAcGJeA==
X-ME-Sender: <xms:KMtwY3cgaT1hbO4h5wgb5CGkIYnE4w7j9neZqSJF9JlK12uZAqcUVA>
    <xme:KMtwY9PYlwC_BEDLwwc__ty1rjx1f54kfR6jxS7jYP37YHh8jWUI5kr4d0lfLANUN
    sbyK0aQkUOjAqcobjw>
X-ME-Received: <xmr:KMtwYwg8WYHHhV93GGSn9hqsxcuZKTWqmTl0Vk-2eLuvV0CEhuW9HXHgHipWOdP7pEwbWbT7Anr5h-jYch327PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedtgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomheprfgrvhgvlhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhkohhf
    fhdrnhgvtheqnecuggftrfgrthhtvghrnhepgeektddthfelgffhuddvhedtheffteefff
    ekkeetveefveeuffevvdfgjeehjedtnecuffhomhgrihhnpeihohgtthhophhrohhjvggt
    thdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehprghvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:KMtwY48rMctkLhpgAD96t21awOLAm-HXktNpLHU_SY2c7oKh7OAxeg>
    <xmx:KMtwYzvKKRdIOANwfLmQTq_PjT2YZhsP1E0ERB6lMFzX6TFlT34glA>
    <xmx:KMtwY3G5xoEqejDxGvUHY5W0cHAVOz0qlMBFqLIiFozII8JsrAhBmw>
    <xmx:KctwYx3SPuap-H6pl0e0RTu4yq0mshYlEIq4JK3sC7zhjvFqM_ZoPw>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 05:47:04 -0500 (EST)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>
Subject: [PATCH] gitsm: Fix regression in gitsm submodule path parsing
Date: Sun, 13 Nov 2022 11:46:39 +0100
Message-Id: <20221113104638.7939-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 13 Nov 2022 10:47:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14076

Commit 0361ecf7eb82c386a9842cf1f3cb706c0a112e77 introduced regression
in submodules path parsing. As the result gitsm fetcher fails on each
submodule which name begins from the name of the parent repo which is
totally valid usecase [Yocto #14045] [1]
Fix the code to error out only if submodule's name is equal to parent
name but not if it's part of it.

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=14045#c4

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
---
 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 25d5db0e..c5f7c03c 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -115,7 +115,7 @@ class GitSM(Git):
                     # This has to be a file reference
                     proto = "file"
                     url = "gitsm://" + uris[module]
-            if "{}{}".format(ud.host, ud.path) in url:
+            if url.endswith("{}{}".format(ud.host, ud.path)):
                 raise bb.fetch2.FetchError("Submodule refers to the parent repository. This will cause deadlock situation in current version of Bitbake." \
                                            "Consider using git fetcher instead.")
 
-- 
2.38.0


