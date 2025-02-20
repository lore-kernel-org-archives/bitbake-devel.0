Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E87BC021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 10:22:41 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.46232.1740046955119620572
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 02:22:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bFySkeMG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so867702f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 02:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740046953; x=1740651753; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kpesj4HAO7WOJIdsFCMaw76jKBxw0fTG5s/Z7xr46oE=;
        b=bFySkeMGd/J8hiSewTxbcTLXj/Ka6KIQTLyI10IjMDXT6//Y8QCjchpOTEliVxxiYy
         UuKmrrQ8ra1bpud5wu/sMOHLgxA0GvQekQMfaxN1YqzlfLrkD6cjyTZYLyp5wGW2f5rt
         tylHs4Tw3k6q7hRI80fxRltCMW1Wi2nIMWxl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046953; x=1740651753;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kpesj4HAO7WOJIdsFCMaw76jKBxw0fTG5s/Z7xr46oE=;
        b=bF2CKYtgApxUlJ6LUCo0G/QdlGErRz9CGb7SU4Rt9AI3q3C1XbTtKWgiwtCgCmnpvU
         +zhXp90k//LcmT4bFfnxAmbBnGRirS8R1R3W5upKMMwymCaOFOEB3ZlUHY6nK0vNPsHj
         8r2Cwt1G7V8KiZZARWETEtvv0tnDqvKcA86vcO/h/Bet8vasEm1fXWw04P5oWF0XKDKo
         xJAJeEiEW6ZTGipbAOBDRl5CXDtq38kWV63LT4b/BrH1TUXYIG+JWF6UX7YtBEkv0Lpm
         xus3etarq679lPFYyVoZ3iCEFPYmWtJzy7p/Mouh86U5oBiBkaZKut8mNmGy4B0z1A4v
         z9aA==
X-Forwarded-Encrypted: i=1; AJvYcCWBfH59Poxo5eGKlKNCum7o1YDMZPAeG+y96f2HR9h9pt0m0XcMi/7cVyd4/tplTBuCEy6xP5le2AoNbNNq@lists.openembedded.org
X-Gm-Message-State: AOJu0YxGqK7JVNkMKDJ/CYzdcp2LXx6GCZdolgNPA+OIrPL2JYNLDt9d
	mkt+cXLujBkw21NquqDoGH8hDYM08DGXEarPcmSUws/LghDiuvVFe5tBRe6wFoo=
X-Gm-Gg: ASbGncuakE+HCTDhwI5qmp/k9BfpsZ5yMFq1xrDuSdzBtqcdsml5BfGE92KD4XjWxaE
	jHwHVMNVuqg1NWSRla2HQN2buUocYjMTH93aIa335K/ndAkKU2gLhNtTvWB6HE99YWMnao2g9uj
	x30PezOX6Fg9dT75gOr04ajvdMDs/mGmU6aBns6C+n7zxzNTi6RIhjHFPHfU4cg2GX1UXrdy+j5
	3lU4ofCizd/dOp/zMShcSvalVsH1nkPsV+XDaxet0ZCc7p6Ta9ArzM8QMwYEr5Q6lRev8LRIGOm
	GegrYqZtFcGjYLCPsju+RsTcFmVHfiqRci0zDKGprml7yK67tUhBtBX5pWV2nDOwJOg7xqvrIGG
	DkKCH
X-Google-Smtp-Source: AGHT+IEZ6bQpWKDs9j/9dycqtkLoNVeh6X4io2jic/qLDNp7ETSlOH3mJW2swSx4dyLHENxbSbVDhA==
X-Received: by 2002:a5d:638d:0:b0:38d:d2ea:9579 with SMTP id ffacd0b85a97d-38f33f5651dmr17161427f8f.46.1740046953251;
        Thu, 20 Feb 2025 02:22:33 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:da41:7167:18bf:b7c5? ([2001:8b0:aba:5f3c:da41:7167:18bf:b7c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c36sm20450819f8f.67.2025.02.20.02.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:22:32 -0800 (PST)
Message-ID: <d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 00/15] Make mirror replacement
 syntax explicit
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Thu, 20 Feb 2025 10:22:31 +0000
In-Reply-To: <027ed1ac-02ae-420b-a65f-d4e48bc86136@weidmueller.com>
References: 
	<20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org>
	 <027ed1ac-02ae-420b-a65f-d4e48bc86136@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 10:22:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17252

On Wed, 2025-02-05 at 13:12 +0100, Stefan Herbrechtsmeier wrote:
> =C2=A0Am 05.02.2025 um 11:34 schrieb Richard Purdie:
> =C2=A0On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists=
.openembedded.org wrote:
> > > The mirror replacement syntax contains many implicit transformations.
> > > The path of the URI always contains the base name of the downloaded
> > > filename. This makes it impossible to rename or remove the base name =
of
> > > the original path. It prevents upstream mirror for SRC_URIS with a
> > > downloadfilename parameter. The base name of the downloaded filename
> > > makes it impossible to use the download mirror for SRC_URIs with
> > > subfolders in the downloadfilename parameter. Altogether the implicit
> > > transformation complicates the understanding of the replacements.
> > >=20
> > > This series adds an additional replacement named DOWNLOADFILENAME. Th=
is
> > > replacement contains the relative filename of the downloaded file or
> > > mirror archive for git and hg. This allows the user to explicitly def=
ine
> > > the behavior. The usage is equivalent to the PATH replacement for the
> > > sstate mirror from file to https scheme.
> > >=20
> > > git://.*/.*=C2=A0 http://downloads.yoctoproject.org/mirror/sources/DO=
WNLOADFILENAME
> > > https?://.*/.*=C2=A0 http://downloads.yoctoproject.org/mirror/sources=
/DOWNLOADFILENAME
> > > file://.*=C2=A0 https://sstate.yoctoproject.org/all/PATH;downloadfile=
name=3DPATH
> > >=20
> > > Without a replacement variable the mirror will use the same base name=
 as
> > > the origin SRC_URI. This allows the usage of private package manager
> > > registry together with a downloadfilename parameter or the rename of =
the
> > > base name.
> > >=20
> > > https://registry.npmjs.org/=C2=A0 https://example.com/npm/registry/
> > > https://example.com/example/1.0.0.tgz=C2=A0 https://example.com/examp=
le/example-1.0.0.tgz
> > >=20
> > > The series adds heuristics to keep a backward compatibility to common
> > > styles. Because of the ambiguity of the old style, it is advisable to
> > > remove this compatibility sooner or later to avoid unexpected behavio=
r.
> > > =C2=A0
> > Thanks for the patches, these look interesting with some good
> > improvements in there. A lot of the series looks like cleanups and
> > those look like good fixes to have. It may make sense to split this
> > series into two, the cleanups/fixes and the behaviour changes.
> >=20
> > I'm not entirely "sold" on the naming of DOWNLOADFILENAME. You have to
> > think about this from the perspective of someone writing a MIRROR or
> > PREMIRROR entry - would they understand what that means vs some of the
> > other names?
> > =C2=A0
> I=E2=80=99m open for suggestions. Even ARCHIVE or TARBALL are hard to
> understand because it is only a relative path on the download mirror.
> Alternative we can mark the lines as upstream or download mirror and
> give the replacement different meanings. The path could be the
> original PATH for an upstream mirror or the relative path of the
> downloaded file for the download mirror.

I've been giving this topic some thought. One idea I wondered about was
to instead markup the mirror urls with how they're expected to work
with a new parameter. For example:

git://.*/.*  http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=
=3Dmirrortarball

The possible options would be something like:

mirrortarball - mirror tarballs taken from DL_DIR
flattened - copy of DL_DIR so DL_DIR layout (maybe call it dldir?)
upstream - layout is the same as the upstream directory structure so a dire=
ct url replacement

If using a mirrortarball mirror url, we'd know to use the values from
urldata.mirrortarballs. We could add parameters to the fetcher to have
two parameters, one will be the DL_DIR path and the other would be the
upstream url path. One key question I have is how we might need to
shorted the url path for some mirror urls to add/remove a path prefix
in the mirroring.

I think that would cover most of our scenarios and make the mirror urls
much more useful/explicit.

It also would give us a migration path as the code can simply error if
it sees a mirror url without a mirrorformat parameter. This may mean we
could have a clean slate for the mirror urls and switch to one clear
format. I think we can make a case for such a breaking architecture
change.

To move it forward we'd need to work out which pieces of mirror syntax
we should drop, which mirror replacement strings we need (I'm not
convinced the current ones are right/useful). We'd probably need a some
proof of concept patches showing it in action and a proposal to the oe-
arch list explaining why the change was needed and what the change
would do/look like.

I think this can be done independently of the other fetcher/vendor
changing but should be able to work for the vendoring issues too.

Thoughts? I'm sure I'm missing things here :/.

Cheers,

Richard



