Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93736CD5BC5
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 11:10:47 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21464.1763032241046618706
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 03:10:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=RXrXUiOR;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 494C7C10F45
	for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 11:10:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 028886068C
	for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 11:10:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18373102F22CB;
	Thu, 13 Nov 2025 12:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763032238; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ggydC0PUsBsRnLOTar1uduh+b2eEU2hc24ozX+KrLUI=;
	b=RXrXUiORReT+XjFZG5jnUMHi5DkV3CznpVX7K+lZSKmcsVDI+InI+gjItJ2zi3HsxhBukc
	z5j2th5Wvex+c12im99czj6PlJs+JHU6dMbLPV/P40RfnTYjpTuvaFUTj269HXk8BnJ/k5
	tvTWlknQ98BLhcTz1pjPDtXz12BrMstbXLSwB1JHcazWwR2NYoG1jFf8MuHZYWNQfO9+fb
	ng6TKNbkjyjXguIWqhKYvGdqufzxByiQCsvOuZ5pl+gMZkiUhCzJ3FIJUR7wMkOMiYgyd8
	UWsLm7cRRlxXTkDzg68h5GSnkEe7LNTUrR3kHZx6AXzoQAgiYU4ii0EQw7uNlQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 13 Nov 2025 12:10:29 +0100
Subject: [PATCH] bitbake-setup: add description of DL_DIR in default
 site.conf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-add-dl-dir-comments-v1-1-01fbda836324@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAKS8FWkC/yXMQQ6CQAxA0auQrm1CmZCAVzEu6rRIiQxmisaEc
 HdGXb7F/xu4ZlOHc7VB1re5LamAThXEkdNd0aQYmrppiSggi6A8UCxjXOZZ0+rYaR+YteYwEJT
 ymXWwz+96uf7tr9ukcf2uYN8P16lTYncAAAA=
X-Change-ID: 20251113-add-dl-dir-comments-8e93aae0a3f1
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=wIaL1OH07perHQ/axP+xH8hk2Sy+QvjbH1+Hy0MWqng=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpFbytkwr1+INompPDKmAdYSdo2R+b1P0RWVe6r
 ZpBUUthb32JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRW8rQAKCRDRgEFAKaOo
 NlvID/9T4ej2j89hPv9jkda1WPV4WzBp6Jdw1G4QTjqev4DelCG6PSZ9e9lQpTGkw741svhqtmZ
 DR2nPKiFelRHUZbj61Z5Qul/B4q8EKjyi9XJS2jhd5/+leXalVPoglrd6maE0v3icSqDk6sLTID
 xsbCZSbCtXqQGItwGBsQ24NpQP3cxwAmqHaabXFxcKGchOL8f9/sU15gTW7GuD+70kG47BktUbj
 bBQUIxi9quHZaXRpHe4W8OexSEF37YIsLEeY6DmsTv525Hwqgtbq8LnU5LDGDoIkrnDhBiIaFnW
 q7WJIHJK/aBT3MNBrGRR4vyPn7/U+77yAgAV8nYtWou4PVE1x3L8JmZjsj+nXsDwVP5lM0mn1g0
 ROXgajytyjYHHCY8wHjcQazaDha5pPvgbvHoNbn+H1/xggAGXE1D6K/mZKCffkx2od79vxtp7k1
 JkW3Jk/DbvE2nXOWJfRry5564Q5yFpNpggHgdr8KjkrbTfw6qR7pTv1wngSlLfmGKkfVHIhEG7p
 aC5FfTS0Mnz2YFtJ+iGfbzmnumGHvNIwMXUJT6RUom/Ytbc+VbiNIkPiyho33M2B/WxJWb+qS0R
 XNgaf3vJ8+QCyFKcERcHOXtMhdR8ISKvSx0L0fvly/iMgDMEgrxsd9PA7ro6bLPOJFEc1HKvUhe
 Xiu2u25ivF9THAw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 11:10:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18368

Add the comment from the local.conf.sample file in meta-poky to the
default site.conf file. It's a better experience for the user to have a
quick description of the variable when opening the file for the first
time.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Note this is a follow-up to Joshua's patch:
https://lore.kernel.org/r/20251112172619.3764053-1-JPEWhacker@gmail.com
---
 bin/bitbake-setup | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 3a281defac..243c7c512b 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -683,6 +683,15 @@ def create_siteconf(top_dir, non_interactive, settings):
                 textwrap.dedent(
                     """\
                     # This file is intended for build host-specific bitbake settings
+
+                    # Where to place downloads
+                    #
+                    # During a first build the system will download many different source code
+                    # tarballs from various upstream projects. This can take a while, particularly
+                    # if your network connection is slow. These are all stored in DL_DIR. When
+                    # wiping and rebuilding you can preserve this directory to speed up this part of
+                    # subsequent builds. This directory is safe to share between multiple builds on
+                    # the same machine too.
                     DL_DIR = "{dl_dir}"
                     """.format(
                         dl_dir=settings["default"]["dl-dir"],

---
base-commit: fd7960eded6228486e75d1c253b5c672b24f505c
change-id: 20251113-add-dl-dir-comments-8e93aae0a3f1


