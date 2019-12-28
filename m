Return-Path: <masahiroy@kernel.org>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
	[210.131.2.90])
	by mail.openembedded.org (Postfix) with ESMTP id 90CAB7D71B
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Dec 2019 17:15:34 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
	[209.85.217.51]) (authenticated)
	by conssluserg-05.nifty.com with ESMTP id xBSHFM3s020822
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 29 Dec 2019 02:15:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xBSHFM3s020822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1577553323;
	bh=GSXxrqZwttGkEkzGcXjgfSMkmwLZOIk6AxSYJcPOm1E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=wzMHheRwAXpfrLg/p7Wp3GyecF9CtSQz+ISivGBMdQXJDdaGZDP9s9qpplMwMX2wa
	iMZw6jEGv07R108abI9g5pPCdP35EB0Eh0MN7T0FjJiKcKL/Ab5kzi8KrB81eJ5haT
	0z0yHiv8cXMvCEX3j8LgqmhgODtNj+TGJJxQs9UI3KrVU+ONbuK+fKVv59XzC3OluO
	wCo9WsQPPGus9xawHNS8qEUycMc27BTlmSuYubhen86wHJf60PbKCc4qJpuDpGW5Kv
	sZeKuFGhoAduKxEqM6/NoQsigqwDKjFIn3GXBKd/bsMQG1AQZTcjj2urDJdHRCvub0
	AJIKJiXW13nRA==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id x123so18642325vsc.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Dec 2019 09:15:22 -0800 (PST)
X-Gm-Message-State: APjAAAXPefkn7+BhYWIyrIJMvPDy88VfbrQJhFJ2DTW7SoU56wfKVn8R
	LZqkJW8th77JpJuuDc056MNwr8iLwRFcYutnogc=
X-Google-Smtp-Source: APXvYqwMMoA8QdLe3kYmEBmdFoxacY2uvF5UkJhk3O8SovdWp4ReznT15FkBNV0DKXQY583Eb2VImZNV9Q9X0Mt0f6o=
X-Received: by 2002:a05:6102:48b:: with SMTP id
	n11mr20489304vsa.181.1577553321448; 
	Sat, 28 Dec 2019 09:15:21 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAQ+4TEnV+hW9ZQpn5dK+brp9o6UfD3OLk++eHn4T_ezxQ@mail.gmail.com>
	<12d09040023dd88ae6fa2397e14929242d8ff317.camel@linuxfoundation.org>
In-Reply-To: <12d09040023dd88ae6fa2397e14929242d8ff317.camel@linuxfoundation.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 29 Dec 2019 02:14:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASYQTQMK7mSqDSRDp64+Q5xazfek5_9fFgUMf-b-r-ZzA@mail.gmail.com>
Message-ID: <CAK7LNASYQTQMK7mSqDSRDp64+Q5xazfek5_9fFgUMf-b-r-ZzA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: DEPENDS vs RDEPENDS from bitbake PoV
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 28 Dec 2019 17:15:34 -0000
Content-Type: text/plain; charset="UTF-8"

On Sat, Dec 28, 2019 at 9:16 PM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Wed, 2019-12-25 at 16:33 +0900, Masahiro Yamada wrote:
> > So, DEPENDS and RDEPENDS are fundamentally the same
> > from the bitbake point of view.
> > Is my understanding correct?
>
> From that perspective, yes, they both have the same dependency
> behaviour.
>
> > I know there is slight difference between them.
> > For the RDEPENDS variant, the form RDEPENDS_<pkg> is also supported.
> > (<pkg> is the element in ${PACKAGES}, or ${PN} if ${PACKAGES} is
> > empty).
> >
> > Other than that, the functionality looks the same between
> > DEPENDS and RDEPENDS.
>
> The namespace difference is key, deptask works off DEPENDS, rdeptask of
> RDEPENDS and as you mention, RDEPENDS has a relationship with PACKAGES
> and RDEPENDS_<pkg>.
>
> Cheers,
>
> Richard


Thanks, it helped me a lot.


If bitbake had been implemented as a really generic task scheduler,
perhaps it would have chosen more sophisticated syntax than DEPENDS/RDEPENDS.

As a new learner, I think one of the most difficult parts to understand
is the boundary/interface between bitbake and meta data.

The metadata-level specification is nibbling at bitbake.
I decided to convince myself that it is how this project goes...


-- 
Best Regards
Masahiro Yamada

