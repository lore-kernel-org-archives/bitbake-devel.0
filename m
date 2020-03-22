Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web10.22008.1584840462461006564
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Mar 2020 18:27:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=pZTCxHDw;
 spf=pass (domain: gmail.com, ip: 209.85.222.178, mailfrom: raj.khem@gmail.com)
Received: by mail-qk1-f178.google.com with SMTP id l25so6653126qki.7
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Mar 2020 18:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rc1gVbrjY32GNTZhpCKzYlebvK54LaezSXCXLLcZC0E=;
        b=pZTCxHDw9JSltUJ4JXs8WjaopvZaB0sTs5fBgt+sXErwkU2SV8zjH1xBcrsMo/7DDs
         v+yXHEG3gl537ApmUSaaQDyDpvW3aIHSZHxEzHUXChxyRQaoHLmWsehYPWwEsTPhcoY1
         6PksHykmYU+jaU9kh/bA0j5+4h2sdu/fIsWYUfYM/80ig0eEZ9ONLRSFMASSiUhXSidf
         Exv5hbxdo3y1alsueSWWjcXfN+OyBFLkzEKazVdxpvM1k/555Skn7/nFYb0XbaoreWEp
         JYq9eA/OIk1MPjTaBcOGma4XlQhopxVxEABzJA9x7eetFv7HmcBTT4+GKouSHkdZ8/Pk
         PmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rc1gVbrjY32GNTZhpCKzYlebvK54LaezSXCXLLcZC0E=;
        b=ib7+IiJA9l0y/zEWR/P9ebDX9rSgDv0nUzmdmD9pKH+Cx1Fxit5H7VzgttMwXld6w7
         TtG+Va9X4nJLjykCzgQ11551gEvLNF8Wi4jQG9P/OlmCn9QG4zjlMlMQ7Wukrqz+T3fy
         VBgqDkGXBdFPMf2NDj08Htn8/8VQ6+Im1L7rVlGdnnBpHaSKpZ2rPlGUkZ1Hu/Z8AEr0
         eAYQDOVWMh8VItAJFtsTE8qJQeIJ4dEolJ1nutFbwEQZj65yIJ6O1f6UjFkNG3HHpptS
         mKx71gwwYJuLZfnSTMplEOACdHfrX/KPgOuSbEeBCTaIxErFBdNY5eKxoNjcHCzIfRXT
         owSg==
X-Gm-Message-State: ANhLgQ1jxBRbp90z8hG1xiqEWDrZLx3O9FV82xYxn0sHt4xALnQ8gETX
	gdQHhtxHX1kYleUgzT3PwmAdb1vAkuL3QfiSY6i+2J8h
X-Google-Smtp-Source: ADFU+vs8V2bN4r9jBiBiSJK569VitgfowMLUd/bOi/6ixQJWXmvcKzIDxz8Xoz9zZ5IcF04DSQjL7hVviQANthmjB2w=
X-Received: by 2002:a37:8d81:: with SMTP id p123mr3029561qkd.17.1584840461159;
 Sat, 21 Mar 2020 18:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200215032955.3958-3-pkj@axis.com> <5532.1584827063458682607@lists.openembedded.org>
 <1cdd50184c1f4af488baee9ee691b495@XBOX03.axis.com> <CAMKF1srOQVRW8n9bzr9GXiA3NBOX=cE5EV-W9S_dq+JFRqNjMQ@mail.gmail.com>
 <2f891d304ee448538457d2b94c32bba3@XBOX03.axis.com>
In-Reply-To: <2f891d304ee448538457d2b94c32bba3@XBOX03.axis.com>
From: "Khem Raj" <raj.khem@gmail.com>
Date: Sat, 21 Mar 2020 18:27:29 -0700
Message-ID: <CAMKF1sqsZW4Nher5wy6WwjdoWcz7-Yd-KHQyzp0PxPZsyGT=yg@mail.gmail.com>
Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000b6903e05a1676cb0"

--000000000000b6903e05a1676cb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2020 at 5:38 PM Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> > -----Original Message-----
> > From: Khem Raj <raj.khem@gmail.com>
> > Sent: den 22 mars 2020 00:59
> > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > Cc: bitbake-devel@lists.openembedded.org
> > Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow
> > ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
> >
> > On Sat, Mar 21, 2020 at 4:50 PM Peter Kjellerstedt
> > <peter.kjellerstedt@axis.com> wrote:
> > >
> > > Rather than blindly reverting, can=E2=80=99t we update the documentat=
ion
> > > instead? If you use ${AUTOREV} you obviously do it because you always
> want
> > > the latest revision.
> >
> > Autorev + clear srcrev policy if you want that
>
> Well, obviously ${AUTOREV} works with BB_SRCREV_POLICY =3D "clear". But
> BB_SRCREV_POLICY is a distro configuration and it is not possible to
> override
> it per recipe. Which means that if it is set to "cache", it is not
> possible
> to use ${AUTOREV}. This is not documented, and to the developers it will
> look
> as if it is working, since it fetches the very first time the recipe is
> built.
> But there will be no updates, so it is as useful as setting SRCREV =3D
> "master"
> (which some of our developers also have tried before being educated to ho=
w
> BitBake works)...
>
> > > Before this change, using ${AUTOREV} in combination with
> > > BB_SRCREV_POLICY =3D "cache" didn=E2=80=99t work, which also wasn=E2=
=80=99t documented.
> >
> > It could be interpreted also that cache also caches AUTOREVs
> > this will break downstream projects. Its equivalent of ABI change,
> > that perhaps will do more harm then what it fixes.
>
> I fail to see how it will break stuff as it was not possible to use
> ${AUTOREV}
> before in a meaningful way together with BB_SRCREV_POLICY =3D "cache".


There are workflows depending on this behavior unfortunately


>
> > > //Peter
>
> //Peter
>
> > > From: bitbake-devel@lists.openembedded.org <bitbake-
> > devel@lists.openembedded.org> On Behalf Of Khem Raj
> > > Sent: den 21 mars 2020 22:44
> > > To: bitbake-devel@lists.openembedded.org
> > > Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow
> > ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
> > >
> > >
> > >
> > > removing
> > >
> > > if d.getVar('BB_SRCREV_POLICY') !=3D "cache":
> > >
> > > Will cause autorevs to be excluded from policy and its not documented
> > >
> > >
> https://www.yoctoproject.org/docs/2.1/bitbake-user-manual/bitbake-user-
> > manual.html#var-BB_SRCREV_POLICY
> > >
> > > did not state that AUTOREVs plus BB_SRCREV_POLICY behavior, this patc=
h
> > is regressing the case
> > > where we rely on this behavior to use externalsrc on AUTOREVed recipe=
s.
>

--000000000000b6903e05a1676cb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sat, Mar 21, 2020 at 5:38 PM Peter Kjellerstedt &lt;<a h=
ref=3D"mailto:peter.kjellerstedt@axis.com">peter.kjellerstedt@axis.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt; -----Original Messa=
ge-----<br>
&gt; From: Khem Raj &lt;<a href=3D"mailto:raj.khem@gmail.com" target=3D"_bl=
ank">raj.khem@gmail.com</a>&gt;<br>
&gt; Sent: den 22 mars 2020 00:59<br>
&gt; To: Peter Kjellerstedt &lt;<a href=3D"mailto:peter.kjellerstedt@axis.c=
om" target=3D"_blank">peter.kjellerstedt@axis.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"=
_blank">bitbake-devel@lists.openembedded.org</a><br>
&gt; Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow<b=
r>
&gt; ${AUTOREV} to be used when BB_SRCREV_POLICY is &quot;cache&quot;<br>
&gt; <br>
&gt; On Sat, Mar 21, 2020 at 4:50 PM Peter Kjellerstedt<br>
&gt; &lt;<a href=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_blank">p=
eter.kjellerstedt@axis.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Rather than blindly reverting, can=E2=80=99t we update the docume=
ntation<br>
&gt; &gt; instead? If you use ${AUTOREV} you obviously do it because you al=
ways want<br>
&gt; &gt; the latest revision.<br>
&gt;=C2=A0 <br>
&gt; Autorev + clear srcrev policy if you want that<br>
<br>
Well, obviously ${AUTOREV} works with BB_SRCREV_POLICY =3D &quot;clear&quot=
;. But <br>
BB_SRCREV_POLICY is a distro configuration and it is not possible to overri=
de <br>
it per recipe. Which means that if it is set to &quot;cache&quot;, it is no=
t possible <br>
to use ${AUTOREV}. This is not documented, and to the developers it will lo=
ok <br>
as if it is working, since it fetches the very first time the recipe is bui=
lt.<br>
But there will be no updates, so it is as useful as setting SRCREV =3D &quo=
t;master&quot; <br>
(which some of our developers also have tried before being educated to how =
<br>
BitBake works)...<br>
<br>
&gt; &gt; Before this change, using ${AUTOREV} in combination with<br>
&gt; &gt; BB_SRCREV_POLICY =3D &quot;cache&quot; didn=E2=80=99t work, which=
 also wasn=E2=80=99t documented.<br>
&gt; <br>
&gt; It could be interpreted also that cache also caches AUTOREVs<br>
&gt; this will break downstream projects. Its equivalent of ABI change,<br>
&gt; that perhaps will do more harm then what it fixes.<br>
<br>
I fail to see how it will break stuff as it was not possible to use ${AUTOR=
EV} <br>
before in a meaningful way together with BB_SRCREV_POLICY =3D &quot;cache&q=
uot;.</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">There are w=
orkflows depending on this behavior unfortunately=C2=A0</div><div dir=3D"au=
to"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
&gt; &gt; //Peter<br>
<br>
//Peter<br>
<br>
&gt; &gt; From: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" tar=
get=3D"_blank">bitbake-devel@lists.openembedded.org</a> &lt;bitbake-<br>
&gt; <a href=3D"mailto:devel@lists.openembedded.org" target=3D"_blank">deve=
l@lists.openembedded.org</a>&gt; On Behalf Of Khem Raj<br>
&gt; &gt; Sent: den 21 mars 2020 22:44<br>
&gt; &gt; To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" targe=
t=3D"_blank">bitbake-devel@lists.openembedded.org</a><br>
&gt; &gt; Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Al=
low<br>
&gt; ${AUTOREV} to be used when BB_SRCREV_POLICY is &quot;cache&quot;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; removing<br>
&gt; &gt;<br>
&gt; &gt; if d.getVar(&#39;BB_SRCREV_POLICY&#39;) !=3D &quot;cache&quot;:<b=
r>
&gt; &gt;<br>
&gt; &gt; Will cause autorevs to be excluded from policy and its not docume=
nted<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://www.yoctoproject.org/docs/2.1/bitbake-user-man=
ual/bitbake-user-" rel=3D"noreferrer" target=3D"_blank">https://www.yoctopr=
oject.org/docs/2.1/bitbake-user-manual/bitbake-user-</a><br>
&gt; manual.html#var-BB_SRCREV_POLICY<br>
&gt; &gt;<br>
&gt; &gt; did not state that AUTOREVs plus BB_SRCREV_POLICY behavior, this =
patch<br>
&gt; is regressing the case<br>
&gt; &gt; where we rely on this behavior to use externalsrc on AUTOREVed re=
cipes.<br>
</blockquote></div></div>

--000000000000b6903e05a1676cb0--
