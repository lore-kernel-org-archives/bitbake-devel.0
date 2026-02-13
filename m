Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864EBEDF16A
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 13:50:53 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71818.1770990651282024956
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Feb 2026 05:50:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=1G5rTI2E;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 59ACCC1E4A9
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0F14606BE
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE2D610368EA0;
	Fri, 13 Feb 2026 14:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770990649; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zz34w/TjKS30ZNqoFBiqBcoBiOmRS0I3KhR/JfczxNw=;
	b=1G5rTI2EgnKD3Fx4cMzRHFNIfhnmRpLlR0QCSthyWcr7XFllJp55paJWVE+vcVSMzkfnaR
	Hwp238VMz13g/F2MPAgHKu3HMfQV77x5U3hGXln47TGBM9Nblvf5/lvqnUyUVgMQgWVSA6
	gBTy9573e0pW4DD1tF8K8lAeVcEVxwppM5mcGKNldxPA/I7eRVe1hkRYTXteUPkVe9bOs7
	H4Ts6CKOHbg6RBLo0xfRfDMVVW2990jZ8nCi8btmVxkN98a7UtLLxAuIjGYpPQrum+C201
	XMQLD+d1NwPHKoR3z8q4f33cCL/smsbgsHrD+Cv4dFRLpDbAqZT4Cc31C+X/mA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 13 Feb 2026 14:50:41 +0100
Subject: [PATCH 3/4] bitbake-setup: print plain messages in quiet mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-improve-bbsetup-readability-v1-3-41cec3b06992@bootlin.com>
References: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
In-Reply-To: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=bpUDnkVUQCWcPByPfOFXy4LVJxmRaXf+AR83eJAIPOc=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpjyw2I2QK/1W7mbPtpt/RGNK/IpW/bfb/KRaDI
 ksX5qOQ9SeJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaY8sNgAKCRDRgEFAKaOo
 NlaTD/sEPRKklV2tjUX6a7BQrCcUkYxwx1y0QQItPI07OFMG41eQ9zhUrO+YbkOg73jVwdaKLzI
 D3rMu/k/L6NLB6T0W1JlH24ej9Tgenccf8bk5Pey3FuLXVGxzwfFSx+g/6HQVPBWVLrnwdPqXlo
 eQ1lXIc4KxXbht3Bni3beTRyo289I9x5ApIGq32r1wsNtLanBhWV4ijlvr7Pth3CFnnHEgACi79
 NutVv34h2rTs7U5kxFqYugsf+s6FhO8x6xqMIwBFOciKxCAiLc0aZnmSyw31FHrdFj+iRgYqk+O
 HAX7vwvz5R9jpobqOiQ32+Z6TJNPFCoEgCO/ksolxUg0Dv6xWxX2vXOmKgGoPFLxbHEr5spjXBH
 K6Na82oXX8SiVSUInUl2/3y+uOAKl38T/DxTs2n81FfHvSh2/REeBqdJdDXCIVYFFoR97tRPS75
 WnS4EBVY4PQiVaE69RbzsXaTnIzgkMq1DiJbqzf1+SUNKw08QBCzk2hOTz8+6Ts7rtgFKoGd++0
 Zfb4YlyHEen3OGYyEe6KHsBzrOnFrXQFAxqPyvSogqVNKsV4CJTDcjgrwqbR1opRDPPq3SZ8kpn
 dJQcMTMvd7UPKvRHQW6al7auHDGLrBlv/1iPUHrB5iKslEVeXZnigUx8U5Bbakivn0Y7nhKkNvN
 KvmUwCQ1wEveuzA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19025

At the moment, plain messages are not printed when --quiet is passed on
the command line. This makes no sense since bitbake-setup prints most of
the essential information with the logging.PLAIN level. Raise the quiet
logger level to logging.INFO + 1, which corresponds to the PLAIN level
in the BBLogFormatter class.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 6529e9f30b5..19db14edb3e 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1122,7 +1122,7 @@ def main():
     if args.debug:
         logger.setLevel(logging.DEBUG)
     elif args.quiet:
-        logger.setLevel(logging.ERROR)
+        logger.setLevel(logging.INFO + 1) # BBLogFormatter.PLAIN level
 
     global BBSETUP_COLOR
     if args.color == 'always' or (args.color == 'auto' and sys.stdout.isatty() and os.environ.get('NO_COLOR', '') == ''):

-- 
2.52.0


