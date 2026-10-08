Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165F7CC6B19
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 17:53:08 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3926.1791913981040938732
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 10:53:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ZslgDT2S;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 28C841A1217
	for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 17:52:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8E856075C
	for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 17:52:58 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 3361911D718A7; Tue, 13 Oct 2026 19:49:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791913978; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wgI7JU4vse6/TGuFinlIRY3uxIBgrzoS6ZpuXEd7qiU=;
	b=ZslgDT2SIAG629bt2Jbf4zzizLXbEfwq7eTgsslwD+rg/qsjCsbJGYEorr7L3UZnFKSn4x
	xAKDCFM2i6Fz17ZH8zG6enAvsp8HHTMVSqe5MeqC6zOOaF96EqaefTiPN9tBiiQibPM0rz
	1ErFzNAT/CpOQ3sAlwsMah9xwKVmgjqBBS5SIHt4CtpX5UjZDdEd2l2agdXix1iAUWVKXm
	FdFCmIPLItY+u9iEiw56Y7FtNnO/Z3zDmGexeTbAZ5YpENHcc84c/Wip4M3K3tvZHGCPwG
	v+6OTQEU5GuS7NpYg+CcLwU28NhX/IxXr4PVsKW09hpX/By7mli12fjjsfeClw==
Authentication-Results: mail.galae.net;
	none
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Oct 2026 16:41:31 +0200
Message-Id: <DLZJAED98DO0.J98TMY81UG2C@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/wget: rename the partial download
 on checksum mismatch
Cc: <bitbake-devel@lists.openembedded.org>, <jose.quaresma@oss.qualcomm.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Ricardo Salveti" <ricardo.salveti@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com>
 <DLZ9GSOJRTMT.3IL2I0HZPLFE5@bootlin.com>
 <CAA_5yot9BGhTmHH1v+NJicxrdpRM9+nkbryESmG5V18GW1+vzQ@mail.gmail.com>
In-Reply-To: <CAA_5yot9BGhTmHH1v+NJicxrdpRM9+nkbryESmG5V18GW1+vzQ@mail.gmail.com>
X-TUID: RGsiiE+unBoj
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 3361911D718A7
X-Spamd-Result: default: False [1.40 / 30.00];
	DATE_IN_PAST(1.00)[123];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[39.70%];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[];
	BCC(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,qualcomm.com:email,openembedded.org:url,bootlin.com:email,bootlin.com:mid,bootlin.com:url,yoctoproject.org:url];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim]
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 17:53:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20337

On Thu Oct 8, 2026 at 4:15 PM CEST, Ricardo Salveti wrote:
> Hi,
>
> On Thu, Oct 8, 2026 at 8:59=E2=80=AFAM Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> wrote:
>>
>> On Tue Sep 29, 2026 at 3:28 AM CEST, Ricardo Salveti via lists.openembed=
ded.org wrote:
>> > The wget fetcher downloads into a .tmp file which is resumed with
>> > --continue and is shared with the mirrors of the same file. When it
>> > fails checksum verification it is left in place, so MIRRORS reuse the
>> > bad file instead of downloading their own copy and, without a mirror,
>> > every retry fails the same way until it is removed by hand. Rename it
>> > with rename_bad_checksum(), as done for any other file with a bad
>> > checksum, so it can be inspected and the next attempt starts from
>> > scratch. Mirror downloads skip this check and are still handled by the
>> > existing code once moved into place.
>> >
>> > Seen with parallel CI runners sharing DL_DIR on Amazon FSx for OpenZFS
>> > mounted over NFSv4.2. What corrupts the file there is not addressed,
>> > only the recovery on retry. Tested with the new tests, which fail
>> > without the fix.
>> >
>> > AI-Generated: Uses Claude Code (Claude Fable 5.1)
>> > Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
>> > ---
>>
>> Hi Ricardo,
>>
>> I suspect this patch is responsible of intermittent failures we can see
>> during test_wget_corrupt_partial_download selftest, only on Fedora
>> workers.
>>
>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16445
>>
>> Do you have any clue about what might be wrong here?
>
> Should be fixed with
> https://patchwork.yoctoproject.org/project/bitbake/patch/20261006213334.3=
360919-1-ricardo.salveti@oss.qualcomm.com/,
> mind giving it a try?
>
> Thanks,
>
> Ricardo

Sorry, I thought it was still failing, but this is something else. I'll
keep you updated.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


