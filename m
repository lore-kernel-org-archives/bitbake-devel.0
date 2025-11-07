Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD45CCFA1C
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 11:17:00 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9043.1762514218601054488
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 03:16:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=1B3ZadRK;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B046BC0FAA0
	for <bitbake-devel@lists.openembedded.org>; Fri,  7 Nov 2025 11:16:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D7EBB606A6;
	Fri,  7 Nov 2025 11:16:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3750011852224;
	Fri,  7 Nov 2025 12:16:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762514215; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dlrPpa+h9rWpU8SfUTAUGaBDzSD6jY375gYxV0hq7/w=;
	b=1B3ZadRK/jU61aUVz5/AC51k82agExQ8o1/XD1OtoVUbebLKGhBWbA2xhVq5L3YtVTT2Wc
	yJBCdEx2Lxrq6IzTh7+b1alu2XsrvEQPNh3o6QRqCJnzk3z8xbwZ6HpfiyIFoS2FkSrGHW
	X7RNDm3qmCXDfD3Mg+ZAK3TIwVzPEdWB9JmCIDTErTEeNTyY5IeePmlxPiNILE59nQz0j2
	qUYL6M5pF0Ajz9AK0cG6K3ozpwCOI093CpjcZXMZGT9zMCmcmajkcgc0Ns44Brjfxfzfm0
	vmqfTPWonC7Ccz+PK6VAxwxVcj5ju1alcXhsThuDII/3wATANmBCTYNa4AfJJQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 07 Nov 2025 12:16:44 +0100
Subject: [PATCH v3 1/2] doc/conf.py: add wikipedia extlink
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-bitbake-setup-v3-1-9aa227ade002@bootlin.com>
References: <20251107-bitbake-setup-v3-0-9aa227ade002@bootlin.com>
In-Reply-To: <20251107-bitbake-setup-v3-0-9aa227ade002@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=652;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=8Uyj02sdsC+CaHZ7lVuFOsunetTYcsZQ2pPDNsTWABg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpDdUlbPQmSbWERLmhK+Y04tCEZiZVISUmTAJr9
 DBY4MQtqoCJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaQ3VJQAKCRDRgEFAKaOo
 NtSYD/wMFx6NQCeJAsQv3ux8GHcyCplTD9Ra6Izziyi/lY2TePwvvwWjVWoVr6CGr8Uk4lqLYuM
 r4dCcvNqZCzpPo8dh5kGVlhfcATt5eBSEPbxE6mmlXJsGQtJsM+P0XPnhL4jPHEUFKFq1IVBdNC
 F11rLJ96rqIgObw7FGZp4GVZXk9Ipq0qMvPdT3gY/kr4nNasYsP/I9AGa5q5e6nmHDVNU28jZgh
 6B9+NjHYA6lX07iUUOkVHxdKDfFlKN80/s/arPmjKAC/k3CmXXd8NAsfXOeAI3GYzpioEgi1yEx
 dGxcCIgaBG5jGcLJlE1x4BIzOHRx27Ukp8o6+w/jTtFP2g7Ts7Iy03Xs3/gJSfVaV7792k9fgza
 wHkbqS+GEdvBYa/ngE5/mnHpaVdeZk1l2mGaGKybiRM7d/v2UWiOK/eVUcPAwr8eOG6Lu7FTVch
 +0Sd6J7JQYOXhpvAqloVPZ93/OXEoJqXU8JiVVJ7e9Xksu4WWBnrKW0U+B7+INvoXbZ+sIUDjSE
 R8QuXSNACrdRiAs5fFarMp4Go0hspVmYF5rrjA3BhufVnYQEfmGBGwmhHa5U8e7bdopn4U+epUZ
 BtG2JtRa4PMPPixeeFfyphdvTB65lOqKjpY3oaABkruQFSyDNofhnhb2gG3Ji6TWx7tz59+VMAQ
 ar26wXIEnG0Rprg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 11:17:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18308

For use in the documentation.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/conf.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/conf.py b/doc/conf.py
index f61241e28b..bce386624e 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -39,6 +39,7 @@ author = 'Richard Purdie, Chris Larson, and Phil Blundell'
 extlinks = {
     'yocto_docs': ('https://docs.yoctoproject.org%s', None),
     'oe_lists': ('https://lists.openembedded.org%s', None),
+    'wikipedia': ('https://en.wikipedia.org/wiki/%s', None),
 }
 
 # -- General configuration ---------------------------------------------------

-- 
2.51.0


