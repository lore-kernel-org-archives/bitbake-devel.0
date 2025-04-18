Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F884C369D3
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 15:16:01 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.14030.1744989353877283467
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Apr 2025 08:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=iithHi43;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 480F7433E9;
	Fri, 18 Apr 2025 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744989351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kTWrFMC+B0p05oNLpO1PO6yAkieX8hMuxkef8uMMIQE=;
	b=iithHi43ooDARNxDtc0lxiI1Rhkb2IHtKzv24yWxn3qZjyuTCJ3ePTBDyGBcNhuwZyjWI0
	DAJqkEaMRBXKn2OrAHkaNGPBhUw3Mqx4FfGuTbu2gv9AR/rNW6HC+Bxdr1f9IlYZ+NIxft
	2hFO6v+GQStrz4QG2VFQGkFDmHWbs6nNxVdtFcL+flLBleh54Sg0eymln2svyxYVnZxn03
	0UKJ/nAdAOxL4JGLJmi/6tOAAWgCCfZKsFg5ybADLbPfhEs1JK8mG20cC2FA6ccMy4klnC
	GDPVnODkL8lG5aJVHOjiE8b9sMhj50SnDownjnzLtSJKLC/mFSFtgOeTvI0Svw==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/4] Document library functions
Date: Fri, 18 Apr 2025 17:15:24 +0200
Message-Id: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIxsAmgC/x2M0QpAMBRAf2XdZytjE35FHjYubml0h2j5d8vjq
 XNOhIBMGKAVERgvCrT5BCoTMCzWzyhpTAxFXphcq1qu5NjyI6fTD0eSg6yaWpVGO2cbDanbGSe
 6/2fXv+8H5TyXqmMAAAA=
X-Change-ID: 20250418-library-functions-6981354bba94
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=uLOW55xpkH+oE4S07hvuyJP9gSjhVWL6B1P2ktnkpGI=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoAmymdV5NVyJVBZTsPscQnpTRGtJsYAdKqrT39
 w6I7JAN+cSJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaAJspgAKCRDRgEFAKaOo
 NpQoD/9qWFapFysgQgWHOtGDKnUreCfIh7W+v3Vr/qVkWXmK+PUIneMH1Tmkn9461TqjeAYPuQi
 uTntcuqXHWZIGvi16akjHBNYcAc3qUZdCTESc1AaxJ7cv8kXj+33BJoEhzw/+bRUbIEvhJdWUN5
 EI62VcBWyE+U6T670CAGuNGy8oPT5s6VF2+AxrPCl8pxCW369fU2LfaFdw26k8exc7kkNRxDHwp
 rM7OW/BT/tDZdXEK9VGmq9JIu8zB7o+HXGHmCFlGGwL8VBGzM+b4IOamdMUdxAcgnXel7qWCnVy
 kS78A13VtvFmVTSgqUk+RKULeqKaBcJkKYSPdhDowY/i8lad/pRugiVMLgzeNNGkDLgGOj+t9xV
 9bLvFo2j8aytJteu+tAyyzl4Qo25so9C3JDr7BK8YGw5N/ZX6+U0+ocPl2cRrGehgCnsTmDaXRs
 2nCMvJLJaVpyJqJqAFvdJ2HHylzqmkF9MY6myPnDLBZxjmUmnjJ7mZ1Bt6RYQ2ki9QfO6DtLdqz
 0T07CcQIbF1KeY5FbkcUGGRPr5IRdVRgM1dUsjx6x4V1k6mC4oSMc/N2yzfP0SnNwZrcls3b9Dn
 dhqVZ+H6LvFiD5cagcM9jtqnuyquyR6KBAGHn+12hj1bxGE/2OGb88UQRShMIXr6lEhdiJcB00t
 4CIixK4otKSEuDg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvgeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduvdefkeffteeluedvgffhjeegffduveegfffghfejteejkedvgfeuvedtudejkeenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmedujegtvdemfeekjegrmehfieehmeehvdefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemudejtgdvmeefkeejrgemfheiheemhedvfeehpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvt
 ghtrdhorhhgpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Apr 2025 15:16:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17535

Use the Sphinx autodoc extensions to document the functions from lib/.
For now logging utilities and bb.utils functions are automatically
documented. Some syntax a formatting needed to be done for the doc to
render properly.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (4):
      utils: format and improve docstrings
      lib/bb: format and improve logging docstrings
      doc: add a new Library Functions document
      doc: bitbake-user-manual-metadata: provide link to new doc

 .../bitbake-user-manual-library-functions.rst      |  59 ++
 .../bitbake-user-manual-metadata.rst               |   7 +-
 doc/conf.py                                        |   7 +
 doc/index.rst                                      |   1 +
 lib/bb/__init__.py                                 |  76 ++-
 lib/bb/utils.py                                    | 601 ++++++++++++++++-----
 6 files changed, 592 insertions(+), 159 deletions(-)
---
base-commit: 24772dd2ae6c0cd11540a260f15065f906fb0997
change-id: 20250418-library-functions-6981354bba94

Best regards,
--
Antonin Godard <antonin.godard@bootlin.com>


