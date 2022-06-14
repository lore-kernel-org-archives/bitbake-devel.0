Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEF1C433EF
	for <webhook@archiver.kernel.org>; Tue, 14 Jun 2022 07:57:43 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web08.3636.1655193448629858530
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Jun 2022 00:57:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PlkHBFeY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id
 r123-20020a1c2b81000000b0039c1439c33cso4312149wmr.5
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Jun 2022 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=Ojq9KCqI7Jhm1KTo5zBDcWtrdDyh4Vki6ozlsEUSXUs=;
        b=PlkHBFeYRQwfqW/SPSETk8OFSa8qaA7+nnB/bBYJPTAXT0v2OSki6d0z2CAwjvQ1IB
         DB33gau7s6pzUqcnZVl9FMSxEkx1ISMf7vgYBs0S7mcf/afoXuNFNVjaE00dXfKVL41b
         VqtXLYBhblBIxHbmgoFWe0m12jwTzynfm2NOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Ojq9KCqI7Jhm1KTo5zBDcWtrdDyh4Vki6ozlsEUSXUs=;
        b=F83glijBVA3TfRv0Xrr27cztc36XuCStXKeT8Nx8UUMBBhKSi4hYjMdk4v47bCjEdj
         GhJtwgz6GGd+NsRKUIhL/JY/JdI5BMsdAIAYJrBaZLbaDnwnXo99m73xC3rJ31rLobjJ
         x0dziyGkabJ2ilLYWQ0uuPGkMxLHUiG0sFPWnJmJKOqLuVKuNS2684qvxOx7vdXsd9TN
         t2XGNJ0bAyWhu77ptcqHKNKBvC/pJKpVcb1F3+RTk06RiWa6GW3p6BSZ1nQpbyiX55dc
         O9VsLimoAvMFdopCPZFDJC3LnA5YhGg+3r9YAozWjLz9xmXluV6ocxIt+haVqf7ARYeX
         QWLg==
X-Gm-Message-State: AOAM532ScHQT0rZDEmKLsts3Viu4pmqIeN7hQCUGy0peW2q0SHXi3blA
	H6SHLYBZ/D4eQuohLHll4UoiNw==
X-Google-Smtp-Source: 
 ABdhPJy/ZlRHjByiZOZUahZ9fau8x1CthWyGAcyFSa/ZYH8du4mF5JYX8lwdGNULawYfXBmYZ6ynNw==
X-Received: by 2002:a05:600c:1ca5:b0:39b:a66b:7805 with SMTP id
 k37-20020a05600c1ca500b0039ba66b7805mr2616988wms.87.1655193447035;
        Tue, 14 Jun 2022 00:57:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8492:b0dd:b0ac:744a?
 ([2001:8b0:aba:5f3c:8492:b0dd:b0ac:744a])
        by smtp.gmail.com with ESMTPSA id
 n31-20020a05600c501f00b003976fbfbf00sm12071921wmr.30.2022.06.14.00.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 00:57:26 -0700 (PDT)
Message-ID: 
 <de66a6b77cfd93e9bda73cca63b5304313cd2f72.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] bitbake-user-manual: Correct
 description of the ??= operator
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jacob Kroon <jacob.kroon@gmail.com>, Peter Kjellerstedt
	 <peter.kjellerstedt@axis.com>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Date: Tue, 14 Jun 2022 08:57:25 +0100
In-Reply-To: <7658eb73-46d9-6c6e-2969-a8862b37d86d@gmail.com>
References: <20220610190845.181330-1-jacob.kroon@gmail.com>
	 <3f8312432bfa45e7a369e5c5a793569e@axis.com>
	 <7658eb73-46d9-6c6e-2969-a8862b37d86d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Jun 2022 07:57:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13760

On Tue, 2022-06-14 at 09:46 +0200, Jacob Kroon wrote:
> Hi Peter,
>=20
> Thanks for the comments, I don't claim to be a data_smart.py expert so=
=20
> bear with me below:
>=20
> On 6/13/22 18:57, Peter Kjellerstedt wrote:
> > > -----Original Message-----
> > > From: bitbake-devel@lists.openembedded.org <bitbake-
> > > devel@lists.openembedded.org> On Behalf Of Jacob Kroon
> > > Sent: den 10 juni 2022 21:09
> > > To: bitbake-devel@lists.openembedded.org
> > > Cc: docs@lists.yoctoproject.org
> > > Subject: [bitbake-devel] [PATCH v3] bitbake-user-manual: Correct
> > > description of the ??=3D operator
> > >=20
> > > Stating that the assignment is done at the end of parsing is misleadi=
ng.
> > > The weak default value is the value which a variable will expand to i=
f no
> > > value
> > > has been assigned to it using any of the assignment operators.
> > >=20
> > > Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> > > ---
> > >=20
> > > Changes in v3:
> > > * Update commit message
> > > * Change "... via one of ..." to "... via any of ..."
> > >=20
> > > Changes in v2:
> > > * Add comment to line with immediate variable expansion
> > >=20
> > >   .../bitbake-user-manual-metadata.rst          | 31 +++++++++-------=
---
> > >   1 file changed, 15 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > > b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > > index af4b1358..45355b6c 100644
> > > --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > > +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > > @@ -195,22 +195,21 @@ value. However, if ``A`` is not set, the variab=
le is
> > > set to "aval".
> > >   Setting a weak default value (??=3D)
> > >   ----------------------------------
> > >=20
> > > -It is possible to use a "weaker" assignment than in the previous sec=
tion
> > > -by using the "??=3D" operator. This assignment behaves identical to =
"?=3D"
> > > -except that the assignment is made at the end of the parsing process
> > > -rather than immediately. Consequently, when multiple "??=3D" assignm=
ents
> > > -exist, the last one is used. Also, any "=3D" or "?=3D" assignment wi=
ll
> > > -override the value set with "??=3D". Here is an example::
> > > -
> > > -   A ??=3D "somevalue"
> > > -   A ??=3D "someothervalue"
> > > -
> > > -If ``A`` is set before the above statements are
> > > -parsed, the variable retains its value. If ``A`` is not set, the
> > > -variable is set to "someothervalue".
> > > -
> > > -Again, this assignment is a "lazy" or "weak" assignment because it d=
oes
> > > -not occur until the end of the parsing process.
> > > +The weak default value of a variable is the value which that variabl=
e
> > > +will expand to if no value has been assigned to it via any of the ot=
her
> > > +assignment operators. Here is an example::
> > > +
> > > +   W ??=3D "x"
> > > +   A :=3D "${W}" # Immediate variable expansion
> > > +   W ??=3D "y"
> > > +   B =3D "${W}"
> > > +   W ?=3D "z"
> > > +
> > > +After parsing we will have::
> > > +
> > > +   A =3D "x"
> > > +   B =3D "z"
> > > +   W =3D "z"
> > >=20
> > >   Immediate variable expansion (:=3D)
> > >   ---------------------------------
> >=20
> > I think the new description is missing some of the information of the
> > original description, e.g., "when multiple "??=3D" assignments exist, t=
he
> > last one is used". So, e.g.:
> >=20
> > W ??=3D "x"
> > W ??=3D "y"
> >=20
> > gives
> >=20
> > W =3D "y"
> >=20
>=20
> I think saying
>=20
> "when multiple "??=3D" assignments exist, the last one is used"
>=20
> is too vague because it depends on when and how you reference the=20
> variable. It is not always the "last one" that ends up "being used".

The last value set during parsing order is used as the weak default
value.

> How about something like:
>=20
> "The ??=3D assignment operator takes effect immediately, overriding any=
=20
> previously defined weak default value"

I do think you need to spell this out with an example as it isn't what
people expect.

> > Another interesting case that is easy to get wrong is:
> >=20
> > W ??=3D "x"
> > W +=3D "y"
> >=20
> > that gives
> >=20
> > W =3D " y"
> > =09
>=20
> Given the definition of the weak default value and the fact that the +=3D=
=20
> operator does not involve expanding the LHS before appending, this is=20
> the result I would expect. Should we add an example to the docs ?

Yes, definitely. Whilst it makes sense, people often don't expect it.

> > and which should be compared to
> >=20
> > W ??=3D "x"
> > W:append =3D " y"
> >=20
> > that gives
> >=20
> > W =3D "x y"
> >=20
>=20
> The docs states overrides are applied "at variable expansion time". But=
=20
> if the new definition of a weak default value that I am proposing is=20
> true, the variable content is expanded first, then the overrides are=20
> applied, in order to match the result above. But is that true ? I'm not=
=20
> that acquainted with data_smart.py to have the confidence in saying so.
>=20
> Richard or any other data_smart.py expert, can you shed some light on=20
> all of this ?

??=3D is the value given to a variable if nothing else sets it.

In the above example it is given a weak default value of "x". " y" is
then appended to the base value which would be "x" since nothing else
sets it. Again, it does make sense we need to have examples in the
manual to make it clear.

Cheers,

Richard

