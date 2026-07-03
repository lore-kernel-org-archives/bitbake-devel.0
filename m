Return-Path: <sivakumar.bs@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BADC43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 12:40:31 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.91472.1783082423681029668
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Jul 2026 05:40:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=e9E/tdgm;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: sivakumar.bs@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so3102506d6.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Jul 2026 05:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783082422; cv=none;
        d=google.com; s=arc-20260327;
        b=idrpa2eSJOjj3xQqLA82qS/J1BthUVICV3iQxynxNXtjkCG22MW9BScVihCPQ7AtdP
         YYjMiDGbmOjOeyXtlp8J199BwGBPRwRm6HMaUg0ypURYFXKfDaStqtVktGSup8B0t4tC
         djHY1OHO368dVjbIn3Na6szd1SfO05PXYaOyxOHt7bR1lRIjHBi/ocg9gVExoU46n6cb
         iDB5UxwcAkDFowf83gLIuUg6+YhR/lWzlzD82sUH0GYj3YTuWU3TDWXeGGgEF+Drs/vn
         tyaaGlt1tOLbZITURCVrCQlcNDWcilfkJJvk6b42RE87jwBEJm4/Wip29v8p5HwsCGZM
         4iRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ps1j8JvLl37VqJidjWVuvD2mZtAb5cn1pGCGDWuLwyc=;
        fh=1cLC2UwfRgPOK1i7OfNVppBUJQJgpSqAgtJckfnwnRs=;
        b=q+rfgQKdW/cvxI2HATABVuMTIPPRxS/1bSyS76wxTh0yqKXk6PsntDHqi/uZCeTaz2
         5gHVwzMuOOJTPR/dpe2AfflSAY313gR1DO6NDw2c62u2BHqjYpGuEdEyfvtBkG5wVvAt
         IvUpFI+sLAhf4J+4M1ou8r9LcnDNekcxEghG5ZG1KKfGJNE0W3xeLZlWBoDKUqiYWw2f
         qFAPPJtZ1p7wN97if3pg0KCupVRH/KSA9zxxXrc2/5sBCFb8d463x/gOG3P1j0bkq/Am
         v2A8gNxmscKL726GY/y9iui0rPcR8s3rgQqnr0JvdEzmIWpfBwG9NYeYq5g3/YUc/zFY
         Yliw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783082422; x=1783687222; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ps1j8JvLl37VqJidjWVuvD2mZtAb5cn1pGCGDWuLwyc=;
        b=e9E/tdgm/ZSL6R0zIMBOfT8Dv+Ne4dJT0Jx1YmMfh6k9iGN4PB48fVYQMYg6LXZtX6
         KZwX2CvgQXo5ouXnMgptGi76qrGHv+zi0th3FzVET+cC5eALcyz3nH0+BzFbvXCwIEeb
         evVhobS0u3ySJudLRTL7J528q2RX/zGuITA2n2zikcjnyWkelMIAeEsUemnbj+ifvVjq
         fzwH0JVcus2JE48CVYAX1vC4EbFwjK3QmOdQrshILcgIkDjRCYqtWF5ZGaehx5ltPzRu
         s0HG71PhjeMFQxtrjFghH+TOshDrWLLcJeJXb354fhReprEpnq4VVLxHU9R2PA96EnTp
         bPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783082422; x=1783687222;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ps1j8JvLl37VqJidjWVuvD2mZtAb5cn1pGCGDWuLwyc=;
        b=oZJ50tNeEjeVk39nnRi23hDGG/++4yypiSSoDKbIjlflFgzvLJFZx0XI6VJLyY/uQG
         j0HXsk449KsgoWwg5bWFxOFeXZZaYjRfT2X9VbXoYmmjHQQldxfZj1lHFIosT69pb5h9
         p2cBZeBsdNdIECSogV/edU9X1RYNwkQ7FndSIlKRfNyj3XKp+AA03zdRCuxrtD8h6NkI
         abnylg0yhVodAYhuTNDgUWos+uMBRwC9w6kj5FdakKFQs54EdQILIH3jlBggeP4Gvrtz
         GMnXlEZSiV1K5fXitTOFqFDAhlR57qhA5aDXTV4zXI7wev5qZ4oy8lcPku4V6uVslAqj
         k5tQ==
X-Gm-Message-State: AOJu0YxMPyCW8ef4lScEVghsc1YxDMrVqlNf8l/gPKxBDgs1fAw+EiJI
	pz3W+p2z9jhPlk7a8cQn4sOLOpOjFU5qvRkUFGB+omAtaUeTA7dJU87Gjuf21BF+e/KcseljB16
	3Mdfrntd01GR9qKP0vjcDHEggQ7x8EIs=
X-Gm-Gg: AfdE7cmjWA3BO2p7oJYJEA41zpUYO7m9ONlOzigrHIWTwt141Dr6OcHnf97L2JsimTP
	uCxaPBJHs11iZNmqtgD6gldhojOXJhBqWbE2V6bV7Z20UBqMK/xxxvIMUex6omeC+46cnW/kXKw
	EQshpIe4fA/05+oPQ+Lidc10BKgQpq3MclYzlyMq6zj3kzaHks+y0J2Bnms2hMMwJMridhNQwIQ
	ZjVe+4V58hUerbc2yOxd2ITCeyCNTYdlKWoDZE+z6Yq75wX6h9+eHxV49uSYZMKjQf51dy42ypN
	ANIpWYWvRhiDTiWLMY31wn1beXVJMg==
X-Received: by 2002:a05:6214:cc3:b0:8ef:ab62:217f with SMTP id
 6a1803df08f44-8f4244e45d6mr146053246d6.37.1783082422164; Fri, 03 Jul 2026
 05:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260703110612.294043-1-sivakumar.bs@gmail.com> <ced86d752a6d62c374f8d2db03adc1787b4c79fa.camel@linuxfoundation.org>
In-Reply-To: <ced86d752a6d62c374f8d2db03adc1787b4c79fa.camel@linuxfoundation.org>
From: Siva Kumar Balasubramanian <sivakumar.bs@gmail.com>
Date: Fri, 3 Jul 2026 18:09:53 +0530
X-Gm-Features: AVVi8CcwOv-ynt-Vqrbs0LfxrAOkdR7SI50scJ8OwsLPmqL9tbmXLUcoX78gWwU
Message-ID: <CACFV95Jd68gLfcBosTQ+wMbZE44fJhT=9j7b197BV8bpkgJShw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] fetch2: give every FetchData a default unpack_tracer
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, randy.macleod@windriver.com, 
	Oliver Feilner <oliver.feilner@yaskawa.eu>
Content-Type: multipart/alternative; boundary="00000000000060df7a0655b43a71"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Jul 2026 12:40:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19818

--00000000000060df7a0655b43a71
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Richard, you're right, this is already fixed in master by
f0c9cf8d ("fetch2: make unpack_tracer available when fetching mirror
URLs"). My checkout was behind and I missed it. Please drop this patch

On Fri, Jul 3, 2026 at 6:00=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2026-07-03 at 16:36 +0530, Siva Balasubramanian via
> lists.openembedded.org wrote:
> > Fetch() sets an unpack_tracer attribute on the FetchData objects it
> > manages, but the per-mirror FetchData objects created in
> > build_mirroruris() are constructed directly and never get one. When a
> > mirror is used for a git recipe that needs Git LFS, git.py's download()
> > performs a checkout (via Git.unpack()) on the mirror's FetchData to
> > materialise the LFS objects, and that unpack path dereferences
> > ud.unpack_tracer, failing with:
> >
> >     AttributeError: 'FetchData' object has no attribute 'unpack_tracer'
> >
> > so PREMIRRORS/MIRRORS fetching is broken for git-lfs sources.
> >
> > Fix this at the source by initialising unpack_tracer to a
> > DummyUnpackTracer in FetchData.__init__(), so the attribute always
> > exists. Fetch() still overrides it with the real (possibly
> > user-configured via BB_UNPACK_TRACER_CLASS) tracer for the URLs it
> > manages; the mirror FetchData objects only perform an internal,
> > throwaway checkout that should not be traced anyway.
> >
> > Add a MirrorUriTest regression test asserting the mirror FetchData
> > objects carry an unpack_tracer.
> >
> > Reported-by: Oliver Feilner <oliver.feilner@yaskawa.eu>
> >
> > [YOCTO #15948]
> >
> > Signed-off-by: Siva Balasubramanian <sivakumar.bs@gmail.com>
>
> Wasn't this already fixed by:
>
>
> https://git.openembedded.org/bitbake/commit/?id=3Df0c9cf8d3885c5b1c2ba448=
f064421dae476fcd0
>
> ?
>
> We don't want to add a dummy one everywhere, only add one when needed
> as the patch avove does...
>
> Cheers,
>
> Richard
>


--=20

Sivakumar B

--00000000000060df7a0655b43a71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,helvetica,sans-serif">Thanks Richard, you&#39;re right, this=
 is already fixed in master by<br>f0c9cf8d (&quot;fetch2: make unpack_trace=
r available when fetching mirror</div><div class=3D"gmail_default" style=3D=
"font-family:arial,helvetica,sans-serif">URLs&quot;). My checkout was behin=
d and I missed it. Please drop this patch</div></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri=
, Jul 3, 2026 at 6:00=E2=80=AFPM Richard Purdie &lt;<a href=3D"mailto:richa=
rd.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 20=
26-07-03 at 16:36 +0530, Siva Balasubramanian via <a href=3D"http://lists.o=
penembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.or=
g</a> wrote:<br>
&gt; Fetch() sets an unpack_tracer attribute on the FetchData objects it<br=
>
&gt; manages, but the per-mirror FetchData objects created in<br>
&gt; build_mirroruris() are constructed directly and never get one. When a<=
br>
&gt; mirror is used for a git recipe that needs Git LFS, git.py&#39;s downl=
oad()<br>
&gt; performs a checkout (via Git.unpack()) on the mirror&#39;s FetchData t=
o<br>
&gt; materialise the LFS objects, and that unpack path dereferences<br>
&gt; ud.unpack_tracer, failing with:<br>
&gt; <br>
&gt; =C2=A0=C2=A0=C2=A0 AttributeError: &#39;FetchData&#39; object has no a=
ttribute &#39;unpack_tracer&#39;<br>
&gt; <br>
&gt; so PREMIRRORS/MIRRORS fetching is broken for git-lfs sources.<br>
&gt; <br>
&gt; Fix this at the source by initialising unpack_tracer to a<br>
&gt; DummyUnpackTracer in FetchData.__init__(), so the attribute always<br>
&gt; exists. Fetch() still overrides it with the real (possibly<br>
&gt; user-configured via BB_UNPACK_TRACER_CLASS) tracer for the URLs it<br>
&gt; manages; the mirror FetchData objects only perform an internal,<br>
&gt; throwaway checkout that should not be traced anyway.<br>
&gt; <br>
&gt; Add a MirrorUriTest regression test asserting the mirror FetchData<br>
&gt; objects carry an unpack_tracer.<br>
&gt; <br>
&gt; Reported-by: Oliver Feilner &lt;<a href=3D"mailto:oliver.feilner@yaska=
wa.eu" target=3D"_blank">oliver.feilner@yaskawa.eu</a>&gt;<br>
&gt; <br>
&gt; [YOCTO #15948]<br>
&gt; <br>
&gt; Signed-off-by: Siva Balasubramanian &lt;<a href=3D"mailto:sivakumar.bs=
@gmail.com" target=3D"_blank">sivakumar.bs@gmail.com</a>&gt;<br>
<br>
Wasn&#39;t this already fixed by:<br>
<br>
<a href=3D"https://git.openembedded.org/bitbake/commit/?id=3Df0c9cf8d3885c5=
b1c2ba448f064421dae476fcd0" rel=3D"noreferrer" target=3D"_blank">https://gi=
t.openembedded.org/bitbake/commit/?id=3Df0c9cf8d3885c5b1c2ba448f064421dae47=
6fcd0</a><br>
<br>
?<br>
<br>
We don&#39;t want to add a dummy one everywhere, only add one when needed<b=
r>
as the patch avove does...<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><br></div>Sivakumar B=
<span></span><span></span></div></div></div></div></div>

--00000000000060df7a0655b43a71--

