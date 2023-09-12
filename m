Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2445EE3F3B
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 21:47:02 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.30.1694555217604393134
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Sep 2023 14:46:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@pianon.eu header.s=mail20151219 header.b=KmvWAsyV;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id CC9C15C0096
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 23:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1694555215; x=1696369616; bh=L7
	Xwi3jDWaEgL81qcyhFIWWa4K3suJN3wymfPJVZmpQ=; b=KmvWAsyVR3i0+HAzai
	pLmOBk7+5+p30L7AioMURgSAe9DA6vIys4eUq/h8av30q28jnbrE+TSIGpBTQWhg
	sz137T54FCDYazdY4i8wHp/SEzquZQBpieijLLjzhfheAhIuHvPbcYcYO9XxTa9q
	9anlGeoxoO7QrljU8CZtjzBzE=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rtLz847lJNTa for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Sep 2023 23:46:55 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 416C45C0095
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 23:46:55 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 12 Sep 2023 23:46:55 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] initial idea for hooks needed for source tracing
In-Reply-To: <CAJdd5Gb1cTQyEqFPQ-_jGb4kaHzHG93SJis800K-q__A_LcTbg@mail.gmail.com>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
 <CAJdd5Gb5wn7GG-1T_5CYjyESdBXU1RGghVYkAtAwF_GNBpnayg@mail.gmail.com>
 <9924500659de9ef4cf2b0c6e127fa27a@pianon.eu>
 <CAJdd5Gb1cTQyEqFPQ-_jGb4kaHzHG93SJis800K-q__A_LcTbg@mail.gmail.com>
Message-ID: <56c7ad20479fc7e333bd007dcd4903c9@pianon.eu>
X-Sender: alberto@pianon.eu
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 21:47:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15037

On 2023-09-12 23:39, Joshua Watt wrote:
> On Tue, Sep 12, 2023 at 3:26=E2=80=AFPM Alberto Pianon <alberto@pianon.=
eu>=20
> wrote:
>>=20
>> On 2023-09-12 23:05, Joshua Watt wrote:
>> > I think this is much better; there's still a few rough edges
>> > (`function.__name__ =3D=3D "unpack_submodules"` is kinda gross :),
>>=20
>>=20
>> I know :) but I couldn't figure out something better off the top of my
>> head...
>>=20
>> The thing is that "function" is passed to process_submodules:
>> http://cgit.openembedded.org/bitbake-contrib/tree/lib/bb/fetch2/gitsm.=
py?h=3Dalpianon/srctrace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8#n=
43
>>=20
>> and it's executed for each submodule:
>> http://cgit.openembedded.org/bitbake-contrib/tree/lib/bb/fetch2/gitsm.=
py?h=3Dalpianon/srctrace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8#n=
152
>=20
> Maybe process_submodules could take an optional argument that
> indicates if the data should be added?
>=20

Yes :)
Like this?=20
http://cgit.openembedded.org/bitbake-contrib/commit/?h=3Dalpianon/srctrac=
e4

