Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507E3C369D2
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 15:16:01 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.14190.1744989354374203462
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Apr 2025 08:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=S3bBG85/;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D417143AD3;
	Fri, 18 Apr 2025 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744989353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pg//qKQ8pVUjeihUArsDkip4fImMKoFr+dKm4YCyO9E=;
	b=S3bBG85/gcY8i/KSHNhRJfONNrEWcjpT1hu52GK+eIpDwpu/uRmbsylFg0dnXVj6AKlmy+
	DvPqFHyAtjBfDv3QjD2EgbuOawbrAA08dIT9Rhsy9HiWTBt01WnCD273CNcilHFu5iwnIs
	CKLHPw3mV2MTMSIU8Hp6c3T9/BCKAOgmWxPHTgUVcVYBoNivDRp/5ducM9pGh6PaIZkEWl
	EuA2t2/dz69Qs8U3S6HTL27xRc87Su2iwLE0Hh84C8XCEutn7GvBoi+tIZs4eIex1MZF3E
	71fQFOPj6OMnMo5mkTy/Z4rV0jCJ1Sz3arKmEJQeHIb9mwEVlkqUhdc2DGuhxA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 18 Apr 2025 17:15:28 +0200
Subject: [PATCH 4/4] doc: bitbake-user-manual-metadata: provide link to new
 doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-library-functions-v1-4-3bbb836149d7@bootlin.com>
References: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
In-Reply-To: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=fdBF0xq3ECE6Qses/aPhdhDLa6AtSnKyUStBjq4FIAA=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoAmynLryvbbmuGQcMtdYz3bhluEeu35Cd6Yb5l
 eUK/rE+VJiJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaAJspwAKCRDRgEFAKaOo
 Nt1kD/9nHNrgmIebm4BeA6Qbjyk+rRI0a65aUGBcF1n5OplAAnRKQ5cB9t2ND1qGJdVSasmPHLC
 yq3HXndo5yd3EXjydLLubX3l5qlL1Qad6SHgiITDqiKPng9ugnS3eVF/soP+4ZY6Xik6AaTHOHj
 /DxKL4ui3OSnS2NMnWcqoV+/Ao2+FXzXIBo1Mm5MF0zPcRZVebdh78mAwpePlii1fJZOUBiVVV/
 jM1MaKYittbSegARBHPwyxYcJspBxfJ7/xLM5Y+ww44MF0fuaLkWuLkcUHm/yZKayEFlsiM7AWt
 AREluYQnkXLRxClDUFnvTS2q3LBmM7B89g9xOYScofPG53d3FCGIJaaY34+ACTleTezw+3hENgQ
 dSMDirTOhlEnzWpmjdaGK1SwXpOeNYEKyZ/pEn6rttfEV43WPD3unRS9sLS0JfjCm9v6fEekJTs
 RYRN3Xp4jjZJ3PCq65DGqVRhywJ0T34xMc7wWJB+EMLbMJNV81hSSu4TdcZPP6N+RjaDa5e9iPk
 q0jxbU/IVyIJhI2V4bdYhKQ2U5kQhqI9oIgnG4G34I/h3DH6EHP4SirTve4X5kWYd6QuB1u/dyb
 f8S7tEGHEfOEJoV8Aaw5fdEijN6Itav0yuu023A19kmnIsP9pOQzoyr19iPkIKknnTvg7hWWcHF
 ZRgII4WiIVqN75w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvgeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmedujegtvdemfeekjegrmehfieehmeehvdefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemudejtgdvmeefkeejrgemfheiheemhedvfeehpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhoj
 hgvtghtrdhorhhgpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Apr 2025 15:16:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17538

Replace the now obsolete paragraph of the "Other Functions" section by
a link to the new "Library Functions" document.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index db1749178..a27b7758d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -2074,11 +2074,8 @@ access. Here is a list of available operations:
 Other Functions
 ---------------
 
-You can find many other functions that can be called from Python by
-looking at the source code of the ``bb`` module, which is in
-``bitbake/lib/bb``. For example, ``bitbake/lib/bb/utils.py`` includes
-the commonly used functions ``bb.utils.contains()`` and
-``bb.utils.mkdirhier()``, which come with docstrings.
+Other functions are documented in the
+:doc:`/bitbake-user-manual/bitbake-user-manual-library-functions` document.
 
 Extending Python Library Code
 -----------------------------

-- 
2.47.0


