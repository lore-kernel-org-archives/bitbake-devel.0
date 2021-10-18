Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2D0C433FE
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 19:01:58 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by mx.groups.io with SMTP id smtpd.web08.17.1634583717084249444
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Oct 2021 12:01:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=mesmtp header.b=qElHFYr3;
 spf=pass (domain: cold-front.org, ip: 66.111.4.29,
 mailfrom: jsbronder@cold-front.org)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 68C025C00C6;
	Mon, 18 Oct 2021 15:01:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 18 Oct 2021 15:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=mesmtp; bh=IT6zwR4QN6
	Tg6FKU8W8LPh+lXXe0HIK5jGYtulep4rU=; b=qElHFYr3c5kUU+wuA7lZqMYUmC
	h/Mj51fu7s6AGbORe77LyzaRZ5hJgLk7LFxFyaljd43tmNUxXNZtzNyt0GRROxqe
	GIKhd8NT6OpOUcNUICxms/wHPjD/L4go92ey1xOfWtaLs7IY4ifDl3JLjYiHDsoe
	k47ExD87itU4rFmA4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; bh=IT6zwR4QN6Tg6FKU8W8LPh+lXXe0HIK5jGYtulep4rU=; b=H1/s7B2E
	GHJP9bGvlUqIFZuqkYOqJrLiKMIfpIangktRdy/wYXpsyC9wpI2LBt6s6kFQ6dYd
	UU7l1qwoF2UnogAudsestTGohZZT6EkfMU2FINsKRQoRsVoALO4aKblNZIqpry/p
	35q8fmMY92YHCx1h1qTHtVpIBEd+taYTIMWJlt5P3H3H1+BdOye9/fv8gxcx4cog
	elqS7VfDHiGNhkdxL70M21YsfVfGSVEc2nb+J+tsrx5Lc/h7VVfN/2H0C9S1PEJp
	qKTXtXcKiky2Pq6RY5hSceF8JzcT3I9oxea8a3IFwtFnc5oS+x7WfaG8xtNO46tx
	VKpSqd0oG0/czA==
X-ME-Sender: <xms:pMRtYTuJO9nx9uDWrtgFfmSHhcvLUDRWYG9ZdYM8z8ZU_yfkcP_eWA>
    <xme:pMRtYUeM_u_tRE9GFA2lDrBD-SbhIN2Ck0dwyLsC47jZ5pkFziSBUG-8LgQ6EuMgC
    UxdukMDLEoSrc54SA>
X-ME-Received: 
 <xmr:pMRtYWzcPbw69aUBK_fR9rkmgtSSlT9sIqmL7KCJdB42_jFnuZgMUNi0Q10LUrgwCH6xztDu3fPEsMcZpIuu5UT8O1d0N_b1_It9a5K-UW2C>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvtddrvddvtddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhushht
    ihhnuceurhhonhguvghruceojhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorh
    hgqeenucggtffrrghtthgvrhhnpeetteehvedvhefglefftdekveeiledtueduffejjeef
    hfdugedtfeejtdegheevffenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjshgsrhhonhguvghrsegtohhlugdqfhhrohhnthdrohhrgh
X-ME-Proxy: <xmx:pMRtYSNO09qNYWYGqAFeB8IrMtgG7Z0WcL4rLmADSvc042EOO9-Zyg>
    <xmx:pMRtYT97s6JQYYFTnQuGesN1eyCU65mMs4pbgUZfAL_oKCMlxxMfdg>
    <xmx:pMRtYSWwIEhVXapxBUr7-HjrstolK1t1b_BWFT4bpFZMStlUpvcffA>
    <xmx:pMRtYWYVn-94zz8XXZ9xu50UN_sxts94uNAllXcOi0zk6_y2cRj25A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 15:01:56 -0400 (EDT)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Justin Bronder <jsbronder@cold-front.org>
Subject: [1.46][PATCH 6/8] bitbake: correct deprecation warning in process.py
Date: Mon, 18 Oct 2021 15:01:39 -0400
Message-Id: <20211018190141.15806-7-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018190141.15806-1-jsbronder@cold-front.org>
References: <20211018190141.15806-1-jsbronder@cold-front.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 19:01:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12799

From: Alexander Kanavin <alex.kanavin@gmail.com>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 45f2e863..43061eb3 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -587,7 +587,7 @@ class BBUIEventQueue:
         self.reader = ConnectionReader(readfd)
 
         self.t = threading.Thread()
-        self.t.setDaemon(True)
+        self.t.daemon = True
         self.t.run = self.startCallbackHandler
         self.t.start()
 
-- 
2.33.0


