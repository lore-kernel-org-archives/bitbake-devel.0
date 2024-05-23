Return-Path: <dl9pf@gmx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F25C25B79
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 10:11:30 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by mx.groups.io with SMTP id smtpd.web10.12013.1716459089137777472
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 May 2024 03:11:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=dl9pf@gmx.de header.s=s31663417 header.b=Brm8aBRV;
 spf=pass (domain: gmx.de, ip: 212.227.17.21, mailfrom: dl9pf@gmx.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716459086; x=1717063886; i=dl9pf@gmx.de;
	bh=pd0M7ZOQi/FZiyVUs1oIY8TItjMuu1bJ55GlHRcPy3s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Brm8aBRVF9D5X9kKhZIpOvfJIg6XiaoA2FoIWUCErncCPyvjT6hIAwCb8qrdsjVB
	 ycH8SZMaVR/u/AiECCHbLCDLsn0QyMeCBPlYU6tk6E2yrePcg7w/MCsiTpRC7D11K
	 2IFFBSAqSf8lVJAzZ0VWAKS9KhKHlF7qmoEATEeKgGKkIGcdtEyqR4hYdlwz21zo8
	 lClLLQYBLzRnVvX/uHiFsvTrxGV8w2xMiIlUcSFU3U4f/+dUZjTUxO4YRM8PoZn00
	 PwNt7/GV47tU2FQrosX26iDIoCmBCHNsx9O7rOWkkuMPYvOQEhCqzIKfNVrjLeYbR
	 503FQ4s1zrFIUt9tUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arbeit.localnet ([77.23.168.18]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1ssW7l0sKF-00n6KU; Thu, 23
 May 2024 12:11:26 +0200
From: Jan-Simon =?ISO-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>,
 Joshua Watt <JPEWhacker@gmail.com>,
 Michael Halstead <mhalstead@linuxfoundation.org>
Cc: richard.purdie@linuxfoundation.org
Subject: Re: [bitbake-devel] hashserv performance issues
Date: Thu, 23 May 2024 12:11:25 +0200
Message-ID: <3558580.dWV9SEqChM@arbeit>
In-Reply-To: 
 <f13fdebcfa74757dbc51a79da995f47238873be7.camel@linuxfoundation.org>
References: 
 <17D1D17091A0A935.11581@lists.openembedded.org>
 <f13fdebcfa74757dbc51a79da995f47238873be7.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wNxfK1oQIfv20roz1naIhmLIv3DPWd8YjsC6wxiFivSnBkBUdw/
 8j5hWsTvVL/fWAAruWU24sUyY7Wb9JeIfqp+eFaDUgLXPl48tCx6xwbSZZg+9u5XSB9rC5g
 FvFCduWCBI6/nzRic1sOyZwhQU2YtRpS2c+r19jUsSGEfT6GqeoCSuM6ht8Cj5twi7J5vOh
 C1H28rYxSeF3IS8rpBSew==
UI-OutboundReport: notjunk:1;M01:P0:tfuF5njP6Lw=;u8VkuyoyS1SrOuHM5tFTVxv4exE
 f/2s/J4azXQptqxnUqWT75w1lCWbEA4vDujk2PbEdVUIW7m3JbXxJz1eWUOF684KGGJnn6anv
 f5PZKb78178BoDUVYzqj6NHtbjeI4aIXMc5ifUPw663oq78JrSTfEutvIR0/4AB9En/iDSPNR
 RwEXfObhKPFqMhCK8ZvOqWSgniE48UvTUOqh5Y+5EAJqNtV2ZVbrmNCgU7sCOuM7UO6MO5KbN
 N5xxUiB3y4o13ndQvEIMu4flpZDjhUvBCv/s8ZmPQQwpdCGrh456xqNGRtJUGnVCU7VdJ4gnQ
 ZAsCO5n5JgerMGArMSeiz6WefrI1jNa5rwCSZksSwFw5swo1oN6p73XuYslzNWVLt78pUdlt/
 rMQCvFrb7AYGelujgR8WpPCXsbQ+Dcnb72S3S/CpRzjC2tOuzGLY+Snfy3pmW/yzfDNwFKAlb
 mhp96E+gdidkONr1+LP61DJBmayD9LYzZCDWkdQldldL1upiKryfwZkxwnuA8BbNOgz1F/Hvz
 83wkCaUMzeO8Kotux9bX0SS+VmGUaplSD9TPVX26F2K7pICG8kwNfJ/Fm9weg33IyexK1nQ2x
 dT7VqU9q79XBsANphRWDlY1jQ2ESLmzcJSiCcbweFiYBXYmrV5AYrVlEweswZPIEuuHyQhcJ2
 hTzNVwVFkb8h8nrEW47rKUye0gTUyDUZq4Cc0rzRN0ruv4ZC2zCVsfeCk6MI+WYn5CSo/ND0a
 jM1o8Twzz5IHShjeGa4132gSDuWVOsd3Zm1FC4r0FWxL1hCEOeMye4YJSsciVNr34IaIaGREu
 WTLLp1c/jGiKM9VapEk8nOrxqRwBI4M+5+6/JLglk6BtM=
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 May 2024 10:11:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16243

Hi !

I share your concern ... and also with an eye on PRServ then.
If we solve this here, we should apply the same lesson there.=20

Can we rethink this maybe:
=2D both are "microservices"
=2D both are serving data stored in a (maybe even distributed) db
=2D both need the concept of an upstream server (or even servers?) to 'fede=
rate'

Essentially these bits should be a common codebase and the APIs a frontend =
to=20
that. Otherwise we will learn lessons twice the hard way and have to write=
=20
more code.


=46or the performance issue ...=20
would a local hashserv + upstream hashserv connection help ?
Or do we need to query things 'always' anyway up to the upstream ...=20


I'm willing to help, but would start on the deployment side as thats my=20
immediate need as we disabled hashserv with scarthgap and want it back. Onc=
e=20
this is up I can work my way down to code.


My 0,02=E2=82=AC=20

Best,
Jan-Simon

Am Mittwoch, 22. Mai 2024, 15:17:02 CEST schrieb Richard Purdie via=20
lists.openembedded.org:
> Joshua reminded me of how to get the server stats (thanks).
>=20
> For our public server:
>=20
> $ bitbake-hashclient --address wss://hashserv.yoctoproject.org/ws stats
> {
>     "requests": {
>         "average": 0.06250257539454776,
>         "max_time": 16.712204183917493,
>         "num": 381569673,
>         "stdev": 0.18345958610620752,
>         "total_time": 23849087.254955433
>     }
> }
>=20
> Compared to my local system:
>=20
> $ bitbake-hashclient --address ws://localhost:8686 stats
> {
>     "requests": {
>         "average": 0.0004462178160857849,
>         "max_time": 0.04537125899992134,
>         "num": 3121,
>         "stdev": 0.00163338261679226,
>         "total_time": 1.3926458040037346
>     }
> }
>=20
> For a world build with 38000 tasks, 38000 * 0.0625 =3D 2375 seconds or 39
> minutes, so I suspect the hash server performance is a real issue here
>=20
> :(
>=20
> Michael: Is there anything we can do?
>=20
> Cheers,
>=20
> Richard





