Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D6D3EE92
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 16:52:51 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41830.1769100762786874700
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 08:52:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YNb2fHK4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee4539adfso12648375e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 08:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1769100761; x=1769705561; darn=lists.openembedded.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FXazJqkHlnXeFT66i56/rsq3qXNqDSnKD9Dnwk+yhMU=;
        b=YNb2fHK4Ea7mKGK9echGR2gxLWTi/CBM/q+8qtKrji5y7lDiE3eLed1H2Yx4v5Y9tA
         D7ADPsbhLf08y3iTRwR7r1JtgTYO/FLBhBg4OO2RY1Y0pq8B/q6XpABNIhspzoHBowIS
         Y9vq05k1WCB5BVWttweU2YICs1aslwoYAyBZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100761; x=1769705561;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FXazJqkHlnXeFT66i56/rsq3qXNqDSnKD9Dnwk+yhMU=;
        b=UGgJIJjYTz3sd2mXFo2d11uFlfKB3m0BcjPV6jgoKG0dZi8XuQlRsx14D8j4PC7e4d
         eIese5tWbNowbQ6q7kGK3QeLtNfjXIZOF45eGj8abuDSy90UaB1y3pgF26TeyYewZWCc
         JsxEQRZyaBm/ypRGONB9ZnPvpBAJBwtomjE0Aw62aIfh0WLW8e055KcZuGcjP1zqZJkd
         jhAkWDQxqFVM5xiFVeb57T19N5LnDMLoTT1XYvxjjCVej35QQCa5bTRbcia2y2uFlcTa
         RuSifIBVEsWWrQCtEV+a0X2knqCi7rB+Vh2AxQqwkGLThGStz0psAyqcWiehUwSkLIOo
         fk+Q==
X-Gm-Message-State: AOJu0Yy90blEq0PKUo/IE/q58y7Bj6Vh7teL3m/XhQeKPeE6vuxDPQW+
	pb0rrW/f/9DYY6R0zJPvZ8JP/xRjepHGSKFMlw4SwNNTdKHZdS97jTJeUI4NSeT4TqA=
X-Gm-Gg: AZuq6aKgM/HyNUf56h4NZagukJBb4sXzwHPe3UiDxyr67UkheJSNgL6gQedK/l3C+I7
	SuVrFjd3RFhDdQFxGq3IpjOXpE/AxOuZuAyER1oCL5cyG8WBMJnycqyq7BM6ZeIMRKsN5mXrQ+j
	vnIEIzMB9c9Qnl3bPC57LQ6Yt2ogWtksz8/l4SKCR7slpDB7bRxGBfRTJWXNaSOEIqNQUbSGAwy
	1CRys4mnQgHVvCAKt48U4QKYL8cEpsuTCQQVGL/FDW9Kk3xIiyJuQEYtuTnU/cwwCezj2fmeMLF
	7KLBPSeRPXwQ4byiNeeiQhh0LBVvc6IsfKjhhEnACoPZ0jLtHkNwMGJhLxkE18Wy7LtmNWOm729
	vgDDCbMXyVxXez2uiuQFfS7pqVUFDTGZ/LFCsFhqStYE4Ns8x4FNicP7AW7aEqDwgTx5GU0NqnU
	W6NPdKUpBvUzTX8SfZjYSwCH1QAgpKoLV0QmPflK2IFQGrY1SSdMvXMcX86wptx+fONZa8GRAy/
	yb7mX3MsvY92w==
X-Received: by 2002:a05:600c:1c13:b0:480:4a90:1afe with SMTP id 5b1f17b1804b1-4804c9d116emr3813135e9.34.1769100761133;
        Thu, 22 Jan 2026 08:52:41 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:8ce7:5a61:b9e8:a245? ([2001:8b0:aba:5f3c:8ce7:5a61:b9e8:a245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm120882535e9.2.2026.01.22.08.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:52:40 -0800 (PST)
Message-ID: <95d5cdea6bc5458c5a72842e81a62c14e35a0563.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/npm/npmsw: Disable npm and
 npmsw fetchers due to security concerns
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: bitbake-devel@lists.openembedded.org, rybczynska@gmail.com
Date: Thu, 22 Jan 2026 16:52:39 +0000
In-Reply-To: <3f3a900e-f2fb-4596-9274-d2129799e498@weidmueller.com>
References: <20260122080922.1695912-1-richard.purdie@linuxfoundation.org>
	 <CAApg2=R1ek+YS44f++taB-N2WpJkZ+3vJWD_dukZ+=WVhzuqnw@mail.gmail.com>
	 <3f3a900e-f2fb-4596-9274-d2129799e498@weidmueller.com>
Content-Type: multipart/alternative; boundary="=-3sArPqAJovR6LfwnnZdJ"
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 16:52:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18852

--=-3sArPqAJovR6LfwnnZdJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-01-22 at 15:53 +0100, Stefan Herbrechtsmeier wrote:
> =20
> Am 22.01.2026 um 14:01 schrieb Marta Rybczynska via
> lists.openembedded.org:
> > On Thu, Jan 22, 2026 at 9:09=E2=80=AFAM Richard Purdie via
> > lists.openembedded.org
> > <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
> > =20
> > > diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
> > > index 2f9599ee9e2..322c7b331e5 100644
> > > --- a/lib/bb/fetch2/npmsw.py
> > > +++ b/lib/bb/fetch2/npmsw.py
> > > @@ -64,6 +64,10 @@ class NpmShrinkWrap(FetchMethod):
> > > =C2=A0 =C2=A0 =C2=A0def supports(self, ud, d):
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"""Check if a given url can be fetc=
hed with npmsw"""
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ud.type in ["npmsw"]
> > >=20
> > =20
> > =20
> > =20
> =20
> You forgot to remove or comment out this line.

Thanks, I will send a new version and retest.

Cheers,

Richard

--=-3sArPqAJovR6LfwnnZdJ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head>

  <style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head>
  <body><div>On Thu, 2026-01-22 at 15:53 +0100, Stefan Herbrechtsmeier wrot=
e:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2=
px #729fcf solid;padding-left:1ex"><div> </div><p>Am 22.01.2026 um 14:01 sc=
hrieb Marta Rybczynska via lists.openembedded.org:</p><blockquote type=3D"c=
ite" cite=3D"mid:CAApg2=3DR1ek+YS44f++taB-N2WpJkZ+3vJWD_dukZ+=3DWVhzuqnw@ma=
il.gmail.com" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;pad=
ding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jan 22, 2026 at 9:=
09=E2=80=AFAM Richard Purdie via <a href=3D"http://lists.openembedded.org" =
moz-do-not-send=3D"true">lists.openembedded.org</a> &lt;richard.purdie=3D<a=
 href=3D"mailto:linuxfoundation.org@lists.openembedded.org" moz-do-not-send=
=3D"true" class=3D"moz-txt-link-freetext">linuxfoundation.org@lists.openemb=
edded.org</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_contain=
er"> <br><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:=
2px #729fcf solid;padding-left:1ex"><div>diff --git a/lib/bb/fetch2/npmsw.p=
y b/lib/bb/fetch2/npmsw.py<br> index 2f9599ee9e2..322c7b331e5 100644<br> --=
- a/lib/bb/fetch2/npmsw.py<br> +++ b/lib/bb/fetch2/npmsw.py<br> @@ -64,6 +6=
4,10 @@ class NpmShrinkWrap(FetchMethod):<br> &nbsp; &nbsp; &nbsp;def suppo=
rts(self, ud, d):<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"""Check if a given=
 url can be fetched with npmsw"""<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret=
urn ud.type in ["npmsw"]<br> </div><br></blockquote> </div> </div><div> </d=
iv></blockquote><div> </div><p>You forgot to remove or comment out this lin=
e.<br></p></blockquote><div><br></div><div>Thanks, I will send a new versio=
n and retest.</div><div><br></div><div>Cheers,</div><div><br></div><div>Ric=
hard</div><div><br></div><div><span></span></div></body></html>

--=-3sArPqAJovR6LfwnnZdJ--

