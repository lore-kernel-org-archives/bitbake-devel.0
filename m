Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D72FE674B3
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 13:50:52 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.80235.1766411444417114219
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 05:50:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=AxFvXbH+;
 spf=pass (domain: smile.fr, ip: 209.85.208.52, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso4906302a12.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766411443; x=1767016243; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mQwzRymOGGA5O1jZXJ2wu7B/+BnDZetMTEsddzynO5E=;
        b=AxFvXbH+APITdA0b+6unCnRkYqR7YOmDkpj911hvhgAoLoSrHGy8Wv58kwMRonmJA+
         cQRDKKaRGVTOcd+R4k1aDn8hVCOSVmzHy8k7x4DVyPH1eg0zDDbrODSg+mIEBcK4yTk8
         B8OeacJ/O33CdUtbzZ3ipC7WAlYjAM1tmywis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766411443; x=1767016243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQwzRymOGGA5O1jZXJ2wu7B/+BnDZetMTEsddzynO5E=;
        b=XT3nKoNGUUKgxomxHYK0N+aS7d/lkxNNJ+GhKmWaLn3Jbc4eRvjJGcl9DtW0rG2nON
         0OVGbtaDlO9W9gLL1qEATEk1dQyZ+QoJOAAEhkmLDmitU0uDn0zrI1irq9ar14HqUnSH
         2KdjQwIfVlElE1WHIOPmhAZayo4vne7Y2fmV9SvU7vs6ZWeKMcPt02v+zGrVXU5Fzh89
         6SOCG9dKYXJ0Nu4PLqDtzy9fAyd+yN/rT6YcfVDod50PR73GfFrxXGr/v/zMRHxp9X5J
         shg/4PcgtemimfaPRnsyMRhZLKdBvtvZwVc3tscgO49C+aXkyKDykYafkKnS8SU/pOPN
         gVFQ==
X-Gm-Message-State: AOJu0Ywi6vlqb2ZPi0/Sz7J4Zz35Bgj/TAosxRgQs+c6Wewd7pffs/MV
	dzB7JbishjTd9n7wJLS9tQxI2U3rUMckZi7e4406RRYaouro8HaO7IU/4RprgIC0X7ruAF35Jp3
	2mOWY8KZFecfQXAV0pDlKmn2fydyXMU8SVrXnaGuDzQ==
X-Gm-Gg: AY/fxX4Fv7xyFr3yo8var+gU/FQ/HxyqRxhqLsweQbflWt60l2A6vLjaayDQBeJ7zQw
	V7cuBiDaiEiMHsEAHdzOXKqZti4buy+T6fv73/nUOTidW08BVKOx9akoFGdy188FciC3pi3IfrD
	DmnVeJlDG36t5V0gK1PPEZSr97fOYTKvOkhgLUDJbQA3QpQgT4S44CaZwVZ4fKWE2KtBHnrrwTo
	jsZ65hQIly1Z6WQSS6yLaM4X884McIt9aAA3MQtfbsRMW/KOplGUXPTzzPjzuq3NjeKlmMMoHqd
	5P4vjUxFmpUmjwoc8dR3FSZF93/O3XUtzMnaZQ==
X-Google-Smtp-Source: AGHT+IGHTj9o+NQhyGVZ+6mEKinYltJ6KrP3ocEpHA8TBuaaBjd1eA+uiWnEVapDTM7RDWzwEwNB6ek9LOoC/Ff8hxo=
X-Received: by 2002:a05:6402:1454:b0:649:b492:70b1 with SMTP id
 4fb4d7f45d1cf-64b8e2a6fb8mr12252361a12.0.1766411442575; Mon, 22 Dec 2025
 05:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20251208161219.41335-1-corentin.guillevic@smile.fr>
 <7501fc9f5b22984c6279f56b04f3888b34913d1a.camel@pbarker.dev>
 <CAMFqQmq0ZjzyPceUGhH25gVpP8295UBtrHBqKs7rttpCt-ijhg@mail.gmail.com>
 <6a06addf2f5746511f152cce0bfa7c662b6469a1.camel@pbarker.dev> <CAMFqQmqOJa4REWPcmu1iW5T9H5rTmabe6cwZAu5Y=NF9s4kung@mail.gmail.com>
In-Reply-To: <CAMFqQmqOJa4REWPcmu1iW5T9H5rTmabe6cwZAu5Y=NF9s4kung@mail.gmail.com>
From: Corentin GUILLEVIC <corentin.guillevic@smile.fr>
Date: Mon, 22 Dec 2025 14:50:30 +0100
X-Gm-Features: AQt7F2qQFTFx6Iy2awwLdmS0H6JIE0krsNNegeD_akp3brIscYXG0_PqrpulMTg
Message-ID: <CAMFqQmrKEv=b=zt-nebLB_UQSPBnpRV2uZXmyXHwjg+UxPXBQw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Skip AUTOREV management if no SCM URI
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000008fe99406468ab6c5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 13:50:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18638

--0000000000008fe99406468ab6c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping

Corentin

Le mer. 10 d=C3=A9c. 2025 =C3=A0 19:46, Corentin GUILLEVIC <
corentin.guillevic@smile.fr> a =C3=A9crit :

> > Which patches are you referring to here?
> I am referring to these patches:
> - https://lists.openembedded.org/g/openembedded-core/topic/116341789
> - https://lists.openembedded.org/g/openembedded-core/message/226505
> They introduce and enable a new "insane" test to check whether if a git
> URI is provided without a revision (SRCREV).
>
> > And, does the issue occur on the current master branch without applying
> any additional patches?
> No, the issue doesn't occur on the master branch. This happens with my
> patches because SRCREV is used in the test, and is expanded during the
> parsing. If SRCREV is equal to "${AUTOREV}" but no SCM URI is present,
> AUTOREV will be seen but no SCM function will act upon it. This leads to
> the error.
>
> Le mer. 10 d=C3=A9c. 2025 =C3=A0 11:20, Paul Barker <paul@pbarker.dev> a =
=C3=A9crit :
>
>> On Tue, 2025-12-09 at 11:43 +0100, Corentin Guillevic via
>> lists.openembedded.org wrote:
>> > > Is there any valid case for `SRCREV =3D "${AUTOREV}` when no SCM URI=
 is
>> > given?
>> >
>> > No, however this case occurs indirectly with the recipetool command
>> (from
>> > the self-test devtool.DevtoolUpgradeTests). It generates a recipe in
>> which
>> > SRCREV is equal to "${AUTOREV}", even though the URI is not a SCM one.
>> The
>> > issue arose because I used SRCREV in a new "insane" test, see:
>> > https://lists.openembedded.org/g/openembedded-core/topic/116341789
>> >
>> > The issue can be reproduced by applying my patches and running the
>> > following command:
>> >
>> > $ recipetool --color=3Dauto create --devtool -o /tmp/devtool4819z5wk '
>> >
>> http://downloads.yoctoproject.org/mirror/sources/i2c-tools-3.1.2.tar.bz2=
'
>> > -x ${BUILDDIR}/workspace/sources/devtoolsrcdcviuvn9
>>
>> Which patches are you referring to here? And, does the issue occur on th=
e
>> current master branch without applying any additional patches?
>>
>> >
>> > Le lun. 8 d=C3=A9c. 2025 =C3=A0 17:59, Paul Barker <paul@pbarker.dev> =
a =C3=A9crit :
>> >
>> > > On Mon, 2025-12-08 at 17:12 +0100, Corentin Guillevic via
>> > > lists.openembedded.org wrote:
>> > > > AUTOREV allows to fetch the latest revision. If no SCM URI is used
>> (e.g.
>> > > git://, ...),
>> > > > AUTOREV has no effect. However there is one case in which a recipe
>> with
>> > > AUTOREV
>> > > > but no SCM URI will lead to a parsing error:
>> > > >
>> > > > ERROR:
>> > > /path/to/yocto/builds/build-qemux86-64/workspace/recipes/i2c-tools/
>> > > i2c-tools_3.1.2.bb: AUTOREV/SRCPV set too late for the fetcher to
>> work
>> > > properly, please set the variables earlier in parsing. Erroring
>> instead of
>> > > later obtuse build failures.
>> > > >
>> > > > This error is raised when AUTOREV occurs (__BBAUTOREV_SEEN) but is
>> not
>> > > acted
>> > > > upon (__BBAUTOREV_ACTED_UPON). A recipe with one SCM URI causes th=
e
>> > > > srcrev_internal_helper() function to run, and read the value of
>> SRCREV.
>> > > If
>> > > > SRCREV =3D "${AUTOREV}", then AUTOREV will be acted upon.
>> > > >
>> > > > If the recipe does not have an SCM URI, SRCREV is not parsed and
>> AUTOREV
>> > > remains
>> > > > unchanged. However, if SRCREV is expanded during the parsing time =
in
>> > > Python code
>> > > > (either pure or evaluated from BitBake code), then AUTOREV will be
>> > > expanded too
>> > > > and resulting in the setting of __BBAUTOREV_SEEN. However, as ther=
e
>> is
>> > > no SCM
>> > > > URI, the code flow that would act upon AUTOREV is never run.
>> > > >
>> > > > The fix slightly changes the way AUTOREV is handled: if no SCM URI
>> is
>> > > provided,
>> > > > AUTOREV will be considered to have never occurred (__BBAUTOREV_SEE=
N
>> will
>> > > not be
>> > > > defined).
>> > >
>> > > It makes more sense to me to throw an error if AUTOREV is seen but n=
o
>> > > SCM URI is provided, rather than silently ignoring AUTOREV. Perhaps =
we
>> > > just need to improve the error that is raised.
>> > >
>> > > Is there any valid case for `SRCREV =3D "${AUTOREV}` when no SCM URI=
 is
>> > > given?
>>
>> Thanks,
>>
>> --
>> Paul Barker
>>
>>
>>

--0000000000008fe99406468ab6c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Gentle ping</div><div><br></div><div>Corentin</div></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Le=C2=A0mer. 10 d=C3=A9c. 2025 =C3=A0=C2=A019:46, Coren=
tin GUILLEVIC &lt;<a href=3D"mailto:corentin.guillevic@smile.fr">corentin.g=
uillevic@smile.fr</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"ltr"><div>&gt;=C2=A0Which patches=
 are you referring to here?</div><div>I am referring to these patches:</div=
><div>-=C2=A0<a href=3D"https://lists.openembedded.org/g/openembedded-core/=
topic/116341789" target=3D"_blank">https://lists.openembedded.org/g/openemb=
edded-core/topic/116341789</a></div><div>-=C2=A0<a href=3D"https://lists.op=
enembedded.org/g/openembedded-core/message/226505" target=3D"_blank">https:=
//lists.openembedded.org/g/openembedded-core/message/226505</a></div><div>T=
hey introduce and enable a new &quot;insane&quot; test to check whether if =
a git URI is provided without a revision (SRCREV).</div><div><br></div><div=
>&gt;=C2=A0And, does the issue occur on the current master branch without a=
pplying any additional patches?</div><div>No, the issue doesn&#39;t occur o=
n the master branch. This happens with my patches because SRCREV is used in=
 the test, and is expanded during the parsing. If SRCREV is equal to &quot;=
${AUTOREV}&quot; but no SCM URI is present, AUTOREV will be seen but no SCM=
 function will act upon it.=C2=A0This leads to the error.</div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mer.=
 10 d=C3=A9c. 2025 =C3=A0=C2=A011:20, Paul Barker &lt;<a href=3D"mailto:pau=
l@pbarker.dev" target=3D"_blank">paul@pbarker.dev</a>&gt; a =C3=A9crit=C2=
=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 202=
5-12-09 at 11:43 +0100, Corentin Guillevic via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a> wrote:<br>
&gt; &gt; Is there any valid case for `SRCREV =3D &quot;${AUTOREV}` when no=
 SCM URI is<br>
&gt; given?<br>
&gt; <br>
&gt; No, however this case occurs indirectly with the recipetool command (f=
rom<br>
&gt; the self-test devtool.DevtoolUpgradeTests). It generates a recipe in w=
hich<br>
&gt; SRCREV is equal to &quot;${AUTOREV}&quot;, even though the URI is not =
a SCM one. The<br>
&gt; issue arose because I used SRCREV in a new &quot;insane&quot; test, se=
e:<br>
&gt; <a href=3D"https://lists.openembedded.org/g/openembedded-core/topic/11=
6341789" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.or=
g/g/openembedded-core/topic/116341789</a><br>
&gt; <br>
&gt; The issue can be reproduced by applying my patches and running the<br>
&gt; following command:<br>
&gt; <br>
&gt; $ recipetool --color=3Dauto create --devtool -o /tmp/devtool4819z5wk &=
#39;<br>
&gt; <a href=3D"http://downloads.yoctoproject.org/mirror/sources/i2c-tools-=
3.1.2.tar.bz2" rel=3D"noreferrer" target=3D"_blank">http://downloads.yoctop=
roject.org/mirror/sources/i2c-tools-3.1.2.tar.bz2</a>&#39;<br>
&gt; -x ${BUILDDIR}/workspace/sources/devtoolsrcdcviuvn9<br>
<br>
Which patches are you referring to here? And, does the issue occur on the<b=
r>
current master branch without applying any additional patches?<br>
<br>
&gt; <br>
&gt; Le lun. 8 d=C3=A9c. 2025 =C3=A0 17:59, Paul Barker &lt;<a href=3D"mail=
to:paul@pbarker.dev" target=3D"_blank">paul@pbarker.dev</a>&gt; a =C3=A9cri=
t :<br>
&gt; <br>
&gt; &gt; On Mon, 2025-12-08 at 17:12 +0100, Corentin Guillevic via<br>
&gt; &gt; <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" targ=
et=3D"_blank">lists.openembedded.org</a> wrote:<br>
&gt; &gt; &gt; AUTOREV allows to fetch the latest revision. If no SCM URI i=
s used (e.g.<br>
&gt; &gt; git://, ...),<br>
&gt; &gt; &gt; AUTOREV has no effect. However there is one case in which a =
recipe with<br>
&gt; &gt; AUTOREV<br>
&gt; &gt; &gt; but no SCM URI will lead to a parsing error:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; ERROR:<br>
&gt; &gt; /path/to/yocto/builds/build-qemux86-64/workspace/recipes/i2c-tool=
s/<br>
&gt; &gt; <a href=3D"http://i2c-tools_3.1.2.bb" rel=3D"noreferrer" target=
=3D"_blank">i2c-tools_3.1.2.bb</a>: AUTOREV/SRCPV set too late for the fetc=
her to work<br>
&gt; &gt; properly, please set the variables earlier in parsing. Erroring i=
nstead of<br>
&gt; &gt; later obtuse build failures.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; This error is raised when AUTOREV occurs (__BBAUTOREV_SEEN) =
but is not<br>
&gt; &gt; acted<br>
&gt; &gt; &gt; upon (__BBAUTOREV_ACTED_UPON). A recipe with one SCM URI cau=
ses the<br>
&gt; &gt; &gt; srcrev_internal_helper() function to run, and read the value=
 of SRCREV.<br>
&gt; &gt; If<br>
&gt; &gt; &gt; SRCREV =3D &quot;${AUTOREV}&quot;, then AUTOREV will be acte=
d upon.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; If the recipe does not have an SCM URI, SRCREV is not parsed=
 and AUTOREV<br>
&gt; &gt; remains<br>
&gt; &gt; &gt; unchanged. However, if SRCREV is expanded during the parsing=
 time in<br>
&gt; &gt; Python code<br>
&gt; &gt; &gt; (either pure or evaluated from BitBake code), then AUTOREV w=
ill be<br>
&gt; &gt; expanded too<br>
&gt; &gt; &gt; and resulting in the setting of __BBAUTOREV_SEEN. However, a=
s there is<br>
&gt; &gt; no SCM<br>
&gt; &gt; &gt; URI, the code flow that would act upon AUTOREV is never run.=
<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The fix slightly changes the way AUTOREV is handled: if no S=
CM URI is<br>
&gt; &gt; provided,<br>
&gt; &gt; &gt; AUTOREV will be considered to have never occurred (__BBAUTOR=
EV_SEEN will<br>
&gt; &gt; not be<br>
&gt; &gt; &gt; defined).<br>
&gt; &gt; <br>
&gt; &gt; It makes more sense to me to throw an error if AUTOREV is seen bu=
t no<br>
&gt; &gt; SCM URI is provided, rather than silently ignoring AUTOREV. Perha=
ps we<br>
&gt; &gt; just need to improve the error that is raised.<br>
&gt; &gt; <br>
&gt; &gt; Is there any valid case for `SRCREV =3D &quot;${AUTOREV}` when no=
 SCM URI is<br>
&gt; &gt; given?<br>
<br>
Thanks,<br>
<br>
-- <br>
Paul Barker<br>
<br>
<br>
</blockquote></div>
</blockquote></div>

--0000000000008fe99406468ab6c5--

