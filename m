Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E221FC9833F
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 10:59:57 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55813.1790593197088309645
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 03:59:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Jwv/ANQA;
 spf=pass (domain: snapchat.com, ip: 74.125.225.140, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so9933235e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 03:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790593195; cv=none;
        d=google.com; s=arc-20260327;
        b=hCHfHMll2XosQjPiPcnWoJPJWN6vP8A/hUbfDuL1t3cbY88iuuhc0LSrjYy8TeU1vj
         /SlMwiOZr39gtivNABcL046rZ/IDKx4ADcwYQWsHW3ris2HW8C657ggBuN3aI0Qm4f9h
         3uG2UeambuW7lmqjB++Mwqy84IjtJGlmcBfrlHLPinCT8NdfFVxKNxD+pMMucP0Gdj93
         1yEZRP8s2e6K5xtrwLLbqq2G5Z56/0u6LlvAK6k++mH7N43U7WegBZDjd4H0xH7QLkza
         Iu5ajk/38SKR0iFWogeMFflBJZo5o2KdnugY61ZyE1hqJQYtLAyd7wdzf/+RmMDedqNL
         498g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DYUFVarRddUSrK5HDGNijmMVV5BGGVXiz+hjPtBD86E=;
        fh=RUGD4bteL4KXEV5W1w3o0UCMeIWQN52jxk18+UaWkxo=;
        b=S5JhjuYNGxhbYI8zGcpT6hOAb5aMIhBlFksMCQs0X6ZhdLeyuuC1a8tWUEi1O0Agt2
         K+X9v53MJkUaqptFf7hsx72eFOksyIm209Kx62i6fPC7Lix27MRzgKuy2aN0XHxqRRI7
         HW+o5m6pN7EIxIuSSRRwveyH82um3JCqiPkJW2q81eYVBlwju840bjWJRDNLNDdsEZ6P
         lN2KWtigUR2hx2JAourYuT06WxQtYyeizzLuyRaRHqIIG0SfYR2VDIjNgXckAQ1k+vJJ
         oYuZOI+VNmTm35HEXnPJZ42q/F9cB8vNdj/7DK8CN2dhlrsLMKSO2yleqj8RJx0zSDUk
         cZRg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790593195; x=1791197995; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYUFVarRddUSrK5HDGNijmMVV5BGGVXiz+hjPtBD86E=;
        b=Jwv/ANQAR8pjkp4XoCTnTgK7Up2JpF5a4Ue4SH57vap0wbh21VIEhEEp6qRE6JeDFA
         FdRP2Mq53Mbocn2MpA3sjNbLT8DxJgb8sXeeLh1Uw7odoh6fPEExtLDGJQPwBQS+Lw+O
         G0lDD0rlVhRV5ZchA9cLnUP548g/SAthC99gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790593195; x=1791197995;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DYUFVarRddUSrK5HDGNijmMVV5BGGVXiz+hjPtBD86E=;
        b=QfBDfvTGXT3KEfXxWLsLapIQK0qXpPxTtz1OfMxjiT02bi/3Ywdnsojsg6HuieGQOd
         HHtCu8pXdjhw3fZAIDgZqwv81B17X+kkgcnmsBmYbAl+0n+flK7z1KB9+uBYr7jx/p3y
         N9Wi/fq1xXSnELDuF0yH9dQUGVoo448rAbyrpO49vV0Z4WRGQ/8zzEuJLkOOGGOFbD+2
         faPA7wrj+o92T3uo+eXg8wcEbFpTcJNtHvdx8iVpvhsSHMjiiqm2f0uA/TFCbtyY2PY2
         2MbgJp1cdEbdePna7tPhfdXvqCzODdGg+ZTAzY+7dj7nzWUBSJVoonsQMJub+rdZOIE2
         ZbRw==
X-Gm-Message-State: AFuF++nJ2x+BwYXc+d3REwhhtH5iJVwA5VmIneiMrAjfnNJvcK753Xwd
	dsDaejx5WfdzAa/Pr/UBT02E0VQ7pW3UyYA6OyVOiPLhOD18DC/5m6ylMmEryqu9ZwSpGgdY0+J
	HSCGdJ2M+Ty49PyPSJ8D5plMnQw0gD35Xwp1eHTrhHg==
X-Gm-Gg: AYBFou3g9nL/rlkHNB3LCJ3vnLrSHimdT4P0SWU1TaLEDrkxOsP+RklPl6l2G66j8uo
	E2+9K7SCO6SBkmprMt+5lnEG3ZQKWEdyxI56Ag2eZyxO01Chsy/2VXSVoDm8MyzySSmNdUmRcdf
	aZxkxIkdQgMtWaCey7HZVmXP9MPGTHVWjEMbmLHUS4Z4TBCaV3gWp0lZNDtwGXXGhZBYg7KW4T/
	wP4yqLiODwDUeeyV5MiCFDedAUXpqb2AS+pgJEIJfcQNqFQySw9SLrH73gdOIXeie0UCaizb6xT
	A76bo2ybEn1bsIN5TzrlSKovOY5Q5irjEeDuZgKQBcXEcWcIz3OF0+w5uQGb0lSK56fv002sNnQ
	IYGL8QDHitoaxlDJwL2Xvn74=
X-Received: by 2002:a05:600c:3b0f:b0:49e:7cc2:e6c2 with SMTP id
 5b1f17b1804b1-49ff06ed8a4mr155654415e9.27.1790593195064; Mon, 28 Sep 2026
 03:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260923170633.1313487-1-ecordonnier@snap.com> <9ea48161f0ffb0ca0b0175631d0a5af9660e71f9.camel@pbarker.dev>
In-Reply-To: <9ea48161f0ffb0ca0b0175631d0a5af9660e71f9.camel@pbarker.dev>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Mon, 28 Sep 2026 12:59:43 +0200
X-Gm-Features: AclHuK_bKOTpGntZzXaOAcf2B5AQvEstKATq0xH9fahaFPNZJ9VT6ukQa_h4g3M
Message-ID: <CAHUKmYYHRy=kAbKoQgYX2cU6Nfv+d2rmwkNP5B=8Jr967fyy0w@mail.gmail.com>
Subject: Re: [PATCH] cache: Reuse os.path.exists() results during dependency validation
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000546a27065c88f7ba"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 10:59:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20269

--000000000000546a27065c88f7ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,
in the commit with the LRU cache, it was a long-lived cache which could
grow over time / over multiple builds (assuming a persistent server using
BB_SERVER_TIMEOUT).
In this case, it is a cache instance with a bounded size which can't grow
over time and is reset after each bitbake command.

I've measured the dict with 48K entries to use about 13MiB (using
sys.getsizeof()), so I'm assuming it's acceptable even for bigger BSPs.

I think in this particular case I think it makes sense to keep it
unbounded. I am using such a huge BSP with many layers myself and the
slowness of bitbake in this use-case is my motivation for those patches.
Do you have a use-case in mind where the size of the cache would be an
issue?

=C3=89tienne

On Mon, Sep 28, 2026 at 11:49=E2=80=AFAM Paul Barker <paul@pbarker.dev> wro=
te:

> On Wed, 2026-09-23 at 19:06 +0200, ecordonnier@snap.com wrote:
> > From: Etienne Cordonnier <ecordonnier@snap.com>
> >
> > cacheValidUpdate() checks each recipe's file_checksums entries with
> > os.path.exists(). Many recipes reference the same optional class or
> > checksum candidate paths, so the same path is checked repeatedly within
> > one validation pass. In a warm parse of 5,112 recipes (poky, meta-yocto=
,
> > meta-oe, meta-python), the real cache data shows 585,348 such calls
> > against only 48,757 unique paths, with the hottest path checked 16,894
> > times: 536,591 calls are redundant. At 3.5us per os.path.exists() call =
on
> > a nonexistent path on this machine, that is about 1.9s of avoidable
> > syscall time per validation pass. Cache the result per Cache instance,
> > which is discarded and recreated at the start of each validation pass, =
so
> > a filesystem change between passes is still observed.
> >
> > AI-Generated: Uses Claude Code (Claude Opus 5.5)
> > Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> > ---
> >  lib/bb/cache.py | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> > index 2361c5684..01020f844 100644
> > --- a/lib/bb/cache.py
> > +++ b/lib/bb/cache.py
> > @@ -401,6 +401,8 @@ class Cache(object):
> >          self.clean =3D set()
> >          self.checked =3D set()
> >          self.depends_cache =3D {}
> > +        # os.path.exists() results for this validation pass (see
> file_exists())
> > +        self.exists_cache =3D {}
> >          self.data_fn =3D None
> >          self.cacheclean =3D True
> >          self.data_hash =3D data_hash
> > @@ -619,7 +621,8 @@ class Cache(object):
> >                      if not f:
> >                          continue
> >                      f, exist =3D f.rsplit(":", 1)
> > -                    if (exist =3D=3D "True" and not os.path.exists(f))=
 or
> (exist =3D=3D "False" and os.path.exists(f)):
> > +                    file_exists =3D self.file_exists(f)
> > +                    if (exist =3D=3D "True" and not file_exists) or (e=
xist
> =3D=3D "False" and file_exists):
> >                          self.logger.debug2("%s's file checksum list
> file %s changed",
> >                                               fn, f)
> >                          self.remove(fn)
> > @@ -657,6 +660,11 @@ class Cache(object):
> >          self.clean.add(fn)
> >          return True
> >
> > +    def file_exists(self, fn):
> > +        if fn not in self.exists_cache:
> > +            self.exists_cache[fn] =3D os.path.exists(fn)
> > +        return self.exists_cache[fn]
>
> In the example given in the commit message this will result in a
> dictionary with 48,757 entries. With more layers included this could be
> larger still.
>
> Would it make sense to use an LRU cache with a maximum size here, as you
> did in [1]?
>
> [1]:
> https://lore.kernel.org/bitbake-devel/20260923140208.1915740-1-ecordonnie=
r@snap.com/
>
> Best regards,
>
> --
> Paul Barker
>
>

--000000000000546a27065c88f7ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Paul,<br>in the commit with the LRU cache, it was a lon=
g-lived cache which could grow over time / over multiple builds (assuming a=
 persistent server using BB_SERVER_TIMEOUT).<br>In this case, it is a cache=
 instance with a bounded size which can&#39;t grow over time and is reset a=
fter each bitbake command.<br><br>I&#39;ve measured the dict with 48K entri=
es to use about 13MiB (using sys.getsizeof()), so I&#39;m assuming it&#39;s=
 acceptable even for bigger BSPs.<br><br>I think in this particular case I =
think it makes sense to keep it unbounded. I am using such a huge BSP with =
many layers myself and the slowness of bitbake in this use-case is my motiv=
ation for those patches.<br>Do you have a use-case in mind where the size o=
f the cache would be an issue?<br><br>=C3=89tienne</div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On =
Mon, Sep 28, 2026 at 11:49=E2=80=AFAM Paul Barker &lt;<a href=3D"mailto:pau=
l@pbarker.dev">paul@pbarker.dev</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Wed, 2026-09-23 at 19:06 +0200, <a href=
=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ecordonnier@snap.com</a>=
 wrote:<br>
&gt; From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; <br>
&gt; cacheValidUpdate() checks each recipe&#39;s file_checksums entries wit=
h<br>
&gt; os.path.exists(). Many recipes reference the same optional class or<br=
>
&gt; checksum candidate paths, so the same path is checked repeatedly withi=
n<br>
&gt; one validation pass. In a warm parse of 5,112 recipes (poky, meta-yoct=
o,<br>
&gt; meta-oe, meta-python), the real cache data shows 585,348 such calls<br=
>
&gt; against only 48,757 unique paths, with the hottest path checked 16,894=
<br>
&gt; times: 536,591 calls are redundant. At 3.5us per os.path.exists() call=
 on<br>
&gt; a nonexistent path on this machine, that is about 1.9s of avoidable<br=
>
&gt; syscall time per validation pass. Cache the result per Cache instance,=
<br>
&gt; which is discarded and recreated at the start of each validation pass,=
 so<br>
&gt; a filesystem change between passes is still observed.<br>
&gt; <br>
&gt; AI-Generated: Uses Claude Code (Claude Opus 5.5)<br>
&gt; Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@sn=
ap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/cache.py | 10 +++++++++-<br>
&gt;=C2=A0 1 file changed, 9 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/cache.py b/lib/bb/cache.py<br>
&gt; index 2361c5684..01020f844 100644<br>
&gt; --- a/lib/bb/cache.py<br>
&gt; +++ b/lib/bb/cache.py<br>
&gt; @@ -401,6 +401,8 @@ class Cache(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.clean =3D set()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.checked =3D set()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.depends_cache =3D {}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # os.path.exists() results for this valid=
ation pass (see file_exists())<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.exists_cache =3D {}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.data_fn =3D None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cacheclean =3D True<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.data_hash =3D data_hash<br>
&gt; @@ -619,7 +621,8 @@ class Cache(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if not f:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 continue<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 f, exist =3D f.rsplit(&quot;:&quot;, 1)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if (exist =3D=3D &quot;True&quot; and not os.path.exists(f)) or (exist =3D=
=3D &quot;False&quot; and os.path.exists(f)):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 file_exists =3D self.file_exists(f)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if (exist =3D=3D &quot;True&quot; and not file_exists) or (exist =3D=3D &q=
uot;False&quot; and file_exists):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 self.logger.debug2(&quot;%s&#39;s file checksum list f=
ile %s changed&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0fn, f)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 self.remove(fn)<br>
&gt; @@ -657,6 +660,11 @@ class Cache(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.clean.add(fn)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def file_exists(self, fn):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if fn not in self.exists_cache:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.exists_cache[fn] =3D o=
s.path.exists(fn)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.exists_cache[fn]<br>
<br>
In the example given in the commit message this will result in a<br>
dictionary with 48,757 entries. With more layers included this could be<br>
larger still.<br>
<br>
Would it make sense to use an LRU cache with a maximum size here, as you<br=
>
did in [1]?<br>
<br>
[1]: <a href=3D"https://lore.kernel.org/bitbake-devel/20260923140208.191574=
0-1-ecordonnier@snap.com/" rel=3D"noreferrer" target=3D"_blank">https://lor=
e.kernel.org/bitbake-devel/20260923140208.1915740-1-ecordonnier@snap.com/</=
a> <br>
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div>

--000000000000546a27065c88f7ba--

