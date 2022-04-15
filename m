Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D08DC6786C
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:26:03 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web09.6166.1650021827923712456
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 04:23:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=OrLqGqmN;
 spf=pass (domain: gmail.com, ip: 209.85.208.54,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id g20so9596363edw.6
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=BekgkDyzYhF1sd+QkhE+VzEWupgyEETxjAkUD0iguUc=;
        b=OrLqGqmNerk2uUf7OhuhrSOLZl16FOUdF+xM2Wq3MAKb//goOmzKQvfrgUpQ08FmDt
         QKlRB1MWhy9diFvQlS0XxiNyVN5ojfVuOIT/sP5Or30h4D5Xk8u+2StyNvQymyplILBJ
         h5JzceahxwRlUV8AR9UcM3YuyAJLKVaS2meD4GA6DNE0tabWzhWeZ5E2kNJ9htz2GEvk
         83pC7vzgESxoN8eg7F0G7LNreeMzEQknfndNUMhnmEDrLSfpBt+ZDCY/SfZSarF435Wk
         7PWbf8ajenIHHERkhaWJMZg6iWzkwXGzXLilyLtQwHM2u+zFgzix5Nt17d4zZfubEMfy
         GDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=BekgkDyzYhF1sd+QkhE+VzEWupgyEETxjAkUD0iguUc=;
        b=MLU24Z1cYFp9go/5TYRRiuye8BzSs2jKEFnaQQG/VweHxlrjabOcFBUJZs/Hn+2wwe
         DuHGBr48xGnRRvBpa4F0441ToGyMMQqR5l0OQEi2Ur+hXABnQWaAo57YNEfe6DkhsplI
         R/zoiV8yOxU0de+rXp5m0ZFPDr6J+bJ+laSgI/Bec7u6y//cCbjkmuqjvMK0dx3yU6CL
         /hhXRl275sP0HjM6A2wFPd1cRkDb7wTK4IE0uz8YsYa6v5piZ3Vz7X3B+pt/csDp7K3o
         JRjEiljEToTJV0ZXyoWtXbITilWX6JxEKni8Sn4BAtNija5UtH7dDIb8v37G6R4FC0D9
         Th1g==
X-Gm-Message-State: AOAM531dGmeQC38+m1TyQzijn6Ll3JkOWMkGBrRSBHv+K471wxuP7G4j
	DU914i/QQk+4Fp2/NRU99Zc=
X-Google-Smtp-Source: 
 ABdhPJxOyr9yD4AsSibeLOkHriuGNFyy+7K20RpOocnSD1XhAV8BKMrXZgAvCV4UyD6WY0ucyrKlew==
X-Received: by 2002:aa7:cd87:0:b0:41d:90a8:2670 with SMTP id
 x7-20020aa7cd87000000b0041d90a82670mr7816443edv.404.1650021825223;
        Fri, 15 Apr 2022 04:23:45 -0700 (PDT)
Received: from smtpclient.apple
 (dslb-178-003-195-224.178.003.pools.vodafone-ip.de. [178.3.195.224])
        by smtp.gmail.com with ESMTPSA id
 bw3-20020a170906c1c300b006e88cdfbc32sm1612831ejb.45.2022.04.15.04.23.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2022 04:23:44 -0700 (PDT)
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Message-Id: <749CBEAC-6A91-4465-9514-0C97F7A8A43D@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_82116F36-31CC-4B3D-80A9-60913A898F36"
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [bitbake-devel] Branch switch doesn't work on openembedded.org
Date: Fri, 15 Apr 2022 13:23:43 +0200
In-Reply-To: <91312f6a-5758-3758-0896-e7dcd438cd90@bootlin.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
References: <D247F1F9-1C2C-4B53-828A-ABB4D29800DF@gmail.com>
 <91312f6a-5758-3758-0896-e7dcd438cd90@bootlin.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Apr 2022 14:26:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13630


--Apple-Mail=_82116F36-31CC-4B3D-80A9-60913A898F36
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Dear Michael,

Thanks for your reply. This does not seem to be the issue. Switching =
between branches on the GitHub Repo works flawless.=20
Dunfell:
=
https://github.com/openembedded/meta-openembedded/blob/dunfell/meta-python=
/recipes-devtools/python/python3-pybind11_2.4.3.bb =
<https://github.com/openembedded/meta-openembedded/blob/dunfell/meta-pytho=
n/recipes-devtools/python/python3-pybind11_2.4.3.bb>
Master:
=
https://github.com/openembedded/meta-openembedded/blob/master/meta-python/=
recipes-devtools/python/python3-pybind11_2.8.1.bb =
<https://github.com/openembedded/meta-openembedded/blob/master/meta-python=
/recipes-devtools/python/python3-pybind11_2.8.1.bb>

As you can see the name has changed. But that should somehow be =
reflected in what is displayed, such as a 404 when the recipe is not =
available under the former name. So, I guess this is what doesn=E2=80=99t =
work properly at git.openembedded.org <http://git.openembedded.org/>.

Best regards

Marius



> On 15. Apr 2022, at 12:48, Michael Opdenacker =
<michael.opdenacker@bootlin.com> wrote:
>=20
> Hi Marius,
>=20
> On 4/12/22 18:26, Marius Kriegerowski wrote:
>> Hi,
>>=20
>> The branch switch button on the top right on git.openembedded.org
>> <http://git.openembedded.org> seems to be broken. At least it =
doesn=E2=80=99t
>> switch between branches on firefox 99.0.
>>=20
>> I tried switching between `master` and `dunfell` on this one (but
>> doesn=E2=80=99t seem to switch nowhere):=20
>>=20
>> =
http://git.openembedded.org/meta-openembedded/tree/meta-python/recipes-dev=
tools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf678428ff11832dc=
9b90f9d5a6&h=3Dmaster
>> =
<http://git.openembedded.org/meta-openembedded/tree/meta-python/recipes-de=
vtools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf678428ff11832d=
c9b90f9d5a6&h=3Dmaster>
>>=20
>>=20
>> Also, it doesn=E2=80=99t work when clicking the `switch` button after
>> selecting a different branch. Am I using it in the wrong way??
>=20
>=20
> Maybe because in your example, both "master" and "dunfell" have the =
same
> version of this file.
> Try this instead:
> =
https://git.openembedded.org/openembedded-core/tree/scripts/runqemu?h=3Dma=
ster
>=20
> Thanks for sharing issues with us anyway.
> Cheers
> Michael.
>=20
> --=20
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>=20


--Apple-Mail=_82116F36-31CC-4B3D-80A9-60913A898F36
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">Dear =
Michael,<div class=3D""><br class=3D""></div><div class=3D"">Thanks for =
your reply. This does not seem to be the issue. Switching between =
branches on the GitHub Repo works flawless.&nbsp;</div><div =
class=3D"">Dunfell:</div><div class=3D""><a =
href=3D"https://github.com/openembedded/meta-openembedded/blob/dunfell/met=
a-python/recipes-devtools/python/python3-pybind11_2.4.3.bb" =
class=3D"">https://github.com/openembedded/meta-openembedded/blob/dunfell/=
meta-python/recipes-devtools/python/python3-pybind11_2.4.3.bb</a></div><di=
v class=3D"">Master:</div><div class=3D""><a =
href=3D"https://github.com/openembedded/meta-openembedded/blob/master/meta=
-python/recipes-devtools/python/python3-pybind11_2.8.1.bb" =
class=3D"">https://github.com/openembedded/meta-openembedded/blob/master/m=
eta-python/recipes-devtools/python/python3-pybind11_2.8.1.bb</a></div><div=
 class=3D""><br class=3D""></div><div class=3D"">As you can see the name =
has changed. But that should somehow be reflected in what is displayed, =
such as a 404 when the recipe is not available under the former name. =
So, I guess this is what doesn=E2=80=99t work properly at <a =
href=3D"http://git.openembedded.org" =
class=3D"">git.openembedded.org</a>.</div><div class=3D""><br =
class=3D""></div><div class=3D"">Best regards</div><div class=3D""><br =
class=3D""></div><div class=3D"">Marius</div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""><div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">On 15. =
Apr 2022, at 12:48, Michael Opdenacker &lt;<a =
href=3D"mailto:michael.opdenacker@bootlin.com" =
class=3D"">michael.opdenacker@bootlin.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div class=3D"">Hi =
Marius,<br class=3D""><br class=3D"">On 4/12/22 18:26, Marius =
Kriegerowski wrote:<br class=3D""><blockquote type=3D"cite" =
class=3D"">Hi,<br class=3D""><br class=3D"">The branch switch button on =
the top right on&nbsp;<a href=3D"http://git.openembedded.org" =
class=3D"">git.openembedded.org</a><br class=3D"">&lt;<a =
href=3D"http://git.openembedded.org" =
class=3D"">http://git.openembedded.org</a>&gt;&nbsp;seems to be broken. =
At least it doesn=E2=80=99t<br class=3D"">switch between branches on =
firefox 99.0.<br class=3D""><br class=3D"">I tried switching between =
`master` and `dunfell` on this one (but<br class=3D"">doesn=E2=80=99t =
seem to switch nowhere):&nbsp;<br class=3D""><br class=3D""><a =
href=3D"http://git.openembedded.org/meta-openembedded/tree/meta-python/rec=
ipes-devtools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf678428f=
f11832dc9b90f9d5a6&amp;h=3Dmaster" =
class=3D"">http://git.openembedded.org/meta-openembedded/tree/meta-python/=
recipes-devtools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf6784=
28ff11832dc9b90f9d5a6&amp;h=3Dmaster</a><br =
class=3D"">&lt;http://git.openembedded.org/meta-openembedded/tree/meta-pyt=
hon/recipes-devtools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf=
678428ff11832dc9b90f9d5a6&amp;h=3Dmaster&gt;<br class=3D""><br =
class=3D""><br class=3D"">Also, it doesn=E2=80=99t work when clicking =
the `switch` button after<br class=3D"">selecting a different branch. Am =
I using it in the wrong way??<br class=3D""></blockquote><br =
class=3D""><br class=3D"">Maybe because in your example, both "master" =
and "dunfell" have the same<br class=3D"">version of this file.<br =
class=3D"">Try this instead:<br class=3D""><a =
href=3D"https://git.openembedded.org/openembedded-core/tree/scripts/runqem=
u?h=3Dmaster" =
class=3D"">https://git.openembedded.org/openembedded-core/tree/scripts/run=
qemu?h=3Dmaster</a><br class=3D""><br class=3D"">Thanks for sharing =
issues with us anyway.<br class=3D"">Cheers<br class=3D"">Michael.<br =
class=3D""><br class=3D"">-- <br class=3D"">Michael Opdenacker, =
Bootlin<br class=3D"">Embedded Linux and Kernel engineering<br =
class=3D"">https://bootlin.com<br class=3D""><br =
class=3D""></div></div></blockquote></div><br =
class=3D""></div></body></html>=

--Apple-Mail=_82116F36-31CC-4B3D-80A9-60913A898F36--

