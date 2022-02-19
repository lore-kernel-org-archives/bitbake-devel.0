Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B4AC433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:43 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web10.11893.1645288840189659696
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ATSys9pu;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.west.internal (Postfix) with ESMTP id 9CD4F2B000EB;
	Sat, 19 Feb 2022 11:40:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 19 Feb 2022 11:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=b4NtdA
	JSuoaCVXAaVNelFQwgCL/c8APGIVxrdhcH9Jg=; b=ATSys9puYChRmiFW/MqptO
	YhLUTB5cjQshXdw4giDphA11YYRGIahBhVC8Py68KP9R9RuNoemmiBjivLm32jq5
	cHSHwAij2uJkvbEl6Gu/D0pTsik8mbIybDUzeUgFg/yg1ZdEow4frvjvlZDpV6Nl
	hPA8ILsXHvULxD8ych3maY+LK5zriQGKL/lohsZrFUHbUGkZt//J08O8oBcumGWr
	I2o1FqMphzfNdb+zVCQcSDh4AzyIIQbgYq2ZvTz+HaDkKiQsDlAQXNV7LhodUACK
	KRgYworEz+w5vsvoIy8gM2HGF8cFBPuZzXJeE8q5n/fB/Zgjsfb+KPbNy4iGrYXw
	==
X-ME-Sender: <xms:hx0RYvBG8s3KA3UhZXHWD28hk-ffOUBeYnxlMjYL9fFDaUwr32h8Hg>
    <xme:hx0RYljwGSlN4CMgnSMdyDkaavtP3-GLdfbkZK4SRGZWMlNdMP4zpEh_8JCI4WRkJ
    -o6mJdept8RG4KSNg>
X-ME-Received: 
 <xmr:hx0RYqm9eqYzPuP9Ce_NiV-VZlkCyzFZ4Q5hkotgDYWBsAjS5S44wdD5--43ynesaZ6yIUQopBKCENbBYNiYQoWUMC9Y2ZEqWPQYkRDTAdWHM8rFnGBs4c4AJ2BfZOo>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:hx0RYhwDWNNENdvSq6w6odF5HMgpLE2j65Lu6r-1njIhidO841X0GQ>
    <xmx:hx0RYkQ_WHHf3MeeF2Ff5i17aC4ErgINMB4wi35-_U9mQgYB7SzmNg>
    <xmx:hx0RYkakAFf9HUwcO4HkvzkzUClND7Eq1fIJGL4qvZvgwqRvpcvqwg>
    <xmx:hx0RYjPWGj0DDr7j1pbTUdE7XPtjWVJmDBjwclCVJnd1wy1OYhJPDvyLxNI>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:38 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 08/17] fetch2: Fix typo "processed"
Date: Sat, 19 Feb 2022 17:40:12 +0100
Message-Id: <20220219164021.8344-8-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13375

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 18a71a07..a7e84e0d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -113,7 +113,7 @@ class MissingParameterError(BBFetchException):
         self.args = (missing, url)
 
 class ParameterError(BBFetchException):
-    """Exception raised when a url cannot be proccessed due to invalid parameters."""
+    """Exception raised when a url cannot be processed due to invalid parameters."""
     def __init__(self, message, url):
         msg = "URL: '%s' has invalid parameters. %s" % (url, message)
         self.url = url
-- 
2.25.1


