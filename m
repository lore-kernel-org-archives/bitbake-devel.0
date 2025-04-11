Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A8FC369B1
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 14:46:31 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.28162.1744382786939879213
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Apr 2025 07:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=nCRY03bY;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E1EB43AE3;
	Fri, 11 Apr 2025 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744382785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stGLYBQOncJCwK8p30Ugeaub3H185haJsTzpGl4uv3M=;
	b=nCRY03bY+nOFoTHg1eBw0eyUj2qJ4TtDcqS2nXi7JsFHNtQWIHUSAtgqlG6qON0guwYnW0
	56F2EERkCHwt/++3KEa4t1dkAEWRkoKdmS7lqrKFOhCou6gp6RLLjWOrZA+iVp+cBpi9qg
	ZddG0I6VT33H96Z0zmcVdAHJZgX2koWJvBnV0vzqfd8RdnvcSTH1ELDu6S7oK4oDkMRDaw
	TCiyR6vxBFMNb5ihk5BjY1mBvtrV7jvoImC/0VafQ3k5ka2x6CQoD9NdnoSzFNSI+tzKTC
	ISW142MdP99AyzByBfj11pKKnaGN/ovEaSRsipXlCSxE9sXn769bqgBSWejFDQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 11 Apr 2025 16:46:10 +0200
Subject: [PATCH 2/2] doc: bitbake-user-manual-ref-variables: improve
 BB_PRESSURE_* doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-bb-pressure-improvements-v1-2-7d9e3593167f@bootlin.com>
References: <20250411-bb-pressure-improvements-v1-0-7d9e3593167f@bootlin.com>
In-Reply-To: <20250411-bb-pressure-improvements-v1-0-7d9e3593167f@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4336;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=yYHTERhxMrOc4ddXV7n5nDtMuMy5thO0duT7XafwEFs=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBn+StAtk/Y5uSixr1DEGz2WVLs6Q5/fr7/bKfsd
 uO2tR7o33CJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ/krQAAKCRDRgEFAKaOo
 NkEpD/4pkycbQ/DzhLNUYBXimt6+PYYMeG1CRSn2b2AjIKQTPAEj8pGpwiWV77QJjrAALNaaCn3
 OAAMeiJBfiI4zKBR3zI96yyI3v3gb2zkcetruCU8nHNTEbahqnJJghkaOCIEd1yxlBm/GO8T1dA
 onEHeCg6OYA9QbR9WTioehS2yOIq8JU8JNDZrL7PPANrS5C6zttKKFW7Pv6B0MkC9cpxlsRMW/2
 9ZuoDoHPJ7UfY8EgXhSHypOGaGR74pukM/zDpenYeCHayoXQ/DBRi86E3K7l4fAvel+J63+rhEz
 m9Rk5Oj1xrlnjube+49f1VQ/WTZGYrbkMwb1d0qHntIbDVgkuJ2z4amvnE15wReH5eCPT6piGBX
 xpueaGnrH71+qOygxMYL3XDXHC/fiPcxK7UwDOSsPRNL7sgHWyx9BgCjaCINv+PL5WT1/vW5d8u
 Um3eKNElhm7KnUKNsmZSNlPq0iVDgRq/5r41LwSghA2qoK0oA/4wKq3V+H2RS8OQ53EOjihpcz1
 vzawru+j16PdyBcrVvnaULLmq9vz4rWfiBmTiyz2XJh5+5/NK9bBWzmsyoKNZ1rJOG0PFBB/IHy
 1AaunT0U1FrfMPJo11xy3U6h0lAZCThqWpaTOhQ9HvpYkFB/9ujYyx2lYCmIdhkTQru0TfJ73KS
 sb0HNrPDaqghH7w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeigeetleehkeeggefhiedvveetfeetjedvledvffelgeehgeellefhiedutdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemiegsleelmegvfhehgeemvddtrgefmeeifhegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemiegsleelmegvfhehgeemvddtrgefmeeifhegvddphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdro
 hhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Apr 2025 14:46:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17527

The current default value for BB_PRESSURE_MAX_CPU is 500, which is
really low. Provide a value of 15000 which limits the load average
without being extremely slow either.

Provide similar values for BB_PRESSURE_MAX_IO and
BB_PRESSURE_MAX_MEMORY. Mention that these should be adjusted depending
on the need.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst          | 37 +++++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 477443e22..3364e57a8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -533,11 +533,18 @@ overview of their function and contents.
       version 4.20 expose under ``/proc/pressure``. The threshold represents
       the difference in "total" pressure from the previous second. The
       minimum value is 1.0 (extremely slow builds) and the maximum is
-      1000000 (a pressure value unlikely to ever be reached).
+      1000000 (a pressure value unlikely to ever be reached). See
+      https://docs.kernel.org/accounting/psi.html for more information.
 
-      This threshold can be set in ``conf/local.conf`` as::
+      A default value to limit the CPU pressure to be set in ``conf/local.conf``
+      could be::
+
+         BB_PRESSURE_MAX_CPU = "15000"
+
+      Multiple values should be tested on the build host to determine what suits
+      best, depending on the need for performances versus load average during
+      the build.
 
-         BB_PRESSURE_MAX_CPU = "500"
 
    :term:`BB_PRESSURE_MAX_IO`
       Specifies a maximum I/O pressure threshold, above which BitBake's
@@ -549,12 +556,22 @@ overview of their function and contents.
       version 4.20 expose under ``/proc/pressure``. The threshold represents
       the difference in "total" pressure from the previous second. The
       minimum value is 1.0 (extremely slow builds) and the maximum is
-      1000000 (a pressure value unlikely to ever be reached).
+      1000000 (a pressure value unlikely to ever be reached). See
+      https://docs.kernel.org/accounting/psi.html for more information.
 
       At this point in time, experiments show that IO pressure tends to
       be short-lived and regulating just the CPU with
       :term:`BB_PRESSURE_MAX_CPU` can help to reduce it.
 
+      A default value to limit the I/O pressure to be set in ``conf/local.conf``
+      could be::
+
+         BB_PRESSURE_MAX_IO = "15000"
+
+      Multiple values should be tested on the build host to determine what suits
+      best, depending on the need for performances versus I/O usage during the
+      build.
+
    :term:`BB_PRESSURE_MAX_MEMORY`
 
       Specifies a maximum memory pressure threshold, above which BitBake's
@@ -566,7 +583,8 @@ overview of their function and contents.
       version 4.20 expose under ``/proc/pressure``. The threshold represents
       the difference in "total" pressure from the previous second. The
       minimum value is 1.0 (extremely slow builds) and the maximum is
-      1000000 (a pressure value unlikely to ever be reached).
+      1000000 (a pressure value unlikely to ever be reached). See
+      https://docs.kernel.org/accounting/psi.html for more information.
 
       Memory pressure is experienced when time is spent swapping,
       refaulting pages from the page cache or performing direct reclaim.
@@ -574,6 +592,15 @@ overview of their function and contents.
       might be useful as a last resort to prevent OOM errors if they are
       occurring during builds.
 
+      A default value to limit the memory pressure to be set in
+      ``conf/local.conf`` could be::
+
+         BB_PRESSURE_MAX_MEMORY = "15000"
+
+      Multiple values should be tested on the build host to determine what suits
+      best, depending on the need for performances versus memory consumption
+      during the build.
+
    :term:`BB_RUNFMT`
       Specifies the name of the executable script files (i.e. run files)
       saved into ``${``\ :term:`T`\ ``}``. By default, the

-- 
2.47.0


