Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424ADC46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 14:56:47 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.20064.1706626605609270782
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jan 2024 06:56:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=c8zG4NCI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fafced20aso2879625e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 06:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706626604; x=1707231404; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTgO+QbTHISDtKlazeJbZ+e8DVpWZdplBulBRqeXzLw=;
        b=c8zG4NCII+0RFuIxzDQ9GsW2EYbwXyIM1O+mWLBO94OphDudVUtn7f7XTnaOu2w0rd
         inS6FgZ7xZ9RGDPQljXKzOTRf/vDNZ/JOCyzCmCGYiJlf10eUX8WS6e7OilVBM4slmbJ
         iHAgzJCHIiwo6P+eZtGBqKSN6Y4y6f/wvjwX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626604; x=1707231404;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTgO+QbTHISDtKlazeJbZ+e8DVpWZdplBulBRqeXzLw=;
        b=cR1PA6VUWjHjcKb0OlZ6rJqs5t55EsU/1Nb++DoJqsW0g5EIKggDXZbuYaHCE7d6w/
         7vhH7Gg3XPmtc0gyeYE8+UBwg8CXOxY2vRcO1rHVSEVIci7XYMHhsJqCqVc0uqLz0ZWR
         KkD+sabL0zkmdoKQJa79UWFnV2aBsL5XtTnaAXtbNJZmVIVdrJqe4ATGSkC4+QqqNutM
         mESXlcUKblqy9Pjen5B8btsxAq90qhEQGmqovt5M5HrYuOUFsbR/10YhozOXD2rBNCIK
         ERfIcLqwaemlbwUh7/AJEJ7yaxnetMUUvqXM4xNFrajtmW+S10bC+EtaJNxx6soPSMxa
         NQZA==
X-Gm-Message-State: AOJu0Yyn4W+dlXeZ4YJu/504xdFSZULBvQ8sRwSfq8Pr3TJ66Zhw3/2z
	WyyvWc+3mT7zyegnROvuS3YwfxgUq2aEZ3H2oAuC2kXTKVAVCikPSWYsfvWF8dsXZ2t1jPgXTp9
	1
X-Google-Smtp-Source: AGHT+IEQf8DvoPfh9fFuc49jathJhrW8DkW1cQ/OpslPUjivq8JnUrmt23OE1uvkn9+hJxB90NEHPg==
X-Received: by 2002:a05:6000:890:b0:336:9e8a:6fde with SMTP id cs16-20020a056000089000b003369e8a6fdemr6516629wrb.22.1706626603560;
        Tue, 30 Jan 2024 06:56:43 -0800 (PST)
Received: from [172.27.244.144] ([212.187.182.165])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b0033aed5feea4sm5796936wrf.54.2024.01.30.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 06:56:43 -0800 (PST)
Message-ID: <915d6f72d58debc70a36fd82a03c2ccdf5be7239.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] fetch2/git.py: fix the try_premirror
 logic
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jan 2024 14:56:42 +0000
In-Reply-To: <20240130111158.1077626-1-Qi.Chen@windriver.com>
References: <20240130111158.1077626-1-Qi.Chen@windriver.com>
Autocrypt: addr=richard.purdie@linuxfoundation.org; prefer-encrypt=mutual; keydata=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
 YNvg==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 14:56:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15807

On Tue, 2024-01-30 at 19:11 +0800, Chen Qi via lists.openembedded.org
wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>=20
> For gitsm recipes, it's possible that some URL is used more than once.
> e.g.,
> A -> B:rev1 (B is a submodule of A)
> A -> C (C is a submodule of A)
> C -> B:rev2 (B is a submodule of C)
> A anc C are both using B as submodules, but on different revs.
> Now if we have:
> B:rev1 -> D
> B:rev2 -> E
> Then, the mirror will not be fully used.
> Say we have all repo mirrors for A, B, C, D, E, then in theory it's not
> necessary to reach out to any network for downloading. But it's not the
> case. After downloading B(rev1) and its submodule D from mirrors, the fet=
ch
> process continues to download C, thus B(rev2) and E. Now it finds that B
> needs an update because its submodule E needs an update. Of course this i=
s
> true because E is not downloaded yet. Now the problem comes to whether to
> use mirror or not. The git.py defines try_premirror to return 'False' whe=
n
> the ud.clonedir exists. As B has been cloned, the ud.clonedir exists and
> try_mirror returns False, resulting in not using mirror and going to upst=
ream
> directly.
>=20
> We can see that the mirrors are not fully used. This is usually not probl=
em,
> as the cost is only some network download. But in case the following two
> settings are there, we get errors.
> BB_NO_NETWORK =3D "0"
> BB_ALLOWED_NETWORKS =3D "*.some.allowed.domain"
> In such case, the gitsm recipe A will fail to fetch. Note that all conten=
ts
> that A needs are in mirrors and now it's failing to fetch. This is unexpe=
cted.
>=20
> Note that the different revs of the same repo in gitsm recipe is not the =
only
> way to reveal this problem. For example, there might be a recipe call B t=
hat
> uses B:rev3. Check the protobuf and grpc recipes as an example.
>=20
> For now, we can use the following steps to reproduce this issue. To be cl=
ear,
> the grpc recipe in meta-oe is now 1.60.0.
> 1. Add in local.conf:
>    DL_DIR =3D "${TOPDIR}/downloads-premirror"
>    bitbake grpc -c fetch
> 2. Comment out the DL_DIR setting in local.conf and add the following lin=
es:
>    PREMIRRORS:append =3D " \
>      git://.*/.* git://${TOPDIR}/downloads-premirror/git2/MIRRORNAME;prot=
ocol=3Dfile \n \
>      gitsm://.*/.* gitsm://${TOPDIR}/downloads-premirror/git2/MIRRORNAME;=
protocol=3Dfile \n \
>    "
> 3. Set BB_NO_NETWORK =3D "1" and then 'bitbake grpc -c fetch'.
>    This command succeeds and this shows that the premirror holds everythi=
ng we need.
> 4. Add the following lines and then 'bitbake grpc -c fetch'.
>    BB_NO_NETWORK =3D "0"
>    BB_ALLOWED_NETWORKS =3D "*.some.domain"
>=20
> After step 4, the error message is as below:
> ERROR: grpc-1.60.0-r0 do_fetch: The URL: 'gitsm://github.com/protocolbuff=
ers/protobuf.git;protocol=3Dhttps;name=3Dthird_party/protobuf;subpath=3Dthi=
rd_party/protobuf;nobranch=3D1;lfs=3DTrue;bareclone=3D1;nobranch=3D1' is no=
t trusted and cannot be used
>=20
> I guess that the try_premirror codes in git fetcher (fetch2/git.py) are a=
ssuming
> that the clonedir syncs with the mirror repo. That's only reason I can th=
ink of
> for why it returns 'False' if the clonedir exists. The assumption is wron=
g. The
> mirror could well be updated via automation tools or some project-level s=
etup
> tools. Yet, it's returning True when BB_FETCH_PREMIRRORONLY is set, regar=
dless
> of whether the clonedir exists. This means it does know that the mirror c=
ould be
> updated. It seems that it treats using mirror as some kind of 'best effor=
t'. Anyway,
> the codes' logic is just contradicting with itself.
>=20
> If the mirror can be possibly updated, then it should be tried regardless=
 of whether
> the clonedir exists. So we should remove the try_premirror codes here and=
 use the
> default one (in __init__.py), which always returns True.
>=20
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  lib/bb/fetch2/git.py | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 7aa3fd9e5..62618012b 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -353,15 +353,6 @@ class Git(FetchMethod):
>      def tarball_need_update(self, ud):
>          return ud.write_tarballs and not os.path.exists(ud.fullmirror)
> =20
> -    def try_premirror(self, ud, d):
> -        # If we don't do this, updating an existing checkout with only p=
remirrors
> -        # is not possible
> -        if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
> -            return True
> -        if os.path.exists(ud.clonedir):
> -            return False
> -        return True
> -
>      def download(self, ud, d):
>          """Fetch url"""

I'm not sure this is a good idea. The problem is that the default
fetcher would not try and incrementally fetch into an existing clone
without this code and that is a common workflow.

Did the existing test cases pass after this change?

We probably should have a test case for this issue too. Things have
changes now mirrors/premirrors are non-destructive to existing git
repos so we may be able to improve the core logic to fix this corner
case but it can't be at the expense of some of the other workflows.

Cheers,

Richard

