Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EBEC2BD09
	for <webhook@archiver.kernel.org>; Thu, 27 Jun 2024 12:55:53 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.7199.1719492945577074151
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jun 2024 05:55:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=C3LClaYa;
 spf=pass (domain: snapchat.com, ip: 209.85.218.42, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a725a918edaso429584866b.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Jun 2024 05:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1719492944; x=1720097744; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yIF1Xnclr++RxdqIn/ZisqPBtZR05Pg5EvZjUh4SJhk=;
        b=C3LClaYaOcdwWtPl29ernZzLIZya0pm3DS6+eNPqqgez2chHeag5jSSnWVkC5VQFwR
         c6qlMqg5+AeEAU8fSvG2BxgXmvouEPDU9tH9cJcrOL5Cvoqefz0N6m27aJ4kBvR+S8P0
         6dwb6cGQ94RKsfzXY0Vyl4FfYcbvzZMAcLjfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492944; x=1720097744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIF1Xnclr++RxdqIn/ZisqPBtZR05Pg5EvZjUh4SJhk=;
        b=aopjUNZXx3nIO9/7bQDSs3+POFaO+M9/c82OPSUgWNjcoiWkxirUOGZO2/0+C9O5ks
         yMuJFq3oiuoh8f2X/f1F6qHUgipoKmAAB5cndv7bYM2Va/RWojwhg8M7msZ+BqcDgLSo
         8URXS1PcCo6n5BMYi+RK+Hj4XeO3LHbXrGXVlfEWRDueCZXtFpzdCpvBbn6i/llR10q3
         0WuLrn1frWw2m3dzhHesSguor0D7mujkRf7U5tazI4a7aQwjZednnlYDuX2y07k8VbL5
         NGu8Uo5vMsJFjpBcHdx7zinDvvMLNpo6qNyoM7QZen6AvYpdjHD93KH7y6QbT5uJlTw/
         uvaA==
X-Forwarded-Encrypted: i=1; AJvYcCXI9G5MZiCuDKtF8EsLtH9NrF10lqrsC2pmW77AvDpH6rzA2yf4wUt1OPnDDQMQWwMUu2cRWE3kyvBsbQjBBpwT0FdwbClOHK4Y+csyzmf4OxPZl8U=
X-Gm-Message-State: AOJu0Yy6JGBYBbk7McLruZN1mPT7rLrksaGP27kHhz2nsF8RlnAe8MeL
	eqXhhs47vM/uoSI4yDZhoYPpj/hM6ljk33jiPkW8fPOamS9lQDuGYT1ruYPaF9MHOWnaUoXtAB/
	SwpCl9LGnNpV4qEvY9SP9tvwPbMpanl2V6YSW3w==
X-Google-Smtp-Source: AGHT+IEIHHXKBDb/wBfnP2ZjezcZThQlh5B4A//9qPlzmc6LWgtEYKakZ7wyXDXstADjc5jVbPnw/dQBJyFz8uXZh5s=
X-Received: by 2002:a17:906:d96e:b0:a6f:608e:c0d0 with SMTP id
 a640c23a62f3a-a7245ba3cc0mr1124986366b.25.1719492943808; Thu, 27 Jun 2024
 05:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240206121528.2581233-1-richard.purdie@linuxfoundation.org>
 <CAHUKmYbjs=_ijo2Jy5a1JCx5jrSJB5Ucoza99yBL2ya+qvwpRg@mail.gmail.com>
 <dfe902c9baab3bdc38bb7afae1455565ab8c0117.camel@linuxfoundation.org>
 <CAHUKmYY1fMCiNq36MzoeuQ5EKQYm_ZAEkkDuRUTeg94a+ZnubQ@mail.gmail.com> <202402072227419c816a19@mail.local>
In-Reply-To: <202402072227419c816a19@mail.local>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Thu, 27 Jun 2024 14:55:32 +0200
Message-ID: <CAHUKmYap7j4GEy1sbhnqC8SmwT5e8AgE-t1d016oY4fL0Usg8Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] lib/bb: Drop BBFILE_PRIORITY support
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000001c2efa061bdea6c4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Jun 2024 12:55:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16380

--0000000000001c2efa061bdea6c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Is the BBFILE_PRIORITY not controlling the order in which bbappends fro=
m
> > different layers gets applied? I thought it was important e.g. when
> > applying kernel configuration files (the last one to be applied overrid=
e
> > the previous ones).

> I'd rather think this is in BBLAYERS list order


Apologies for the late reply. I've finally got time to test this, and the
BBFILE_PRIORITY value of the layer indeed overrides the BBLAYERS list
order, so files added to SRC_URI layers with higher BBFILE_PRIORITY are
last in the SRC_URI order (I can reproduce this playing around with two
linux-yocto_%.bbappend). I guess in this case reordering the layers is the
proper solution, rather than relying on BBFILE_PRIORITY.
I was not aware that the order of inclusion in BBLAYERS mattered when using
the same priority, thus I guess BBFILE_PRIORITY could be removed (this
would break my project unless I reorder the layers properly, though, so I
would definitely include this in the migration guide for the release).

On Wed, Feb 7, 2024 at 11:27=E2=80=AFPM Alexandre Belloni <
alexandre.belloni@bootlin.com> wrote:

> On 06/02/2024 17:31:03+0100, Etienne Cordonnier via lists.openembedded.or=
g
> wrote:
> > Is the BBFILE_PRIORITY not controlling the order in which bbappends fro=
m
> > different layers gets applied? I thought it was important e.g. when
> > applying kernel configuration files (the last one to be applied overrid=
e
> > the previous ones).
>
> I'd rather think this is in BBLAYERS list order
>
> >
> > On Tue, Feb 6, 2024 at 4:56=E2=80=AFPM Richard Purdie <
> > richard.purdie@linuxfoundation.org> wrote:
> >
> > > On Tue, 2024-02-06 at 16:26 +0100, Etienne Cordonnier wrote:
> > > > Hi Richard, there is a word missing in the commit message:
> > > > " The functionality had a and place" -> "the functionality had a ti=
me
> > > and place"
> > > > Also a typo: "comparibility" -> " compatibility "
> > >
> > > Thanks, I'll tweak those on the branch.
> > >
> > > > What is the correct way to set layer priorities after this patch (I=
'm
> > > > asking because the BSP I'm using makes use of BBFILE_PRIORITY)?
> > >
> > > It may set it, but what is it trying to achieve by setting it?
> > >
> > > As far as I know, the potential issue is needing to set specific
> > > PREFERRED_VERSION entries where older recipes need to be used.
> > >
> > > Cheers,
> > >
> > > Richard
> > >
>
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#15832):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_message_15832&d=3DDwIDaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DPF=
dWZklNEsJp5d53FoO0qUONhBkFLS6kTFi3Ri0VIGCdtMAJlG4EMCZ0fk27vcD1&s=3Dnkms8wmk=
pBFNLoD_tIhMX7gighjb9-vDCGbqx4EUHpY&e=3D
> > Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_mt_104196430_3617179&d=3DDwIDaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DPFdWZklNEsJp5=
d53FoO0qUONhBkFLS6kTFi3Ri0VIGCdtMAJlG4EMCZ0fk27vcD1&s=3DO5kulu9daAQPZCy9pk2=
wkeWkXPB9ZFJjjyvIIRayD4o&e=3D
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_unsub&d=3DDwIDaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGk=
ICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DPFdWZklNEs=
Jp5d53FoO0qUONhBkFLS6kTFi3Ri0VIGCdtMAJlG4EMCZ0fk27vcD1&s=3Dqv5A5DpnymmLJoar=
by3NF1ZNC75oZXuo87auR8Y2FK8&e=3D
> [alexandre.belloni@bootlin.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bootlin.com&d=3DDw=
IDaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Q=
j9TsRih1DULJTKUkSGa66m67E&m=3DPFdWZklNEsJp5d53FoO0qUONhBkFLS6kTFi3Ri0VIGCdt=
MAJlG4EMCZ0fk27vcD1&s=3D_Eu0UvlfGlLxisJ57yP2XH8J30Q2PhmSO19R0djWdzM&e=3D
>

--0000000000001c2efa061bdea6c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-im" style=3D"color:rgb(80,0,80)">&gt;=
 &gt; Is the=C2=A0<span class=3D"gmail-il">BBFILE_PRIORITY</span>=C2=A0not =
controlling the order in which bbappends from<br>&gt; &gt; different layers=
 gets applied? I thought it was important e.g. when<br>&gt; &gt; applying k=
ernel configuration files (the last one to be applied override<br>&gt; &gt;=
 the previous ones).<br><br></span>&gt; I&#39;d rather think this is in BBL=
AYERS list order<br><br><br>Apologies for the late reply. I&#39;ve finally =
got time to test this, and the BBFILE_PRIORITY value of the layer indeed ov=
errides the BBLAYERS list order,=C2=A0so files added to SRC_URI layers with=
 higher BBFILE_PRIORITY are last in the SRC_URI order (I can reproduce this=
 playing around with two linux-yocto_%.bbappend). I guess in this case reor=
dering the layers is the proper solution, rather than relying on BBFILE_PRI=
ORITY.<br>I was not aware that the order of inclusion in BBLAYERS mattered =
when using the same priority, thus I guess BBFILE_PRIORITY could be removed=
 (this would break my project unless I reorder the layers properly, though,=
 so I would definitely=C2=A0include this in the migration guide for the rel=
ease).</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Wed, Feb 7, 2024 at 11:27=E2=80=AFPM Alexandre Belloni &lt;<a href=
=3D"mailto:alexandre.belloni@bootlin.com">alexandre.belloni@bootlin.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 0=
6/02/2024 17:31:03+0100, Etienne Cordonnier via <a href=3D"http://lists.ope=
nembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org<=
/a> wrote:<br>
&gt; Is the BBFILE_PRIORITY not controlling the order in which bbappends fr=
om<br>
&gt; different layers gets applied? I thought it was important e.g. when<br=
>
&gt; applying kernel configuration files (the last one to be applied overri=
de<br>
&gt; the previous ones).<br>
<br>
I&#39;d rather think this is in BBLAYERS list order<br>
<br>
&gt; <br>
&gt; On Tue, Feb 6, 2024 at 4:56=E2=80=AFPM Richard Purdie &lt;<br>
&gt; <a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank=
">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Tue, 2024-02-06 at 16:26 +0100, Etienne Cordonnier wrote:<br>
&gt; &gt; &gt; Hi Richard, there is a word missing in the commit message:<b=
r>
&gt; &gt; &gt; &quot; The functionality had a and place&quot; -&gt; &quot;t=
he functionality had a time<br>
&gt; &gt; and place&quot;<br>
&gt; &gt; &gt; Also a typo: &quot;comparibility&quot; -&gt; &quot; compatib=
ility &quot;<br>
&gt; &gt;<br>
&gt; &gt; Thanks, I&#39;ll tweak those on the branch.<br>
&gt; &gt;<br>
&gt; &gt; &gt; What is the correct way to set layer priorities after this p=
atch (I&#39;m<br>
&gt; &gt; &gt; asking because the BSP I&#39;m using makes use of BBFILE_PRI=
ORITY)?<br>
&gt; &gt;<br>
&gt; &gt; It may set it, but what is it trying to achieve by setting it?<br=
>
&gt; &gt;<br>
&gt; &gt; As far as I know, the potential issue is needing to set specific<=
br>
&gt; &gt; PREFERRED_VERSION entries where older recipes need to be used.<br=
>
&gt; &gt;<br>
&gt; &gt; Cheers,<br>
&gt; &gt;<br>
&gt; &gt; Richard<br>
&gt; &gt;<br>
<br>
&gt; <br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#15832): <a href=3D"https://urldefense.proofpoint.c=
om/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_15=
832&amp;d=3DDwIDaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;=
r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DPFdWZklNEsJp5d53FoO=
0qUONhBkFLS6kTFi3Ri0VIGCdtMAJlG4EMCZ0fk27vcD1&amp;s=3Dnkms8wmkpBFNLoD_tIhMX=
7gighjb9-vDCGbqx4EUHpY&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https=
://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_=
bitbake-2Ddevel_message_15832&amp;d=3DDwIDaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4=
vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&a=
mp;m=3DPFdWZklNEsJp5d53FoO0qUONhBkFLS6kTFi3Ri0VIGCdtMAJlG4EMCZ0fk27vcD1&amp=
;s=3Dnkms8wmkpBFNLoD_tIhMX7gighjb9-vDCGbqx4EUHpY&amp;e=3D</a> <br>
&gt; Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=
=3Dhttps-3A__lists.openembedded.org_mt_104196430_3617179&amp;d=3DDwIDaQ&amp=
;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Q=
j9TsRih1DULJTKUkSGa66m67E&amp;m=3DPFdWZklNEsJp5d53FoO0qUONhBkFLS6kTFi3Ri0VI=
GCdtMAJlG4EMCZ0fk27vcD1&amp;s=3DO5kulu9daAQPZCy9pk2wkeWkXPB9ZFJjjyvIIRayD4o=
&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoi=
nt.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_mt_104196430_3617179&amp=
;d=3DDwIDaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DPFdWZklNEsJp5d53FoO0qUONhB=
kFLS6kTFi3Ri0VIGCdtMAJlG4EMCZ0fk27vcD1&amp;s=3DO5kulu9daAQPZCy9pk2wkeWkXPB9=
ZFJjjyvIIRayD4o&amp;e=3D</a> <br>
&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedde=
d.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
&gt; Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dh=
ttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwIDaQ&amp;=
c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj=
9TsRih1DULJTKUkSGa66m67E&amp;m=3DPFdWZklNEsJp5d53FoO0qUONhBkFLS6kTFi3Ri0VIG=
CdtMAJlG4EMCZ0fk27vcD1&amp;s=3Dqv5A5DpnymmLJoarby3NF1ZNC75oZXuo87auR8Y2FK8&=
amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoin=
t.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&a=
mp;d=3DDwIDaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DPFdWZklNEsJp5d53FoO0qUON=
hBkFLS6kTFi3Ri0VIGCdtMAJlG4EMCZ0fk27vcD1&amp;s=3Dqv5A5DpnymmLJoarby3NF1ZNC7=
5oZXuo87auR8Y2FK8&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:alexandre.belloni@b=
ootlin.com" target=3D"_blank">alexandre.belloni@bootlin.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; <br>
<br>
<br>
-- <br>
Alexandre Belloni, co-owner and COO, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bootlin.c=
om&amp;d=3DDwIDaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=
=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DPFdWZklNEsJp5d53FoO0=
qUONhBkFLS6kTFi3Ri0VIGCdtMAJlG4EMCZ0fk27vcD1&amp;s=3D_Eu0UvlfGlLxisJ57yP2XH=
8J30Q2PhmSO19R0djWdzM&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https:=
//urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bootlin.com&amp;d=3DDwIDaQ=
&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRf=
Px_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DPFdWZklNEsJp5d53FoO0qUONhBkFLS6kTFi3R=
i0VIGCdtMAJlG4EMCZ0fk27vcD1&amp;s=3D_Eu0UvlfGlLxisJ57yP2XH8J30Q2PhmSO19R0dj=
WdzM&amp;e=3D</a> <br>
</blockquote></div>

--0000000000001c2efa061bdea6c4--

