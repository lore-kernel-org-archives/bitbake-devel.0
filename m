Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BA7C4167B
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:43:23 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.2183.1698774201653095301
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:43:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=FOkU/tVE;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F18BD9C08AD;
	Tue, 31 Oct 2023 13:43:20 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id M6gFC2hPpixy; Tue, 31 Oct 2023 13:43:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3B86C9C0B9B;
	Tue, 31 Oct 2023 13:43:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3B86C9C0B9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698774200; bh=1wQTqw6HfRzI2xQxOHz3lF8/dnCuQ+Kga+ENeXuhmPo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=FOkU/tVEph/hNTVAc/qzwFHPWgkb8F4GmDPOxhPkQcjRraiexZITAyF3LMufm2JuS
	 Uogqz0DAERUYB358TY3W7kg2jxw45zBxy+cvzkOo625diIXL+POsQOArq9U7Ajgeem
	 6DJmciQTFAfRZVIXo6V7hxVcIklj3eVVjBk0Ebqz64H3b6u2H5Mdj2+j6xrtbL8xxI
	 VL4sOFNuPpZXn4NmQaUYAqp5zPBquWabxZdD+AjhP/VsTJVpPaw5P1r9B5OyLS6fcY
	 6mchiH3KIMmFgb5QtI6BcgFFmMllZEzz67E4AZAYB6unmtwz8bOhKRsOco0RtY8DB4
	 hHUr1ZaYarYfA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id LgeAfS-rQd2p; Tue, 31 Oct 2023 13:43:20 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1C4D39C08AD;
	Tue, 31 Oct 2023 13:43:20 -0400 (EDT)
Date: Tue, 31 Oct 2023 13:43:19 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Tim Orling <ticotimo@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	toaster <toaster@lists.yoctoproject.org>
Message-ID: <1356747739.298841.1698774199817.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <9c0799acda8eb7751d518614477246db8456dead.camel@linuxfoundation.org>
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com> <20231030195037.232912-8-alassane.yattara@savoirfairelinux.com> <CANx9H-ChzdqV_wyra4RFhswNYZYmjaXO-iFdJvateo7NtL5f2A@mail.gmail.com> <9c0799acda8eb7751d518614477246db8456dead.camel@linuxfoundation.org>
Subject: Re: [Toaster] [bitbake-devel] [PATCH 8/8] Toaster: Added
 pytest.init file
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - GC117 (Linux)/8.8.15_GA_4570)
Thread-Topic: Toaster: Added pytest.init file
Thread-Index: 92vgzgsSWmlCdfwi9k2/3YD8iddldg==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:43:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15377

Tim,

> > Typo: pytest.ini file?=20
Non, pytest.init is a config file for pytest, next step is to merge this fi=
le with tox.init.=20
tox.ini file are the configuration files of the tox project, and can also b=
e used to hold pytest configuration if they have a [pytest] section.=20

----- Mail original -----
De: "Richard Purdie" <richard.purdie@linuxfoundation.org>
=C3=80: "Tim Orling" <ticotimo@gmail.com>, "Alassane Yattara" <alassane.yat=
tara@savoirfairelinux.com>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>, "toaster" <toas=
ter@lists.yoctoproject.org>
Envoy=C3=A9: Mardi 31 Octobre 2023 16:36:42
Objet: Re: [Toaster] [bitbake-devel] [PATCH 8/8] Toaster: Added pytest.init=
 file

On Tue, 2023-10-31 at 08:16 -0700, Tim Orling wrote:
>=20
>=20
> On Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara
> <alassane.yattara@savoirfairelinux.com> wrote:
> > Added pytest init file to configure pytest and generate test
> > reports.
> >=20
>=20
>=20
> Typo: pytest.ini file?
> =C2=A0
> >=20
> > Objective
> > - We propose to integrate the plugin Pytest to generate test
> > reports for Toaster application.
> > - To keep configurations to a minimal, we propose to integrate
> > Pytest with Tox(tox.ini).
> > - Tox will automate the execution of the Pytest test cases.=C2=A0=20
> >=20
> > Pros
> > - Generate test reports
> > - Create a historical record of test results over time
> > - Track Toasters stability and quality=20
> > - Documentation and Transparency
> > - Debugging, troubleshooting=C2=A0 : identify regressions (input,
> > output,)=20
> >=20
> > Cons
> > - Limited predefined report options. Although Pytest provides
> > different report
> > formats, its default reports are rather straightforward, We might
> > have to put extra effort into crafting them ourselves.
> >=20
>=20
>=20
> One of the benefits of pytest is in fact that report plugins are
> available and fairly straightforward to implement if we need our own
> custom report format (although we should avoid=C2=A0custom plugins and us=
e
> upstream maintained ones wherever possible).=C2=A0
>=20
> We do need to ensure that plain text output is generated for
> consumption by the AutoBuilder. Fancy html output is going to clutter
> the testresults.json that will be where these test results will
> ultimately be stored:
> https://git.yoctoproject.org/poky/plain/scripts/resulttool
> https://git.yoctoproject.org/yocto-testresults/
> https://docs.yoctoproject.org/test-manual/understand-autobuilder.html?hig=
hlight=3Dresulttool#resulttool
>=20
> The reason is that the testresults.json=C2=A0is consumed by tooling to
> look for regressions. It must be machine readable and easily
> processed.

Tim is correct that we do need text/machine readable results for
tesresults.json but there is also a case for generating graphical/html
reports alongside the results. =C2=A0An example would be our build
performance tests:

https://autobuilder.yocto.io/pub/non-release/20231030-22/testresults/buildp=
erf-alma8/perf-alma8_master_20231030150044_28324600cb.html

where we've saved text data but also show it more visually.

Cheers,

Richard

