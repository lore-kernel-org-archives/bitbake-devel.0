Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90510C83F3B
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 09:07:11 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.16684.1752829629272828878
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Jul 2025 02:07:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=VNnrFgkN;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B589E431F6;
	Fri, 18 Jul 2025 09:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752829627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4OJBLLMxoKzikBZlyxsDnmwiUsHWPNBpcN4Qpo7/LE=;
	b=VNnrFgkN7CJUvkNWALjq3g5dKHqBrEp+kDqR8mCTJPiLYx/leZ1BXDE6R5E3nlYkTkdYlL
	9ROmQo+DaJcZFFgmziF8Wtx9N/w38Io2Bi8wxrhabSvlUbHpGQqD7IbN68ELcFJkT/iLaX
	W8ZlABuLWi+eTvPk2gUwgbLdbU0TOxCLT3Pg/yCnnO2Tx0IJ62rY3Bp8q8w9fv5UueboO4
	5TX6gvBfuCs8kWQgCuLuev3QV64RedMG1uB7NkN0mB3m7PmibqsV6BBKYy7V4V2hwB/GOY
	B6HoQzBMxTRDIQSuXTeIrkyT65ZBON6Ks7dEMnFn9dFOqwh7rVP8dMs5MvGB5Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 18 Jul 2025 11:06:58 +0200
Subject: [PATCH v2 2/2] doc/bitbake-user-manual-fetching: remove 'rev'
 default value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-new-tag-git-fetcher-v2-2-11240d481a05@bootlin.com>
References: <20250718-new-tag-git-fetcher-v2-0-11240d481a05@bootlin.com>
In-Reply-To: <20250718-new-tag-git-fetcher-v2-0-11240d481a05@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=C6kzm+hc8fxELXzkzZHbVFtkkC8cPPUWHe2F9Ar2I4o=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoeg66QgatMwvl6IXfUEb0QKGCjCy7DDht2kxp0
 JWzzSIGt+qJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaHoOugAKCRDRgEFAKaOo
 No8jD/4g5xSuucl0Ijs1BqTe8TWfYyrrzWmNPoqUizu4Hggjthwn/NXqsCJEOAhHz6aMnutJRXK
 WE8Gf/kNjGbyXwZOVFKCIAwR3tkjXB/I7MVno1pqMJ1KuK+UX1Cegbd3Ujb6enK9kA/ZW+O1TC7
 EDlMBuUD+PGmHXpY8p5B3UV2a0yMGRuAcCq0kw0g67XHdekU8BwriBPEcz3X3chsPJHWh135Q2/
 O9uZdi84l60Yz1rbEOJR5g4I+F2fGTKZ5nXpg0mx1+lbHpW94so/a3IUT3Seoou4NOsWkgaxr+8
 TYpDDRMSWyMUFXxX/Ya3iY/k8OKtPOO8qjAGSYJL+OdP8quAVb08Fjxo80q3/sA7KrCG+FnTmwa
 ED5003AOOlA53hhlpLHzLv1N4GHsO1s22ItW2JbMgJ3FhzXig7jufAtrpibQtfPlbcQv0cBgbj7
 hvWnhgPa86vVVCKJ5KcHAV8AI9BLt0yyPuIl+eYcMAdqRXvAcjtyUTR0bg7IzeKP3d5m7PwFYKW
 dmf7q4FSUcs1kez7fxOEFPXhCx+qPyEesG4Oo0FQB+32ocRmYCsaq7ebMjrnLC1Pks9Pvi4J9el
 w4LAYA56Q3PORK1r3qh0mFWoLa7W3AILM1E8tMK2HecpmYyb0yuXWPz+o+vmeL9Lks2LwtaI3gi
 SnvtXABZXuKwqUw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifedtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeigeeuhfefgeehfffgueeiteehieelfeehjeektefgkeeuheeuleduvdelgffhnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtr
 giiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhliiestghhvghrrhihrdguvg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 09:07:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17789

Remove rev's "master" default value. Mention that it must match SRCREV,
if set.

Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 51c9a81e03..d4496a9fb7 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -436,8 +436,8 @@ This fetcher supports the following parameters:
    "nobranch" is set to "1", this is a mandatory parameter. The number of
    branch parameters must match the number of name parameters.
 
--  *"rev":* The revision to use for the checkout. The default is
-   "master".
+-  *"rev":* The revision to use for the checkout. If :term:`SRCREV` is also set,
+   this parameter must match its value.
 
 -  *"tag":* Specifies a tag to match against the supplied revision (``rev=``).
    This does not replace the ``rev`` parameter: the ``tag`` parameter should

-- 
2.50.0


