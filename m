Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA13C433FE
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:31 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web11.11881.1645288830630662183
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=cSdyu0lM;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id D07752B000EB;
	Sat, 19 Feb 2022 11:40:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 19 Feb 2022 11:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=pENkI0
	QALoGSQoA6saL5l+YAIeFhTHSiVvdlKEr0nyo=; b=cSdyu0lMMvY8qUAMf7M3Uz
	CcBfh9V1VLTFsT6rJgWK1gczILTK5jQZvMONrOWpD02Zr02d/nyLCZvzgFvuNGaM
	a6fJDrTJuQuEFauITmZNuHNhr66VjAa6G+c8ypXPj4/dP5fFkjuNf6psnD6lwgB2
	PRvoeQRdFCdrk3qQbXvmwAnm6bno24jB+/378UGIJKMWuR2hc50nAWr6wDHUGftd
	D5YTAKa0N2oIA622UHMMcbjL5AQJUjUfquJWNcpW0RJLrL2fN/5raIaxJzCeA8qi
	nXx9dqR3QuaM2hzlGJXa5n2XutHS+C7voEVbODLpzAoEMznjyBQI0Jhk+BlBKLCQ
	==
X-ME-Sender: <xms:fR0RYqIb6Ki48MSIddMtvEOHN6rv-3vNcRxBp37WfHi-9_iF_5KXPQ>
    <xme:fR0RYiJs9bB_bWiNjdRYxgyLuoeoZusC4aP-Y-uDgPaKc7UjGk0mis0wDUzA1-L2e
    Tn28eaiFeBZrIAFCA>
X-ME-Received: 
 <xmr:fR0RYqvuXfr3UHDAMPGR4208I6CIKpvg-oqzq7S0kK2ABe1JEP4FeybO5HF_TdmzYJ6kpZ8RQu8W2M2in_sYkOyYXdFRBYqwKJIqe741Kb-ESY-B32q0PawDiwy7C7U>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:fR0RYvas85Lr80q5cktdIcPiq18hiTKuYiyA73gR5HFmH_xdTGDZyg>
    <xmx:fR0RYhZtMYKsqg0sL5tDv4reo72joxiYWY2QpALU5KOfYTHwG-OKCA>
    <xmx:fR0RYrDSO_xvVRQ5INux-Ivgszuuw0xFjrgNaP2DiSuaCoiot7dk-Q>
    <xmx:fR0RYj1Bemz-FRQz-hNCJNwneMEB7P4cNoy5URV4AOeKPre6DpYAC7HqJds>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:28 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 03/17] cookerdata: Fix typo "normally"
Date: Sat, 19 Feb 2022 17:40:07 +0100
Message-Id: <20220219164021.8344-3-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13370

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/cookerdata.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index a961f365..e4d91486 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -428,7 +428,7 @@ class CookerDataBuilder(object):
         for bbclass in bbclasses:
             data = _inherit(bbclass, data)
 
-        # Nomally we only register event handlers at the end of parsing .bb files
+        # Normally we only register event handlers at the end of parsing .bb files
         # We register any handlers we've found so far here...
         for var in data.getVar('__BBHANDLERS', False) or []:
             handlerfn = data.getVarFlag(var, "filename", False)
-- 
2.25.1


