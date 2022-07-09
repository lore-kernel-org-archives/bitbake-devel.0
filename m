Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0053C433EF
	for <webhook@archiver.kernel.org>; Sat,  9 Jul 2022 13:20:36 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.6230.1657372829481092928
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 Jul 2022 06:20:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PaPhIcoL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f46.google.com with SMTP id mf4so705635ejc.3
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 Jul 2022 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=z0OOn+zMD/zBEwV5+y9fVp/lf2fXtIWy9JHXUx12tSI=;
        b=PaPhIcoLZY9rYbutwh/kiek+uRQjIFboy5zDupxi/nIyzN74izqf5puRDTtzG4bWYF
         i3PHQd7QRkpHP9tf9s6UXqhZSRapcCuNrZQERsBrJQtGJjOi+tzufuvQw4nRIAskcdK4
         deZuY1jDSEQZGAd2++zxgjWm67TDC04eQYuJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=z0OOn+zMD/zBEwV5+y9fVp/lf2fXtIWy9JHXUx12tSI=;
        b=clQRad/LiAKkxMfv9Rq13IhSGLTj+pswcun0+rxD2SAK30eWMLNP16JKPnHwQOs9qw
         MpaZUb64qPSJIXck1S2PlsBBSPcpOMfxDHezrvPkj5i4ahjkHO8f1IXhH/gv+Fe6rpCb
         sgxwp2ftj4LSKIhpgBJBm93TMM7NKW8kInZzZlVc7Sjp5PuNlVZly4XME6MXjSrJhKgh
         cae7FE8R4U35C4Yd3fKQ5m7mO2APcAXO0MLsDBL7+zpO2WDuPqdslG6KZqHHILmW+Wzk
         lqziePS/KXKbMYQFH2muiYfZio9MvScKG1JW0CD5e2s9vk+RNHxrECLS8ISFw7si+ib5
         oOvw==
X-Gm-Message-State: AJIora8AkO0R/IfvmkGGoRbmpELmKD2H7ZiIquhToOcySC+Non3bExsV
	HLFp9MiInnugsVF0JHiFQeffyA==
X-Google-Smtp-Source: 
 AGRyM1vFMbyGW16an3XIYFdycIqJs0fmZNE4OGq+v5OrEuuszOhgDwEw41NMONMKHv5u0YZktttTtg==
X-Received: by 2002:a17:907:b17:b0:72a:edb8:7529 with SMTP id
 h23-20020a1709070b1700b0072aedb87529mr8714685ejl.749.1657372827602;
        Sat, 09 Jul 2022 06:20:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a5a8:564c:c2df:f45c?
 ([2001:8b0:aba:5f3c:a5a8:564c:c2df:f45c])
        by smtp.gmail.com with ESMTPSA id
 lb7-20020a170907784700b0072b1738a1d7sm591633ejc.214.2022.07.09.06.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 06:20:26 -0700 (PDT)
Message-ID: 
 <bd23c5b5baedb0d3ebfcc9dc437260ab3b7e6d00.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch2: local files only in DL_DIR
 becomes fatal error
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paulo Neves <ptsneves@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Sat, 09 Jul 2022 14:20:25 +0100
In-Reply-To: <a7dffab1-9b0c-fab8-a538-81c3d0065834@gmail.com>
References: <20220708205407.1680137-1-ptsneves@gmail.com>
	 <c677e1a7cedcd974e9ecd6b0bb4aefdcd240932f.camel@linuxfoundation.org>
	 <CAJO0J4g4cyPLGEQ1s4v8cMk0RTgGKGtoh3GME=9Sx+D0KQLX3A@mail.gmail.com>
	 <a7dffab1-9b0c-fab8-a538-81c3d0065834@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 Jul 2022 13:20:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13818

On Sat, 2022-07-09 at 13:12 +0200, Paulo Neves wrote:
> =C2=A0
> =C2=A0
> On 7/9/22 09:19, Paulo Neves wrote:
> =C2=A0
> > =C2=A0
> >=20
> > =C2=A0
> > On Sat, Jul 9, 2022, 08:52 Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > =C2=A0
> > > On Fri, 2022-07-08 at 22:54 +0200, Paulo Neves wrote:
> > > =C2=A0> When trying to checksum local files, if a given file is not
> > > found
> > > =C2=A0> anywhere else than the DL_DIR then this means that the the
> > > build is
> > > =C2=A0> inconsistent, and unreproducible.
> > > =C2=A0>=20
> > > =C2=A0> This also means that if the DL_DIR is removed or not availabl=
e
> > > the
> > > =C2=A0> build does not know how to fetch the file and will fail. With
> > > this
> > > =C2=A0> commit we fail earlier and consistently on this condition.
> > > =C2=A0>=20
> > > =C2=A0> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> > > =C2=A0> ---
> > > =C2=A0>=C2=A0 lib/bb/fetch2/__init__.py | 4 +++-
> > > =C2=A0>=C2=A0 lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0| 7 +++++++
> > > =C2=A0>=C2=A0 2 files changed, 10 insertions(+), 1 deletion(-)
> > > =C2=A0>=20
> > > =C2=A0> diff --git a/lib/bb/fetch2/__init__.py
> > > b/lib/bb/fetch2/__init__.py
> > > =C2=A0> index ac557176..5f05278a 100644
> > > =C2=A0> --- a/lib/bb/fetch2/__init__.py
> > > =C2=A0> +++ b/lib/bb/fetch2/__init__.py
> > > =C2=A0> @@ -1233,7 +1233,9 @@ def get_checksum_file_list(d):
> > > =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if f.startswith(dl_dir):
> > > =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 # The local fetcher's behaviour is to
> > > return a path under DL_DIR if it couldn't find the file anywhere
> > > else
> > > =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if os.path.exists(f):
> > > =C2=A0> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn("Getting checksum for %s
> > > SRC_URI entry %s: file not found except in DL_DIR" %
> > > (d.getVar('PN'), os.path.basename(f)))
> > > =C2=A0> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bb.fatal(("Getting checksum for %s
> > > SRC_URI entry %s: file not found except in DL_DIR."
> > > =C2=A0> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " This means there is no way to
> > > get the file except for an orphaned copy"
> > > =C2=A0> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " in DL_DIR.") % (d.getVar('PN'),
> > > os.path.basename(f)))
> > > =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 else:
> > > =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn("Unable to get checksum for
> > > %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'),
> > > os.path.basename(f)))
> > > =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 filelist.append(f + ":" +
> > > str(os.path.exists(f)))
> > > =C2=A0
> > > =C2=A0Did you manage to trigger that error in a real world use case?
> > > =C2=A0
> > > =C2=A0I've just been looking at this code and it is horribly old and
> > > =C2=A0outdated. I can't help wonder if we shouldn't do something a bi=
t
> > > more
> > > =C2=A0invasive to clean it up a bit more. I suspect it does some of
> > > these
> > > =C2=A0things for old/obsolete reasons...
> > > =C2=A0
> > > =C2=A0I ask since I'm wondering if anyone ever hits these code paths
> > > in a
> > > =C2=A0valid usecase.
> > > =C2=A0
> > > =C2=A0Thanks for working on it, we do need to improve some of these
> > > things.
> > > =C2=A0
> > > =C2=A0Cheers,
> > > =C2=A0
> > > =C2=A0Richard
> > >=20
> >=20
> > Hey Richard,=C2=A0
> >=20
> > I think these codepaths are hit on mostly on bugs(bad uri parsing)
> > or bad files(bad permissions).
> >=20
> > The use case i added on the tests is also clearly bad, but I have
> > seen builds going on for very long in the state of warning, which
> > becomes fatal with the patch, because the dl_dir was stable and
> > used by all users. So expect this patch to increase the reports of
> > latent issues people just ignored.=C2=A0
> >=20
> > Yesterday I also hit this warning organically exactly on the
> > situation of the test: a directory mentioned on the SRC_URI which
> > did not exist in any FILESPATHS but somehow existed on the dl_dir.
> > So it is real.=C2=A0
> >=20
> > I will investigate the whole default to dl_dir if not found and
> > remove it if I cannot find a good reason.
> >=20
> > Paulo Neves=C2=A0
> =C2=A0
> =C2=A0I did some archeology trying to find why DL_DIR has anything to do
> with the local fetcher and the reason probably comes from this[1] and
> this[2]. The commit is about sstate cache and i think it considers
> DL_DIR as valid mirror directory in agreement with
> lib/bb/fetch2/README[2].=20
> =C2=A0
> =C2=A0The problem is that [3] from the same README "spec", is either
> contradictory with with [2], senseless, or accurate depending on the
> usage of the local file:// fetcher. For a SRC_URI file, what it is
> senseless to search DL_DIR if we have the FILEPATHS? If it is not at
> hand and only in the DL_DIR then it is irreproducible and contradicts
> [3] (the case this patch argues for).

sstate.bbclass sets DL_DIR to SSTATE_DIR in the context of sstate
downloads.=C2=A0It also puts SSTATE_DIR in FILESPATH which I suspect it did
not back in 2011. I therefore suspect we now have a better fix for the
issue as FILESPATH is set and the change from 2011 is now obsolete for
sstate. Or I hope so anyway!

Cheers,

Richard




