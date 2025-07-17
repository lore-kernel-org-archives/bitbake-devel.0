Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05E7C83F1A
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 12:24:04 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.47218.1752755037720049870
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Jul 2025 05:23:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=fwSyzlVo;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E037843945;
	Thu, 17 Jul 2025 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752755036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GQYnbp+qeRBKLHtSi84qU+41lGvL2MszWqyZP0RlFPE=;
	b=fwSyzlVo9OeQmhOSIgE0CQWUQ6P+xLMBXY265GOa9OxL/loc98aQJ86CnNNzq1cFpPhEQV
	Jt25NM9KMH+FwJJ5h111tzlb472EnHX7TNlbQMphd+5s//P971aHdnWX5aZR5cS+10sGj7
	z+fGg8hwDWJlBCrO5aXwLMjmkbYxRL+3Uz4RbEITL9RhSf7Yv3eeSzN24DmtLvpUsN2fJN
	vnlthw+FFTJ2C0IcB/AreeZxiVf1XQcfeR/Naw5mQbRMuc0Wm6m+/RLwpZUr4eIhE3Bbc2
	tOuYninodY83zCZiIwYzIxFQm7eDeAHp6BEjO9vnZjQdRwi2/LII5LWWEtqsUQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 17 Jul 2025 14:23:43 +0200
Subject: [PATCH] doc/bitbake-user-manual-fetching: update the Git fetcher
 tag description
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-new-tag-git-fetcher-v1-1-77e46929103b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAE7reGgC/x3MQQqAIBBA0avErBvQiTK6SrQoG202FioVRHdPW
 r7F/w8kjsIJhuqByKck2UOBriuw2xw8o6zFQIpaZbTBwBfm2aOXjI6z3ThiR72hhpxVi4ZSHpG
 d3P91nN73AzpgeRJlAAAA
X-Change-ID: 20250717-new-tag-git-fetcher-6287232fc0b1
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=0696C29f0RMq2GxJR9OfdYZsbZXgWy4BUqB411AO6p4=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoeOtb6g/uFCnQDE8fO9/gPaI7D5ZkYfxb2OZTj
 l2/TIfmHOiJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaHjrWwAKCRDRgEFAKaOo
 NgGaEAC+9Ry+uASHlJhABgKdGw7v2f7EWs+nCcMn6Z5kF7+gXUMHrAhKbGAw4g0sleTwIqfklNT
 31Ntq9UnckzXOFg9EwZWs17gzd765QrJ/uTRMHhjdgj1NG5Ab/4VNUiXvhfnKwQzZlX27QUtaAI
 6qhHlM/1QTMBBrtZ35XOKYUsPucpiTZeQAZMy2SHdtCav0mYNl0b04b9GOiYgBn0XgAIxlAdw18
 AoB1fh1eYGyHYFx8lD3p2QfGys9dgNEbFEs3Pk2Zd6d2lNDqpFLBLNiRCtFmFIUGooqiW9eyAkt
 K03UiWJRU94dRmsF79tdNm64MS4tclcoZaxVAacZ19e7I3vdmsbBRM3sMV26WJb9JljBqL87Jnx
 bWty+zsVMafbh5R4Ohptsi3zMVSGVBKVJXHDTNRJg1sR3JRu0gfsA/mMsHiu/+5DamivEwPobQy
 +xIFcx0Trunx8c0ZFINRtDBH+FD/MFZop5dgdaF4ARPldh22DgTfD4GE9/An+ZfWKbECclktMPj
 SAwKhnYjMgVZwXa66UvFBtO3i6WLSD2BgzN1bNBjCQfT7ldCcxfHzxl9CG8aH37F50Tib0n/v5M
 POIK/IFIgKDH2cGhBa+o1/PsCMFh5rVAb23IOP0/d9fzIrHxGgoza4KhUxJUljlAoZF+5uEBqnJ
 jcfzs77B7CtaSCA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeijeeltdeiueetffevteelueffiedvffejgfethefgheelieetheeiueeikeeunecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgri
 iiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Jul 2025 12:24:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17783

After commit d591d7633fe8 ("fetch/git: Rework tag parameter handling"),
update the description of the tag= parameter for the Git fetcher.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index a2c2432db1..b3fc3ce72c 100644
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
+   supplied ``rev`` SHA. The ``tag`` parameter is not mandatory to use, but
+   strongly recommended.
 
 -  *"subpath":* Limits the checkout to a specific subpath of the tree.
    By default, the whole tree is checked out.

---
base-commit: 09f29a4968841ee5070f70277ba8c253bb14f017
change-id: 20250717-new-tag-git-fetcher-6287232fc0b1

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


