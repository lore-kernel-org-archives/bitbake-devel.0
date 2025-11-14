Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D408DCE7AFD
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 12:17:49 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16519.1763122665677640968
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 04:17:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DzZX9LeP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so957935f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763122664; x=1763727464; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dgycdcO71ry1BIQM2ftPtxB/5w5muEPXpLwQtcmcwUU=;
        b=DzZX9LePLoMaErsHk7GtRRl4zeo+NDkb6q8OLm7aiG/V6sBiDzg7tciqYl9merCHNS
         6jbZ4pKMCIeK7o+vRu8pfsbBblMJBFeJJ9SZPNsc7hzg19Fulg0Vv6QHsGc87hahU7o3
         bCrFIXw5lAEg5Ck8vP868VKcA3PkYXFe6CfFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122664; x=1763727464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgycdcO71ry1BIQM2ftPtxB/5w5muEPXpLwQtcmcwUU=;
        b=q6V/iv9EZCsAK1N5pMUApLEXTfesqHq6ftAQ+5NonDrZsJO4G4jC2rbJUmGFionigP
         +qlCm5zmz7wBtrzu5qXriXFlH5qMvi4vVlXmz8hFN9YVi4kOEh0GkGy1rWwioGFQC8j2
         u2SLrqzyURVYHJxTE4id3qJ2GwVeOh0WftRHES6LGZSbBWl1BlbR3SpZTWNTLySTwPfq
         jPeQQtNpZoRXW4vvTz5GVM73is8Hfr5lt2AgkwpWK9m6i7JBzmbbPj1o+CJA+2iij0A1
         lElUBAD13RWRAWUm4lVvet/GZzKogZX9tq9TtPGwgZocCJ8vIBkEzEuDRt0Mhg8jwZAV
         Thnw==
X-Forwarded-Encrypted: i=1; AJvYcCWsfDDco0j0F/zSKSeYkpXo2AZKEhM3JR6Lq91VtEY0h9Y5f9e9yzzj9Wx8NCWg2/ymG5AqewlYdjjkkrcg@lists.openembedded.org
X-Gm-Message-State: AOJu0YywuF8/a/AIw76p0o0AKzLpA/Wr62LSnLbftQAn0FABMzUBGIWf
	eb6tTPOgwKOqr7H1ynRCxNj6nguHc9bzoIRlq0KHViysByR4RI3vWpdYVSsRCZb1710=
X-Gm-Gg: ASbGncu2xb+FRJKrV/C/DZQqRqz6C64B2faudhLZduWcCl4p1gdHG4EUrwODBVzGMNT
	CVpGq48ePR+UuXR8VHNwY0oWv4tSAyLqyOx3U18JGgBsJHM+tTrZWYF4keZABeAp11q20xoeW3x
	QPoI4Ve6H3dWxAUTAfV+T7WL2aGT4YRXqz2kaAqYS5Qq/OakE4Z+vgSrtlZWDIAWht0FI1w/dDG
	Zpl6vANYkT5Q1pk43HYNdS8xu9QJZ4PTe7kesUOB2ykDdHN3KqZLov/VOop5mj4KSw7NWsIqqBY
	o6W+FftP+c3MCsmywxd9pvZfjTtZr9piC3MjfPam8LHLLYRRtlxt+AiiJ+dFPUygfw2+S1eJ+E0
	P1ElNbVzwdcS9BBLqLy16zPUoQVcyGwOL7FRhbBaNFb9FoZknQ42sec1FUXgOHk1uj2jDvG3lS3
	ZNWZG7tO4XI73Bm4Usg9q66ZqRpIdG78JO/2E7fbNkUKguAhwD5N3Eu+P4k2nqkeQWMvNaTn7Sm
	Hw=
X-Google-Smtp-Source: AGHT+IF6t5bHrRPIkxd/6fLiYZBGKSLbnm/IDyGHa5sRLMWIadczk4BuvByd7Le3CpdxJmo7bCIMRA==
X-Received: by 2002:a5d:584e:0:b0:42b:2e94:5a90 with SMTP id ffacd0b85a97d-42b5936c3bamr3429998f8f.36.1763122663889;
        Fri, 14 Nov 2025 04:17:43 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e30a:8116:32e6:5cd2? ([2001:8b0:aba:5f3c:e30a:8116:32e6:5cd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f2084dsm9925920f8f.42.2025.11.14.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:17:43 -0800 (PST)
Message-ID: <ff4f9fa86f6db5966b40c8169131c13cbf404994.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com
Date: Fri, 14 Nov 2025 12:17:42 +0000
In-Reply-To: <1877DE8BA2A633E6.930811@lists.openembedded.org>
References: <20251114060211.1742728-1-Qi.Chen@windriver.com>
	 <1877DE8BA2A633E6.930811@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 12:17:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18399

On Fri, 2025-11-14 at 12:14 +0000, Richard Purdie via lists.openembedded.or=
g wrote:
> On Fri, 2025-11-14 at 14:02 +0800, Qi.Chen@windriver.com=C2=A0wrote:
> > From: Chen Qi <Qi.Chen@windriver.com>
> >=20
> > When an internal fragment is enabled, and there's already a value
> > for the corresponding variable, we should error out to avoid any
> > confusion.
> >=20
> > For example, when 'machine/qemux86-64' fragement is enabled, and
> > we get some "MACHINE =3D xxx" in local.conf or env, we should error
> > out and recomment users to use 'bitbake-config-build disable-fragment'.
> >=20
> > We should be tolerating weak assignments. For example, DISTRO defaults
> > to "nodistro", and when 'distro/poky" fragment is enabled, there should
> > be no confusion.
> >=20
> > The implementation hacks the environment variable as a way to tell
> > bitbake that we're using 'bitbake-config-build'. Because we recommend
> > users to use bitbake-config-build, then it should not error out.
> >=20
> > Fixes [YOCTO #16060]
> >=20
> > Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> > ---
> > =C2=A0bin/bitbake-layers=C2=A0 | 3 +++
> > =C2=A0lib/bb/parse/ast.py | 7 +++++++
> > =C2=A02 files changed, 10 insertions(+)
>=20
> Thanks, I think this is a step in the right direction but I can see the
> challenge you're facing with the parsing. There are probably other bugs
> in this area, for example what if there is an invalid fragment set (you
> delete a fragment file, then try to disable it with bitbake-build-
> config?).
>=20
> What might be a slightly "nicer" approach would be to pass the toolname
> into the bitbake datastore as some variable (BB_TOOLNAME?) from
> tinfoil, then we might want to skip all of the fragment code if
> bitbake-config-build is in use?
>=20
> We'd have to check what other implications that might have, for
> example, does bitbake-build-config need a full datastore? What are the
> implications for bitbake's cache files and cache file hashes?

I did have a couple of other ideas:

a) we could pass in options to tinfoil. We could have a
fragements=3DTrue/False parameter and allow this tool to disable those.

b) we could add a new CookerFeatures option to disable fragments.


I'm kind of leaning to b) since this was the existing designed in
mechanism to change things like this.

Cheers,

Richard

