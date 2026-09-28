Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20235CA5FA2
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 12:52:22 +0000 (UTC)
Received: from mail-wr2-f23.google.com (mail-wr2-f23.google.com [74.125.225.87])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.57724.1790599936915519649
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 05:52:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=AgHe2Th5;
 spf=pass (domain: snapchat.com, ip: 74.125.225.87, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr2-f23.google.com with SMTP id ffacd0b85a97d-4888598e4f9so1739620f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 05:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790599935; cv=none;
        d=google.com; s=arc-20260327;
        b=AXAVZxNDkSpshUBaR8Dday8EZab/74BUYk6ZWDz3HgTilx9YWWXsPrsm8aRxNXqCxl
         rVpnkJ5SDofAxBrM1j+VIebR53FeVJVLPBHmG+ZOFxo678nfb0ZGUM4mZforrMD3SIYH
         JRUjd5wsJmQkIPtCX4/Nedj2+sTlx7vOGbgr+epTwRLZwTX3s6+WeprNVqxIzEcq24VW
         onbgYeEevZ5+EE+PJa0oY/m3kti/St8BYhBjQJXGHcnzuCAiO2NAOMZ6eFR7SKIqK1+u
         u7Wvc4edvSjBp06rYF3/0twNvk+FUvsKqgaiEIZ4ty/M7o69Lpgf6CM+L8bV5rsbXz19
         tsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U7NsppfnlRH9CE7Q7l0LVO3vYCVv96XFftTzMrgTf3Y=;
        fh=RUGD4bteL4KXEV5W1w3o0UCMeIWQN52jxk18+UaWkxo=;
        b=ZwIkyI0HX27xx4w3BqG9Fx7n36yDDotI8Vc6a3H1nuJhZjqBEJRjFZbGP7xJAoG4nr
         +EvRRElfxbZ9xhTIKmQyMgR9ExAdCBIm43zMaq9nxVqbf9Wz1FBCoXTgRcIiC08HvKSb
         iBW/GN0aN/zCnuc0U67ut2l8q1G9fe+T2Mc9A95LsnllbOFs386qzNkKJMVH4I05eS1N
         az7R1iBA6f/+S3nHg8rAIdITzNuuzHuAO58mJ61B0QOHjtm8b2xVDUFEhYweKVYOZlRs
         IxBSK/d79r27FoYEhR2X4HM16vtWFT+ItFA3gyc4sfDESc3V+tccpy9yDikP+gWTEFcp
         6WTw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790599935; x=1791204735; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U7NsppfnlRH9CE7Q7l0LVO3vYCVv96XFftTzMrgTf3Y=;
        b=AgHe2Th5MfAqfFml2RBbbJh2hvx7adu9DndVbbCoTAIS64WRxrmeKw34o+rhqteiMN
         gI0pmjTxLc9gUM11FAdYAHSFPD3U59R7FUFqfFxfAQqaYHjQQB8YwrtO63e3qrLoXid4
         PN9mR6dQZSyXW2rTLBmWsR8uUvmv5vEtJ2TLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790599935; x=1791204735;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U7NsppfnlRH9CE7Q7l0LVO3vYCVv96XFftTzMrgTf3Y=;
        b=vl++fHKv4/fP/jYpPIAPJHMcBdejkZKYZthD6utDBuzdgVPfgweDkCCMtUSKkpePvV
         WQUtao7AA7tp7HDCaFCvVcHoY+Dq0rU815sL0u3O4JYMFAd19h8CRPFg2VWZi6TVe4wI
         tk1bGUIpezeJBusec1+pDrhChfCwJI0YaF97LhVBOYsGLt924jG46fvQOAKP6EZUo/xs
         86qRdFWN6dSFScR1a5DimUS7Jjzi7W0W7OmSI7P+pkOHqVS9q2xCPOmre+w62Cum3hOb
         TkU+B/lgrstN7RmqoNX1vW083aQwnCNN6W6ZKtEMQ2hVcHfz9q05ucQy+82iRKdqdQx8
         IJSQ==
X-Gm-Message-State: AFq9FYLMcxceNtzRCxFV3Iz2Pt366hLlesgUgF7oaRbkQFvm3t10L1A8
	JhtJGp1MDKQjNFzvic6vrT3BEDZq+N6XNyKTojpv4CAp1yH56bHGy9ArHnlbFCgVL7YOnIwKBDB
	t6pdN2hAaWiRLuwYSk0bAN4ePKSjsqzwLH2fN6wfSZA==
X-Gm-Gg: AYBFou36KPwM9m8hgk4pEGm3NJvGVXZGxrdxeAvoXcpXhaX6u8e1Yc12qxt+eT2Iw6G
	LAtbcLo26ipY/eFkzWQ8/D6IXgDKmMZiKjVN8NqctOCoPGpHbl3Q1lDrJVcR7t2oO8cQDgx6rOA
	gh/g3TrHb+5OeqPstJkgnCO+8cdy9cX+sdJz6BTTh2ElR4GN0KT+B1P8xSsM3cHrpCvPj98RrJw
	nvFVqinnD3Ur20x1M8sL5W0vqssYchypP7sp7bSB0V7JqqBiN+ok1c7Np7gFKEoOeHMqITBdu4Z
	pcOfkVNHkH2Tu561qUpqvI8vqBS2osfUpBWjA3vx69E1WZyhUd5/mmfSjD43SZNqUVsbvx/nx0O
	GluUezyBc36U=
X-Received: by 2002:a05:6000:2083:b0:487:27f9:844 with SMTP id
 ffacd0b85a97d-4887172ac0cmr22582166f8f.57.1790599934975; Mon, 28 Sep 2026
 05:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260923170846.1360600-1-ecordonnier@snap.com> <8af7260e8e2d80ff6c597c0598e37b2a01c97dea.camel@pbarker.dev>
In-Reply-To: <8af7260e8e2d80ff6c597c0598e37b2a01c97dea.camel@pbarker.dev>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Mon, 28 Sep 2026 14:52:02 +0200
X-Gm-Features: AclHuK9enwzfEqQhBrsR39zJM2UmcoAaFG4tqDrDffLoDCeZ5n7V4ehq3QQv7X0
Message-ID: <CAHUKmYbk=biGvm0uf44hiwA+gOA5OG0Eg-MG+0uExu0TigE9xw@mail.gmail.com>
Subject: Re: [PATCH] fetch/wget: Reuse the checkstatus() urllib opener
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000000f73d1065c8a89ef"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 12:52:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20274

--0000000000000f73d1065c8a89ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

making the opener cache safe to use does depend on it: without the rename,
caching the opener would leak a Fetch object per distinct opener built. So
the two changes are tied together.
I've split the change in 2 patches as you suggested.

=C3=89tienne

On Mon, Sep 28, 2026 at 11:59=E2=80=AFAM Paul Barker <paul@pbarker.dev> wro=
te:

> On Wed, 2026-09-23 at 19:08 +0200, ecordonnier@snap.com wrote:
> > From: Etienne Cordonnier <ecordonnier@snap.com>
> >
> > checkstatus() builds a new urllib opener with its redirect, proxy and
> > connection cache handlers on every call, although sstate.bbclass calls =
it
> > for every object in an sstate mirror check with the same settings. Keep
> > the opener on the FetchConnectionCache, keyed on the certificate checki=
ng
> > setting and the fetcher environment, and rebuild it only when those
> > change. The handlers now refer to the connection cache directly rather
> > than through the first Fetch object, so a cached opener does not keep i=
t
> > alive. A connection cache is only used by one thread at a time, so no
> > locking is needed.
> >
> > Checking 2,114 objects on the Yocto sstate mirror with BB_NUMBER_THREAD=
S
> =3D "8"
> > reduced the time to task execution from 26.9s to 25.1s on average.
> >
> > AI-Generated: Uses Claude Code (Claude Opus 5.5)
> > Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> > ---
> >  lib/bb/fetch/__init__.py |  2 ++
> >  lib/bb/fetch/wget.py     | 45 ++++++++++++++++++++++++----------------
> >  2 files changed, 29 insertions(+), 18 deletions(-)
> >
> > diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
> > index 55ab710f3..0eb660685 100644
> > --- a/lib/bb/fetch/__init__.py
> > +++ b/lib/bb/fetch/__init__.py
> > @@ -2090,6 +2090,8 @@ class FetchConnectionCache(object):
> >      """
> >      def __init__(self):
> >          self.cache =3D {}
> > +        # urllib openers built by the wget fetcher, see
> Wget.checkstatus()
> > +        self.opener_cache =3D {}
> >
> >      def get_connection_name(self, host, port, connection_id=3DNone):
> >          if connection_id is None:
> > diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py
> > index 972c84048..9cb4a4f32 100644
> > --- a/lib/bb/fetch/wget.py
> > +++ b/lib/bb/fetch/wget.py
> > @@ -178,23 +178,24 @@ class Wget(FetchMethod):
> >      def checkstatus(self, fetch, ud, d, try_again=3DTrue):
> >          check_certs =3D self.check_certs(d)
> >          newenv =3D bb.fetch.get_fetcher_environment(d)
> > +        connection_cache =3D fetch.connection_cache
>
> Hi,
>
> Is this refactoring a necessary part of the urllib opener caching? If
> not it would be better to move it to a separate commit so that this
> patch is easier to understand.
>
> Best regards,
>
> --
> Paul Barker
>
>

--0000000000000f73d1065c8a89ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Paul,<br><br>making the opener cache safe to use does d=
epend on it: without the rename, caching the opener would leak a Fetch obje=
ct per distinct opener built. So the two changes are tied together.<br>I&#3=
9;ve split the change in 2 patches as you suggested.<br><br>=C3=89tienne</d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Mon, Sep 28, 2026 at 11:59=E2=80=AFAM Paul Barker &lt;<a href=3D"mailto:pau=
l@pbarker.dev" target=3D"_blank">paul@pbarker.dev</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 2026-09-23 at 19:0=
8 +0200, <a href=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ecordonn=
ier@snap.com</a> wrote:<br>
&gt; From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; <br>
&gt; checkstatus() builds a new urllib opener with its redirect, proxy and<=
br>
&gt; connection cache handlers on every call, although sstate.bbclass calls=
 it<br>
&gt; for every object in an sstate mirror check with the same settings. Kee=
p<br>
&gt; the opener on the FetchConnectionCache, keyed on the certificate check=
ing<br>
&gt; setting and the fetcher environment, and rebuild it only when those<br=
>
&gt; change. The handlers now refer to the connection cache directly rather=
<br>
&gt; than through the first Fetch object, so a cached opener does not keep =
it<br>
&gt; alive. A connection cache is only used by one thread at a time, so no<=
br>
&gt; locking is needed.<br>
&gt; <br>
&gt; Checking 2,114 objects on the Yocto sstate mirror with BB_NUMBER_THREA=
DS =3D &quot;8&quot;<br>
&gt; reduced the time to task execution from 26.9s to 25.1s on average.<br>
&gt; <br>
&gt; AI-Generated: Uses Claude Code (Claude Opus 5.5)<br>
&gt; Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@sn=
ap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch/__init__.py |=C2=A0 2 ++<br>
&gt;=C2=A0 lib/bb/fetch/wget.py=C2=A0 =C2=A0 =C2=A0| 45 +++++++++++++++++++=
+++++----------------<br>
&gt;=C2=A0 2 files changed, 29 insertions(+), 18 deletions(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py<br>
&gt; index 55ab710f3..0eb660685 100644<br>
&gt; --- a/lib/bb/fetch/__init__.py<br>
&gt; +++ b/lib/bb/fetch/__init__.py<br>
&gt; @@ -2090,6 +2090,8 @@ class FetchConnectionCache(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def __init__(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cache =3D {}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # urllib openers built by the wget fetche=
r, see Wget.checkstatus()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.opener_cache =3D {}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def get_connection_name(self, host, port, connecti=
on_id=3DNone):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if connection_id is None:<br>
&gt; diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py<br>
&gt; index 972c84048..9cb4a4f32 100644<br>
&gt; --- a/lib/bb/fetch/wget.py<br>
&gt; +++ b/lib/bb/fetch/wget.py<br>
&gt; @@ -178,23 +178,24 @@ class Wget(FetchMethod):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def checkstatus(self, fetch, ud, d, try_again=3DTr=
ue):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check_certs =3D self.check_certs(d)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newenv =3D bb.fetch.get_fetcher_envi=
ronment(d)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 connection_cache =3D fetch.connection_cac=
he<br>
<br>
Hi,<br>
<br>
Is this refactoring a necessary part of the urllib opener caching? If<br>
not it would be better to move it to a separate commit so that this<br>
patch is easier to understand.<br>
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div>

--0000000000000f73d1065c8a89ef--

