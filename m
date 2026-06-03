Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE1CD6E55
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 15:39:00 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23138.1780501137820941381
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2026 08:38:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RXy4us6b;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45efa80e0afso3646723f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780501136; x=1781105936; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CogeWA6oZPHOjZBxB9XcPLs83Ivc7cmpdk3JTS6YIo=;
        b=RXy4us6bvrZPrHj3IhFlqZfKeHam4fbrp8khDuN8lyIeG21l6oRicl/tbtlOjUIDQD
         VBIfl4v4RpmWRpW1rXLj9Q6vLblauJOBuuLNLu7MM3Pn/BT2SS1Abt0Gn1RfPpQpJbAU
         NpxYHjoaiK3WxrrOQFKGz8CNOAgzbjMN9fEoNzJ5mvLY/FQoH8qaiFnxeNDv4slEWK5U
         0Yu0jeAb2TobQaXIygWaZXqh8d4XyLKoihllHH/syUaNA9rA/hrmUCykz39GZ/9lst60
         Sn5pN+OQRU8bLzw04xgfArpQgp4PUbHub/Q+FMNU9itbVvCEtXCv8YUdhzQK/OicpgJi
         nPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501136; x=1781105936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CogeWA6oZPHOjZBxB9XcPLs83Ivc7cmpdk3JTS6YIo=;
        b=JeqteMTi1lVCqIT59CBwK5cbyBJVkQsTZjypnsDHWDwaHn/hm13XRUl5XPBJXwFxb4
         72xi1UHNnNer7zAag+ILQIXPuDP9PIUUuVDpiskrgu5BLbz3u1joI5jF6lA7XlVy39hW
         5A3iuAw7PYl8QYYTdubJdQz5au4PBVtfVueq4lqZhIaNZy5WHGJnKiuMp6aVE6lzhC6X
         L21ohLRtMObbWDqZ5KhDy7HggwiOh2+MV0dIsiLv4Dz4zr1fm1Nt8Tn+lFWlVsDO2iuy
         F+Y9MpFBczJXERIcrqNUgYNzNe8D79PAeN3o6C2WxWTFBP+Xr38f/x3Nif+KzBxBgIDT
         CIIw==
X-Gm-Message-State: AOJu0YxyoDH8tbzQtohhUAINU+K8MnyzTtW7Vu4yq3RxrGBUjVZS2eC2
	7PzeE9UzzEzac0NpibTzv849qynna1kmIzw/3vpdHAX6fSHalmZ3tzYn
X-Gm-Gg: Acq92OFJKx8e7bQ0zgH/9MB0uwgUzPPdrSjN/Unka6oJY6EH8ANaQwCieUzPlz0DXZW
	tiPSByMg/qyI6UACbZLDLtyxlHos00/f6LOcMzfmefcUgFyOm9t7hN7b5eOiAT+l4qHcEB6QGP4
	DQA9SE70VNML0G+v5iRYrAy74vND8UeuM1nVV8BUg8PM7NtsKlXmDRA46LydMux3nIZ2pd/hOF2
	WeF98oE+uPmS/dtIRHIgJKu55t8J8kDDaKOx4b6W2pjbIMlmzg+KHaF3Xf0roviKc0gXMX5bNcb
	UokcvK8W39ndIOFa6s7hVd1Gwi7FMhBTq5EKBQ1yss+fMiwkKr42jf5trq2rx8ABMBWY0AlgP0J
	I/kXk1CiRwKN1dm/anRJ3Vs+14iAGYQodtq6ehyYTKiDv9iBO8vdug2gUSEtWw2hPjqaIv8PiDV
	Zu1+7jq8oagoAgquemyKdrY+FICShcAjCXVkj06VesX1a8STJMHtORGGlSZffSLcASdE46Zk6ud
	PnGkoDjgucsmWTUIrlf3RxR/f+53nEG9/9ZoDTmg9hIGO6Q
X-Received: by 2002:a05:6000:e12:b0:439:c18f:5aaf with SMTP id ffacd0b85a97d-46021759d88mr4766247f8f.34.1780501136023;
        Wed, 03 Jun 2026 08:38:56 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm13684473f8f.27.2026.06.03.08.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:38:55 -0700 (PDT)
Date: Wed, 3 Jun 2026 17:38:54 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: support multiple
 source override files
Message-ID: <nt34wvdpwl7fzvw6dm2awzfc2mxfswua2mey76zxovjsb7vyl3@enxihzd4dzm5>
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
 <20260529-bb-setup-override-improvements-v1-1-91db62e0149e@toradex.com>
 <CANNYZj_iZGyJQo-OrTXfH1rBSxtrQtOcCT9Mfnb3uiBJpwQL3Q@mail.gmail.com>
 <o2tur4mf7vfsmx2qkizqhhxjnz34vifjtxeschtjvueskuzrcy@5hmfaoevpek6>
 <CANNYZj-ajQ_2LJnTHMvC82JjtNxLRMPKEJO1ez_Paj6vb9NBdA@mail.gmail.com>
 <epsie6ihulfecgum6rju6azeyhzv34544bvw3tmyqeznycq3pk@fmmew2m6ahcw>
 <CANNYZj9rKRS0CD-LGq=phvB_T1XS+SmR5Uti0p8tu49PtTm-QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNYZj9rKRS0CD-LGq=phvB_T1XS+SmR5Uti0p8tu49PtTm-QA@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 15:39:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19604

On Tue, Jun 02, 2026 at 10:03:50AM +0200, Alexander Kanavin wrote:
> On Mon, 1 Jun 2026 at 21:21, Ernest Van Hoecke
> <ernestvanhoecke@gmail.com> wrote:
> > Agreed, I'm playing with this idea now. How would you feel about a
> > top-level definition of:
> >
> >     "source-override-sets": {
> >         "release": { "sources": { ... } },
> >         "dev": { "sources": { ... } }
> >     }
> >
> > That can then be selected by a config with
> >
> >     "source-override-set": "release"
> >
> > I don't really see the use case of having this be user selectable such
> > as the "oe-template-one-of" property. Seems to me that it'd just create
> > another axis of choice for the setup but at least for me, the sources
> > would always be tied to a certain config. For example, my dev config
> > also applies some other templates that differentiate it from the release
> > config, so release+"dev sources" is not enough, and I'm not interested
> > in creating a dev setup with release sources or vice versa.
> >
> > I'm struggling a bit with the semantics of this new approach tho. It
> > makes me think that we really just want multiple sources nodes, not
> > overrides.
> 
> I wouldn't call them 'override sets' as they're actually the starting
> point, I'd go with something like 'source-choices'.
> 
> The use case for making them user selectable can be seen right here:
> https://git.openembedded.org/bitbake/tree/default-registry/configurations
> 
> There's a lot of copy-paste in these configs, because each can hold
> only one set of sources, and folding different yocto releases (plus
> master) into a single config file would be great, so that actual build
> configurations need to be written only once. I can imagine downstream
> users could use it in a similar way: share configs between different
> releases.
> 

That makes sense to me, in this case I'd add "source-choices" that
contain multiple "sources" nodes as you proposed. I'd like to start with
just that and the ability for a (leaf) config to select that with a
property "source-choice" so it does not have to be specified by the
user. That would already solve my use case, and also allow for folding
all these OE distros into one.

I can see how you might prefer the choice so you do not even need to 
specify multiple leaf configs, but then indeed we might (later) want
allow lists. I'll send an RFC or PATCH for this and we can see how it
feels.

> Adding restrictions on what config can be used with what set of
> sources can be done as a followup, and doesn't need to be decided and
> agreed up front. Until then you'd have to maintain that restriction
> externally, by ensuring bitbake-setup is called with matching items:
> 
> $ bitbake-setup init my-mega-config-file dev-sources dev-config
> 
> I'm considering whether the source sets should hold optional allow
> lists and deny lists of what configs they can be used with:
> 
>     "source-choices": {
>          "release": { "sources": { ... }, "configs-allow":
> ["release"], "description": "...", "expires": "yyyymmdd" },
>          "dev": { "sources": { ... }, "configs-allow": ["dev"],
> "description": "..." }
>      }
> 
> This feels more elegant and flexible. But again, it doesn't have to be
> implemented up front. The best way to add new features is incremental
> and iterative.
> 
> Alex
> 

