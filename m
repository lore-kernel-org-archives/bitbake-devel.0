Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994AED3E773
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 18:46:44 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3593.1765392400957245475
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Dec 2025 10:46:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=qinqdXUd;
 spf=pass (domain: smile.fr, ip: 209.85.208.50, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so282870a12.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Dec 2025 10:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1765392399; x=1765997199; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KEsTtb2OI5bN79SwahEnOfSL9lJwMLpomdNb0UylNac=;
        b=qinqdXUdyl+IZrBSt13DmTxJKu6NTZ6ypzdqD2PUn0C+T7KOKI6Bqk6NHWvW2JJowM
         R4rZm6eanDVzplh1AvwErJpGL+emuNEfNqj3vULnw+qNOQ/3qAdSQHTqEsD8f3A5GiCj
         h4N0HikhuMOAil2nA6/2E9rEWLSo4IOT0+LaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765392399; x=1765997199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEsTtb2OI5bN79SwahEnOfSL9lJwMLpomdNb0UylNac=;
        b=mUgKxbehyddHXs2efHNqQ0TIYNdY+9rR39uX2z94GjAVk0deaMGxQSQ62KOs9LbILn
         NXM4MvHXHjA2qWzbAILz8SszsYdMXVnvD1b7LPqnjxTQ65j6A25DNE1RVfZ6fQu/oRPw
         jq9c4EWeC6kmA8CDwFhvclbuppvT7zFGvK+uxKTxbdG91tx2/2gehkvr7VqCFloaAHXS
         26FClwZnI0kLab7ph8NlAmEZcMRwFa3ZMbHX6etGcc0rip+zPNPjsiULIDYVwBk3WniP
         NDT7CGAIpNCCc886rlaC2RBftabRZzy5Tay6jZLXxuKmE3kG+oXS7e1DJMmYZdWS3FMY
         xJmA==
X-Gm-Message-State: AOJu0YwjYG4r4dPylRgGgQC+gMUKU9H3w867w/tJzG0s9tob22ugWNZV
	mGa8g6E4e+xp1kEee0uB5fhiHo0qne9i0V4boldlooyIAFpLVG278t7+/syewTnJ3g7ZcoL05MK
	jVasEY7Cc0cEN3mOj1sjN9p6x+bplOwTlbTOe/d4ADg==
X-Gm-Gg: AY/fxX7KQl104b/xAa8Q3upb2yH9QSZo/zhafVty1KLDOouN/Ne3MamaF0PMoTnMSjw
	cKiDA4GbP/wCvYmDMpLA2fcIHm/c6QCh71iAPjjrwdEXXvMzyTeDFIndwsIZKy2vZm2QkJws7Qs
	NegQb2LuZd1UekuouShRK/ShFAWsisH/24IgNEHuQYzMoIuJ82xlL4E02pv8C/UUHBpkw0lLl/2
	CN/3tIrBEk7qWCOExdW3ig+UqW8eZKf5/PIR8/VC0FOWqcx+kQazRzR3vfACT5Rv7kudK1WDRQl
	UGpSFdS610DJ2+CYJAbLQSou3A==
X-Google-Smtp-Source: AGHT+IFDACQTlKIH27MDKPMWV6e/eXjeOnadmvVhxDA21O16+AHD6T4b0qEsAcZFyomPlabVUFOJDRiIyfpOMst4JVI=
X-Received: by 2002:a05:6402:27cd:b0:63c:690d:6a46 with SMTP id
 4fb4d7f45d1cf-6496cb8ea1cmr3453588a12.13.1765392399020; Wed, 10 Dec 2025
 10:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20251208161219.41335-1-corentin.guillevic@smile.fr>
 <7501fc9f5b22984c6279f56b04f3888b34913d1a.camel@pbarker.dev>
 <CAMFqQmq0ZjzyPceUGhH25gVpP8295UBtrHBqKs7rttpCt-ijhg@mail.gmail.com> <6a06addf2f5746511f152cce0bfa7c662b6469a1.camel@pbarker.dev>
In-Reply-To: <6a06addf2f5746511f152cce0bfa7c662b6469a1.camel@pbarker.dev>
From: Corentin GUILLEVIC <corentin.guillevic@smile.fr>
Date: Wed, 10 Dec 2025 19:46:26 +0100
X-Gm-Features: AQt7F2qQntIfKjkZvbQUn91KLQcTTKJUDrM1Qo8PKh_oSwZ0AAnAbya_uYawAKU
Message-ID: <CAMFqQmqOJa4REWPcmu1iW5T9H5rTmabe6cwZAu5Y=NF9s4kung@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Skip AUTOREV management if no SCM URI
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d547d806459d72f5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Dec 2025 18:46:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18560

--000000000000d547d806459d72f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Which patches are you referring to here?
I am referring to these patches:
- https://lists.openembedded.org/g/openembedded-core/topic/116341789
- https://lists.openembedded.org/g/openembedded-core/message/226505
They introduce and enable a new "insane" test to check whether if a git URI
is provided without a revision (SRCREV).

> And, does the issue occur on the current master branch without applying
any additional patches?
No, the issue doesn't occur on the master branch. This happens with my
patches because SRCREV is used in the test, and is expanded during the
parsing. If SRCREV is equal to "${AUTOREV}" but no SCM URI is present,
AUTOREV will be seen but no SCM function will act upon it. This leads to
the error.

Le mer. 10 d=C3=A9c. 2025 =C3=A0 11:20, Paul Barker <paul@pbarker.dev> a =
=C3=A9crit :

> On Tue, 2025-12-09 at 11:43 +0100, Corentin Guillevic via
> lists.openembedded.org wrote:
> > > Is there any valid case for `SRCREV =3D "${AUTOREV}` when no SCM URI =
is
> > given?
> >
> > No, however this case occurs indirectly with the recipetool command (fr=
om
> > the self-test devtool.DevtoolUpgradeTests). It generates a recipe in
> which
> > SRCREV is equal to "${AUTOREV}", even though the URI is not a SCM one.
> The
> > issue arose because I used SRCREV in a new "insane" test, see:
> > https://lists.openembedded.org/g/openembedded-core/topic/116341789
> >
> > The issue can be reproduced by applying my patches and running the
> > following command:
> >
> > $ recipetool --color=3Dauto create --devtool -o /tmp/devtool4819z5wk '
> > http://downloads.yoctoproject.org/mirror/sources/i2c-tools-3.1.2.tar.bz=
2
> '
> > -x ${BUILDDIR}/workspace/sources/devtoolsrcdcviuvn9
>
> Which patches are you referring to here? And, does the issue occur on the
> current master branch without applying any additional patches?
>
> >
> > Le lun. 8 d=C3=A9c. 2025 =C3=A0 17:59, Paul Barker <paul@pbarker.dev> a=
 =C3=A9crit :
> >
> > > On Mon, 2025-12-08 at 17:12 +0100, Corentin Guillevic via
> > > lists.openembedded.org wrote:
> > > > AUTOREV allows to fetch the latest revision. If no SCM URI is used
> (e.g.
> > > git://, ...),
> > > > AUTOREV has no effect. However there is one case in which a recipe
> with
> > > AUTOREV
> > > > but no SCM URI will lead to a parsing error:
> > > >
> > > > ERROR:
> > > /path/to/yocto/builds/build-qemux86-64/workspace/recipes/i2c-tools/
> > > i2c-tools_3.1.2.bb: AUTOREV/SRCPV set too late for the fetcher to wor=
k
> > > properly, please set the variables earlier in parsing. Erroring
> instead of
> > > later obtuse build failures.
> > > >
> > > > This error is raised when AUTOREV occurs (__BBAUTOREV_SEEN) but is
> not
> > > acted
> > > > upon (__BBAUTOREV_ACTED_UPON). A recipe with one SCM URI causes the
> > > > srcrev_internal_helper() function to run, and read the value of
> SRCREV.
> > > If
> > > > SRCREV =3D "${AUTOREV}", then AUTOREV will be acted upon.
> > > >
> > > > If the recipe does not have an SCM URI, SRCREV is not parsed and
> AUTOREV
> > > remains
> > > > unchanged. However, if SRCREV is expanded during the parsing time i=
n
> > > Python code
> > > > (either pure or evaluated from BitBake code), then AUTOREV will be
> > > expanded too
> > > > and resulting in the setting of __BBAUTOREV_SEEN. However, as there
> is
> > > no SCM
> > > > URI, the code flow that would act upon AUTOREV is never run.
> > > >
> > > > The fix slightly changes the way AUTOREV is handled: if no SCM URI =
is
> > > provided,
> > > > AUTOREV will be considered to have never occurred (__BBAUTOREV_SEEN
> will
> > > not be
> > > > defined).
> > >
> > > It makes more sense to me to throw an error if AUTOREV is seen but no
> > > SCM URI is provided, rather than silently ignoring AUTOREV. Perhaps w=
e
> > > just need to improve the error that is raised.
> > >
> > > Is there any valid case for `SRCREV =3D "${AUTOREV}` when no SCM URI =
is
> > > given?
>
> Thanks,
>
> --
> Paul Barker
>
>
>

--000000000000d547d806459d72f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt;=C2=A0Which patches are you referring to here?</d=
iv><div>I am referring to these patches:</div><div>-=C2=A0<a href=3D"https:=
//lists.openembedded.org/g/openembedded-core/topic/116341789" target=3D"_bl=
ank">https://lists.openembedded.org/g/openembedded-core/topic/116341789</a>=
</div><div>-=C2=A0<a href=3D"https://lists.openembedded.org/g/openembedded-=
core/message/226505" target=3D"_blank">https://lists.openembedded.org/g/ope=
nembedded-core/message/226505</a></div><div>They introduce and enable a new=
 &quot;insane&quot; test to check whether if a git URI is provided without =
a revision (SRCREV).</div><div><br></div><div>&gt;=C2=A0And, does the issue=
 occur on the current master branch without applying any additional patches=
?</div><div>No, the issue doesn&#39;t occur on the master branch. This happ=
ens with my patches because SRCREV is used in the test, and is expanded dur=
ing the parsing. If SRCREV is equal to &quot;${AUTOREV}&quot; but no SCM UR=
I is present, AUTOREV will be seen but no SCM function will act upon it.=C2=
=A0This leads to the error.</div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mer. 10 d=C3=A9c. 2025 =C3=A0=C2=
=A011:20, Paul Barker &lt;<a href=3D"mailto:paul@pbarker.dev" target=3D"_bl=
ank">paul@pbarker.dev</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Tue, 2025-12-09 at 11:43 +0100, Corent=
in Guillevic via<br>
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

--000000000000d547d806459d72f5--

