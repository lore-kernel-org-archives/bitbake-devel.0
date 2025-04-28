Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097D9C369DC
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 21:10:02 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.60295.1745874591700877717
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Apr 2025 14:09:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=a9FPw6xI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so4036319f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Apr 2025 14:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745874590; x=1746479390; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS0XvI2iM+990BRInVrlyBwiZv7FPVTuDRxiQVxKmQQ=;
        b=a9FPw6xI8EKIX2mpGOtMXiIF2mWS3bc9pcZYccgDHd6ukSa3NO+9V63znsct4uF7Jq
         AXpWqSbL2fhZ9P6zMf4ynqPilv8j14VrqVxv+OLq/O+yY7jmlBw/wIAQqd76TulPaHdk
         neDQBpTh7aysbzKqSF8tZZrS1QQfL5FNYH5do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745874590; x=1746479390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nS0XvI2iM+990BRInVrlyBwiZv7FPVTuDRxiQVxKmQQ=;
        b=RAAquBeKSHjiPbtd5F9nlqyI/2XPNOpkrlOuVLSGFSBbBPBZY7HC2B6V+DJdc6DnNl
         IXuoOPEInKh+0MWyLjxKj8CPvEEbuifzd9ZJfk02IIVwqNfjcevhODJurvSo/CqN5WxI
         PV1qKBHHU/Car+sqGdWPydX9kw1rdyLfIv85irgN3lI2gjf1z8knikfkHoqhj/tJnJy4
         aSaV2N3Hsb/4f328XTIhysRzZ2L64bgNU8UN510pAgj38YqKnzrzLsVlTk9leJV0zgxh
         1BULMhPan/I8A6vSqAu64tSbf9DZMzPzSYFG9uile6BNGCH8lVhhrGDa1iBjtocJ/z0+
         /RbA==
X-Forwarded-Encrypted: i=1; AJvYcCUr8k+Paxza/IY4hXxNPD75EHh83ZFGt3i5SJa01hoVsN2bnScOx1ugBEbw0qqIqF2jCXwTossxyUWCfFUE@lists.openembedded.org
X-Gm-Message-State: AOJu0YyuPxQToA79dlNE4/95HuCKs89fr7IJSue6Q1HnajATcA1kf7PH
	ZcPGsF2B+oh78SXIUEZAYwvyWnQl0kn0+9K5vIfrdK+1U30ywGiFTDLAIbHFkUo=
X-Gm-Gg: ASbGncs+rVU+pvGvTS/6mP/tLzHAFYiAilNVA0JwkibfNu3W0CXObamy/ZD21rxiDAM
	PiJx8vDe8T69Hu4Gtz5msD5YQJEtgTdlzO1R/gw7qs7J2j7O08XKigbivM6zQiVGrhlEvmwK745
	7A2uE2fNav7sems6BdKUDFou+pw6ooiUVMFre3YTubhh848pc6yUEZM3JZDf7t9E4kPQpmiN/aO
	z0gN5/YlxWkAvIRozUCUCBvk9MrsLszAcM8mLhWotT9v10DWy9iOIKrzxKfDcpa7gSAAIQbBIQR
	xYNTvKfEh7IpknIjSyr10QCenW74dN1uk1KURIy86P5MKwI2Dr3hYnU4DB3+a00HTNZ0eh+2ga4
	gMkbKqDeKfNhBjQXK8kgNcUM5kYOXyw==
X-Google-Smtp-Source: AGHT+IFMW8UIFnbY74wNK1kI0IWZypt13UZxIWEQX0GwvtXpf96+FrV6eGX/cTmBJvcgWrl1r36QDg==
X-Received: by 2002:a5d:64c5:0:b0:39c:cd5:4bc0 with SMTP id ffacd0b85a97d-3a0894b21f5mr991834f8f.52.1745874589756;
        Mon, 28 Apr 2025 14:09:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:1fc1:a08d:2291:3439? ([2001:8b0:aba:5f3c:1fc1:a08d:2291:3439])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5c6a0sm12053494f8f.86.2025.04.28.14.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 14:09:49 -0700 (PDT)
Message-ID: <3c8bcef0df736c09d12970cb8cab08c003065839.camel@linuxfoundation.org>
Subject: Re: [PATCH v3 0/8] Fix gitsm LFS support
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Philip Lorenz
	 <philip.lorenz@bmw.de>, bitbake-devel@lists.openembedded.org
Date: Mon, 28 Apr 2025 22:09:48 +0100
In-Reply-To: <D9IEUL8C31XI.2888IIXIFIPAW@bootlin.com>
References: <20250425144138.4089681-1-philip.lorenz@bmw.de>
	 <D9IEUL8C31XI.2888IIXIFIPAW@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Apr 2025 21:10:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17580

On Mon, 2025-04-28 at 18:25 +0200, Mathieu Dubois-Briand wrote:
> On Fri Apr 25, 2025 at 4:41 PM CEST, Philip Lorenz wrote:
> > This patch series fixes a number of issues we observed when using the
> > gitsm fetcher in conjunction with git-lfs.
> >=20
> > I'd like to highlight two patches in this series:
> > * 0004-fetch2-Simplify-git-LFS-detection: I could not come up with a
> > =C2=A0 good reason on why the code so far preferred the content of
> > =C2=A0`.gitattributes` on the repository's branch instead of always
> > =C2=A0 considering the state of the target revision. Please let me know
> > =C2=A0 if there's something I didn't take into account.
> > * 0005-fetch2-Use-git-lfs-fetch-to-download-objects.patch: I could not
> > =C2=A0 replicate the `git-lfs fetch` behaviour in versions going back t=
o
> > =C2=A0 2.13.2 released in 2021. This leads me to believe that the issue
> > =C2=A0 leading to this workaround is no longer in place. However, if an=
yone
> > =C2=A0 remembers the actual issue / versions involved I can also retest=
 to
> > =C2=A0 confirm that there are no regression.
> >=20
> > ---
>=20
> Hi Philip,
>=20
> Thanks for the new version.
>=20
> It works much better than previously. I still have some issues with
> bitbake selftests on my branch:
>=20
> ERROR: test_lfs_enabled_not_installed (bb.tests.fetch.GitLfsTest.test_lfs=
_enabled_not_installed)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
> =C2=A0 File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake=
/lib/bb/tests/fetch.py", line 2528, in test_lfs_enabled_not_installed
> =C2=A0=C2=A0=C2=A0 fetcher.download()
> =C2=A0=C2=A0=C2=A0 ~~~~~~~~~~~~~~~~^^
> =C2=A0 File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake=
/lib/bb/fetch2/__init__.py", line 1929, in download
> =C2=A0=C2=A0=C2=A0 raise FetchError("Unable to fetch URL from any source.=
", u)
> bb.fetch2.FetchError: Fetcher failure for URL: 'git:///tmp/bitbake-fetch-=
m30azy7_/gitsource;protocol=3Dfile;lfs=3D1;branch=3Dmaster'. Unable to fetc=
h URL from any source.
>=20
> Stdout:
> Cloning into bare repository '/tmp/bitbake-fetch-m30azy7_/download/git2/t=
mp.bitbake-fetch-m30azy7_.gitsource'...
> remote: Enumerating objects: 3, done.
> remote: Counting objects: 100% (3/3), done.
> remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
> Receiving objects:=C2=A0 33% (1/3)
> Receiving objects: 100% (3/3), done.
> Failed to fetch URL git:///tmp/bitbake-fetch-m30azy7_/gitsource;protocol=
=3Dfile;lfs=3D1;branch=3Dmaster, attempting MIRRORS if available
> Fetcher failure: Repository file:///tmp/bitbake-fetch-m30azy7_/gitsource=
=C2=A0has LFS content, install git-lfs on host to download (or set lfs=3D0 =
to ignore it)
> Failed to fetch URL git:///tmp/bitbake-fetch-m30azy7_/gitsource;protocol=
=3Dfile;lfs=3D1;branch=3Dmaster, attempting MIRRORS if available
> Fetcher failure: Repository file:///tmp/bitbake-fetch-m30azy7_/gitsource=
=C2=A0has LFS content, install git-lfs on host to download (or set lfs=3D0 =
to ignore it)
>=20
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/1440/s=
teps/12/logs/stdio

My bitbake master-next branch has a fix for this. We need to mark an
additional test as requiring git-lfs...

I've tested it and it works, I just need to clean up the patch and send
it which I didn't get to yet.

Cheers,

Richard

