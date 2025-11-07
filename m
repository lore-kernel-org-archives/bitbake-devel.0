Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F7BCCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 15:28:13 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1273.1762529289674238058
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 07:28:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=F/wpfJXb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c82bf86bso460098f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 07:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762529288; x=1763134088; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t7NhfB37NYGRsinANKoyGGvvwwU0G/sFjy7yQPCUgSw=;
        b=F/wpfJXbq7+t86Te0ZvAFCAFc5EqEA2t+LxoS/PJ7qgW0T1+POwqNl6wqpLo/AR3L1
         nx9FHbBAGhLjL7FIGDxNaYrFrGROjfz0iGWUOO7EqrqTjzCmdcXbH2HF4MI3+Kpc45rk
         wZUjjrgSxlT2x952ZpW5l2fwMl3ttuIHKMEQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529288; x=1763134088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7NhfB37NYGRsinANKoyGGvvwwU0G/sFjy7yQPCUgSw=;
        b=gbDhslr/xi6mBjZcFSUJmBaigeVvDop0JLPs7FiPxu7duPogKbYXlnCNZaGNMQArfU
         JWf/bm/YD1wucdv3nLTygt4wfM+BgdkD9RVGzYrnwVAWFIUxpKofakAlBhczFCJrixyS
         OlTFtwjA6Hqgdymq1uPg0Bk4VJ5ssI4muc6eiJh/UQh9UWDhwiHogFR6UAS3bibNhVSy
         HTEYKbHXSOR58w0F7EO6EdttHrKX1PWpXai45Za+NfkiVDCC/GlXw5qodIsa9zF7kchG
         vkoPXe2YKGmAtjHuOWkZNzWCFC+fWTFOpy4rDwFX0je3E2OI6pX1PNKCCfN2Se8YbI71
         nFqw==
X-Forwarded-Encrypted: i=1; AJvYcCU5YNmtJ43sYLXm3FwzfMoljntkf5TZ9jrAJ3DkhMfOUxRKbrurJEOxUxB8eRvTxk055oS1r7xaMGrwJvBO@lists.openembedded.org
X-Gm-Message-State: AOJu0YwnkPDZvxBHg/hb91wwnKin3pKU1mPhisi/YIkQR+kopbsRhe5K
	9kmDKTB2x8/jiqsduWlhg7t/gbRY9waIUi5AYeEnnnnV910lXxUCwSgfnPRawx8ZRHQ=
X-Gm-Gg: ASbGnctxgpYTiri6OnABIvUNO0jhT+orgV0QTP6j2W9BHdE79cbq2UzHpa1e46eiGJz
	YW+e5lpTNGeaQsqE8Q+MT5aX10bnE+WRJd3VAokLSKneES2wrEzk8pFF104lesGKGdhrn6oIDax
	H4QLwZgut+ciJLZ41ydh6O/G2CDi2txbtwp9MDOMcp1Yi5qF20w3tDvAFasZo171UxHXPo13mes
	X9VZtc0rmVG14uYFov7m7amV3tmij+88J28M+cmrCcDuhQ8QyiLgXaEU+cpIoM79NzmVPvm944A
	fuUhvK+Xajh2Z7jF7O45jW9WLmV2cil8m3cTTJdbpL2i1mKHlAHCe3vNSAmlE5aQSmvpvPENE0p
	1rtuh/JAv8koliYIxZYzBBlJ5JJBbC01Ui/WehIg4uijdSi4v7iUpyprbYZqSqaL1r7IY3tUUvB
	PhZGIQyO8dRkjiZI97S2aPkRnY6rAm+0NpKQKvLhme3IBkIqCUaDhwRF5fO3F97wOk
X-Google-Smtp-Source: AGHT+IG3voMGn46qfrHgv0q9yhubMJEzmrql32rHzdFBGF9UHGWJjs3eRDUA+ubrIW+Onhofg2tWRg==
X-Received: by 2002:a05:6000:26c9:b0:429:8d0f:e91 with SMTP id ffacd0b85a97d-42adc6885ddmr3503641f8f.3.1762529288048;
        Fri, 07 Nov 2025 07:28:08 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09? ([2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e131sm6113755f8f.20.2025.11.07.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:28:07 -0800 (PST)
Message-ID: <0703bfca3fd4f27b34d05307698f13ded72150eb.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: unpack sources (e.g.
 layers and bitbake) into 'sources' rather than 'layers'
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: peter.kjellerstedt@axis.com, "alex.kanavin@gmail.com"
	 <alex.kanavin@gmail.com>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Fri, 07 Nov 2025 15:28:06 +0000
In-Reply-To: <DB5PR02MB1021378D8FFB243D45302CF4FEFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20251107080026.2599821-1-alex.kanavin@gmail.com>
			 <20251107080026.2599821-2-alex.kanavin@gmail.com>
		 <13179deb9c814179d00e7bcd125c3999399c5819.camel@linuxfoundation.org>
		 <DB5PR02MB1021360A5C5B050606199CD02EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <e12005baac32b9cc5ca13b79a66b54584060bb84.camel@linuxfoundation.org>
	 <DB5PR02MB1021378D8FFB243D45302CF4FEFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 15:28:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18314

On Fri, 2025-11-07 at 14:36 +0000, Peter Kjellerstedt via
lists.openembedded.org wrote:
> > -----Original Message-----
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > Sent: den 7 november 2025 12:44
> > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>;
> > alex.kanavin@gmail.com; bitbake-devel@lists.openembedded.org
> > Cc: Alexander Kanavin <alex@linutronix.de>
> > Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: unpack
> > sources (e.g. layers and bitbake) into 'sources' rather than
> > 'layers'
> >=20
> > On Fri, 2025-11-07 at 11:07 +0000, Peter Kjellerstedt wrote:
> > > > -----Original Message-----
> > > > From:
> > > > bitbake-devel@lists.openembedded.org=C2=A0<bitbake-devel@lists.open=
embedded.org
> > > > > On Behalf Of Richard Purdie via lists.openembedded.org
> > > > Sent: den 7 november 2025 10:49
> > > > To: alex.kanavin@gmail.com;
> > > > bitbake-devel@lists.openembedded.org
> > > > Cc: Alexander Kanavin <alex@linutronix.de>
> > > > Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: unpack
> > > > sources (e.g. layers and bitbake) into 'sources' rather than
> > > > 'layers'
> > > >=20
> > > > On Fri, 2025-11-07 at 09:00 +0100, Alexander Kanavin via
> > > > lists.openembedded.org wrote:
> > > > > From: Alexander Kanavin <alex@linutronix.de>
> > > > >=20
> > > > > 'layers' is not a good directory name, as it contains
> > > > > bitbake, or repositories
> > > > > that can contain multiple layers or no layers at all (e.g.
> > > > > yocto-docs).
> > > > >=20
> > > > > While there's a chance, let's name it right: 'sources'. This
> > > > > aligns nicely
> > > > > with both the 'sources' property in the json configs, and oe-
> > > > > core's unpack dir
> > > > > which also 'sources'.
> > > >=20
> > > > I'm afraid I strongly disagree with this change. Whilst
> > > > "layers" isn't
> > > > ideal, to me "sources" is worse since it implies source code
> > > > and the
> > > > general downloads. It is all too easy to think this is going to
> > > > be a
> > > > downloads cache directory of some kind, or where S might get
> > > > unpacked,
> > > > and so on.
> > > >=20
> > > > From that standpoint "repositories" would be a more fitting
> > > > description
> > >=20
> > > In our setup, I have called the corresponding directory 'repos'.
> > >=20
> > > > but I think "layers" is reasonable.
> > >=20
> > > Please don't call it 'layers'.
> >=20
> > It is already called layers and has been in the patches for months.
> >=20
> >=20
> > > =C2=A0To me, a directory called 'layers' should
> > > be used for individual layers, e.g., meta, meta-oe, meta-
> > > virtualization,
> > > etc, whereas this directory contains full repositories, which may
> > > each be
> > > a single layer, a collection of layers, or may contain something
> > > not
> > > layer-related at all, e.g., documentation. I have some ideas for
> > > the
> > > future, and can see a use case for a 'layers' directory, which
> > > would then
> > > typically contain symbolic links to the individual layer
> > > directories
> > > somewhere within the 'repos' directory.
> >=20
> > At this point that ship has sailed.
> >=20
> > > > > Then the setup directory contains:
> > > > >=20
> > > > > - build (bitbake's build directory)
> > > > > - config (bitbake-setup's configuration data under version
> > > > > control)
> > > > > - sources (everything that was fetched and unpacked)
> > > >=20
> > > > so the linux kernel?
> > > >=20
> > > > I say that tongue in cheek but it illustrates my point, new
> > > > users will
> > > > not understand that.
> > >=20
> > > And I think they will even less understand why a directory called
> > > 'layers'
> > > contains bitbake and the documentation. I believe 'repos' (or the
> > > longer
> > > 'repositories') would be the best option.
> >=20
> > I disagree, quite strongly and I don't really want to open this for
> > discussion. That should have happened months ago.
> >=20
> > Cheers,
> >=20
> > Richard
>=20
> Tbh, I was not surprised by your response. My reply was primarily in=20
> the context of _if_ we were going to rename the 'layers' directory
> now,=20
> as suggested by Alex, then I would much rather see it named 'repos'
> (or=20
> 'repositories') than 'sources'.
>=20
> That said, unless I am mistaken, the 'layers' directory is not part=20
> of any API. It is created and maintained by bitbake-setup, and if it=20
> is renamed, then that should only affect bitbake-setup. It is not=20
> really any different than renaming sources-unpack to sources. Ok,=20
> that may be a slight exaggeration as it is more visible to the user,=20
> but at least I don't think the current name is something that should=20
> be seen as set in stone.
>=20
> And while your are quite right that it would have been better if this
> discussion had happened months ago, there is still room for improving
> things, after the Whinlatter release.

Perhaps. The bigger picture of these changes are testing the limits of
my sanity as things are though so I don't really want to do this now as
I don't think there is a big issue there.

Alex's change to autobuilder-helper also showed just how invasive that
change was. Yes, it is 'only' CI, so fewer people notice/care and it
only breaks people maintaining CI but it did mean a lot of change
there.

We have bigger problems right now.

Cheers,

Richard


