Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97303C02194
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 10:48:41 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web10.66710.1738925316028099998
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 02:48:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=a3od3HLZ;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so14465196d6.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 02:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738925315; x=1739530115; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3/OoHMey+9FJlUTsQ8RWlSNYBy7KYz/l5XDl4doJflk=;
        b=a3od3HLZbHGoveZQCNfhS9e3TUaw1OS4zCrhmZg7aB7e+r+wTXiuPkDrc4uBrOlFet
         LOrR2da+vghniq3ZgOI3WB6frQ899rboKcKBsydLNq/yZr6tWHiuMsPTKZ6Zs45WHZZc
         6VVzdSCwnPvvQMbfxV2v4OaSLyvi7yQwwisu0usrS5C1EfCJu8p4gpYKeLC2B000gPMH
         gN6E9QQdEx+au+Q7oFrMSfhxqtOZbVgAfF4WwJ7dClK5Iw5TW/0eH2IdgCC9lGh6sJsh
         TL70cs6M3zOki21PkgwgLbuU2tjvQVtHxIIsltDNPVW4GAMP7SDqCGIpD7TQ4ACDejUn
         9qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738925315; x=1739530115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/OoHMey+9FJlUTsQ8RWlSNYBy7KYz/l5XDl4doJflk=;
        b=WPggJlnlMgFiTSnDonEcaQtyC7UaYARrnxYT82/Tm6/udx/GiOq//90cQE3nbSDmyz
         lGtOODXhdRvDGBLHm+wChv/rZFCm+DZ7IovAGBiXxT6nX4sZexAUOk9DcpWM6BRlcY6j
         FQ7aXmJPKAC+cNrGyydQjymUvQdNEz3t1r5w0t3bCLOm2NK1YvmB2aepa8rOomHbg6V1
         e8ULl4N/QtiwNGk+onX1ulWuTnVce+ou/um41r6yUnhOybruVcxBI7pswEUDHKHM0y3U
         rWxlMI7FJVbucrSEAWRmOGIRLqTU1rDfT4IGyZT41PkDNeGsq/pUuqrZ3nVtw23/gQlT
         qdBA==
X-Forwarded-Encrypted: i=1; AJvYcCXUskRVKc5OXX3ws3DRd5Jg4+ZGuRRRfwlWp655EVqqe/Ytyvrq5lm2UVP6E2r2JgKshWAF1s3OzjDBUz9x@lists.openembedded.org
X-Gm-Message-State: AOJu0YxsXnijqEhK5iZmZCixNAxNbLsP9VtmPkdSTUbYcbbFCX5s4hTb
	ql1Z4T1sBkODsY9PTmdA7zEK6tv4LTbTc5RRUpUKl0kxrWuAtKJTXeL4WtuL5laLm2/BvOPaHUi
	R/xZ6zmOmIc2Lt+qFBpnFZC/G0hg=
X-Gm-Gg: ASbGncs8Jaj5Xhqx98tfKnf8LnU9IDRe3D15KUmwx6rIv+aElBQB9Aeo7f2PdPIQhsf
	As77qY+dm6INlJKnVZtY9TBr6XpB6vRBXWjTQ99poyzwsnYrK0i974N7i/nD+CKJnWv1kXj14+o
	aFad11B1Tw3bfVSse5ZVsrf+EbLPljxuA=
X-Google-Smtp-Source: AGHT+IF7nd8uP3HyC56YNCsSh0zNvHnSx5Mfl/zKM94NkCEb/0w5hi9nvKAADfWrEIlCAJQG0Y04jAnrxr2kxQBODEU=
X-Received: by 2002:a05:6214:c6e:b0:6e4:269f:60fd with SMTP id
 6a1803df08f44-6e445681b9dmr31202496d6.23.1738925314975; Fri, 07 Feb 2025
 02:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
 <20250129112406.1660522-3-stefan-koch@siemens.com> <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
 <87f5216654f92c2b0a9790cf336023ec1b788eb1.camel@siemens.com> <1821E627D6FBF186.752@lists.openembedded.org>
In-Reply-To: <1821E627D6FBF186.752@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 7 Feb 2025 11:48:24 +0100
X-Gm-Features: AWEUYZk9aJNJoGpBF2rPgsus6OTXdiA4ZRWA61JUMX9PVdWQRKaB1uzy3pn8Tiw
Message-ID: <CANNYZj-EyEK5QPjuRiJXAR0x+BFeZCAkQV01cKoP_kFB5gf+0A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build support
 for tags
To: alex.kanavin@gmail.com
Cc: "Koch, Stefan" <stefan-koch@siemens.com>, "Sudler, Simon" <simon.sudler@siemens.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	"Kiszka, Jan" <jan.kiszka@siemens.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 10:48:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17166

On Fri, 7 Feb 2025 at 11:26, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
>
> On Thu, 6 Feb 2025 at 13:46, Koch, Stefan <stefan-koch@siemens.com> wrote:
> >  File "/work/isar/bitbake/lib/bb/fetch2/__init__.py", line 1670, in
> > Git.latest_revision(ud=<bb.fetch2.FetchData object at 0x7f873f06eb90>,
> > d=<bb.data_smart.DataSmart object at 0x7f873fce9590>, name='default'):
> >  except KeyError:
> >  > revs[key] = rev = self._latest_revision(ud, d, name)
> >  return rev
>
> This is the function:
>
>     def latest_revision(self, ud, d, name):
>         """
>         Look in the cache for the latest revision, if not present ask the SCM.
>         """
>         if not hasattr(self, "_latest_revision"):
>             raise ParameterError("The fetcher for this URL does not
> support _latest_revision", ud.url)
>
>         revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
>         key = self.generate_revision_key(ud, d, name)
>         try:
>             return revs[key]
>         except KeyError:
>             revs[key] = rev = self._latest_revision(ud, d, name)
>             return rev
>
> Something doesn't compute properly here: the cached revision should've
> been successfully looked up via BB_URI_HEADREVS, and a call to
> _latest_revision (triggering network access) avoided altogether.

This has been recently refactored to use a different mechanism, and
the code above is from an earlier yocto, but it should still be using
a cache, and the look up should succeed.

Alex

