Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74960C433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:50 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web08.11632.1645288849716630097
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ciK2/nrs;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.west.internal (Postfix) with ESMTP id 2CEA42B000EB;
	Sat, 19 Feb 2022 11:40:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 19 Feb 2022 11:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ztHyGX
	uQL99yz/xgIIM4Yn1ZkZIPh3TJoJWqL3vZlHQ=; b=ciK2/nrsv0woFRsdswTdqs
	QO7HvMUxHtP8aQ4/8PNTGBH95XVsrVGzmOX364jONxA2mGTtjQqboXUy125D/So/
	hglzXKxbogrnQC9UtXH2CHvXCAoJ2XxtR6xcvrj5fulTVP/Q8fIXb8nu0d56LHDB
	tqNT3i2yNmIVjG8YGDoaUzFKsAEaERvzIweBvLYrpxyPpfOpkfSWvkEmcQEkU6zO
	I7/+Yu+XT8aZEWor9Py7jAxdOth9T0RETa6eteLmG9dpDjltlxe0aJnVdfXwywna
	ABInEpf9iZigBpky2fzO6qomMGJGpyWPa5W4nr+LON+EQm6VgkTHTcSwqEiZC66g
	==
X-ME-Sender: <xms:kB0RYnwWtvfeWhZufOYicaszf5DfObTjzAaZcUXv8xsacdOYQoIZvg>
    <xme:kB0RYvQWAZuZQJRT6KHqimcv_asNcGrTsQu2lkKMQ1Ba6_6Eq0z3OSzvM2D-2BXvq
    fbb0NIF5LVRliokzg>
X-ME-Received: 
 <xmr:kB0RYhVWZrJNouSXlrDwemdGBehxDqdEfu6jsh7YX1kOHDKx6ONwO1EqHCa32WSK3VmgQhZoNyRWfbkjVlNB5XmI4wGEzsavTyL6veUZANri2B0gdyOIYcF15SeBIYo>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:kB0RYhjxKL3tUK3DrTmxCxgXKUqmF9lVqJK5QxBcTO_pa5BHsZrkQQ>
    <xmx:kB0RYpD7baFdx7m8N-jSCXplFaanSWenRhtTOvkP755QC-aGg_CwJQ>
    <xmx:kB0RYqIYftU5J6lWu7gbis5-9JAqb6eCvtajbOMsYE4vyYQzxAUWhQ>
    <xmx:kB0RYk-0bfXZ82N-4g3gmEy6OXSPPqSqjGbXg1QJqfxgZSch6_NvqbfBEMU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:47 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 13/17] tinfoil: Fix typo "receive"
Date: Sat, 19 Feb 2022 17:40:17 +0100
Message-Id: <20220219164021.8344-13-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13380

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/tinfoil.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 27a34154..c3ad9211 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -493,7 +493,7 @@ class Tinfoil:
         Wait for an event from the server for the specified time.
         A timeout of 0 means don't wait if there are no events in the queue.
         Returns the next event in the queue or None if the timeout was
-        reached. Note that in order to recieve any events you will
+        reached. Note that in order to receive any events you will
         first need to set the internal event mask using set_event_mask()
         (otherwise whatever event mask the UI set up will be in effect).
         """
-- 
2.25.1


