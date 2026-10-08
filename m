Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001ACCC6B1A
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 17:55:07 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3961.1791914096202968089
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 10:54:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=PRCkDhnX;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 086F6C653F9
	for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 17:55:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 685A360362
	for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 17:54:54 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 00E4F11D7186C; Tue, 13 Oct 2026 19:49:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791914094; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=F/erUpS/0jHejjqDFbo6wJCZ5xVTzYwrd42Jvq4Dd6I=;
	b=PRCkDhnXflXnX1SPCDmqpMylTJw5wFVQZCpeIgyXFxQHNZkKX+OAk4BwRddkzMbM2lSkNe
	EQ0BTm4UAfl104DygJA6Td0fPFxQYAUpqzDJa337oZrl+Zwr12he27IK4d3ah9AutxFdHw
	p8qBd0Qyrghv7OC79D0XYQ1mjH7vYi4e8atQtJT1JTx96dhfR20lYpk8eMmWdv/ZJt9xa4
	yD0e94N6EnHGI6xL+585yz8m+X1N/YhxMm0JtFuHQHXvRF9ukoszZcKjLgetq1OBjjY5MG
	1NsUOZF53j8tw96NzXwgQ5w4EbWri4RLDSbchR7BIJ6ouXwOR9qFpDvxsIvEgw==
Authentication-Results: mail.galae.net;
	none
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Oct 2026 08:59:41 +0200
Message-Id: <DLZ9GSOJRTMT.3IL2I0HZPLFE5@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/wget: rename the partial download
 on checksum mismatch
Cc: <jose.quaresma@oss.qualcomm.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <ricardo.salveti@oss.qualcomm.com>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com>
In-Reply-To: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com>
X-TUID: +Y6TMrY8EYoj
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 00E4F11D7186C
X-Spamd-Result: default: False [1.35 / 30.00];
	DATE_IN_PAST(1.00)[130];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.05)[56.02%];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	BCC(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[yoctoproject.org:url,openembedded.org:url,localhost:rdns,localhost:helo,bootlin.com:mid,bootlin.com:url,qualcomm.com:email];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim]
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 17:55:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20338

On Tue Sep 29, 2026 at 3:28 AM CEST, Ricardo Salveti via lists.openembedded=
.org wrote:
> The wget fetcher downloads into a .tmp file which is resumed with
> --continue and is shared with the mirrors of the same file. When it
> fails checksum verification it is left in place, so MIRRORS reuse the
> bad file instead of downloading their own copy and, without a mirror,
> every retry fails the same way until it is removed by hand. Rename it
> with rename_bad_checksum(), as done for any other file with a bad
> checksum, so it can be inspected and the next attempt starts from
> scratch. Mirror downloads skip this check and are still handled by the
> existing code once moved into place.
>
> Seen with parallel CI runners sharing DL_DIR on Amazon FSx for OpenZFS
> mounted over NFSv4.2. What corrupts the file there is not addressed,
> only the recovery on retry. Tested with the new tests, which fail
> without the fix.
>
> AI-Generated: Uses Claude Code (Claude Fable 5.1)
> Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> ---

Hi Ricardo,

I suspect this patch is responsible of intermittent failures we can see
during test_wget_corrupt_partial_download selftest, only on Fedora
workers.

https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16445

Do you have any clue about what might be wrong here?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


