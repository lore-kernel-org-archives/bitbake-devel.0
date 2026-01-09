Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5D6D232F8
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 08:59:06 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6395.1767949140282467922
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jan 2026 00:59:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=gpf85rLZ;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 92E2AC1F6D0
	for <bitbake-devel@lists.openembedded.org>; Fri,  9 Jan 2026 08:58:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D294460734;
	Fri,  9 Jan 2026 08:58:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8AA18103C814E;
	Fri,  9 Jan 2026 09:58:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767949137; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eK7rIMf0s1YVgUH400/BB+Amk+KckUZdWFgRHAme130=;
	b=gpf85rLZnDBKQqPqra4Rht92UM47UebPPgwucLs2G9aWTKTOJMX+YTlNqCt+j33LZx9WJW
	riYbyOYolbXxxi0zooZWffnha6jdzBQfVp2xXL+rzUL7QsMcauQRAc3+qI6VFyPu2E8YrI
	ZiidbsAQJRMYz4pCY/ZLI3SroO4BtqEnEKpH8JT4kZAIKrggQ+hunpkrFdLLyLA9x3IaiN
	WLnR106wgZMmQ/LFfFic3g6Uwtk4Ojh0JS4Acelr+QOUKGGdAmx7qgbNyid8l1RlkqOV5p
	WEx7ofLbUQaa932JDtW0WSOyJTH1bvXtvrJxqgJ0oqKy1Uhuw00RStI642UMGg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Jan 2026 09:58:56 +0100
Message-Id: <DFJXNWS384EV.3DJADARTCRNOG@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] doc/releases.rst: add whinlatter, move
 walnascar to EOL
Cc: <bitbake-devel@lists.openembedded.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Yoann Congal" <yoann.congal@smile.fr>
References: <20251219-update-releases-rst-v1-1-39fa5d19cb58@bootlin.com>
 <CAMSfU+6OuTd2Gbk2D7q5SJhDohB9SbguYb10ckeQV6xtfLuPwg@mail.gmail.com>
In-Reply-To: <CAMSfU+6OuTd2Gbk2D7q5SJhDohB9SbguYb10ckeQV6xtfLuPwg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 08:59:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18717

Hi,

On Thu Jan 8, 2026 at 12:28 PM CET, Yoann Congal wrote:
[...]
>> -******************************
>> -Release Series 5.2 (walnascar)
>> -******************************
>> +*******************************
>> +Release Series 5.3 (whinlatter)
>> +*******************************
>>
>> -- :yocto_docs:`BitBake 2.12 User Manual </bitbake/2.12/>`
>> +- :yocto_docs:`BitBake 2.14 User Manual </bitbake/2.14/>`
>>
>
> The correct bitbake version for whinlatter is 2.16 (not 2.14). See
> https://wiki.yoctoproject.org/wiki/Releases.
> Something happened and prevented the usual X.Y+2 jump, hence the X.Y+4 ju=
mp.

Thanks, I didn't notice that as the 2.14 branch existed in bitbake. I'll fi=
x it in v2.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


