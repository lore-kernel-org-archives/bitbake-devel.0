Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E46C4332F
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 19:01:56 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by mx.groups.io with SMTP id smtpd.web10.12.1634583715127414657
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Oct 2021 12:01:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=mesmtp header.b=pJlBvKxO;
 spf=pass (domain: cold-front.org, ip: 66.111.4.29,
 mailfrom: jsbronder@cold-front.org)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 71A055C0073;
	Mon, 18 Oct 2021 15:01:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 18 Oct 2021 15:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=mesmtp; bh=quxwCo+h2V
	OGbIk2Elk0BjmTWFjx4b3eJZ58t0SfH0E=; b=pJlBvKxO3wlcZd3ZcN5YBqr+qg
	OM6tdqTbfCdvVsDpUNaS24eLu8kEzAMXX1uiWx+29fzTKM9vchqwjQ4gBHcGncd5
	ENZPwgUFC/9WvgSSxdMeJqCiIwc7iTG3gRf0Levh4IYF9boQzqMldoNy/0fObSi1
	sEK+QzPEXzu2/LJj8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; bh=quxwCo+h2VOGbIk2Elk0BjmTWFjx4b3eJZ58t0SfH0E=; b=bpBeC09Z
	kR2UDu//F18CS9LP1VjiaRdL+URUEcjY6/940cKbNh5AUOngDGKCXarBim0RUpI2
	wr6whWbichiOQOCF10VowcVOG/ilYBhKb7AgopkLJJ2WFHloBKR3IBV22kBzIYGX
	DG7yPog6hskw0AVoIZETUJ03obPneukcdaRduePWHYzVHLD1VA3WIGRVihog+uUV
	7uV1OL5qC4Plr3aKEMuzPWgZpTnrG1jNqCFcJE2bp+0UiqMAIymMcSLtH4hsFidN
	DXKIU2AaK9zZ/bxKuW8mwLV55srizsWC8hGWvUKzfBAE/IUSvJ3E8GlHWpMbF5Sz
	S+yzlLJ9L7sppQ==
X-ME-Sender: <xms:osRtYbdqzoMdJ_tFUvw2QsSKSMwTm-cYGz8cK_OYrkHzjuQNLUvDdA>
    <xme:osRtYRP2be2nDQVHE1DFxm0bY3A3N9woxzSHguXudWHgTUOzIod9lXXFHeH0eejlX
    lMHHpxHdJ-k-Zanrg>
X-ME-Received: 
 <xmr:osRtYUgwyy2oYXWPFBN8QFZNIBU-hsW9nlr9mOQKROKsZW_EqgxqHYpLmZfzhrm-U4b4YXCY_0-aIZdMp-Ogl0F02CNzb72KxTDzd7Jh9xTb>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvtddrvddvtddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhushht
    ihhnuceurhhonhguvghruceojhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorh
    hgqeenucggtffrrghtthgvrhhnpeetheeijefhfffhleefgffhueekfefguefhgfefieet
    ueegtdfgteeihefhudeiudenucffohhmrghinhepphihthhhohhnrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhssghrohhnuggv
    rhestgholhguqdhfrhhonhhtrdhorhhg
X-ME-Proxy: <xmx:osRtYc-qJ0RyF5y6xbkpklif8NeHPejV9X5pEApTM0KE526Y9jokDQ>
    <xmx:osRtYXt4cd1BiO9q_jyJEr4cd8QBhKYnUAODHkXCznupjDxnA9fZow>
    <xmx:osRtYbFq2XcPegGRX6VEHchmt_RrOjr4VSpW5qrFV3727ZetcKMS5A>
    <xmx:osRtYXIViLw914BLGk8HB4B_E-ZV5JuFUMU_x0q13GJXoWWWai1mDg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 15:01:54 -0400 (EDT)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Justin Bronder <jsbronder@cold-front.org>
Subject: [1.46][PATCH 3/8] bitbake: fix regexp deprecation warnings
Date: Mon, 18 Oct 2021 15:01:36 -0400
Message-Id: <20211018190141.15806-4-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018190141.15806-1-jsbronder@cold-front.org>
References: <20211018190141.15806-1-jsbronder@cold-front.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 19:01:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12796

From: Alexander Kanavin <alex.kanavin@gmail.com>

See here for details:
https://docs.python.org/3/library/re.html

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 lib/bblayers/query.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index fb6f550e..652a3acc 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -433,10 +433,10 @@ NOTE: .bbappend files can impact the dependencies.
                     line = fnfile.readline()
 
         # The "require/include xxx" in conf/machine/*.conf, .inc and .bbclass
-        conf_re = re.compile(".*/conf/machine/[^\/]*\.conf$")
-        inc_re = re.compile(".*\.inc$")
+        conf_re = re.compile(r".*/conf/machine/[^\/]*\.conf$")
+        inc_re = re.compile(r".*\.inc$")
         # The "inherit xxx" in .bbclass
-        bbclass_re = re.compile(".*\.bbclass$")
+        bbclass_re = re.compile(r".*\.bbclass$")
         for layerdir in self.bblayers:
             layername = self.get_layer_name(layerdir)
             for dirpath, dirnames, filenames in os.walk(layerdir):
-- 
2.33.0


