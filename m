Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F92CD5BD1
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 19:21:33 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7502.1780341690588981598
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 12:21:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=E1UqzIBm;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-460166910e6so478272f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780341689; x=1780946489; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZFtSHXGC1dneVvdUJbUhoYoZVS39Jn4sUKCTCAHmQk=;
        b=E1UqzIBmIO/aYsn3GYBqBgClvnEUfAIoOvJH3i+MDPa8L1nftk0QYxU6Q5rr91AzF/
         qyQy6f947mfydyGyjoV9RrjKifqBz2IQTQdqB4PbypByXl4AkBzuwawz4wpfGPruCgoZ
         CmysTQMRpLcEMaBTSLeaSXJtRmQtKoE74B68QZ2SjMrIetBGRPnnaUnUilKo32dWdl7M
         m20eoUn6hAS8paKKEy6241fOcXxD5xutsv9ddeP5mFUbiNU0qaaIFDTVFMog+NWYy+zI
         sWgrVZqGSYe5bofv6si6yg+OtcaAzu2fF0qe2Txo9SO2h76XYr6LSL3K7PESCXAMYLSV
         bXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341689; x=1780946489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZFtSHXGC1dneVvdUJbUhoYoZVS39Jn4sUKCTCAHmQk=;
        b=HyBOILsNhrxV0Ots1v6kNOnP/tAn+ElLR+EASELIAuWrxkW/rSLI8gjjAGN78kP2i+
         6Bn2dFdCyez2QGddHUt63oouzQK9m2KOknMsBvYmvBSoOiiarhPd+7xKYcgvIWNiX30G
         LzbAOJ6BhP8wM/NTqx26jmgeD6bQFx0nXbvq1fHs/rxbmD1UNQEoYEhLbPipn1CCVBav
         rmEBAEsqoa8ayIRkpOIkg1YpysHCYSu5Oc32guk+PchnCly+nW3855CH9fOM9VHeNpEJ
         c1AyIx1O0yAtKIY0O7PLsfa0hNIlz9Gwssy8h/xqlv9akPi4S3XU4L8o4ykDzYDF7V1K
         mX9w==
X-Gm-Message-State: AOJu0Yw/F7PUTYUbNONrLxjjEqLWNa84RNwW9FPFipL8KKh74Vkp3IHs
	MujMnvNYmt4hsuI71iANOGl4aCmjgVshQoxVfG9319QlgHkCG+K7PkgL
X-Gm-Gg: Acq92OHOU3K7AF3DUIF08mo1345aGHcTMRJJ4QhnVDtelar9Xb/OD9AvZuBvSo8J6J/
	oEGQUXwTuD5SGWI55n5dlc6uz85MDO51Zs+hOe2w6JyJ1M6TAz8zmEKvGyXPs6ZVfzh/lW5tuYn
	bh+Qx+Vj9cDxJ9MvI4U3dQF4s85Fz4KUeiZlhR6ZNxc5i9C7tSQ+GptrJwrTAVTBbEjG8oKDpHm
	i0QpLRbuv3HBBLCbWTf5/K73kwd3uxC9+fOTl3wng74AKrKWRblfROcn9JOkw1HBfmPCae+Rt/Z
	96KCGJdEpYMr5LCyNvXOI7RUbs8tVdj6/Wg1K4LEs3+/KuST8ZR249mAt9CSTqcTUHPgYTBO9P2
	AuTvIpv8lNWXhbe2iexWoc7qWKw47A547npGY3XEXxMZMjabdF8BlH2ESxMQoIgU/8XBstYFUaj
	y0OYhGRqCK7lD63Yqzoc516bqmQgO7CIcMK/18+kGtVRQhhBZrU9YqC0pB76yCCPPL97irE82gH
	heD8sO+0+Gv4KiLQqAZNZr2kR3OdAKDaK9q2N8OMEquNGlbLeM3RvPra5vphQMA
X-Received: by 2002:a05:6000:4c8:b0:45e:ea3a:47d6 with SMTP id ffacd0b85a97d-45ef6b93b94mr16581326f8f.32.1780341688655;
        Mon, 01 Jun 2026 12:21:28 -0700 (PDT)
Received: from ernest.hoecke-nb (static-2a02-1368-6200-2fbc-d7b4-25e5-cfdd-1870.cust.swissbackbone.net. [2a02:1368:6200:2fbc:d7b4:25e5:cfdd:1870])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35601d7sm38735930f8f.28.2026.06.01.12.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:21:28 -0700 (PDT)
Date: Mon, 1 Jun 2026 21:21:27 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: support multiple
 source override files
Message-ID: <epsie6ihulfecgum6rju6azeyhzv34544bvw3tmyqeznycq3pk@fmmew2m6ahcw>
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
 <20260529-bb-setup-override-improvements-v1-1-91db62e0149e@toradex.com>
 <CANNYZj_iZGyJQo-OrTXfH1rBSxtrQtOcCT9Mfnb3uiBJpwQL3Q@mail.gmail.com>
 <o2tur4mf7vfsmx2qkizqhhxjnz34vifjtxeschtjvueskuzrcy@5hmfaoevpek6>
 <CANNYZj-ajQ_2LJnTHMvC82JjtNxLRMPKEJO1ez_Paj6vb9NBdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNYZj-ajQ_2LJnTHMvC82JjtNxLRMPKEJO1ez_Paj6vb9NBdA@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 19:21:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19589

On Mon, Jun 01, 2026 at 03:50:05PM +0200, Alexander Kanavin wrote:
> On Mon, 1 Jun 2026 at 14:43, Ernest Van Hoecke
> <ernestvanhoecke@gmail.com> wrote:
> > I arrived at this from a real use case. Admittedly, that might now be
> > semi-artifical if we don't want the other default-source-overrides
> > patch.
> >
> > My setup idea was to have all sources move, then use a fixed revisions
> > override to create a "release" setup at known pins, and then apply
> > another override on top of that one to create an "integration" setup for
> > CI where most sources are at known pins, but some repos are at latest.
> >
> > By overriding again, it prevents needing to maintain a "release" and
> > "integration" sources override files, that are mostly duplication of
> > each other.
> 
> But why can't 'release' be a full json config? If that leads to
> multiple duplicated configs for each release, then we should pursue
> the 'souces-one-of' idea to have multiple source sets in configs.
>

Agreed, I'm playing with this idea now. How would you feel about a
top-level definition of:

    "source-override-sets": {
        "release": { "sources": { ... } },
        "dev": { "sources": { ... } }
    }

That can then be selected by a config with

    "source-override-set": "release"

I don't really see the use case of having this be user selectable such
as the "oe-template-one-of" property. Seems to me that it'd just create
another axis of choice for the setup but at least for me, the sources
would always be tied to a certain config. For example, my dev config
also applies some other templates that differentiate it from the release
config, so release+"dev sources" is not enough, and I'm not interested
in creating a dev setup with release sources or vice versa.

I'm struggling a bit with the semantics of this new approach tho. It
makes me think that we really just want multiple sources nodes, not
overrides.
 
> > You're right that this can easily be managed with other tools, the small
> > risk I see is that lots of custom solutions start growing around
> > bitbake-setup, but with your feedback on the other patch I also see less
> > value in this one.
> >
> > In short, the expectation here is that people use their own tooling to
> > manage the .conf.json and source overrides .json files? If so I'll send
> > a patch later to remove the multiple --source-overrides option from the
> > docs.
> 
> Overiddes are meant as something local and throw-away, and not
> something that is ever checked into a public git repo or otherwise
> shared. They're not self-describing for example, if you look at the
> content, there's no way to tell what is it for. Allowing multiple
> overrides that are overlaid on top of each other also makes it more
> difficult to tell what would be the final result, it's hard enough to
> figure how bitbake variables get their final values, and we don't need
> to repeat that :)
> 

That is a very compelling argument :) 

> So if a certain set of sources is reused between many builds, it
> should really be in a config. Bitbake-setup could help with that, e.g.
> 'take this override and add it to this config' command.
> 
> Alex
> 

Agreed and I've experimented with just using jq to overwrite the sources
node, I see this as the way forward. If I find a reason maybe I'll
integrate the behaviour straight  into bitbake-setup once we have an
idea on the multiple source sets/overrides concept. Thanks for your
thinking on this.                     
                                                                         
Ernest


