Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB01CCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 11:39:15 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11331.1762947541984810747
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 03:39:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=E0sbOPxn;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-2.intern.sigma-chemnitz.de (8.18.1/8.18.1) with ESMTPS id 5ACBcxFH453419
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 12:39:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1762947540;
	bh=DoHXrd0UTO5ek6ZxeQpkJSUiOFYDRm6fX8EhS6XK4ak=; l=812;
	h=From:To:Subject:In-Reply-To:References:Date;
	b=E0sbOPxnBUIZibKQCcb/stYFdjtibdclebc570/P0sj7v2seztYI31iT6dEZqeaU6
	 N51v1GusL4V7f75mSFLdYx1qxKnx8JsbLTqtrITQeqdIOZP6hlk/ecWdqeJ/8Irsky
	 H+006VHDPqxTURANGrc2vmuLA49HzpeeynjGI2lZjihAL4ztjRMEJ9rVnCgqejHW6Z
	 mgYcsDo9bya2Ku6oKplKGx9hmH2aEl7IQ5jVhaN7ZrcyKpg2jdhXNOzRydcYqyz1Tz
	 IEy0B8rg2/i65CFKcbn1LKoxigTYruPqUHOmADQlnqz2IJAazvR6P105XNSNv74jAw
	 Ir8Iio9y4dOAQ==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.18.1/8.18.1) with ESMTP id 5ACBcwsj4019123
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 12 Nov 2025 12:38:58 +0100
Received: from mail-msa-2.intern.sigma-chemnitz.de ([192.168.12.72])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id GEG2HUDVF3; Wed, 12 Nov 2025 12:38:57 +0100
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.18.1/8.18.1) with ESMTPS id 5ACBcv3B440515
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org> from ensc@sigma-chemnitz.de; Wed, 12 Nov 2025 12:38:57 +0100
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.98.2)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1vJ9Bh-0000000GZpf-3WQZ
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Nov 2025 12:38:57 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] Broken 'knotty' UI on Fedora 43
In-Reply-To: <lyldkbcy4m.fsf@ensc-pc.intern.sigma-chemnitz.de> (Enrico Scholz
	via lists openembedded org's message of "Wed, 12 Nov 2025 12:02:17
	+0100")
References: <lyldkbcy4m.fsf@ensc-pc.intern.sigma-chemnitz.de>
Date: Wed, 12 Nov 2025 12:38:57 +0100
Message-ID: <lyh5uzcwfi.fsf@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 691471d1f95b4083a919bb53
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 11:39:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18350

"Enrico Scholz via lists.openembedded.org"
<enrico.scholz=sigma-chemnitz.de@lists.openembedded.org> writes:

> when running recent bitbake master (2c6c40bda) under Fedora 43, the
> knotty UI is broken.  While building, it eats previous lines when a new
> task is started so that every output (Build Configuration, warnings) is
> removed at the end.
>
> Downgrading 3.14.0-1.fc43 to 3.13.9-1.fc42 restores the old behavior.
> Seen with 'screen' and 'xterm' $TERM.

Problem is

| cr = struct.unpack('hh', fcntl.ioctl(fd, self.termios.TIOCGWINSZ, '1234'))

which is accepted by old python but fails now with

| struct.unpack('hh', fcntl.ioctl(0, termios.TIOCGWINSZ, '1234'))
|                         ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
| SystemError: buffer overflow


I will provide a patch...



Enrico

