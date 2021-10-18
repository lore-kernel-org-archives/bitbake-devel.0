Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C244C43219
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 19:01:57 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by mx.groups.io with SMTP id smtpd.web10.13.1634583715827228359
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Oct 2021 12:01:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=mesmtp header.b=VC3BZVww;
 spf=pass (domain: cold-front.org, ip: 66.111.4.29,
 mailfrom: jsbronder@cold-front.org)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 28C2F5C01B9;
	Mon, 18 Oct 2021 15:01:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 18 Oct 2021 15:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=mesmtp; bh=/68EB+qhly
	pLKoe+TwkJ8lTeIN4g+ay0mi2ajwrBtnU=; b=VC3BZVww7lCKP/DuS0zNWLnv3u
	AYBPyhpr6AKN1eCJ8BjrY+uX9i1BVy1IwdVQk2k/sEXhFV7QGWc6LsW61ULnAY/+
	Cw4EvgtyJwkAvFdev/DXPow8Vl/G2RAB+FxlwxMoVB8jT01ia2gIAOQ0cJc0T0qH
	NBkb9290uRdHDC+nY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; bh=/68EB+qhlypLKoe+TwkJ8lTeIN4g+ay0mi2ajwrBtnU=; b=HLAAuBb0
	0dJKE6qu7SnmEE2XdTBWZV9Ny1IRAGgU18F/YgCpZpkK3/bbheNsRA2I06FIYVv2
	prhZ57uL5W93BCFchOaYIeu/lZcCQTH1OVc5aLCXK3RHDEOWLyK6i1XnkOTWfJly
	uP27rNfzRDOfk1vX896Hu/NlvSx8aZGpmxCNJhBOoAqInk/o3utlPpbAD1r3Az5U
	6GHVDR+lN6ycIfOPYdS2VI2i5Fr9gik6bXjjt1gd9Jf0lhOEDFK0l0Jea9ilL4z6
	DQHD4htiiD4dXPWZxlW1B6yqQCsklCA6BpwNoRBUG5U9lkMQBfxXNOPiDZp5SsGq
	aSUuXdXbyqZ8WA==
X-ME-Sender: <xms:osRtYVr_eWsoOS0Ah2naNKyIjOXwTOTU0__7N21cjnA9D9-BcJOGFA>
    <xme:osRtYXqxShkMXka40qSg6S-35Z1AoV5XEajOCL2bbjv_p3ZDDzxYj-ZtF2TXBBMjp
    gSFDYDLQWa3Qd4nKw>
X-ME-Received: 
 <xmr:osRtYSOFGUBJPPxjcMAwaMmz6wiqDpP_pRLcIQZ2YPQJDnjEaAgd4MpT7_bxLloeGRdfIX25SGaUy_t_QnifbdljOUHYNoa0UNR36p7YNpM1>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvtddrvddvtddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhushht
    ihhnuceurhhonhguvghruceojhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorh
    hgqeenucggtffrrghtthgvrhhnpeetteehvedvhefglefftdekveeiledtueduffejjeef
    hfdugedtfeejtdegheevffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjshgsrhhonhguvghrsegtohhlugdqfhhrohhnthdrohhrgh
X-ME-Proxy: <xmx:osRtYQ6OopPFRcTXGmaAHWazt3aft6TaF1bsiL2zfxJcUKdknYGg8g>
    <xmx:osRtYU7UAj126dWXXGt24dP90R3ZBts1PEwUT_XiaN6qzRjbdpS02w>
    <xmx:osRtYYgVwWG8C_vYx5qP0ektMcB0-K0aYvGounQ1PChuq0850alO2w>
    <xmx:o8RtYSmkkwCOKgnNZMxR7o_yyHdef20TqinNm5BOR_HtaPuf8CdIdg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 15:01:54 -0400 (EDT)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Justin Bronder <jsbronder@cold-front.org>
Subject: [1.46][PATCH 4/8] bitbake: do not import imp in layerindexlib
Date: Mon, 18 Oct 2021 15:01:37 -0400
Message-Id: <20211018190141.15806-5-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018190141.15806-1-jsbronder@cold-front.org>
References: <20211018190141.15806-1-jsbronder@cold-front.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 19:01:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12797

From: Alexander Kanavin <alex.kanavin@gmail.com>

The module is deprecated and unused.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 lib/layerindexlib/__init__.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
index 77196b40..f30ee9e2 100644
--- a/lib/layerindexlib/__init__.py
+++ b/lib/layerindexlib/__init__.py
@@ -6,7 +6,6 @@
 import datetime
 
 import logging
-import imp
 
 from collections import OrderedDict
 from layerindexlib.plugin import LayerIndexPluginUrlError
-- 
2.33.0


