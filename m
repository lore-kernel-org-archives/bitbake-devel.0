Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F88C433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:45 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web09.11831.1645288844244055486
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=iXLR8QJT;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id AA9AF2B000FA;
	Sat, 19 Feb 2022 11:40:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 19 Feb 2022 11:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RYAYR0
	BBQwEOUdws/XRH9YDS3GbkPf0lfomknXsMnaE=; b=iXLR8QJTNd/fBj+fwg5Aez
	+Fur0dRv8I2KrH7v1OMsga66/5rrtP8v1g2Rd1YjnupVQoGLFWVAzj9bYsbkfnmR
	rovqf9rX7FD78P0zHrOHDSmAKSgvExvxamgP3oWpXi1uOouIr6+Vk/WVq3Is1rby
	tBYjMJH/M5i0CzZQR0a4gWwtGLJ/PIr87Xv5O6IeflbqsbjHjyCogv/GTRHTamj5
	pfLpLmdCGOO16strKqZA7aEnK6f7nFjVtweddMKo6eHtSnkbOMjKEqM5ySI/ABDS
	Rga9DcMTv3Dj0T2TSUm+h4XCWJnm/07sx3+xcLQYjSVmLbRtmb24GTQ0/9kztAUA
	==
X-ME-Sender: <xms:ix0RYhq5Sg_5HpItum_TBbqyfzjNDA1wG_2YUO9QITz8QESkPL9Nqw>
    <xme:ix0RYjpIDB391CCJqN-lrtajb_E1TADSwkAYxxkSGAULmYPuy1T0-UTuQQYMcimSk
    aT1I2rCx2km8ID1qA>
X-ME-Received: 
 <xmr:ix0RYuM09z-uAUD0ykxpNDWCMi3gwW5-XNGnogq5viXKtQ2jPXz11lt-w6HDkArLckDsZQCjCMxH-OlgoITnCgyR1C6ylfwASvPTCzRDsgvVByNkaK0u6eg6uSzoRpQ>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:ix0RYs7i7DXLmmnyRPXTY5HFJVR61Y-BeU0LXRL_lzVUKxPeIT-yng>
    <xmx:ix0RYg5qzb-Ol2xVRU9GEAbsLOIuBZgoXqkcYgSNxARQYb7QWpIPkg>
    <xmx:ix0RYkhYjaFin5ZqJsmBeh8caAMlXtO_KdU9OIQhS5erzJ_mDps7rA>
    <xmx:ix0RYlWIl0VidzhUXnBsPylvB76ONbawn6tZ2wLttZUBgyG43aLuyp4XQQc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:42 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 10/17] persist_data: Fix typo "committed"
Date: Sat, 19 Feb 2022 17:40:14 +0100
Message-Id: <20220219164021.8344-10-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13377

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/persist_data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index 49c9a0d5..9e20a837 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -63,7 +63,7 @@ class SQLTable(collections.abc.MutableMapping):
             """
             Decorator that starts a database transaction and creates a database
             cursor for performing queries. If no exception is thrown, the
-            database results are commited. If an exception occurs, the database
+            database results are committed. If an exception occurs, the database
             is rolled back. In all cases, the cursor is closed after the
             function ends.
 
-- 
2.25.1


