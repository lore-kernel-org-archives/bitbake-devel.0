Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F43C433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 20:20:33 +0000 (UTC)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by mx.groups.io with SMTP id smtpd.web09.14199.1645302029333276833
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 12:20:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=YpngSSqZ;
 spf=fail (domain: huawei.com, ip: 66.111.4.224,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id AFC2B580133;
	Sat, 19 Feb 2022 15:20:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 19 Feb 2022 15:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FiAoik
	hUTDL6O7M7m8IIfDkgcKOgRC3GTUca2xPOuZw=; b=YpngSSqZzS3jgAoX/cRHu4
	fHPx/0E5KrSI8kB1fx57xLfYdffV9rVgZ4gMFEIkqj9HfoziPIXNhyuXzf1JO9ki
	qx2RPMZfFAJF4AYlJZDFyc+DWH5K2DKP9HUex4LLDt4DEax+wImIbJUjQtX9UDMT
	JZ7owndhNvlN6LX5+En8LhUP80w6Bxl9rgIW6kNzxI7FJIlkp4pjA9QtFjBrVj+S
	NAoZfQijMirZyzac6ORMjnVzfq7BEjELV5uCEcwtV2tUCy1ogNDspofBtPr+r1Mx
	z3GDo620enzcxBIXrph2fRtQDsac0jniUV4zwizDxS8bLVj7/zIsT63/+liGEcng
	==
X-ME-Sender: <xms:DFERYn5qtxPdyHvWhBJEQi0IH3jdyHkckmlJeTPcQdcQny2yhj2Aog>
    <xme:DFERYs6n4-a9yqeYiy_hN1ppiyTvTXIY6z9TEsdYRDwOnIf6grS0CloW9edabIAvw
    sPBbQ4bZGsElzbnHg>
X-ME-Received: 
 <xmr:DFERYufe-SSsn-AA2DepG3DucRBg94o0RBb-djC0tlleQrdWGdlaBtoo0cebWpPIr8UvWGvSxYcqrEZ3g8SR29rO7yKBzx2IVxx-5U6wcoC09FUxnYFFgH26xKvXcWw>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepkgihghhmuhhnthcumfhrhihnihgtkhhiuceoiiihghhmuhhn
    thdrkhhrhihnihgtkhhisehhuhgrfigvihdrtghomheqnecuggftrfgrthhtvghrnhepgf
    ffgfejffefieeffeehtedvudfhkeeuteegieejvdehlefhhffhgfelheefueehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiiihghhmuhhnth
    drkhhrhihnihgtkhhisehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:DFERYoLeflBb6vwjRgKx0e0X0idJ5qlz5Zro6S1_KfbpILuMdVDXiA>
    <xmx:DFERYrJNCVqEsjLTSb1JCky25mOE46phwxPwiq4RPUJngLdyF3Uqaw>
    <xmx:DFERYhydwi5K329kG37qpDmo4V3ZELWueoCe7pwgyZjH4QmpSHt-7Q>
    <xmx:DFERYmnGG8tdHDMaybdmWzTLInKVnscCGIBRW2tbWZJ2JDW5dfVeAw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 15:20:27 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 2/3] simplediff: Use "a if b else c" expression
Date: Sat, 19 Feb 2022 21:19:56 +0100
Message-Id: <20220219201957.8329-2-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219201957.8329-1-zygmunt.krynicki@huawei.com>
References: <20220219201957.8329-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 20:20:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13390

The diff code used "a and b or c" as an old-style Python implementation
of the ternary operator. The more correct way to do this is to use "b if
a else c", as it has cleaner type signature.

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/simplediff/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/simplediff/__init__.py b/lib/simplediff/__init__.py
index 11eb7e70..64ec64b4 100644
--- a/lib/simplediff/__init__.py
+++ b/lib/simplediff/__init__.py
@@ -100,7 +100,7 @@ def diff(old, new):
 
     if sub_length == 0:
         # If no common substring is found, we return an insert and delete...
-        return (old and [('-', old)] or []) + (new and [('+', new)] or [])
+        return ([('-', old)] if old else []) + ([('+', new)] if new else [])
     else:
         # ...otherwise, the common substring is unchanged and we recursively
         # diff the text before and after that substring
-- 
2.25.1


