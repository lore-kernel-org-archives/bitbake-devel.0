Return-Path: <zhangqiang.zq307@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2685C88E50
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 11:44:04 +0000 (UTC)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18071.1789386242467403371
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 04:44:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=hKpKBqGt;
 spf=pass (domain: gmail.com, ip: 74.125.228.12, mailfrom: zhangqiang.zq307@gmail.com)
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4b29fa803so1422578a12.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 04:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789386242; cv=none;
        d=google.com; s=arc-20260327;
        b=YQuKM+Z7POdPgqm3NFL3Fn3IhuaA57VJM+tzHSsFkPazTV9WVPVQcrzdaLN5z9NJJp
         vPbg84IiDqRznVv0fEnOWRY4Usg6dD5g4da6XaLh0yhOcKL2r5VPzVXBIpdfsACxT+zF
         sfk/OsBegjxp9jI+9jHTtVvvbtExIYr6bO9jZ4E1eBzy2jphmnHtK/+iOjK+xNOiXKF2
         CSU3p97BL55lJmZeQd62OsIWCRmjxWrOelEZOLso9UIA9UD7SGnN/4mz6XqwJUEfh5ym
         pIyNJjG1IwAoIFOMuzywTkjXANAgkFovQhQgi/U5CW8joTQNr183gR6TT/gO1LKSPt6r
         4KFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dzIQZwEz1FbNNrMB3hVJyUGyNwn+CZZvceAYZ3H8d/8=;
        fh=SK27jGDeuPIF+dJJVhVhn4KziPt8/7C8VJxx6bxT9oA=;
        b=MRL5vLMBjGlzFQSG1BLvvEJRirWLTHTQD3a3u0aDVTO+ALddv7czro8RAyoDwU4N/A
         o2vVgC7ypRGN2kwtTNFlnfvgYV9bLGOJ2i3jVcLH3gZYEErbqWlDIlwLqXr0xIjzacqE
         QVwnl84qbOS1yFKlbXE7S81FjcFXKrd0gj0s0Da35DavwOGkAKVCwTV+Q7yKCP37qngj
         lLBybS8dbdi2G2grMxkZ9qa7vyTTkX2f2A7mp4ufh3F2x70FTq4MCpJUOJ5oaC+EgII3
         nnj/H4HT2n2KiIeRJEwNeiAwdKx0m4gi4X7RI42jsIomY3U1zwK3dIrJAlMoAGKO7pFr
         yteg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789386242; x=1789991042; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzIQZwEz1FbNNrMB3hVJyUGyNwn+CZZvceAYZ3H8d/8=;
        b=hKpKBqGtYtjf0S08NSkQLcOKGdCa/j7ZK4MfhmTcOOZ2Ld/Z+tTM60i1+SEWAYPE1d
         eWpJ0FUpOmLKXSQUt5QZfjMSZjN1so6PQflVmWsGZ62o+6xzd6xdwIiBbQZnQfU1GZ3S
         3q6O8X9emIS9fTA2XLFVzN5pyhaVc686M26Jh0tWsXNOPpC3VnENDMO1zp7ifwCcjBij
         ppPRnjxF+21eM2gcG5AvRd8iOnRB28XkQRG12jt68MBXBjxWbK6zuVm1t/naPNCW8rVd
         igYQptb+i/y68grgXvlQSvp65o9IbmggG5SlGlWcdRaHyzOCEUIPLW7hmVeBsRL8AvEh
         wwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789386242; x=1789991042;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dzIQZwEz1FbNNrMB3hVJyUGyNwn+CZZvceAYZ3H8d/8=;
        b=cKMSvInQgdHZuue5fFfKbinEPZHqOeY4Az0tO3onSYEShjDGuwcumhD9Wp6XATmEUH
         q0IYH14Ex92jX554Q2uNUGz4ybAV8H/trW5hjcAZ6J9f017mew2MLynzv9aL+hznGRBi
         a+iEtxpIKck5wzqYmOlNg/xnujFgHbE6Xxd1uIgK1ESyMR+qo+SbLBATgoIYAxBCg94D
         MFFkOneGtA5IJW6twtT5gMX4Ppv7hCqedyybcwVPonvmET2MylEhGXyNBqs36jKSoOTQ
         bsMcqUYD4Twh1MyUT92oQ077jJf5tEqM7vSADJ/nUKLdqzFgEVHH0CHhT/DSrlwcqQwi
         Nd7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxtr/eZrBsD/klx4kVAYU7q8kPTFsQJfQxeYFgd1UCdMI4e55SsXWYC98MDSfJipoScX4sFHICMvIzEQN3n@lists.openembedded.org
X-Gm-Message-State: AFuF++mlYua7gRnVH/bkg6RT0gTOFVw5xFj5XtMivP3yLtNpeGZ5t2Sm
	GUrwmnq+dqkv7SEcswZXeQaKY/Qesh3TvN4pZkauPJr5RSsfO1eFjrnANx+z+7uLKmoMnuuefe6
	NJD/Mi2IBX0cT0mlrgg/i8P0RLIusGRc=
X-Gm-Gg: AYBFou3+m2UMXEK9OSnzcpSdc97p8pegEaRMC9hkOr6M6ikGRbwdB9JHHNRj01CruOM
	0yiVUwuSqIxLwcp9ilqJZwc2t26aiGomBfFJEVo6sMp78Z3Vs47SVoV24MaFOeGluCMq3NpSCHB
	MmSRXQFJqzT4pEpGN9sQt9HxriDkH+z3C9DINXnMh8LpydMJKDD4ZlBqY0uX+8EyPsyM9tssGNC
	Z2mzoi+/L2Pg1/kDcadnUXOBs6ETl4oXC5g7mhxIVFoAV+lDfjibZtuMyzwBo8e1sniNPvzRsi9
	t2bmqMCmWG3aCSWPAlnvLF3cszklH57E35XP9r44OAL13nlUMv/oEqqy
X-Received: by 2002:a05:6a21:4612:b0:3d3:aec2:4dce with SMTP id
 adf61e73a8af0-3db4063b182mr4070156637.26.1789386241532; Mon, 14 Sep 2026
 04:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260914051148.1445323-1-zhangqiang.zq307@gmail.com>
 <1166440fd2b4a63232ad5959369f7602a43de82f.camel@linuxfoundation.org>
 <CAFb4brP7OpopstkUKCCGyFPEaGwjab+AR+FFPh0pvGjK+Uhsxw@mail.gmail.com> <CANNYZj-2Wxevg8NM5ODrztE6rh3NrvjAwFR=BPcBWFffM0zsUQ@mail.gmail.com>
In-Reply-To: <CANNYZj-2Wxevg8NM5ODrztE6rh3NrvjAwFR=BPcBWFffM0zsUQ@mail.gmail.com>
From: =?UTF-8?B?5byg5by6?= <zhangqiang.zq307@gmail.com>
Date: Mon, 14 Sep 2026 19:43:50 +0800
X-Gm-Features: AcwNN1UsfJct_2GkAaOQAesy2Isma8IQiaRxzFksUR4zd45MHmwO07Nhe8UKhZY
Message-ID: <CAFb4brN8fd624Qdfs_A6mcPM9M8SWxEs8f1FX4hdDHY6B5Zhag@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch: Add log_errors parameter to Fetch.download()
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000004ae677065b6ff329"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 11:44:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20196

--0000000000004ae677065b6ff329
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood, thanks both. I'll look into the mirror/network side and handle
the exit-code concern on our infrastructure instead.

Alexander Kanavin <alex.kanavin@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=88=
14=E6=97=A5=E5=91=A8=E4=B8=80 18:20=E5=86=99=E9=81=93=EF=BC=9A

> On Mon, 14 Sept 2026 at 12:04, =E5=BC=A0=E5=BC=BA via lists.openembedded.=
org
> <zhangqiang.zq307=3Dgmail.com@lists.openembedded.org> wrote:
> > Both keep real mirror problems loud while not failing a build over a
> > network blip. Happy to respin the patch in whichever direction you
> > prefer.
>
> 'Network blips' are just as real problems as missing cache objects.
> They're not 'problems that can be recovered from', they're
> infrastructure errors that need fixing and should be reported as such,
> regardless of whether the build process can find a way to produce the
> needed artefacts in the end.
>
> Alex
>

--0000000000004ae677065b6ff329
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span class=3D"gmail-universal-card-text">Understood,=
 thanks both. I&#39;ll look into the mirror/network side and handle the exi=
t-code concern on our infrastructure instead.</span></div></div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com">alex.k=
anavin@gmail.com</a>&gt; =E4=BA=8E2026=E5=B9=B49=E6=9C=8814=E6=97=A5=E5=91=
=A8=E4=B8=80 18:20=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Mon, 14 Sept 2026 at 12:04, =E5=BC=A0=E5=
=BC=BA via <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" tar=
get=3D"_blank">lists.openembedded.org</a><br>
&lt;zhangqiang.zq307=3D<a href=3D"mailto:gmail.com@lists.openembedded.org" =
target=3D"_blank">gmail.com@lists.openembedded.org</a>&gt; wrote:<br>
&gt; Both keep real mirror problems loud while not failing a build over a<b=
r>
&gt; network blip. Happy to respin the patch in whichever direction you<br>
&gt; prefer.<br>
<br>
&#39;Network blips&#39; are just as real problems as missing cache objects.=
<br>
They&#39;re not &#39;problems that can be recovered from&#39;, they&#39;re<=
br>
infrastructure errors that need fixing and should be reported as such,<br>
regardless of whether the build process can find a way to produce the<br>
needed artefacts in the end.<br>
<br>
Alex<br>
</blockquote></div>

--0000000000004ae677065b6ff329--

