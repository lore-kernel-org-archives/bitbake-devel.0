Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1153DCCF9F8
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 17:13:29 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.web11.3375.1761844401716564268
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Oct 2025 10:13:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aRFcmbbk;
 spf=pass (domain: gmail.com, ip: 209.85.128.173, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-781421f5bf5so16438117b3.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Oct 2025 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761844401; x=1762449201; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kam/zLCn4r/08RbsWqzmVgEEVeEKTbck6SCCoIQQGI4=;
        b=aRFcmbbkPz5dIX2W+CwmRPUcJPwXmSAcXzpaeaFMpdoE8uYXX8NOdwREYpTHjz5j2r
         Q3ozzd7M6Us2U84O7iwXOIbXcSsV123P1U9hyEW4rgG/kB8woG+hxNAakYZRFsDltBXl
         22bmrHcy7z8O4q3NSZiCq6AC21eSpeLqQRNlRqRYsZpi8bvQ29P+XpkBLHUB5YgxQfVd
         8oMyzFx4EuQ3XzIZbeBFRXolk9iGeT1D0zEVfikf7PEjZ4Zf9tn6Nw99gPpFbwU18Q7n
         +kfRSkiMBVdKfJdGPeOLOBNzaMo8lmy/FPLSyJwtFl8t9zLTeOUFoztObTjhHn32dTZN
         4nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761844401; x=1762449201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kam/zLCn4r/08RbsWqzmVgEEVeEKTbck6SCCoIQQGI4=;
        b=bsNdRVAzksNUsEnnTh3XieVzvDCk9qpBPtwju7U58TTmNi4eVzuX4wvezb0cD81EbE
         DbjTYGug7TkxlLUnUlLkRjoZl2B4TTnzj23gRhdwGvOyVMsmVpMWE0sMP9B/ZijiGlNR
         L3yo1EPQ37Jb0lIe7ltdVyuq5mKVW6YXM2ji34NSGTns6Dg0oCu0DOhhOtM0kiGmlzzG
         dNxB1jOdPOmb1m4eaLSaXwxNhFsmb2jrR/0DF2kCQ1Huxgnl18U+C1AzQnogxtPXPzFg
         aikcFJdEoqBOyVa8j/BvEroz7/nkUyUi+MA5m35xKPUG8d278ERsaIQHbLQ85vjCN0p+
         g20g==
X-Gm-Message-State: AOJu0YygL7T6Mn08Y/ZzL9pIWosnnGfK/0mxqzn3JzavGPcC4kMW8y5i
	WoVemIuYutQ/yZV46GyxWr46K3eY7uZlPsqncM3l+cdBcFrQmfot9hzQxU5Agw/2NP/nzuY/iWR
	lezRS0o6+b4nooXWCNfnsI4UWr8zlhVQ=
X-Gm-Gg: ASbGncvjy0kIpqrLeAUCTLFSEoZmZ+cCpNvBc9el/mU6x5m1uLzLkP2fvS5H+UitQBI
	klL3rJjI6Z/38/NeYpr0uqDiwizX335aZhjv3Z99d0H1MvUHFuuJPfbpSdkeTh0+cgt1kImZmol
	AC9nfMy41AHGqMGE/iAiZ1dzHYTybQjXHfXdc+RnpOIHG5edy1Zrk8JH0dJ3FatRw5Q1/31Bubv
	lzAt5qhsoBPD15FVzl7jawTj/UMHIGLfq6Ibo83c5qYCk/ryWm2mUf39CsPVqwux7rwo6WgdnuO
	0nyAdK0OgA==
X-Google-Smtp-Source: AGHT+IFFCIZGO8eq6vof0FGZuNgL9tazczWQd6kD1VIcBwqnMeyv+A+Nl7+q8PE4XEi4er1IedcSBViLPPuQRvs+Jnk=
X-Received: by 2002:a05:690c:968f:b0:786:266c:5bd0 with SMTP id
 00721157ae682-786484df431mr3276947b3.42.1761844400804; Thu, 30 Oct 2025
 10:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251030141904.69494-1-JPEWhacker@gmail.com> <DB5PR02MB102133B9E1450E0175B8576D4EFFBA@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB102133B9E1450E0175B8576D4EFFBA@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 30 Oct 2025 11:13:09 -0600
X-Gm-Features: AWmQ_blzHN4P-L5wzARwZ79aq9pjUU-iFuC9aOLMkL2SJbbXOizdfoSWpKenq9Q
Message-ID: <CAJdd5Ga1Bp9V0+Thk4x86o-Yab54sb_L9FT50We65nok0t+vJg@mail.gmail.com>
Subject: Re: [bitbake-devel][RFC] cookerdata: Include "originating" recipe
 data when parsing
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Oct 2025 17:13:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18228

On Thu, Oct 30, 2025 at 11:09=E2=80=AFAM Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
>
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openemb=
edded.org> On Behalf Of Joshua Watt via lists.openembedded.org
> > Sent: den 30 oktober 2025 15:19
> > To: bitbake-devel@lists.openembedded.org
> > Cc: Joshua Watt <JPEWhacker@gmail.com>
> > Subject: [bitbake-devel][RFC] cookerdata: Include "originating" recipe =
data when parsing
> >
> > Parse out PN, PV, and PR from the "originating" recipe (the .bb file
> > being parsed) and provide them at parse time. This allows .bbappends,
> > .inc, etc. files to know what recipe is currently being parsed.
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >  lib/bb/cookerdata.py | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> > index 65c153a5b..8abf5e56e 100644
> > --- a/lib/bb/cookerdata.py
> > +++ b/lib/bb/cookerdata.py
> > @@ -504,6 +504,12 @@ class CookerDataBuilder(object):
> >          bb_data.setVar("__BBMULTICONFIG", mc)
> >          bb_data.setVar("FILE_LAYERNAME", layername)
> >
> > +        pn, pv, pr =3D bb.parse.vars_from_file(bbfile, bb_data)
> > +
> > +        bb_data.setVar("ORIG_PN", pn or "defaultpkgname")
> > +        bb_data.setVar("ORIG_PV", pv or "1.0")
> > +        bb_data.setVar("ORIG_PR", pr or "r0")
> > +
> >          bbfile_loc =3D os.path.abspath(os.path.dirname(bbfile))
> >          bb.parse.cached_mtime_noerror(bbfile_loc)
> >
> > --
> > 2.51.1
>
> You want to include PE as well.

Ya. The other option would just be to do:

  bb_data.setVar("ORIG_BBFILE", bbfile)

And let users parse it out for themselves if necessary.

>
> //Peter
>

