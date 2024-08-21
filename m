Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53000C52D6F
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 10:32:23 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.16883.1724236339808154038
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Aug 2024 03:32:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gON+yiWi;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efd8807aaso8327550e87.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 03:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724236338; x=1724841138; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bF2PJLSWUZ4uAKxmRg82bGDJ2w7nwBlpfTko3gYxC8=;
        b=gON+yiWi2D1VBRTaCSOMz7rXL6vFjRTSOvFK2MTsb5OkunpzKBPh0Pwz13LWYmO3hn
         RU+0lLuZo8Xm5mJx8gHTjUorvlh8N7ZODXLjDkdOwauvciCy8fPm+c/aEa7SiKsrlfCY
         MQMHV/7H2eFrVXf4Cxg0QfKwGgTv817Kadjpo0MceoZfP9LCixlWLId+EDh64ZSDDSXN
         INSnSq5zvC7UoWK44B0Q3BKCf2SdSx2RJn8O0/tFIH6SKM3Mvh70eyf4WydiNXbeU0Jw
         UNMmyPkTBfCr1YFNCseGTq5OB9nzqwUyY4o3g4ZolYbBPidvA2fgYSq0miN/GuIWJkkS
         r2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724236338; x=1724841138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bF2PJLSWUZ4uAKxmRg82bGDJ2w7nwBlpfTko3gYxC8=;
        b=n0USVsZ83NPGxsah9yCrthQsiRHf1msyl3o0JG/zj774j+DblMoR7A15rtOcCx0PzN
         iRtCca7TZMmsovJSD9l1G6jMBFC1Lk+VMKBSvBKMqFMQDItriWD/sqtzIFoTGoLonUTG
         6iOvFgXSb41Cc4wPsy0mAXAwHZiTF+OsZGljEom7uyUZB+ZIiXS0QnSskvvHayhEGbAn
         XmJFLHi+88GLSwx+CN1a86JhVlS4/N/G/mhZg1Mgz8ZnQmoHM4b2IdCP+d628gIXnMfQ
         +S9ySsBxWaJPRStRC4qEIIZ45HaRD7M2Phw5FqpccmvUUjhFxvoUvjIh3gi0wK1OtvW1
         hecA==
X-Forwarded-Encrypted: i=1; AJvYcCWNd6jZCB93xOD5JJYw72yI7ZVcR/0RculGktiNLvDEk3yCFpPOK5oD3l3FfoUe8Sp5D1apgp+4tz7SK/hG@lists.openembedded.org
X-Gm-Message-State: AOJu0YzqjdtCEzYFyH649o4uyiYS4xX3eGBYxG4bhpxWXJ3ZdUxgBi0Q
	8YFdAWSdQbJoXtggsxQx6Ybi4C6//FWGyyElY0lHeFmMTrDkUwfMRJ5dHOMIz0CMkB7vvnReeMr
	o1epm7Am6p2DGtnpedKvsm8dmxbE=
X-Google-Smtp-Source: AGHT+IG+ATJpADWvTn0rRjj0LFfbaOYGOHAXDt7anXItdRcW1aGnMBqYb2Uucc2fHxXbuGCpIzrEd7v7TxcZMfRl4To=
X-Received: by 2002:a05:6512:2212:b0:533:32b4:ca6f with SMTP id
 2adb3069b0e04-53348565364mr889946e87.34.1724236337367; Wed, 21 Aug 2024
 03:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240812122539.573337-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <0e0d0b28d207d2bcb20180aa4c187e10ddc694c3.camel@linuxfoundation.org>
 <c2136d36-fac4-401d-9220-0f227260ef2d@savoirfairelinux.com>
 <b89f6243322fc0e72ae6a9773c437ee598d773e4.camel@linuxfoundation.org>
 <AS4PR08MB8046E1B791A39B4751C4D732958E2@AS4PR08MB8046.eurprd08.prod.outlook.com>
 <028bd9ca-a8ca-4d8d-87a9-00d19232855b@savoirfairelinux.com>
In-Reply-To: <028bd9ca-a8ca-4d8d-87a9-00d19232855b@savoirfairelinux.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 21 Aug 2024 12:32:06 +0200
Message-ID: <CANNYZj_1n5x9K6XWe+T6DNSjwNkucCqz0oNiL9yL6xKgzOs+jQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v4 2/2] npmsw: accept unspecified versions
 in package.json
To: enguerrand.de-ribaucourt@savoirfairelinux.com
Cc: "Herbrechtsmeier, Stefan" <Stefan.Herbrechtsmeier@weidmueller.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	"tanguy.raufflet@savoirfairelinux.com" <tanguy.raufflet@savoirfairelinux.com>, 
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 10:32:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16506

This still doesn't entirely compute. We do have npm fetcher tests in
bitbake, but they test for existence of 'npm', and are skipped if npm
is not there. And so they're never run on the autobuilder, and npm
fetcher regularly regresses.

On the other hand, you seem to be claiming that the fetcher does not
require npm. But then this skipping is unnecessary and should be
dropped, and all tests should pass.

Once we resolve that point, we should ensure that tests do check both
possibilities:

- modules that have checksum information result in a successful fetch opeta=
tion
- if something does not have such information, the fetch fails, and
that is interpreted as the test succeeding

This would reassure everyone that the fetcher does fulfil source
integrity requirements a lot more than a hand-written description of
how it operates.

Alex


On Wed, 21 Aug 2024 at 12:08, Enguerrand de Ribaucourt via
lists.openembedded.org
<enguerrand.de-ribaucourt=3Dsavoirfairelinux.com@lists.openembedded.org>
wrote:
>
>
>
> On 21/08/2024 10:42, Herbrechtsmeier, Stefan wrote:
> > Hi,
> >
> > I'm not that deep into the topic anymore, but I can hopefully explain s=
ome implementation details.
> >
> >> -----Urspr=C3=BCngliche Nachricht-----
> >> Von: Richard Purdie <richard.purdie@linuxfoundation.org>
> >> Gesendet: Dienstag, 20. August 2024 18:00
> >> An: Enguerrand de Ribaucourt <enguerrand.de-
> >> ribaucourt@savoirfairelinux.com>; bitbake-devel@lists.openembedded.org
> >> Cc: tanguy.raufflet@savoirfairelinux.com; alexandre.belloni@bootlin.co=
m;
> >> Herbrechtsmeier, Stefan <Stefan.Herbrechtsmeier@weidmueller.com>
> >> Betreff: [EXTERNAL] Re: [bitbake-devel][PATCH v4 2/2] npmsw: accept
> >> unspecified versions in package.json
> >>
> >> CAUTION: This email originated from outside the organization. Do not c=
lick
> >> links or open attachments unless you recognize the sender and know the
> >> content is safe.
> >>
> >>
> >>
> >> On Mon, 2024-08-19 at 09:58 +0200, Enguerrand de Ribaucourt wrote:
> >>> On 15/08/2024 16:12, Richard Purdie wrote:
> >>>> On Mon, 2024-08-12 at 14:25 +0200, Enguerrand de Ribaucourt wrote:
> >>>>> Our current emulation mandates that the package.json contains a
> >>>>> version field. Some packages may not provide it when they are not
> >>>>> published to the registry. The actual `npm pack` would allow such
> >>>>> packages, so should we.
> >>>>>
> >>>>> A first commit was required in the npm class.
> >>>>>
> >>>>> For the shrinkwrap part , we can actually use the resolved field
> >>>>> which contains the exact source, including the revision, to pass
> >>>>> integrity tests.
> >>>>>
> >>>>> v3:
> >>>>>    - Split bitbake npmsw.py modification in another commit
> >>>>>
> >>>>> Co-authored-by: Tanguy Raufflet
> >>>>> <tanguy.raufflet@savoirfairelinux.com>
> >>>>> Signed-off-by: Tanguy Raufflet
> >>>>> <tanguy.raufflet@savoirfairelinux.com>
> >>>>> Signed-off-by: Enguerrand de Ribaucourt
> >>>>> <enguerrand.de-ribaucourt@savoirfairelinux.com>
> >>>>> ---
> >>>>>    bitbake/lib/bb/fetch2/npmsw.py | 2 +-
> >>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/bitbake/lib/bb/fetch2/npmsw.py
> >>>>> b/bitbake/lib/bb/fetch2/npmsw.py index d8ed9df327..a5fa598deb
> >>>>> 100644
> >>>>> --- a/bitbake/lib/bb/fetch2/npmsw.py
> >>>>> +++ b/bitbake/lib/bb/fetch2/npmsw.py
> >>>>> @@ -97,7 +97,7 @@ class NpmShrinkWrap(FetchMethod):
> >>>>>
> >>>>>                integrity =3D params.get("integrity", None)
> >>>>>                resolved =3D params.get("resolved", None)
> >>>>> -            version =3D params.get("version", None)
> >>>>> +            version =3D params.get("version", resolved)
> >>>>>
> >>>>>                # Handle registry sources
> >>>>>                if is_semver(version) and integrity:
> >>>>
> >>>> I'm not convinced by this reasoning. The whole point of our SRC_URI
> >>>> is to precisely define something that is being built. I think this
> >>>> allows floating versions of dependencies and hence makes this non-
> >>>> reproducible?
> >>>
> >>> The version declared in package.json is purely declarative for the NP=
M
> >>> package registry. The basic Yocto fetchers will still be used for
> >>> downloading the SRC_URI (https, git, ...), with the same version
> >>> reproducibility mechanisms like git hash or md5sum.
> >>>
> >>> In the npm.bbclass, we have a second fetch stage (actually during
> >>> do_configure) to fetch all the dependencies. The npm class here
> >>> behaves wildly differently than regular frameworks where each
> >>> dependency is a separate recipe. But since there are myriads of
> >>> dependencies in the NPM world and it would be rare to share them, the
> >>> current recipe class is intended to package an application with all
> >>> its dependencies using the NPM registry.
> >>>
> >>> To fetch all those dependencies, we rely on the NPM dependencies
> >>> mechanism of package.json which lists packages with their declarative
> >>> version. However this is not reproducible. NPM provides two additiona=
l
> >>> files that NPM developers should include in their repositories to pin
> >>> the whole dependency tree: package-lock.json and npm-shrinkwrap.json.
> >>> The npm recipetool will fetch the dependencies the first time with
> >>> package.json information, and produce an npm-shrinkwrap.json file tha=
t
> >>> pins all versions.
> >>
> >> Are you saying that the codepath in question is only used to generate =
the
> >> npm-shrinkwrap.json file and that a normal do_fetch and a normal build=
 will
> >> not fetch any floating version?
> >
> > The npm-shrinkwrap.json is generated by npm. In contrast to rust and go=
 the lock file isn't processed during recipe creation but during build. Thi=
s leads to the problem that the recipe author need to fix the npm-shrinkwra=
p.json.
> >
> > The npm-shrinkwrap.json is a common lock file and locks the download so=
urces. It contains the download source inside the `resolved` field [1]. In =
case of git it contains the full git url with commit sha. This means the fe=
tch use an unspecified release version but not a floating version.
> >
> > [1] https://docs.npmjs.com/cli/v10/configuring-npm/package-lock-json#pa=
ckages
> >
> >
> >> I appreciate the npm build itself might not be deterministic but the p=
oint of
> >> our SRC_URI is to make it deterministic.
> >>
> >> I'm also worried that you implied fetching is happening during do_conf=
igure.
> >> That should not be the case and if that is happening, it needs to be c=
hanged so
> >> that all fetching happens during do_fetch.
> >
> > The npm command in do_configure fetches the packages from a local tempo=
rary repository. The local repository is filled by pre fetch packages. The =
packages are fetched during do_fetch. Therefore bitbake parses the npm-shri=
nkwrap.json during fetch and creates a list of fetch uris on-the-fly .
> >
> >
> >>> Back to our commit, we do not change the aforementioned behavior, we
> >>> only make it compatible with packages which do not declare a version
> >>> in their package.json. The npmsw.py code wants to have a version to
> >>> validate what's being downloaded, so we pass a dummy version. But the
> >>> npm-shrinkwrap.json file, generated by npm native, still contains the
> >>> reproducible metadata. Example here with a package that doesn't
> >>> declare a version field: NPM still added integrity and resolved field=
s
> >>> which will ensure reproducibility:
> >>>
> >>> ```
> >>>       "node_modules/cockpit-repo": {
> >>>         "name": "CockpitDevelopmentDependencies",
> >>>         "resolved":
> >>> "git+ssh://git@github.com/cockpit-
> >> project/cockpit.git#d34cabacb8e5e1e028c7eea3d6e3b606d862b8ac",
> >>>         "integrity":
> >>> "sha512-
> >> 4nBWhDtVLwF++ZPY/67QtpsXc9y/Jpa/jj1LW/gScSafDKoHmtg1BwAQ7sqpN/
> >>> fdyi1xrkysM9hxLq3Q16ofaw=3D=3D",
> >>> ```
> >>>>
> >>>> We should probably error if a version cannot be found and force the
> >>>> user to add one?
> >>> An NPM project can typically pull hundreds of dependencies with some
> >>> not declaring a version, the user would need to submit patches to all
> >>> of their upstreams to fix that which is challenging. Meanwhile, the
> >>> real NPM tool is perfectly fine with accepting that, as illustrated
> >>> above. I believe we should hence behave like the official NPM tool.
> >>
> >> I'm not asking for the upstream NPM projects to be locked down. I'm as=
king
> >> that our recipes always have versions specified. This is similar to wh=
at we do in
> >> other places like crates with carg under rust, which probably is the b=
est
> >> example of how we can lock down situations like this.
> >
> > The rust solution has the advantage, that the lock is parsed during rec=
ipe creation and the recipe author can rework the result.
> >
> > But the real problem is that the project wasn't published to the regist=
ry and has no release. Both cargo and npm support git repositories without =
a version. Maybe the parser should set the version to `0-git<short git comm=
it sha>` and extract the hash from the `resolved` field.
> We do declare a dummy version in another patchset somewhere else indeed
> to pass some checks and allow building such packages. However in this
> specific place, the version field is what's used to fetch the packages
> and it needs a URL (git://, ...) which is conveniently provided by the
> `resolved` field!
> >
> > Regards
> >    Stefan
> >
> > ________________________________
> > Kommanditgesellschaft - Sitz: Detmold - Amtsgericht Lemgo HRA 2790 -
> > Komplement=C3=A4rin: Weidm=C3=BCller Interface F=C3=BChrungsgesellschaf=
t mbH -
> > Sitz: Detmold - Amtsgericht Lemgo HRB 3924;
> > Gesch=C3=A4ftsf=C3=BChrer: Dr. Timo Berger, Volker Bibelhausen, Dr. Seb=
astian Durst, Andr=C3=A9 Sombecki;
> > USt-ID-Nr. DE124599660
>
> --
> Savoir-faire Linux
> Enguerrand de Ribaucourt
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16505): https://lists.openembedded.org/g/bitbake-deve=
l/message/16505
> Mute This Topic: https://lists.openembedded.org/mt/107855179/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

