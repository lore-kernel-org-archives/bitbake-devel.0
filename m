Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F41C83F17
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 11:17:26 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.11615.1753269431453373063
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Jul 2025 04:17:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Ea/tgWYT;
 spf=pass (domain: snapchat.com, ip: 209.85.218.50, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0c4945c76so890066666b.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Jul 2025 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1753269430; x=1753874230; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dghayUwkdW1jd+u3bU4duftheksBwhA4jPONjPegyII=;
        b=Ea/tgWYTAK7/HWhh5q3mA0r3Bh+vioLEnpkfkl/GdKAHeto8KbxGynYJH2UUhr/A9y
         bS0Cj0JnSGaUbvwGI8IGDEWmv5TgydWDm44At4tO4JfmMtrdj5jG8yyxhaoNkAGEWgVF
         T3n+0HmZq0qad6dgcYWW6Al8aS9trfpv+Ox4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269430; x=1753874230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dghayUwkdW1jd+u3bU4duftheksBwhA4jPONjPegyII=;
        b=eFl+MpFmrNkrrWIMJT0gcYQX3P1Mk8Zq5Lss0UjrGg/JTIm2Q2HtMlCh+reRgHAHnq
         Oqtjksv0dS/M+9cKqKVGoXdPNzGkk7z1Qwl56jrP9rEH0UXjIqWULpAZT3QWxIICIALQ
         LECYqINDRctjv4FmgtyAPt0R2/2c6HHf3NGhGiJaka3Kt+a5Md0xaYRQvWjkvFtUskge
         HJoM32y85wj6rD4fhL4N4zpH6omC2CcCt7MEuu1mXfr5hGIDZKhiyIbGsXLeNtzfK+Ok
         4Nx8Ds6S91OXqEKIVHII2V1RzerxpQA3pXl+pjFP1tuUZm2yarOVqKbO24SLKPYqhSHx
         kOvQ==
X-Gm-Message-State: AOJu0YyTC1/sZofJ1VVWahJAePWDArl4B6vBSk8+qOSB4+BIxPgV2TRG
	oNvsD2oX2tmhi3JNbK5aeIcJEZOrzVL8jjw0vXDaJJLbCUUsEO+KBZLyk1eJPpUD4oP9kV5a1u4
	tH/XHszvi5UN13A/+Q5e8zdAqPTlrTHMFm6HWho9bQw==
X-Gm-Gg: ASbGnctph+ebwxvkzRhY+btc6rxXe6JNzsCAScRKYAdOaxHCyB2QbbuiMJaGGK4EaIt
	ie70NcbWabgDUc6O8pWU7DbKoI57UvwvjS33kyLUp9x70dRY1R70XBcY8jAx/MaXht870Ed2Hl+
	D8wv210Wcj9vVtg2KwNOUJhq9WKBAGE0S9aIoDRCELKGw8fpcikz0D97lt4kv/sYt3DO2HyP0wP
	r4ALkA=
X-Google-Smtp-Source: AGHT+IG2M+Z1QdVwIYtHx+0rVcWnMp1RF23K5ShEcsjhg7v7/vSw/NtGVaN5GlqcHvG8KlnaRnBtWiS/ehX0VHl15tw=
X-Received: by 2002:a17:907:6d23:b0:ae0:e123:605f with SMTP id
 a640c23a62f3a-af2f895947fmr236430666b.39.1753269429547; Wed, 23 Jul 2025
 04:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250702204758.2773339-1-ecordonnier@snap.com> <965923cb6979f8066b596810e5c5344d7739b8a6.camel@linuxfoundation.org>
In-Reply-To: <965923cb6979f8066b596810e5c5344d7739b8a6.camel@linuxfoundation.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Wed, 23 Jul 2025 13:16:58 +0200
X-Gm-Features: Ac12FXz1QXSjsBkvubXACBmrWjjyQ29I2WCG6EuvW_CVKG8_ZdCTB9zm_0zR_tQ
Message-ID: <CAHUKmYYuC1j4uKCc+MizUF-STEOa4hxCRjicMO17rNuvtOgDYg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] uihelper: Fix KeyError race condition in
 pidmap access
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, Steve Sakoman <steve@sakoman.com>
Content-Type: multipart/alternative; boundary="0000000000008b5e58063a96d9c3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Jul 2025 11:17:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17806

--0000000000008b5e58063a96d9c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the information. I have continued to monitor this on our side,
but I have not seen a single failure after July 2 even though 300 builds
have run on the CI build pipeline which failed 2 from 50 builds while
building the 5.0.10 update branch. The fix above is not applied.
I guess there was some pre-condition to trigger the race-condition in this
update branch which is not there any more.

=C3=89tienne


On Wed, Jul 23, 2025 at 12:45=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2025-07-02 at 22:47 +0200, Etienne Cordonnier via
> lists.openembedded.org wrote:
> > From: Etienne Cordonnier <ecordonnier@snap.com>
> >
> > I'm seeing random build errors on scarthgap 5.0.10 because the pid is
> not contained in pidmap.
> > Fix the error by ensure the PID exists in pidmap before accessing it.
> >
> > Call-stack of the error:
> >
> > ```
> > Traceback (most recent call last):
> >   File "poky/bitbake/lib/bb/ui/knotty.py", line 681, in main
> >     helper.eventHandler(event)
> >   File "poky/bitbake/lib/bb/ui/uihelper.py", line 43, in eventHandler
> >     removetid(event.pid, tid)
> >   File "poky/bitbake/lib/bb/ui/uihelper.py", line 28, in removetid
> >     if self.pidmap[pid] =3D=3D tid:
> > KeyError: 21041
> > WARNING: Exiting due to interrupt.
> > ```
> >
> > Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> > ---
> >  lib/bb/ui/uihelper.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
> > index e6983bd55..0bc526ca1 100644
> > --- a/lib/bb/ui/uihelper.py
> > +++ b/lib/bb/ui/uihelper.py
> > @@ -25,7 +25,7 @@ class BBUIHelper:
> >          def removetid(pid, tid):
> >              self.running_pids.remove(tid)
> >              del self.running_tasks[tid]
> > -            if self.pidmap[pid] =3D=3D tid:
> > +            if pid in self.pidmap and self.pidmap[pid] =3D=3D tid:
> >                  del self.pidmap[pid]
> >              self.needUpdate =3D True
> >
>
> FWIW I did discover a bug recently:
>
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.yoctoproject.o=
rg_poky_commit_-3Fid-3Db7173ca2254421c45f01243a77be611fe4b9d1c5&d=3DDwIFaQ&=
c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&m=3DIJNUV1g533T5CdmLjFtHp3AubpGaT_vPTNW9eXmoXP2mLpyc7C=
KV6QDuolkL3rQW&s=3DkOBWhnHiyEQNgRIPAIPbPAfBmFzavE7sa6RXMnnj01g&e=3D
>
> which could potentially have caused the issue you saw.
>
> Copying Steve as this fix could potentially be stable branch material.
>
> Cheers,
>
> Richard
>

--0000000000008b5e58063a96d9c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the information. I have continued to monitor th=
is on our side, but I have not seen a single failure after July 2 even thou=
gh 300 builds have run on the CI build pipeline which failed 2 from 50 buil=
ds while building the 5.0.10=C2=A0update branch. The fix above is not appli=
ed.<br>I guess there was some pre-condition to trigger the race-condition i=
n this update branch which is not there any more.<br><br>=C3=89tienne<br>=
=C2=A0</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Jul 23, 2025 at 12:45=E2=80=AFPM Rich=
ard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richar=
d.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Wed, 2025-07-02 at 22:47 +0200, Etienne Cord=
onnier via <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" tar=
get=3D"_blank">lists.openembedded.org</a> wrote:<br>
&gt; From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; <br>
&gt; I&#39;m seeing random build errors on scarthgap 5.0.10 because the pid=
 is not contained in pidmap.<br>
&gt; Fix the error by ensure the PID exists in pidmap before accessing it.<=
br>
&gt; <br>
&gt; Call-stack of the error:<br>
&gt; <br>
&gt; ```<br>
&gt; Traceback (most recent call last):<br>
&gt; =C2=A0 File &quot;poky/bitbake/lib/bb/ui/knotty.py&quot;, line 681, in=
 main<br>
&gt; =C2=A0=C2=A0=C2=A0 helper.eventHandler(event)<br>
&gt; =C2=A0 File &quot;poky/bitbake/lib/bb/ui/uihelper.py&quot;, line 43, i=
n eventHandler<br>
&gt; =C2=A0=C2=A0=C2=A0 removetid(event.pid, tid)<br>
&gt; =C2=A0 File &quot;poky/bitbake/lib/bb/ui/uihelper.py&quot;, line 28, i=
n removetid<br>
&gt; =C2=A0=C2=A0=C2=A0 if self.pidmap[pid] =3D=3D tid:<br>
&gt; KeyError: 21041<br>
&gt; WARNING: Exiting due to interrupt.<br>
&gt; ```<br>
&gt; <br>
&gt; Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@sn=
ap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/ui/uihelper.py | 2 +-<br>
&gt; =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py<br>
&gt; index e6983bd55..0bc526ca1 100644<br>
&gt; --- a/lib/bb/ui/uihelper.py<br>
&gt; +++ b/lib/bb/ui/uihelper.py<br>
&gt; @@ -25,7 +25,7 @@ class BBUIHelper:<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def removetid(pid, ti=
d):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 self.running_pids.remove(tid)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 del self.running_tasks[tid]<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 self.pidmap[pid] =3D=3D tid:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 pid in self.pidmap and self.pidmap[pid] =3D=3D tid:<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 del self.pidmap[pid]<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 self.needUpdate =3D True<br>
&gt; =C2=A0<br>
<br>
FWIW I did discover a bug recently:<br>
<br>
<a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.yocto=
project.org_poky_commit_-3Fid-3Db7173ca2254421c45f01243a77be611fe4b9d1c5&am=
p;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAh=
kbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DIJNUV1g533T5CdmLjFtHp3Aub=
pGaT_vPTNW9eXmoXP2mLpyc7CKV6QDuolkL3rQW&amp;s=3DkOBWhnHiyEQNgRIPAIPbPAfBmFz=
avE7sa6RXMnnj01g&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://url=
defense.proofpoint.com/v2/url?u=3Dhttps-3A__git.yoctoproject.org_poky_commi=
t_-3Fid-3Db7173ca2254421c45f01243a77be611fe4b9d1c5&amp;d=3DDwIFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3DIJNUV1g533T5CdmLjFtHp3AubpGaT_vPTNW9eXmoXP2mLpy=
c7CKV6QDuolkL3rQW&amp;s=3DkOBWhnHiyEQNgRIPAIPbPAfBmFzavE7sa6RXMnnj01g&amp;e=
=3D</a> <br>
<br>
which could potentially have caused the issue you saw.<br>
<br>
Copying Steve as this fix could potentially be stable branch material.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--0000000000008b5e58063a96d9c3--

