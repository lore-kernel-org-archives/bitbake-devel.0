Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54A2C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 11:21:46 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.34955.1741605698384535501
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Mar 2025 04:21:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ImkyaRPk;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40B1D44219;
	Mon, 10 Mar 2025 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741605696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0f5Q58Osn+OcFIcGzdkjPo26yDJ0tKWkMjGoc6qjCuA=;
	b=ImkyaRPk8GS9RALv49/SeS3LTvTP8kOff6KCpyI0yyH1fKa8NtWWxoOky71AEY3Ax8BS/9
	g4IXUByYf+546yLJaiUEp8Rkj5XKqm6IaEBfRBzmx+0Lm4ql5qEo39Wj/NQ8hVUwtmQEGL
	md2teMQ3yuRPzeFamrSNiXWMvdtpugPQiw0bv4y88Ig6T4diHOl6HupayVJQL7twcz47oN
	as+3ubO6rK9Mg2rn6utSV/6zLA9zmsQLL6xYI8jLFDF9sZRZ11dt8uGJy/ISoj9VykF+y3
	5J36P72U0KHLH50jUF6Kp28iii7O12M3RxWkd7pLN6cSpp4awnsyp2TxHrzZ0A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 10 Mar 2025 12:21:17 +0100
Subject: [PATCH] doc: bitbake-user-manual-metadata: document the
 include_all directive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-include-all-v1-1-76843785384d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIACzLzmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0MD3cy85JzSlFTdxJwc3VRDMyOzRLOUJBNjMyWgjoKi1LTMCrBp0bG
 1tQByywVPXQAAAA==
X-Change-ID: 20250310-include-all-e1626a6db436
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=tOH+YsXWs0VLo7SPzg+B23ppchKO3+Oy7KQGkLf7Yts=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnzss/qkpe2RdWbRF9jZlWbRBoI26jBfZmOjHti
 gvnOXv1LMyJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ87LPwAKCRDRgEFAKaOo
 NvgcEACi/0XWgb1wTSMPGQqvRSEIjIsxPClu6E/Dbn53sWTvLdYI2veEC5QmsaoUn2DCQw4PPmS
 uSquNBSLJhShvXoaN66OxQ1SBXOo7A4Z2OJA9CC7wgFATEnpcttpXRWf0zkJbm6r5XabIsAALww
 T0A+uZiTzEQJ15wUqDSprZEXmEiHA1ysOO46FnjZQJosm3GPc01XZRcNx3BIv3Avx4yg3HHht2q
 P5IH3iH+urFA6vhc7mO+QN2K2z6LlP1E3oxVBmR5kJddTAZ9SXvwd6IK3EzgQq04fJI6weF1MYt
 OX/InPmI9IGY5XKrQvcPYVrwT0yPPMQv+FeebljcyNbolMrz24oSSRdqGHBLxhyac+TQG5dVLoC
 2/UbnIVh+a0yHtHId0eb6hHxMyt4+XaiLgg10aQDKX1CX/hmDHcDdTmaxgVaRp+FUJ7acoAar1/
 NrUj2aw4RkTEylhe1FvsiScVIpph4wFXWuVHBPhXraVvvP7Q7ztohqZPYj2rqbxw4M1DKxFLEsP
 EMVP2AOagZe0roGEo+RUfv7xZproq4TzXRYhxWRgNOg9B5dq9Ek+N4Gp/h4cLXyytFx4WD9otjj
 6JFoK4X10M8FOQZC3Fs9ORa+frUMYC3pxllAqaMBYMbos35XjZgCXzoMJhcJNqQBunQ5ngPRnRg
 2v7FMgBaGP2Omxw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduieejledtieeuteffveetleeuffeivdffjefgteehgfehleeiteehieeuieekueenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsr
 dhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 11:21:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17418

From: Antonin Godard <antonin.godard@bootlin.com>

Document the include_all directive, which can be used to include
multiple files present in the same location in different layers.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-metadata.rst          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 2680c6ac2..415fbf6d6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -900,6 +900,33 @@ definitions::
    of include . Doing so makes sure that an error is produced if the file cannot
    be found.
 
+``include_all`` Directive
+-------------------------
+
+The ``include_all`` directive works like the :ref:`include
+<bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>`
+directive but will include all of the files that match the specified path in
+the enabled layers (layers part of :term:`BBLAYERS`).
+
+For example, let's say a ``maintainers.inc`` file is present in different layers
+and is conventionally placed in the ``conf/distro/include`` directory of each
+layer. In that case the ``include_all`` directive can be used to include
+the ``maintainers.inc`` file for all of these layers::
+
+   include_all conf/distro/include/maintainers.inc
+
+In other words, the ``maintainers.inc`` file for each layer is included through
+the :ref:`include <bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>`
+directive.
+
+BitBake will iterate through the colon-separated :term:`BBPATH` list to look for
+matching files to include, from left to right. As a consequence, matching files
+are included in that order.
+
+As the ``include_all`` directive uses the :ref:`include
+<bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>`
+directive in the background, no error is produced if no files are matched.
+
 .. _require-inclusion:
 
 ``require`` Directive

---
base-commit: d5562e007c7c64e8613a118ab9a6c73ed2063263
change-id: 20250310-include-all-e1626a6db436

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


