Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4B0C433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:44:43 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web12.11923.1645289082446149384
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:44:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=CMQmJklM;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id E6A3C2B000E9;
	Sat, 19 Feb 2022 11:44:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 19 Feb 2022 11:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; bh=DP/+T64FgR+ZzQxnswascsojzbgRG
	5GafSDdAW+rQcI=; b=CMQmJklMxr62dbkvgKVKLy4xDvDRGihIGC1YghSUOsnMu
	NrWCSW/Y/Hc9VVWM84KB7Lorst/om9S/mCavqekRkt748GIN2BwQJXBGcLLMGWPS
	ZAPXEEDQ0GF5GCE/Va/unE25R28IWS/Rm8ak2APeqJAVj2go7UMQ2kDmp/PTKkIJ
	aknXBggsRTtwMJQI9IyRKq3q8BJaanwfFSKSWWtsGule7VA6IDx8eufqVglMwdhc
	ZlfgHN0GUIkwoMMNtuvLKFcPZk1v+ZsEe7/G3NYrQ1h8PZ/tFwCDhEovCUNgcVe0
	a+Q5uXWJE5hzZVaNdEdr2lHl82UHGYqDiQwFqijyA==
X-ME-Sender: <xms:eR4RYjYJXlipkShha6e4IRp5oT4sMsUTdocCb9D0SatHuB9jPXjw2g>
    <xme:eR4RYiaMDrbhdBcXlvLUiuyST6lUiN9vqLqc7vu1dpF-4mh7vMInGyy31qlLhbE_e
    _jPjgJCEpwJ88KrlA>
X-ME-Received: 
 <xmr:eR4RYl8ohLS1WfKM8o76sJzEdRYi6Lkd5s7VEC_J71vCeUKLK-oFk4gk3MywuL0fKLJ23wJNRRrdwbHKrx3Nkdng7i7wyIoDZ8nfxPxijk6xzk9CyIIu7XR3QHVwWq0>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhhtrdhk
    rhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpeeivdfhle
    dtieelieffuefgheekvdefffeihedvjeethfelhffftdehveekheevheenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrdhkrh
    ihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:eR4RYpr2AXeeVIVHWkO6ANb6NHAwXvEhXM-P92YMbwXWQbOc-EW74w>
    <xmx:eR4RYuofoI3woP-MO4Jx1J1mphjKTi_c-GhhZjgCej5uv0hr_vk_PA>
    <xmx:eR4RYvRueAJaQd7_Ml5olMiwydnHayanMuGDrdXwVP406E3d_AzysA>
    <xmx:eR4RYsHdLcyAW47M7JL_Ht6tWMZjdMikrCsncDLKlq3Oc8DmvXKkQyRrLM0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:44:40 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH] wget: move loop-invariant load of BB_ORIGENV
Date: Sat, 19 Feb 2022 17:44:39 +0100
Message-Id: <20220219164439.8534-1-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:44:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13385

BB_ORIGENV is used as a fallback environment block. It is repeatedly
access inside the loop. Since it is a loop invariant, move it out of the
loop.

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 253cabce..9a3a9d66 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -316,10 +316,10 @@ class Wget(FetchMethod):
         # to scope the changes to the build_opener request, which is when the
         # environment lookups happen.
         newenv = {}
+        origenv = d.getVar("BB_ORIGENV")
         for name in bb.fetch2.FETCH_EXPORT_VARS:
             value = d.getVar(name)
             if not value:
-                origenv = d.getVar("BB_ORIGENV")
                 if origenv:
                     value = origenv.getVar(name)
             if value:
-- 
2.25.1


