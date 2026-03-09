Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AAEFCA193
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 21:33:09 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26003.1773091981123848032
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 14:33:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hKFPUkPh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so27411325e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773091979; x=1773696779; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7btz3TD5TvIEwEUqzWSIU5Kg+KNBjJMTpOHEiawOovc=;
        b=hKFPUkPhl7Vw5Hm+hfNRVDL/X49wlUf5R4CeAjPPuIgEnB1kRXR58lYRuIt538RrZ6
         MN7cH2JFWQAiZ6EogeimkKy2C7L+B/V7yOkqQQvb1/pCxLBw2rqr7HAC/nc2M+tTWgj4
         weaqn8igHtpI/Dr6+0aJjuaZ8nWlf5RDV8HIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091979; x=1773696779;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7btz3TD5TvIEwEUqzWSIU5Kg+KNBjJMTpOHEiawOovc=;
        b=gakqDIffHtWKt6kgQ+cq+gpRcwyJfLbGzLR7syvx2xz+S02yZ/8dKWe0HnXMHMbpV4
         b+RDopVLqmeDO9t/kHcHLv8nElfNWY1/17melpcgUD2rHm0W6hd7sMIUYE7bGAB9Ybvn
         NZtNJW3yW79LHgCZzz/EWoLKLCUtjVb+imVhTpbeS8mWkrVC+S+raXqL6+Ps5vhjo4lA
         y6Km6miC/RTvhoPabHxgx9fCQXkfgJn1ACDkBfpo6gYNgUzYy76Mq/6JBECnAvE8AEYq
         kIlEQAk66p95Gn2cfrGWgMfXKY24HKohAtXdjTOwDOEVWI7Fv34qK03JEkVk36ELnwtH
         u6ag==
X-Gm-Message-State: AOJu0YyGJ7NzITCV+gCUPNS+68Ig8WM2Z6EkYkkK5gmKHkIw0cdmZIBC
	6HuG7HrlIgxq0IGSFsx0XQ/JGDqMb2phm4Hfc92XCPyxdkCEG4ApQcVGA9/StDPjdWk=
X-Gm-Gg: ATEYQzzYBKICnNGp+Z8GUmwkXmBQZTt1Wmo0Eb1uIlf5PjzbyA36fNkCUEY7uUhI2Cm
	UyiV1vEHAMAyv6ZhnU0a8FWt0JWyrmA5Ztxg80FTX/fDUtehSlP8PNmKduNu26xejFP7XGFWe+P
	CRDVMoqk79d/OV+lyH1ziK40RLKYBzaE9lOkLt+HVpK3svQIZq8CVOC+HyxEKcDuMVH2FZEHX4N
	oTFJ9TfkeqE/SyaYN4CcONieaspOq+bjoopTZdyeBL7fRMeUllUDc+cLAP8hhdqhCBuTNA5PgyM
	BA1MLH3iZtGTPftO8r+ILI3mg5LuHSNfDoGrc/J0se7iYSvJHYUR3B8bf9ZOUQO8+dRJW6p1CMq
	JVqJJdECaSMwe5L7WPuitsfETWAMrDZ9bu2skKvEjuxHDf0j5JVZnYt34GKeSbcFw1mwHqKLzhH
	udpLJDPMMTualBC8yJBNT0PJaecOQZFB1B+M+PX+1XzCK2j0dhQGkTc2IY0WrmDGvhpnKlcRW9U
	x2dUoGbNO5+
X-Received: by 2002:a05:600c:4f49:b0:485:3dfc:569 with SMTP id 5b1f17b1804b1-4853dfc06f1mr60369025e9.16.1773091979448;
        Mon, 09 Mar 2026 14:32:59 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f0f:27a5:814a:c92a? ([2001:8b0:aba:5f3c:f0f:27a5:814a:c92a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa7aacsm25781425e9.13.2026.03.09.14.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:32:58 -0700 (PDT)
Message-ID: <69ad2307918818d02c42eba53787f404f8fc0fc6.camel@linuxfoundation.org>
Subject: Re: [PATCH 3/3] bitbake: fetch2: Fix LFS object checkout in
 submodules
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Michael Siebold <michael.siebold@gmail.com>, Yoann Congal
	 <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org, Philip Lorenz
 <philip.lorenz@bmw.de>
Date: Mon, 09 Mar 2026 21:32:58 +0000
In-Reply-To: <20260309212125.3172717-4-michael.siebold@gmail.com>
References: <20260309212125.3172717-1-michael.siebold@gmail.com>
	 <20260309212125.3172717-4-michael.siebold@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 21:33:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19131

On Mon, 2026-03-09 at 14:21 -0700, Michael Siebold wrote:
> From: Philip Lorenz <philip.lorenz@bmw.de>
>=20
> Skipping smudging prevents the LFS objects from replacing their
> placeholder files when `git submodule update` actually checks out the
> target revision in the submodule. Smudging cannot happen earlier as the
> clone stored in `.git/modules` is bare.
>=20
> This should be fine as long as all LFS objects are available in the
> download cache (which they are after the other fixes are applied).
>=20
> (Bitbake rev: d270e33a07c50bb9c08861cf9a6dc51e1fd2d874)
>=20
> Upstream-Status: Backport [from commit 3eeac69385]
>=20
> Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit 3eeac69385e8f29a08d022a17b28b5d504deed66)
> Signed-off-by: Michael Siebold <michael.siebold@gmail.com>
> ---
> =C2=A0bitbake/lib/bb/fetch2/gitsm.py | 11 +++++------
> =C2=A01 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm=
.py
> index 5c98991480..ef19053330 100644
> --- a/bitbake/lib/bb/fetch2/gitsm.py
> +++ b/bitbake/lib/bb/fetch2/gitsm.py
> @@ -243,12 +243,11 @@ class GitSM(Git):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D self.process_sub=
modules(ud, ud.destdir, unpack_submodules, d)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not ud.bareclone and =
ret:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # All=
 submodules should already be downloaded and configured in the tree.=C2=A0 =
This simply
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # set=
s up the configuration and checks out the files.=C2=A0 The main project con=
fig should
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # rem=
ain unmodified, and no download from the internet should occur. As such, lf=
s smudge
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # sho=
uld also be skipped as these files were already smudged in the fetch stage =
if lfs
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # was=
 enabled.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 runfe=
tchcmd("GIT_LFS_SKIP_SMUDGE=3D1 %s submodule update --recursive --no-fetch"=
 % (ud.basecmd), d, quiet=3DTrue, workdir=3Dud.destdir)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmdpr=
efix =3D ""
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Avo=
id LFS smudging (replacing the LFS pointers with the actual content) when L=
FS shouldn't be used but git-lfs is installed.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if no=
t self._need_lfs(ud):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cmdprefix =3D "GIT_LFS_SKIP_SMUDGE=3D1 "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 runfe=
tchcmd("%s%s submodule update --recursive --no-fetch" % (cmdprefix, ud.base=
cmd), d, quiet=3DTrue, workdir=3Dud.destdir)
> =C2=A0=C2=A0=C2=A0=C2=A0 def clean(self, ud, d):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def clean_submodule(ud, =
url, module, modpath, workdir, d):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
url +=3D ";bareclone=3D1;nobranch=3D1"


We've had a lot of churn on this code and it isn't something I use and
fully understand myself so I need to ask some questions to make sure we
get this right this time.

Is "git submodule update --recursive --no-fetch" going to access the
network?=C2=A0

If I understand correctly, you say it shouldn't as things should
already be in DL_DIR. What happens if they're not? Where are the large
files stored in DL_DIR?

From the older comments in the code, it sounds like the smudging was
meant to happen at do_fetch time and this is now being changed to
happen at do_unpack.

Put differently, the fetcher code needs to:

* ensure software manifests are correct and only specifically
referenced things are fetched, no random revisions or accesses outside
of what is listed
* ensure mirroring works correctly and all artefacts needed (including
lfs ones) can be handled by a mirror setting
* be reproducible, the same thing will always be fetched for a given
url/revision

I'd like to be certain this change allows for that and the smudging
doesn't bypass things.

Also, do we have tests covering this from bitbake-selftest?

Cheers,

Richard




