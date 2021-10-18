Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC08C433F5
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 19:01:57 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by mx.groups.io with SMTP id smtpd.web10.14.1634583716452228941
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Oct 2021 12:01:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=mesmtp header.b=EFMqLu0Q;
 spf=pass (domain: cold-front.org, ip: 66.111.4.29,
 mailfrom: jsbronder@cold-front.org)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C1BE35C003E;
	Mon, 18 Oct 2021 15:01:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 18 Oct 2021 15:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=mesmtp; bh=T7eTGd+Ybb
	Ur0QQqQ7HhdTZAw6eaZfm2TyvvBL4q8Q0=; b=EFMqLu0QSBi6seU7FZkQUBxoj7
	RDhIVW2LA1WDW1Goc1S56TxzfxCXikldvFUBRDlYe/HTmEycy7953MmrqQn5fRxd
	Dm0cgLr0aEdhhoIGZk300Jm71n8Sw8pVPmfBpz80MH51mZsd3BNKEv0dwC+PrkLZ
	DKhc1WxMkat+M1WD4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; bh=T7eTGd+YbbUr0QQqQ7HhdTZAw6eaZfm2TyvvBL4q8Q0=; b=n/OmTCFO
	0NxwLHzkNexWWKAWEhk8ni9HntJOdaoBB1cbwY2heAGmXC4qtO8k/fT8gGaYQnpu
	z5a2dcGVODbc8QVNQfU+uYU1lp78nCdFygd570a8xbqhpsUqMe7vdoaChJ02KkPl
	QWsQaE5FhK+Pjel0yGmWktAuZivyzWySB0KCxTZsqs+KWY9w3/1OVYHVTfczunSi
	AcAaJG4Nb138pKlTpI8pQvrOxsq9cDlufwnXpCi54pZJ+nHx6SBTxdja1V3IRUSA
	zAZMsm1fh+nEydTOZ6JcbgJpTDEeEB3x40fsDWAHcw0X9t7LlffDNquknltmXznK
	SrhWicjjHCBnLQ==
X-ME-Sender: <xms:o8RtYefXnFyVBar1NPjy9-yVkGDTQOfcDAUfAaXZeO7461QuGW80PQ>
    <xme:o8RtYYOTq_s62EMB5BnC14tEvFUiv1ljBw2PBYoryA2JF8BO8SHP_gjsWrNqKqY1J
    AquPErszzls5Pq6kA>
X-ME-Received: 
 <xmr:o8RtYfjYudwxqNoOkNIMX5guiHSW9k21Dj9M4qT2V_94BQrB26Sk8HB6X56klS_09_ULOsxSC09mNyL1C31bz1aV0wbboAF9j99trdjz8YdK>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvtddrvddvtddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhushht
    ihhnuceurhhonhguvghruceojhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorh
    hgqeenucggtffrrghtthgvrhhnpeehleetteejieeiteejueeufeduudelgfegffevieek
    veffleegiefgfeethefgkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhssghrohhnuggv
    rhestgholhguqdhfrhhonhhtrdhorhhg
X-ME-Proxy: <xmx:o8RtYb-dk03dolpF7BI29HjWifEQXsLq91AvbCeI7V_yCPOVG9b4sQ>
    <xmx:o8RtYauI6_EpZVgWZhiZvD6AUtuNdVdU1TB4pQ1jBK_DtUlH8QUhGw>
    <xmx:o8RtYSFvnWbeWjowUEBNI8HCg3hmntxE8Pu0m6kpFo78bWnDMWPpxw>
    <xmx:o8RtYeI3vnYDgXMrf6z0x3ZYzPDw9c0-aDwZXI6ZQ5R21feEF6pDAA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 15:01:55 -0400 (EDT)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Justin Bronder <jsbronder@cold-front.org>
Subject: [1.46][PATCH 5/8] bitbake: adjust parser error check for python 3.10
 compatibility
Date: Mon, 18 Oct 2021 15:01:38 -0400
Message-Id: <20211018190141.15806-6-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018190141.15806-1-jsbronder@cold-front.org>
References: <20211018190141.15806-1-jsbronder@cold-front.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 19:01:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12798

From: Alexander Kanavin <alex.kanavin@gmail.com>

The change was introduced in
https://github.com/python/cpython/commit/a698d52c3975c80b45b139b2f08402ec514dce75

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c8d2a437..c46d3f0a 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -403,7 +403,7 @@ class DataSmart(MutableMapping):
                     s = __expand_python_regexp__.sub(varparse.python_sub, s)
                 except SyntaxError as e:
                     # Likely unmatched brackets, just don't expand the expression
-                    if e.msg != "EOL while scanning string literal":
+                    if e.msg != "EOL while scanning string literal" and not e.msg.startswith("unterminated string literal"):
                         raise
                 if s == olds:
                     break
-- 
2.33.0


