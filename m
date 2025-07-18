Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84147C83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 09:07:11 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.16685.1752829629381221665
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Jul 2025 02:07:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=N42ciIi1;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AC0241C7B;
	Fri, 18 Jul 2025 09:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752829627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ft8s2y3UrkAh8OxLoUai9arT4tS5ADcykdT7shUXP+E=;
	b=N42ciIi13d0Mg2S32z5VSvK9TxTYCbPO+nesk69zketK/uTjw8/cmz4coD4xW4+k3R6LAq
	D3DCeZWNYHlfoUH06spe7/NfNcz3ZUaxrvb19Jf0Vb+rC8FH7qF3ceDgzkNZJyTOmukG7E
	K5EzR/NWzZVJAjfmCp8lPTWLUS6yLnCYEiQpFmC3Hj6X5tD/mkJOvwUjPHtfmeimREFw9b
	/hVrxLPpn1ujEPwDnH8dcq6ovaKsGUvzGaKVhYg32rwR5qqXPhxSFRchYR78rWfLIPzsQG
	+whu3gLj6RUZqdMB+AbnNbbxggE15h7VPcIxLAWUjVViC2TzQDF2o8D9PNdPBA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 18 Jul 2025 11:06:57 +0200
Subject: [PATCH v2 1/2] doc/bitbake-user-manual-fetching: update the Git
 fetcher tag description
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-new-tag-git-fetcher-v2-1-11240d481a05@bootlin.com>
References: <20250718-new-tag-git-fetcher-v2-0-11240d481a05@bootlin.com>
In-Reply-To: <20250718-new-tag-git-fetcher-v2-0-11240d481a05@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=n9bOtXV124CCs8u9f7pGNwWECMWKnSDjQZXSFaQV0EY=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoeg66pKwrtM6CQICeihPvP53yfRzmpZTS+Ki2+
 jGRJV0uCT2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaHoOugAKCRDRgEFAKaOo
 NnbvEACI+jIpew0TCwO+t2QavmOzxqQYb9RK6wVEn6mP371n7fb/Gg1ot0zsKmEve/Uf3/g5Nrg
 inE/Q/afdHyJ2WwAuq8zNHB5r+GpN6A5TLXs/31oRs/NZO+gz7IIB/z8AliEvU8tJF7D1pApnpT
 UudHa5rdWX8G045G18n0yy+wRh98103OOYww+HxUvTNe20Ggj92urp96qVumhzf/txJDRuY3W7v
 04p1W9XelUXthnPJp1+V8HF6hNOYfDumADWG3vgOXT62A2k4a7hxbA8iSWJtPbXB6c5EYGQU+Ff
 RS29k33iZ48qwsacA7cD5oqvXSDx5Ajh68/O8cNjV5FRidllCGs69JCZ7ctalRcM6vOR8cRO1En
 YpuTWfznGupsx+t25FpebNnKfLS1gv8Uqk7xWHAaqhQFOWT7O3STHiNZgiWpdqduMIt1PgIBoQz
 6vg99RnjiX3rtxhVLzjk29NSHG/24G5td8+WQH+VvinZ2328Gq5trsy3g3wu9b8WD+PjAqeGLAE
 9KNMR0mGfUaqXUZOGpNrOFXKVYPK69geccdmnT6Ce6EhqMJGGvOb9GuQAtIeLJNtJYpdho29+yO
 gEchqjn7PVtybJZrg3+azmrJFpSTCBbP7EkJbqZ1ftyenMFp/fCSKX/+aHM+tVNX+wQKWYGh3OZ
 DSMIxxkIWL29kHA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifedtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeigeeuhfefgeehfffgueeiteehieelfeehjeektefgkeeuheeuleduvdelgffhnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopegrnhhtohhnihhnrdhgo
 hgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 09:07:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17790

After commit d591d7633fe8 ("fetch/git: Rework tag parameter handling"),
update the description of the tag= parameter for the Git fetcher.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index a2c2432db1..51c9a81e03 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -439,10 +439,11 @@ This fetcher supports the following parameters:
 -  *"rev":* The revision to use for the checkout. The default is
    "master".
 
--  *"tag":* Specifies a tag to use for the checkout. To correctly
-   resolve tags, BitBake must access the network. For that reason, tags
-   are often not used. As far as Git is concerned, the "tag" parameter
-   behaves effectively the same as the "rev" parameter.
+-  *"tag":* Specifies a tag to match against the supplied revision (``rev=``).
+   This does not replace the ``rev`` parameter: the ``tag`` parameter should
+   only be specified if you want to verify that the tag commit SHA matches the
+   supplied ``rev`` SHA. The ``tag`` parameter is optional, but strongly
+   recommended if the checked out revision is a tag.
 
 -  *"subpath":* Limits the checkout to a specific subpath of the tree.
    By default, the whole tree is checked out.

-- 
2.50.0


