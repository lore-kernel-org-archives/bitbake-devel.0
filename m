Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCB7C83F34
	for <webhook@archiver.kernel.org>; Tue, 22 Jul 2025 11:41:53 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.10611.1753184505539818480
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Jul 2025 04:41:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Kt7u7cYV;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8AF5843B12;
	Tue, 22 Jul 2025 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753184503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tf7ou49mV2AaQB5rPAvKzpzjpNCqrnZrgGO3Ath4fic=;
	b=Kt7u7cYV+v6mSli70ib+bFOembJuVMqagYC0Gydj6Ul1iQdG45mylKX2m/QtbrTWP8RBD1
	COkejpMDlKCpsQVyKpA68bDgLMvM5aFfpm5r0kKzXgtqm938YiSNTkPO/sKLUJY8gCmFn5
	UPfw5o4cHGobBQHj92cP4jM4GbIWOWTdUwh5r3OUkeblnq0FuCl5cLv8o5CKBol0VoyfeU
	xqBq4JwF9/+1v2/TsCL5K3HwAh8LXswkASj1sFOpDSIZUwD3mLW4qM6H7Cb14pEXSKzx0A
	0QklJ2yv0t6s0De2nCKfZH70YT6uODAqk0CYWotVOuoEZ6Ayjazxptij1y8ODw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 22 Jul 2025 13:41:27 +0200
Subject: [PATCH v3] doc/bitbake-user-manual-fetching: update the Git
 fetcher tag description
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-new-tag-git-fetcher-v3-1-3753ad481b96@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAOZ4f2gC/33NTQ6CMBCG4auQrh3TGX6KrryHcQFlgCZKTdtUD
 eHuFlaaGJfvl8wzs/DsDHtxzGbhOBpv7JQi32VCj800MJgutSBJpVSoYOIHhGaAwQToOeiRHVR
 UK8qp17JFkS7vjnvz3NTzJfVofLDutT2JuK7/vYiAoBQX1YEOKPP21Fobrmbaa3sTqxjpU6l/K
 wQSEKmQXVFjI8tvZVmWN7A7Xoz+AAAA
X-Change-ID: 20250717-new-tag-git-fetcher-6287232fc0b1
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=yW/xAPogfdcq/YFC6pwiq45N0i3QuL8Qc4/1Pj5HGvA=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBof3j2vie8UrjREMF82bLCJDUhdljvnoWlTAXOB
 ksAQJVuw8GJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaH949gAKCRDRgEFAKaOo
 NkTXD/0RzBMb7ZFNKx7No9HOOWkKpUH0Xdy9pxxQQeLuudAN6tnB/O8XqzPahNLtgSQQChwlJ8O
 rFn0NMMcaHg9FV2bKc6FCLKQmUc+0a2BPQIbYpofqV/mTiHSPNaPZN5qKGbbTzlVTdLSm48jOKQ
 TsPvRXf52edHfU+Zz3ScRqq2Bzg4kgGaTbp80QfRsbA+5GHCDvvvwYuAWBFCC/4VEXlAKMmFian
 JChjC0+OQ3y1a+0hQTXS+7HhDFBCCsyTlwigNHcx2DJSoTjRUjJvYhFEFy2tRea0KbYiRQsZm9P
 YozpBq0ZkWRMdRztngfE69hHzPwhwJv3E1WK3YGgh58scQYOknmBfNcqSEIN6hV1cAnHq8cPdM2
 r7jqTYbx9/mTg5lMyIdNdkPtN3BBZvQiw419DGct8xHnFrSKnKd4JZg8RBIUqnjdsrimnCEb8nv
 XY66ufzlx5izdEFZ7Xi/sFzpa77kMEONpzp9BSZrojmRDkTIIpBXCYDpW4uQPuvSsLOuh5gcyZS
 kywg92dX6W93kZhXPWJ+X8OuJlfrluA6Jk8V1JYhHwCQ8zp2ZuJHQPqgQ6uqAjE8miiFRq6cyOZ
 oXS/4uIXbT9fuoUmZGOPnSUNyK/xniTQIbRihXOgVyQFSesaS9nhjIxRGGVv0wMCM4NI2B7589Y
 PiM+4hQvG8x+sJA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdegteehlefgheegvddufeevheehveeijedvfeduvdefvdekueduuedvjeelteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpr
 hgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Jul 2025 11:41:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17804

After commit d591d7633fe8 ("fetch/git: Rework tag parameter handling"),
update the description of the tag= parameter for the Git fetcher.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v3:
- Rework tag description as suggested by Richard in v2 (thanks!)
- Rebase on master
- Link to v2: https://lore.kernel.org/r/20250718-new-tag-git-fetcher-v2-0-11240d481a05@bootlin.com

Changes in v2:
- Suggestions by Quentin (thanks!):
  - not mandatory to -> optional
  - correct the rev parameter description
- Link to v1: https://lore.kernel.org/r/20250717-new-tag-git-fetcher-v1-1-77e46929103b@bootlin.com
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 4762d2637a..f357765b77 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -439,10 +439,12 @@ This fetcher supports the following parameters:
 -  *"rev":* The revision to use for the checkout. If :term:`SRCREV` is also set,
    this parameter must match its value.
 
--  *"tag":* Specifies a tag to use for the checkout. To correctly
-   resolve tags, BitBake must access the network. For that reason, tags
-   are often not used. As far as Git is concerned, the "tag" parameter
-   behaves effectively the same as the "rev" parameter.
+-  *"tag":* Specifies a tag to use when fetching. To correctly resolve
+   tags, BitBake must access the network. If a ``rev`` parameter or
+   :term:`SRCREV` is also specified, network access is not necessary to resolve
+   the tag and instead, it is verified that they both resolve to the same commit
+   SHA at unpack time.  The ``tag`` parameter is optional, but strongly
+   recommended if the checked out revision is a tag.
 
 -  *"subpath":* Limits the checkout to a specific subpath of the tree.
    By default, the whole tree is checked out.

---
base-commit: a8145c84e0899285a5e6a809f1515118b002b106
change-id: 20250717-new-tag-git-fetcher-6287232fc0b1

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


