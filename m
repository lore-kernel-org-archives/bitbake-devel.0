Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C406CD98ED
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 15:13:15 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.156740.1781622297433906531
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 08:04:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@emlix.com header.s=20250930 header.b=DeBRHTGT;
 dkim=pass header.i=@emlix.com header.s=20250930 header.b=DeBRHTGT;
 spf=pass (domain: emlix.com, ip: 178.63.209.131, mailfrom: andreas.muetzel@emlix.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
	s=20250930; t=1781622295;
	bh=oY+Jg/jFw2CCo/lsI9WIKgVrXALpc+qUC3XSuvIFH00=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DeBRHTGT0ohI3mXYrrDdTPQWv7TcQ80xe9Fk8Xkmm8g6RqKKrvV4/V/yVN7RVDflD
	 6GUxG17PDPT0ArrrxJPdA9u447VHkwn1/Y+aXicMj3JvoMvsWAsH0DBeftyOdwHDcQ
	 6c9SzFuAML8pSL/ZyhyaSZRtTq1vHFkDOj2k0YWaK/TEA2Ccm94+agz94qoDbbcgFi
	 ZlT+BoeOSnal2jhtsHZjKb7+30RY4YymM6VbDMTyCqyxMefA9seBjMP7HMkQDCCdZ4
	 gT1jyTyLUA0qbbODlEdRNtgWSAPEvnsYr+++CY7RVjzS1TKAUPCxVhWwMGqDzWfCxM
	 JwBKLiO7pi9lw==
Received: from mx1.emlix.com (localhost [127.0.0.1])
	by mx1.emlix.com (Postfix) with ESMTP id 222725F9D3;
	Tue, 16 Jun 2026 17:04:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
	s=20250930; t=1781622295;
	bh=oY+Jg/jFw2CCo/lsI9WIKgVrXALpc+qUC3XSuvIFH00=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DeBRHTGT0ohI3mXYrrDdTPQWv7TcQ80xe9Fk8Xkmm8g6RqKKrvV4/V/yVN7RVDflD
	 6GUxG17PDPT0ArrrxJPdA9u447VHkwn1/Y+aXicMj3JvoMvsWAsH0DBeftyOdwHDcQ
	 6c9SzFuAML8pSL/ZyhyaSZRtTq1vHFkDOj2k0YWaK/TEA2Ccm94+agz94qoDbbcgFi
	 ZlT+BoeOSnal2jhtsHZjKb7+30RY4YymM6VbDMTyCqyxMefA9seBjMP7HMkQDCCdZ4
	 gT1jyTyLUA0qbbODlEdRNtgWSAPEvnsYr+++CY7RVjzS1TKAUPCxVhWwMGqDzWfCxM
	 JwBKLiO7pi9lw==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 045075F96C;
	Tue, 16 Jun 2026 17:04:55 +0200 (CEST)
From: =?UTF-8?B?QW5kcmVhcyBNw7x0emVs?= <andreas.muetzel@emlix.com>
To: bitbake-devel@lists.openembedded.org,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: make unpack_tracer available when fetching mirror URLs
Date: Tue, 16 Jun 2026 17:04:54 +0200
Message-ID: <7t_xLdSqSAGAMwHknc0miQ@emlix.com>
In-Reply-To: <DJAJV26HEHOV.88JA3ODFVZL8@bootlin.com>
References: 
 <20260616064749.36789-1-andreas.muetzel@emlix.com>
 <DJAJV26HEHOV.88JA3ODFVZL8@bootlin.com>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 15:13:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19712

On Tuesday, 16 June 2026 16:39:55 CEST Mathieu Dubois-Briand wrote:
> > It looks like bitbake-selftest is now failing:
> [...]
> AttributeError: 'FetchData' object has no attribute 'unpack_tracer'
> [...]
> Can you have a look at the issue?

Hi Mathieu,

sorry about that! Reproduced and fixed that on my end, I'll send patch v2 r=
ight away.

Best regards,
Andreas


=2D-=20
emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
Office M=C3=BCnchen: Am Knie 16, 81241 M=C3=BCnchen, Germany
http://www.emlix.com

emlix - your embedded Linux partner



