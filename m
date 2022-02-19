Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6D1C433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:59:51 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web09.12042.1645289990363705521
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:59:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=iGiD9JG3;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id 53D5C2B000E8;
	Sat, 19 Feb 2022 11:59:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 19 Feb 2022 11:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; bh=T/7kQuI0F2jaw3GV/Ki4jB8TYTvvY
	X9cDWh+SO8Ryeo=; b=iGiD9JG3OCxlzs5KVUjbiC2jriZ8KwqNrSY7d0RVvuhxT
	hOsj1735fQQkhXvTFbXPz0pg+EB/C9pVA2o72yZQoli44sz6rdK83soLHkhDL0pk
	Hroky9WFh/EqQ4nfFC55UvsTCEKV3OoleV9TXfU/dAUehs/P1DossCHLiSaedwUO
	5oJwPkFQJr98B6mYm+llDoOjqn+2OPKpjxdejc0cpbLmbQVnH0a4E8LR1yFjxY/H
	/1EfEiLUCy8LbLn06uGDVYlw8puaKHIE0aKEaF/4435I3yJXABG+Pu4ijSUc4kos
	ebkk0160YCBZ0rODnCj6dJEfAu2aSD4aLyD/ajinQ==
X-ME-Sender: <xms:AyIRYj9G1E-aoWhNO4YMKQyUj8akEjbrh3GiWEtS6uxB8CK18jBWOA>
    <xme:AyIRYvueiGC72oc4TGrHtXwVbcYcOtykGAvsDI0mnCB9di17fnNkK3ZN3-n58nROd
    lH8-BYtodKzuEdssA>
X-ME-Received: 
 <xmr:AyIRYhCLxQl7ojk9XjwbF69jB2j8P6XfZiXMEuQpcEDo0NHJq3cLuF6bUA4duMCRpsI07-HV1uthvEbgHCZPr-1KlBItl69QhZHhOxwp1srPD2Toet0jaHLnfJ2Z8fU>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhhtrdhk
    rhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpeeivdfhle
    dtieelieffuefgheekvdefffeihedvjeethfelhffftdehveekheevheenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrdhkrh
    ihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:AyIRYvcBsPs1qOuIKC2pYaeTpQdce169hsIhtkLtA9M2Fru9l96llQ>
    <xmx:AyIRYoOErIkybIuKp7OVpaykF4DJQYVsl97xwyVKcvijGB8t1WQpCQ>
    <xmx:AyIRYhm6LOFk0TUBbc5gH3IBBv-A0Cpq4386H7-st-wvSjU4dvSTlQ>
    <xmx:BCIRYjaWZZui6s6AdBiPf3snSCfevtsqxxM1KQjYF2YV2jkmV7o6FArjxkQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:59:47 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCHv2] wget: move loop-invariant load of BB_ORIGENV
Date: Sat, 19 Feb 2022 17:59:46 +0100
Message-Id: <20220219165946.9355-1-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:59:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13387

BB_ORIGENV is used as a fallback environment block. It is repeatedly
accessed inside the loop. Since it is a loop invariant, move it out of
the loop.

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/fetch2/wget.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 253cabce..2579a65c 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -316,12 +316,11 @@ class Wget(FetchMethod):
         # to scope the changes to the build_opener request, which is when the
         # environment lookups happen.
         newenv = {}
+        origenv = d.getVar("BB_ORIGENV")
         for name in bb.fetch2.FETCH_EXPORT_VARS:
             value = d.getVar(name)
-            if not value:
-                origenv = d.getVar("BB_ORIGENV")
-                if origenv:
-                    value = origenv.getVar(name)
+            if not value and origenv:
+                value = origenv.getVar(name)
             if value:
                 newenv[name] = value
 
-- 
2.25.1


