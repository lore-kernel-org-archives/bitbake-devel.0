Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86065C3DA7A
	for <webhook@archiver.kernel.org>; Mon,  2 Jan 2023 10:05:03 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.32577.1672653897588120391
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jan 2023 02:04:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Hm5vtIQX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id o15so20045906wmr.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Jan 2023 02:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBeJEyinj409I2yxFyBTJfr8d2maYR/J8WmfdGAYOBY=;
        b=Hm5vtIQXlq81F9zHjkoI1dxigcx0Jaqn6hxtQPkCTvtQizNWS1PHwJ2/TRL2YI5BBZ
         j82OVbU1+3PONGIddkMABBASV+SW4YI1iQ65nvUdB88RaMJ214QimZcJy4ocKCZL9mYM
         nlZP9axmZKvI6B8/JVaQvLIOAhOM+n+TQDfuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PBeJEyinj409I2yxFyBTJfr8d2maYR/J8WmfdGAYOBY=;
        b=NyhVkPXpIPDfBurrg2BIT4LL/LOCXWAV8AvH5xgFvTTyBeOn84KGbnyl587irROxHY
         WGodkWHJxxCpUzLG4ju8Ou6epkm9VA6Nn6xC8YheMj56Uf2LfjFXBRxuzIUdr25zK0pq
         Kc8wPHP9kc5JxIXw16S9YU3pEFk1FEQYuwZCV9tEZtF2glRjGdedrnkzPqmP6Gmgmpjc
         XD63GiCIs2m+DzwGf3UYedEx54e/+6A1qW0jet0tyU35Cex0EMihgJYP85Ez8RdLI3Bo
         Zkt9Ug2eiz1ExBwYH7q3O700KPPTOmBLWamRFBFy8g5Z7MDnQmJB0K6HTQG/q1I3e69K
         O3vw==
X-Gm-Message-State: AFqh2kotlw/5yXrDwH9xq9sP2MWuI/zGBlw6gWDfmLHkTonKFxhnK4PO
	13srupDpsIN7se+mH8rXTJNlYw==
X-Google-Smtp-Source: AMrXdXsny1/02scz8bEDZL6ik4ugoSf54CMyZAg5nYqIEKqm5e2QrkKhoE22QXSzqK44vD1BGG7RRA==
X-Received: by 2002:a05:600c:4255:b0:3d3:3d34:5d63 with SMTP id r21-20020a05600c425500b003d33d345d63mr29998843wmm.8.1672653895803;
        Mon, 02 Jan 2023 02:04:55 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:409d:216c:1a2:8d83? ([2001:8b0:aba:5f3c:409d:216c:1a2:8d83])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003d9862ec435sm24825373wmb.20.2023.01.02.02.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 02:04:55 -0800 (PST)
Message-ID: <d0ef1d8f2b4b482c891ce33d7942724566538f71.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cookerdata: Fix cache/reparsing issue
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Christopher
 Larson <kergoth@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 02 Jan 2023 10:04:54 +0000
In-Reply-To: <b660011a-3526-3016-c3a9-0f7a6868f4ab@theobroma-systems.com>
References: <20230101142509.1022073-1-richard.purdie@linuxfoundation.org>
	 <59224516-17d8-4c43-9f2b-38c5034cfdba@Spark>
	 <9d512b49ed3254cc9ef67f21cc1a0facdaff9479.camel@linuxfoundation.org>
	 <b660011a-3526-3016-c3a9-0f7a6868f4ab@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jan 2023 10:05:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14277

On Mon, 2023-01-02 at 11:01 +0100, Quentin Schulz wrote:
> Hi Richard,
>=20
> On 1/2/23 01:50, Richard Purdie wrote:
> > On Sun, 2023-01-01 at 09:55 -0700, Christopher Larson wrote:
> > > On Jan 1, 2023 at 7:25 AM -0700, Richard Purdie
> > > <richard.purdie@linuxfoundation.org>, wrote:
> > > > When setting the LAYERSERIES_COMPAT and LAYERSERIES_CORENAMES
> > > > variables,
> > > > we need to be deterministic. The random ordering from the sets was
> > > > causing
> > > > unexpected reparses.
> > > >=20
> > > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > > ---
> > > > lib/bb/cookerdata.py | 4 ++--
> > > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> > > > index b4e0c4216b..8198f509e2 100644
> > > > --- a/lib/bb/cookerdata.py
> > > > +++ b/lib/bb/cookerdata.py
> > > > @@ -425,7 +425,7 @@ class CookerDataBuilder(object):
> > > > data.delVar('LAYERDIR_RE')
> > > > data.delVar('LAYERDIR')
> > > > for c in compat_entries:
> > > > - data.setVar("LAYERSERIES_COMPAT_%s" % c, compat_entries[c])
> > > > + data.setVar("LAYERSERIES_COMPAT_%s" % c,
> > > > sorted(compat_entries[c]))
> > >=20
>=20
> compat_entries and layerseries are sets set just a few lines above.=20
> Would it make sense to actually have them sorted directly there instead=
=20
> of only when they are used?
>=20
> https://git.openembedded.org/bitbake/tree/lib/bb/cookerdata.py#n418
> https://git.openembedded.org/bitbake/tree/lib/bb/cookerdata.py#n421

They're used as sets elsewhere and that is used to de-duplicate them so
whilst I did wonder too, I ended up just sorting as we wrote strings
back...

Cheers,

Richard

