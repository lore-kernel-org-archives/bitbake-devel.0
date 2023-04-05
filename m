Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE63C7619A
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 10:15:07 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web10.126280.1680689697687194727
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 03:15:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=Optk8jS9;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
	by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 335AEtak1307789
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 5 Apr 2023 12:14:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1680689695;
	bh=+k/UxlIW5sQI7L7buwHFVTrWN2AB/+jtK5vVvu0m3uE=; l=721;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=Optk8jS9kwNf5ggrtiO9VEHCZ7UdE0/kKvPmd4Ax0ACFqz2WAIpnu9RG+Uxw69QVg
	 3Ey+gXOBzqq5sUbsV6vz79EjUtt1D6xgK567OFvSmxAlTw3m4YwTuhbDws9donFzoD
	 EYxgUiLEkRh/eG3NPb6Y/PD+S3C8Z/tHfJy2Xuuq8mijl06EdM6waCjcM7gHltq6XY
	 MoVOtQvufYqkMB0hHKOE16CJRzRFEXCd+E1pplGV/S2Er1D05BlyhfBxsDDlCPTt4e
	 kYYmD07RMZGpn4KBsjpoozFn0YhWPTIT+CeLEU0W95GILlfs0SEUuHzWR0oKhJBUNn
	 rp0MxkvPQk5kA==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 335AEnBI1660877
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 5 Apr 2023 12:14:49 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ([192.168.12.72])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id 6FRCLKQ2YT; Wed, 05 Apr 2023 12:14:48 +0200
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 335AEmEX1269359
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 5 Apr 2023 12:14:48 +0200
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.96)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1pk0AC-00Dsm5-1E;
	Wed, 05 Apr 2023 12:14:48 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Martinsons <frederic.martinsons@gmail.com>
Cc: Martin Jansa <martin.jansa@gmail.com>, akuster <akuster@mvista.com>,
        bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at
 once
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
	<7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com>
	<CA+chaQcWaafMWnok=q+3SUcEj-+R99wxdC4JXpaM+rAGYCWhkg@mail.gmail.com>
	<68045681-5481-80f5-30f4-e15616503dcd@mvista.com>
	<CA+chaQead2PQ4yn7XSp-dejU+66kzROBOkAAeAJA42h=BSRLHg@mail.gmail.com>
	<CA+cAkeqJmpO2A6-bERPJjTuKt+e-MLBAgtFB34UOSRCb=7hBMw@mail.gmail.com>
	<lysfded5w3.fsf@ensc-pc.intern.sigma-chemnitz.de>
	<CA+cAkerNGGj6cadUKfk581kMEXSXqBF=DQC5MMwzZKsD_vmkHg@mail.gmail.com>
Date: Wed, 05 Apr 2023 12:14:48 +0200
In-Reply-To: <CA+cAkerNGGj6cadUKfk581kMEXSXqBF=DQC5MMwzZKsD_vmkHg@mail.gmail.com>
	(=?utf-8?B?IkZyw6lkw6lyaWM=?= Martinsons"'s message of "Wed, 5 Apr 2023
 11:51:58 +0200")
Message-ID: <lyo7o2d49z.fsf@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 642d4a185038ce378780cae1
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 10:15:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14644

Fr=C3=A9d=C3=A9ric Martinsons <frederic.martinsons@gmail.com> writes:

> I'm pretty new to cargo package (and even more with the support of it
> inside yocto) but I read from that the update_crates bitbake task is
> the way to go for those recipes and that cargo bitbake is not
> supported in yocto (see
> https://lists.openembedded.org/g/openembedded-core/message/178415)

well, the problem is, that 'cargo-update-recipe-crates' can be only used
to complete the list of crates with their sha256sum entries.

It is not suitable for creating the initial list of crates (which is not
a trivial task).  You have to use something like 'cargo bitbake' for it
(regardless of its maintenance status).



Enrico

