Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D2EC02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 13:35:08 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.11934.1738762498292850713
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Feb 2025 05:34:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d5QSgZoC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso46676155e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 05:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1738762497; x=1739367297; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10D8AQr9MW60mF7MHkwqIYR7w0kz5rAeIzxCD/WpPRs=;
        b=d5QSgZoCjWvRLhVZLpq1jN9Lwf1k6xq+7EXFFESRZn96bgR7wv0vimS51Q9XJTc3NB
         vrxyBkLje/DkVk6F4WENZrtkHL4CqwyBccp52puNtp33861jX/rXS4dvL5surmwVLOOG
         ddBetdPLBcRb0UokJ/QB5Fq7lrTSaQeUIW/xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762497; x=1739367297;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10D8AQr9MW60mF7MHkwqIYR7w0kz5rAeIzxCD/WpPRs=;
        b=AtjoiyJK1YDHiHydBqbDlgAMQNiq/AQdWp3T5FV6uwgBbp+D/MtfZdg4zifzC9hHl1
         ri/2lk5Ij3cz19GjczOcU/NGvb+gaHJFZ+maAgluH0qK2PCWXDpgpn19lWvXIWHD3C3h
         6H2afZc4ELXwPMcrcORbwi3ggukXX0VBx+DZWPKP47DmQCbyLhncBKNESZhOZjpvcTeT
         kDp3WU2r9pwa+kKTsNXvLoxZbtAFDt3NQ5xnMMP/XTnsj6TKZmR9MhXhIWUoySAeDrZ+
         96/Wlpx8qZZltV5UkukC1vHM8ilX4fQpqZBcyU5eI001bhSnb3mDbkyjazBQCvGPIAb6
         EYIg==
X-Forwarded-Encrypted: i=1; AJvYcCWGvm9TrsCECqVcRkpDIZxRgI153A+DrtPVFytdJvPT4K08T+5e/KQ/hdp7FD/q7/r8vOhvRUPSJQv9uisC@lists.openembedded.org
X-Gm-Message-State: AOJu0YyMAW08qoTD7SYBjeoVeNsOHmI3t2ixB5Ukn2ZV1uXMKthnkJZ5
	vpmS5UGP49CKAmo/b9xDyF29zOjCyH8inW9OBTc4CgPTU3XG0z/2QlYAAup5nkEu0gzPoWZO4KO
	3
X-Gm-Gg: ASbGncvMntiMpiXZVS+QqOIsR9fHIud0VchG3+4H1Pz6px6PrwadH8AUXISzMDEebUe
	BJUb2igWJrAeeNIkg9o2xqys4GT++ADocLalUGg/bgjv8j5vRXXCRX8y/rHswBwF6hQxw5tuCdA
	GKLF9ybG4biopwrTaiXTvy6VIQb6XgXVaVMAYAQD6cT8aKg4UJj7LdlD2sdr0A75ZNfw7M46AdI
	N7S4ieuZ4GXiLQF15T1qny998iUZGwQQ0skf++/9hEWrLFQAedHzr3OnPlc0gNY3TUxeje+1XKx
	i/zronZQH0TaZk71ZZ0WYjfukqcGK27R2M+WlpSQGe6DEw6yORR7H4T5yfVvsrvU5YkNjG1qgju
	OmC3i
X-Google-Smtp-Source: AGHT+IFoowtFk88gv9p8PWT/YeVar6h+P99rXbaXBDCHmNivSBEbL+OeuGPlgnoEJQXKxC8ZsnSHxw==
X-Received: by 2002:a05:600c:5814:b0:434:f739:7ce3 with SMTP id 5b1f17b1804b1-4390e88b7d8mr16468595e9.8.1738762496638;
        Wed, 05 Feb 2025 05:34:56 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:be8c:5293:84c1:352a? ([2001:8b0:aba:5f3c:be8c:5293:84c1:352a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390da71041sm21050445e9.27.2025.02.05.05.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:34:56 -0800 (PST)
Message-ID: <7b5e158cc6d983ec0aac8c13365572fe5a44b3d2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] add basic support for b4
 contribution workflow
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: quentin.schulz@cherry.de, Quentin Schulz <foss+yocto@0leil.net>, 
	bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Date: Wed, 05 Feb 2025 13:34:55 +0000
In-Reply-To: <abd86c0a-0c57-4425-b4c0-b8c9ba21cbea@cherry.de>
References: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
	 <abd86c0a-0c57-4425-b4c0-b8c9ba21cbea@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 13:35:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17154

On Wed, 2025-02-05 at 14:11 +0100, Quentin Schulz via lists.openembedded.or=
g wrote:
> Hi all,
>=20
> On 1/17/25 11:44 AM, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@cherry.de>
> >=20
> > b4[1] is a very nice tool for mail-based contribution. A config[2] file
> > exists to set up a few defaults. We can use it to set the Cc recipients
> > to always add, in our case the mailing list.
> >=20
> > This also adds a wrapper script that is called by b4 to figure out whic=
h
> > addresses to put as Cc recipients. Considering that patches to the doc/
> > directory also need to be sent to the yocto-docs mailing list, this
> > wrapper handles that. A limitation of the script (lsdiff actually) is
> > that it doesn't know how to handle empty files, but those should be
> > of rather rare occurrences.
> >=20
> > While the wrapper script should be enough by itself to add the bitbake
> > mailing list to the Cc recipients, one still needs to manually run b4
> > prep --auto-to-cc for that to happen. Therefore, let's add an explicit
> > send-series-cc so that at least that mailing list is always there.
> >=20
> > Because we currently do not have anything to check for patch validity,
> > remove requirement for b4 prep --check to be run before sending a patch
> > series, via disable-needs-checking in prep-pre-flight-checks.
> >=20
> > [1] https://pypi.org/project/b4/
> > [2] https://b4.docs.kernel.org/en/latest/config.html
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > ---
> > This adds a basic config file for b4 to avoid to have to add the mailin=
g
> > list by hand.
> > For documentation patches, the additional mailing list will be added
> > when running b4 prep --check, as is required for each new series manage=
d
> > by b4.
> >=20
> > Note that b4 supports patchwork, c.f.
> > https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-=
settings
> > though I have no clue what it does with it as I am no maintainer, but
> > maybe something worth having a look at if some maintainer of this repo
> > wants to use b4 to merge stuff?
> > ---
> > Changes in v2:
> > - add b4-wrapper for auto-detecting patches that are to be sent to the
> > =C2=A0=C2=A0 docs mailing list as well,
> > - disable forced b4 prep --check for each b4-managed series,
> > - Link to v1: https://lore.kernel.org/r/20240524-b4-support-v1-1-0c4334=
c36cc7@cherry.de
> > ---
> > =C2=A0 .b4-config=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> > =C2=A0 b4-wrapper.py | 38 ++++++++++++++++++++++++++++++++++++++
> > =C2=A0 2 files changed, 42 insertions(+)
> >=20
> > diff --git a/.b4-config b/.b4-config
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..0b699f204c414099f2118ff=
dbc9f7b24454e4a4e
> > --- /dev/null
> > +++ b/.b4-config
> > @@ -0,0 +1,4 @@
> > +[b4]
> > +=C2=A0 send-series-cc =3D bitbake-devel@lists.openembedded.org
> > +=C2=A0 send-auto-cc-cmd =3D ./b4-wrapper.py send-auto-cc-cmd
>=20
> All the above should be to instead of cc, will fix in next version.
>=20
> @Richard, is the b4-wrapper.py below (this one for BitBake and not=20
> Poky!) fine in BitBake git repo? I believe it should since it needs to=
=20
> be called even when one develops from "vanilla" BitBake git repo and not=
=20
> poky combo repo. Just asking for confirmation here (and maybe you want a=
=20
> different name too?).

I guess the location is ok but can we call it b4-bitbake-wrapper.py
please? This is so that if someone sends patches, it is clear which
wrapper the patch is against. Top level files in repos can sometimes
get interesting for that, even if b4 should be helping make sure the
right patches go to the right lists in future!

Cheers,

Richard



