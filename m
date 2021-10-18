Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337EEC433F5
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 19:01:54 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by mx.groups.io with SMTP id smtpd.web09.16.1634583713131191387
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Oct 2021 12:01:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=mesmtp header.b=DusApeVT;
 spf=pass (domain: cold-front.org, ip: 66.111.4.29,
 mailfrom: jsbronder@cold-front.org)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 660625C0118
	for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Oct 2021 15:01:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 18 Oct 2021 15:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding; s=mesmtp; bh=7iBfAEGUg7gq/OjgVb4ryXL
	1aufcz4U1AG9HhZ8HgTY=; b=DusApeVTzUDofjhPMpx1W4E7Xqlov5OY9GGst4T
	9D5pU8hjXEnCNHGVnmLDu6BlK+fCnNhi38PHLRGYOfUh85Dwxh71lPdTG39BTKQr
	gSWb/u/Nu8YasXgb/mmLeJt1DC+F5jm/uC4oKGMR2aw35Dnqgos2TyRxb/p4fs81
	fjX0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:date:from
	:message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7iBfAEGUg7gq/OjgV
	b4ryXL1aufcz4U1AG9HhZ8HgTY=; b=i1IBvj+emWAPVSomh34QTxwgcavYkAscL
	Rs8kUYDXQsUBAy7c7n1jlohovsBzWnvjXF3N4u8+nO1myZRFF8vDKG2FaWhySndM
	zZ0jtJfVPLDnIkQ/E57KTwnUhvs0RIBZrNK+pVGGoNwxsNmR6RSWdygPbd5PPVjk
	2pEBAEpCmKCWObtC7A2lhVOF01GIHPJ8yII9X9pb5TRnNtj5u1nf2KsC3WXC0kVV
	JV9r/m947dWWSMgdX+sfMjfUpBW9fwca7fZ/sfZvk+93neNIttZBt+pVJ656ybUj
	RaTQVB6v+6iayG/xR/sFm/A4kXT5kWQy61s7Z9ExxBwUYiTsWm0XQ==
X-ME-Sender: <xms:oMRtYbmwzycu6G2d_s9kPfJRTAaoxrrIiBvKVSWkA-0wJM0dq-mtzw>
    <xme:oMRtYe2QtizNxPUMQmSMKRAbiE4XzO3sKT95BylR3cU-B4ZkloeYTB3bTmPbYWAja
    MOz0fv32cD18WZLMA>
X-ME-Received: 
 <xmr:oMRtYRr7zCcy2ULD2iSBc8xzGYQOpstnxCRqQqEKH551WdfaqlAXoS39c2pj6PzOsvDGXjQ3b6SFQxeBFxQGsSM5jq_51w6aYQXys-6HCf5P>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvtddrvddvtddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefluhhsthhinhcuuehrohhnuggvrhcuoehjshgsrhhonhguvghr
    segtohhlugdqfhhrohhnthdrohhrgheqnecuggftrfgrthhtvghrnhepvdfhtdfhffeiff
    evteevieefuedvtdfhleduieetudekgefgveffgffffffffffhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhssghrohhnuggvrhestgholh
    guqdhfrhhonhhtrdhorhhg
X-ME-Proxy: <xmx:oMRtYTmyu2het38C-AGlTRaAaP_DrtrwQcG03gyaRFZsLH_jTiub1Q>
    <xmx:oMRtYZ3c2TDacfr00pzeT36EYqhUjirfSAdf0RlCkTHLp3SwM1E-KA>
    <xmx:oMRtYSuZmpAWCVTzQ6oObFL0hjBqdN_fktuYvsh5X6lM9FTwBWV_Cw>
    <xmx:oMRtYWgUkbzG1hcEWICzrh5M8fvBkIR4jQDxQx3T7WbKt7kpQmYEJA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <bitbake-devel@lists.openembedded.org>; Mon,
 18 Oct 2021 15:01:52 -0400 (EDT)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Subject: [1.46][PATCH 0/8] Backport fixes for Python 3.10 compatibility
Date: Mon, 18 Oct 2021 15:01:33 -0400
Message-Id: <20211018190141.15806-1-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 19:01:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12793

With Python 3.10.0 and the following patches bitbake-selftest passed for
me and I was able to run through my standard uses of bitbake.  Note that
all but the last commit are direct cherry-picks from master.

 lib/bb/compat.py              | 10 ----------
 lib/bb/data_smart.py          |  4 ++--
 lib/bb/event.py               | 16 ++++++++--------
 lib/bb/persist_data.py        | 13 +++++++------
 lib/bb/server/process.py      |  2 +-
 lib/bb/tests/event.py         | 17 +++++++++--------
 lib/bb/tests/fetch.py         |  6 +++---
 lib/bblayers/query.py         |  6 +++---
 lib/hashserv/server.py        |  4 ++--
 lib/layerindexlib/__init__.py |  1 -
 10 files changed, 35 insertions(+), 44 deletions(-)



