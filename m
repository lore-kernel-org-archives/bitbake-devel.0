Return-Path: <rob.woolleywr@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176EE10F2868
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 18:59:10 +0000 (UTC)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.80498.1774637949596990654
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Mar 2026 11:59:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HW+EluB+;
 spf=pass (domain: gmail.com, ip: 74.125.224.51, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ea73e7b60so2642191d50.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Mar 2026 11:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774637949; cv=none;
        d=google.com; s=arc-20240605;
        b=QpyCnAeAplPKIo6r5ahg7nff/Xk9kr1dHmQL3kj6C8g+hWTbyVf4tvO6pgGLqiUoOl
         KlEAgzaDefaRo13NH4zmV1ct+BKLtsLKFAJUsOpKq89y6Z+Rp63VleIeHuAoBGGJjaAn
         FqS66GChxz3AGWoAR2Gc7KCSvkKot1yIe8GaCCvI0BXEahnA/2ZNVQW08MLifo2s0Ffp
         Ns5jYSxmVdRcbcfNYdQcpERFw9k8AQyGA/Ef4+Cru/IMisEijlqXSRIXrTA0yM9j+63W
         /lpgcVDESv085i8DKCXmJ5OORbQZo6K7LRmsyQBJFGNXlDLTxjhFv3c2a94Tf/e/zLdP
         KiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/aD9bqmXkkftHvlO2R2oM/qHtjhVoeDU4T/lN7y8hSU=;
        fh=DV/4p23SvkkXaRXl1ad+QZ1WYTTc/1dEGY5/9n5HVJg=;
        b=jSvYAKVso+kC3vLfmV0GjFCGzsLrfYgAbkAOorDyiK69W+HSYKdLylNpeHOV3hvKX5
         /a7vKJ3dqCUkE0VCtXlkyCrdhw92f2piVdFpdg+1cuEdiEJEEzuc8UM1b4tfBj0RsIZ+
         +uoM2SuCXFrbO87pbcx8LaEZbgc6D46tiGhZ/baiWfJnIT8VzKti4NlLjIC2xOONSNX5
         LiXgVCQCIAhLoVgePuDzIf8yQuVZvkJ8tSTnaI7WOs+0jyO8gJWiLp0QaOsTj1WuuZ7C
         jvEEWGJblX/D+hfZBsgJr3A1r7TMHw30tXTMJlkzjhMmcmbdgfZTu0m0UmoCcRz54JGn
         ggEg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774637949; x=1775242749; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/aD9bqmXkkftHvlO2R2oM/qHtjhVoeDU4T/lN7y8hSU=;
        b=HW+EluB+z06mTO9BW5lHL8Clys/tz7eDd51/4a5uFHP0jv09K1rNCjaBDaueOUMeNI
         E5I3iv1YNAdwEXduidSxNEfWCviR15w9F87EVOzsvLhn/iZvd3Vy4+m424NkU2tnP4Io
         uhAbqIJ9fjERbz3sdZ4l2JHT5pj+wvHRXDHMgJVtxa1q3R7SktRqtRUe8gkz83a0DDXR
         2oYEuShJA4nCWXLqrGr8D78Mim+RRwL5vi1E97/xYwQuUAUDeH9XRSvR2XeyDJIezwCD
         4Bk5gy09YGHJ2nhOPIFf9wh2QiULM1mdKkSHoyrsSG6oorWlQhT7E97r26XpDFmwWpAh
         +C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774637949; x=1775242749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aD9bqmXkkftHvlO2R2oM/qHtjhVoeDU4T/lN7y8hSU=;
        b=PXGlbX6iY4cvkad5FK5Dl9FrDSQBGxibld0JvPwP0fUeAS4RAJIf35MIBAizVGi03h
         RX037IXNRhShGrERiNi4G47rAhGrQ7HrdCx1RiDyOZCL7p7YuPvBLYliHJDvF8DXSX0I
         qkruSLCJ1Km9LTVLvsQM87ksXxgoh1bMeVPkpcdMhPT5/Xmo3Ey4cFxUkys11aLHYEHK
         +JoBbDz9Eg7K/2RcSuJUlN2uJxv3aXgTgdCKOPNoltrJJnkELNFY1EkblKfnx6msP8rM
         DhG3l7TVh0JJpGjUwFnx4oMkqs8XXK+TsGvmbMbn71e1BavCEunuL4Vcui0KfcI/eWcB
         pqmQ==
X-Gm-Message-State: AOJu0YyFVGnhCn3JeSlFFzsHbs8/wgVe3CJcEALGdv9JGDecbfVl8Y03
	mg8nQ3u7+gQHZ0GZ396uQNNzSApECv0dgkq3AUmz8JCY9snJ45sqV2MNZIk+sagKYHevI7cruAY
	4fL+ykm5RW/fExggqrMkoGBSK7yqFeZY=
X-Gm-Gg: ATEYQzxHenK2Pu4wltv6RvURlmjxTuimlbhguRToUFf7R2ZZP0r4MxPRmdUuXaD1i6H
	iJvYv66+FoKackq63Zf7+StCsTFyvuiN2xtL2bNxil1Et5jWscrRAM6mt24gVRNuY+4donk2NXM
	uNVGWxbp68GpPVDW5HeZWWTXvMC3kTSrnuQ2z8u6wCbwfYqMDpO1RFigPn+TLMqNXN6OvNIoYwi
	6v0Ayt+AdgNNpwQ4rtaH+SluxK4DOWRdXZh7/yAHV0yoQjtr+qde20QDKImva3Q9nElyEWMueaS
	CDaB5NKfcYSahn1hFtFMuUEznmo/8xA81wVrLTE=
X-Received: by 2002:a05:690e:1507:b0:64e:e9b2:bdea with SMTP id
 956f58d0204a3-64ff7411e78mr3268851d50.53.1774637948491; Fri, 27 Mar 2026
 11:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260326173951.519326-1-rob.woolley@windriver.com> <aa7e9473a5d2712f16b0edb366af9b172779397c.camel@linuxfoundation.org>
In-Reply-To: <aa7e9473a5d2712f16b0edb366af9b172779397c.camel@linuxfoundation.org>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Fri, 27 Mar 2026 14:58:56 -0400
X-Gm-Features: AQROBzD7RNN5ob9mtrk-cMIKtE9nRouVB2Y1DbzLv3h0q9qan5VBO74PfhsqyWg
Message-ID: <CAGAhMBxGA=cjmQ1566rbB+TP3Yig6Q7Hom65WkVBJ=jTtH++3A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Common BitBake Versioning
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org, alex.kanavin@gmail.com
Content-Type: multipart/alternative; boundary="000000000000865e70064e061841"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Mar 2026 18:59:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19262

--000000000000865e70064e061841
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

No problem.  I had reservations about the version.py approach, so I'm glad
you provided that feedback.

I have some ideas, I'll take another run at it.

Regards,
Rob

On Fri, Mar 27, 2026 at 1:03=E2=80=AFPM Richard Purdie via lists.openembedd=
ed.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:

> Hi Rob,
>
> On Thu, 2026-03-26 at 10:39 -0700, Rob Woolley wrote:
> > We discussed how to version bitbake and bitbake-setup on a Weekly Tech
> > call at the end of January.
> >
> > The initial proposal was to use the git tags in the bitbake git
> repository
> > to dynamically determine the package version. There were complications =
in
> > this approach due to conflicting conventions between how the Yocto
> Project
> > maintains git tags and the format accepted by PyPI.
> >
> > A simpler alternative of using the version strings directly was propose=
d.
> > The request from Richard was to converge the 2 version strings for
> bitbake
> > and bitbake-setup. He asked for it to be sent as a separate series from
> > the PyPI changes. He also asked for some sort of version checking in
> > case the scripts find the wrong version of the bb module.
>
> Sorry, I think there has been a misunderstanding here :(. I asked that
> we reconcile the version strings from bitbake and lib/bb/__init__.py
>
> I'm worried that we might end up with a bin/bitbake being run but a
> "lib/bb" coming from somewhere else. The current versions are compared
> to check that but if we install bitbake-setup to somewhere, I'm not
> sure how we'd continue to ensure this.
>
> Putting a "version.py" into something we inject into PATH does worry me
> a bit as it is a very generic name and it doesn't really avoid the
> issue above I'm worried about.
>
> Cheers,
>
> Richard
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19261):
> https://lists.openembedded.org/g/bitbake-devel/message/19261
> Mute This Topic: https://lists.openembedded.org/mt/118522774/556952
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> rob.woolleywr@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000865e70064e061841
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<br><br>No problem.=C2=A0 I had reservations ab=
out the version.py approach, so I&#39;m glad you provided that feedback.<br=
><br><div>I have some ideas, I&#39;ll take another run at it.<br><br>Regard=
s,<br>Rob</div></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 27, 2026 at 1:03=E2=80=AFP=
M Richard Purdie via <a href=3D"http://lists.openembedded.org">lists.openem=
bedded.org</a> &lt;richard.purdie=3D<a href=3D"mailto:linuxfoundation.org@l=
ists.openembedded.org">linuxfoundation.org@lists.openembedded.org</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Rob,<br=
>
<br>
On Thu, 2026-03-26 at 10:39 -0700, Rob Woolley wrote:<br>
&gt; We discussed how to version bitbake and bitbake-setup on a Weekly Tech=
<br>
&gt; call at the end of January.<br>
&gt; <br>
&gt; The initial proposal was to use the git tags in the bitbake git reposi=
tory<br>
&gt; to dynamically determine the package version. There were complications=
 in<br>
&gt; this approach due to conflicting conventions between how the Yocto Pro=
ject<br>
&gt; maintains git tags and the format accepted by PyPI.<br>
&gt; <br>
&gt; A simpler alternative of using the version strings directly was propos=
ed.<br>
&gt; The request from Richard was to converge the 2 version strings for bit=
bake<br>
&gt; and bitbake-setup. He asked for it to be sent as a separate series fro=
m<br>
&gt; the PyPI changes. He also asked for some sort of version checking in<b=
r>
&gt; case the scripts find the wrong version of the bb module.<br>
<br>
Sorry, I think there has been a misunderstanding here :(. I asked that<br>
we reconcile the version strings from bitbake and lib/bb/__init__.py<br>
<br>
I&#39;m worried that we might end up with a bin/bitbake being run but a<br>
&quot;lib/bb&quot; coming from somewhere else. The current versions are com=
pared<br>
to check that but if we install bitbake-setup to somewhere, I&#39;m not<br>
sure how we&#39;d continue to ensure this.<br>
<br>
Putting a &quot;version.py&quot; into something we inject into PATH does wo=
rry me<br>
a bit as it is a very generic name and it doesn&#39;t really avoid the<br>
issue above I&#39;m worried about.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#19261): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/19261" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/19261</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/118522774/556=
952" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/118522774/556952</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:rob.woolleywr@gmail.com" target=3D=
"_blank">rob.woolleywr@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000865e70064e061841--

