Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA36BCAC581
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 10:26:13 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.9842.1757327167750597782
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Sep 2025 03:26:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Yca/S79Z;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo1610196f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Sep 2025 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757327166; x=1757931966; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UDmf1f1cvZbh5et1zySPSr6rU7YWd15nl6fMupqcBBQ=;
        b=Yca/S79ZXf9NheVd1zgGISV9fM0n90T0iPe/u7EIzd+/BqbxyQ0eJJhh2BWafq5TPD
         OtGDf26o+oQSkEi/0/hSLGT2eTXOgAoXnx8SPoZ4xjS35FUmpgm/Qta2YR3U6Nc2gsFF
         7AA8GTcAHF6aE9xetBarTSHXJA3JbNfkoDWhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757327166; x=1757931966;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDmf1f1cvZbh5et1zySPSr6rU7YWd15nl6fMupqcBBQ=;
        b=Ck42fJbgZps7CyDW/L7eRH2tkWs8btMrQZEs5k1FGtoagd1TT6UmL7n0tdRPg3RI9m
         T0HQO8SiHdAi6pnOTBkK9ne580ZxPT3vqlZv42B7KDiv4s6b+JlEA/Fc8dYxx6jsrT8B
         /agebRiRQHVe471JQr1GfPOheTizjOFnXnCX7qPvV7KmFgcQT7W2HbGG1WXZksxiql7R
         irT911zXuLS//InuCt9gmET8D9w99uSRzO/UTGmRTO2yetdw3sb/mknVG72GbH5/+sO8
         qvgzzjfHtnR4PfLeiP0M6Ix6jFo8Dk6A+GPR01dl4wBUOPKmSMYTP7fAPg9tDZQhlmdh
         BKrA==
X-Forwarded-Encrypted: i=1; AJvYcCUsC0rxNKZkM95sLMq4yBppN976AYhsutEKww1qhqF4nrGkRyc8bT7pa8zorbWs8fW26Nwv3+jqhwkQiB0p@lists.openembedded.org
X-Gm-Message-State: AOJu0YzIESbEJueK4Zbb9mX7Zi08PmaJk7gRIl2txM5RGT+U9+0n3uHi
	IloIReKDw9xXsCFgKWtAOH9z1DyynUx2hKDIeo57nkOYzcdW+sqCy98lXDpVovb/66M=
X-Gm-Gg: ASbGnctBQBvs/Dl+gaDKpW3AfDweJhaMV8FuxBoulR4mqDxeaMyS8fGEtA2ohieugtl
	uV6HlSVohhnj+psKXzuPFVhz0pnK58G2OP1H/zanCj706xS1xXSLGT0imD+8QEwtyeDyWebb+UX
	q3q+W1NgmssE1XsXzju/APv6imUltiHMvg6s4PbCsobkYq+gqnUKMFI90dbccOH1XfRsZiuyT/K
	aoiykv8iHu/ii8C8HhOnKhCDeaonIYUOYiATfjjqZbjp061kKUlHwYFjNSJ0meYemgREDh89A2d
	D69I1pP5zH0aouvTEFTH+7CmKhnBTm7V/ymdX5rkw5AexRaV9cULfJmdkOpjoJXzoJX5RqBw0H7
	N9I3yT5x2o/0m/8/zesSITo+6Ijhc+mPMeEWftV2be2UlpZJExex0JRXxpP8tbUhI/C1vTrcvc8
	RPaXlOxVn0YB5JYgIsj+TrHQ==
X-Google-Smtp-Source: AGHT+IHwKXQgZDFY2ksC9PrPtXiCCTS4iTZ51ZizmmzvjEK1aumb2ApmMMLOT1KS3maMvLsbLYFDMg==
X-Received: by 2002:a05:6000:178e:b0:3ce:a06e:f24e with SMTP id ffacd0b85a97d-3e64c87e0a1mr4381426f8f.52.1757327165967;
        Mon, 08 Sep 2025 03:26:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2892:3aae:20fe:dbc0? ([2001:8b0:aba:5f3c:2892:3aae:20fe:dbc0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34491a65sm40325716f8f.56.2025.09.08.03.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:26:05 -0700 (PDT)
Message-ID: <fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 0/6] fetch2: add support for
 implicit urls
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Mon, 08 Sep 2025 11:26:04 +0100
In-Reply-To: <be5703d4-00ee-45be-9183-7bb4a327ed79@weidmueller.com>
References: 
	<20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <c1124597a57241518f4ddee17c5786ecb11caf2f.camel@linuxfoundation.org>
	 <be5703d4-00ee-45be-9183-7bb4a327ed79@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Sep 2025 10:26:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17986

On Mon, 2025-09-08 at 11:20 +0200, Stefan Herbrechtsmeier wrote:
> =C2=A0Am 07.09.2025 um 17:52 schrieb Richard Purdie via lists.openembedde=
d.org:
> =C2=A0On Tue, 2025-09-02 at 08:55 +0200, Stefan Herbrechtsmeier via lists=
.openembedded.org wrote:
> > > The patch series add support for implicit URLs inside the fetcher. Th=
e
> > > implicit URLs could be defined inside a source like a version control
> > > system (git submodule) or a lock file (package-lock.json, cargo.lock =
or
> > > go.sum). The integration of implicit URLs beside explicit URLs
> > > simplifies the fetcher classes and avoid bugs because of iterations
> > > between the Fetch and FetchMethod classes.
> > >=20
> > > The series remove most methods inside the gitsm fetcher and only leav=
es
> > > the parsing of the git submodules and the unpack functionality. It
> > > allows the gitsm fetcher to use the premirror only feature. The curre=
nt
> > > implementation leads to problems because the download of the git
> > > submodules is triggered via the download method which is called deepl=
y
> > > inside the fetcher code.

> > =C2=A0We had the discussion a while back and the conclusion seemed to b=
e that
> > implict urls were disliked by a significant number of people as the
> > were too unclear about what was going on behind the scenes and also
> > made things like software manifests harder.
> > =C2=A0=C2=A0
> >=20
>=20
> It looks like I miss some discussion and especially the conclusion.
> =C2=A0
>=20
> =C2=A0I assume you mean recipes by software manifests.

No, I did mean software manifests. If the urls are explict, it makes
generating manifests of the sources being used more obvious for people
to understand. Yes, there are programmatic=C2=A0ways of doing it with
implicit urls but people don't like them.

By conclusions, I was taking that as the outcome of the last set of
discussions but there was a lot of different emails and it was hard to
follow. Perhaps i got the conclusion wrong, I don't know.

> > =C2=A0There was a strong
> > preference for metadata helpers and explicit lists of components
> > which
> > we have for crates/rust and now for go too.
> > =C2=A0
> =C2=A0
> Does this mean the npmsw and gitsm fetchers are obsolete and should
> be replace by a metadata helpers to fix open issues?

I really don't know about npmsw. I don't use it and I don't really
follow development there. I'm don't know much about the current set of
issues it may have.

With gitsm, I think that is generally accepted by people and I don't
see a strong reason to change it at present. I would be interested in a
clear summary of what the known issues are (e.g. the premirror issue
you mentioned).

> > It feels like this series is moving us back to the other direction.
> > Is
> > that correct and if so, what has changed in the approach since the
> > last
> > discussion?
> > =C2=A0
> =C2=A0
> Do you mean the response to my last RFC? In this case it wasn't clear
> to me that the project is against implicit URLs and that the npmsw
> and gitsm fetcher are the wrong direction.

I'm trying to read the "mood" of our developer community and right now,
it feels like putting a lot of complexity hidden in the fetcher isn't
what people want to see as they don't understand it and can't "see"
what is going on. During the discussions, I think we identified some
key fundamental issues with implict urls for some fetch types too.

There is some hard work needs to be done in trying to summarise those
discussions and writing down the "results" so that we don't have to
redo this every time a new patch series comes along. By that, I mean a
non-emotive list of the current advantages, disdtantages and known bugs
of the current approach and any proposed alternatives we might choose.
=C2=A0It perhaps falls to me as the developer lead for bitbake to try and d=
o
it but I'd very much welcome help from anyone else in trying to do it
as I simply don't have the mental bandwidth to try and do that for this
topic right now (due to e.g. bitbake-setup). I certainly don't have to
be the one who does it. I appreciate it isn't a fun task though.


> This series is only a cleanup of the existing functionally. The gitsm
> fetcher uses implicit URLs but doesn't work correct because of the
> misuses of the download code.

I'm worried about where the series is trying to take the project and
codebase though, hence the questions about intent.


> It is useless to start the discussion again. The project doesn't like
> implicit URLs. It prefers a special task as a replacement for the
> separate recipetool. It decides against the on-the-fly parse inside
> the fetcher.

The developers using the project feel much happier with that approach,
yes.

> How should I proceed? I have working code which parse the cargo.lock,
> go.sum and package-lock.json files and only use Git and Wget
> fetchers. The code uses the vendor feature of the package managers to
> create a patchable folder of the sources. It simplifies the npm class
> and add additional classes to build packages. The code integrates
> valid URLs inside the SBOM and creates components with name and
> version per dependency. Furthermore, I have rework the gitsm fetcher
> to hopefully fix some open issues. I can convert my cargo, go, npm
> and gitsm parser into metadata helpers but this is useless if the
> project dislike python functions to generate URLs like the pypi class
> or prefer package manager specific code inside the fetcher.

So you are proposing we drop the crate and gomod fetchers in favour of
implict urls?

I'd suggest sharing a branch of your changes so that others can see and
understand the implications and hopefully experiment a bit, see if it
can convince some people that implict urls are the way forward.

Cheers,

Richard



