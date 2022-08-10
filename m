Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FA7C25B07
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 14:05:15 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web12.6164.1660140311843548189
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 07:05:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QaF4FbTz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id v3so17957546wrp.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=pCRsCWeUDJCizMhec6ZmblGLdtUcYa8OitWzCYFpSwE=;
        b=QaF4FbTz/qdmf2lkmBo8qoLn2U4PzXajTc1i7dhMbS2KarAbVoVNEHFMDmtual0lCN
         1Xa8ljxgS+YzN4dAQcNg5FYDO3xVX2oEuL9gIQLJ/VXkxU004rY2gomc9UalG2t43kkr
         o5S+FMnzAlLFzx4fVnDRhWqKrbDmH9eSnpMvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=pCRsCWeUDJCizMhec6ZmblGLdtUcYa8OitWzCYFpSwE=;
        b=4R94TmMdQHKd/9sysQWqlL4tYLMdhPSlrlphAyh4Xekibivgf4fIsF+SXKpOwqhbG3
         gBwqq3hbecJj9yX+Qaqf2JiyozDL3/L2uiv7NANA58fhbM4Fir0Bs7R6qcy2Wcmy/9JF
         9xGXtWAJKamVGDf7PSF/8ki11UAqb2Jcrl1oMrMkFatCXRHaxlTLMQx/+zXkFoLugIol
         SAWdciiNrliXTlbNPHTxGQTrBVgHE44vmc+NSMNPB9/oo2cYQGF+VuVSyyYMUSNyvWNK
         QF5CowL2uCQy79fyTpdjlLenYI6S0cNqQeosww5Zt8je6Yz7cDCQv0rg7u7Nzn8zkH8p
         rhMQ==
X-Gm-Message-State: ACgBeo10WAIrMgq6j30dZw5fSSPiH3tECW3sQ7wyHA3fJ99TnWZRw8jN
	IwK7q7QShTZPXg2izkPn2rqRIw==
X-Google-Smtp-Source: 
 AA6agR4yjZRJxvLTckcbq6nlRcygKPtN2TzYK7Xr9A2QRnDROo3ulMeXyXV6Hj9S25bWHUnqmAhvMg==
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id
 e14-20020a056000178e00b00220635feb13mr17447276wrg.634.1660140310115;
        Wed, 10 Aug 2022 07:05:10 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:54f2:80ed:9b2b:a32b?
 ([2001:8b0:aba:5f3c:54f2:80ed:9b2b:a32b])
        by smtp.gmail.com with ESMTPSA id
 p3-20020a05600c1d8300b003a50924f1c0sm2659940wms.18.2022.08.10.07.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:05:09 -0700 (PDT)
Message-ID: 
 <f853e0fb1daec7c32a1fb1d0ac523cc4b8c2031f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Switch branch to correct
 hash in case of two premirrors
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>,
	bitbake-devel@lists.openembedded.org
Cc: Mateusz Marciniec <mateuszmar2@gmail.com>, Jan Brzezanski
	 <jan.brzezanski@gmail.com>
Date: Wed, 10 Aug 2022 15:05:08 +0100
In-Reply-To: <20220810084401.3885-1-tomasz.dziendzielski@gmail.com>
References: <20220810084401.3885-1-tomasz.dziendzielski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 14:05:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13884

On Wed, 2022-08-10 at 10:44 +0200, Tomasz Dziendzielski wrote:
> If we use two premirrors and tarball from the first one contains older
> commit then after fetching from tmpdir master ref still points to older
> commit, so _contains_ref can't find the proper revision on a branch.
>=20
> Switch master ref to correct hash so _contains ref can find it. It needs
> to be done in for loop because we don't know which branch is used for
> specific repo in case of multiple repositories.
>=20
> We need to use two try blocks because both commands might fail and it's
> not the reason to break the execution. There are two specific cases I
> want to cover. First is when we have multiple git:// entries in SRC_URI
> and one uses "master" and second "main". In this code we don't know
> which branch is assigned for which repository so we want to add both
> branches - so first we need to remove both branches and one might not
> exist. We could check if the branch exists and create it only then but
> this would break the second case. Now the second case is when for the
> first premirror we remove the branch but we can't create it later
> because the hash does not exist on the branch since tarball doesn't
> contain the newer commits - then for the second premirror the removal of
> the branch would fail.
>=20
> Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
> Signed-off-by: Mateusz Marciniec <mateuszmar2@gmail.com>
> Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
> ---
>  lib/bb/fetch2/git.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 4534bd758..ea47df3cf 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -362,6 +362,16 @@ class Git(FetchMethod):
>                  runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3D=
tmpdir)
>                  fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s " % (u=
d.basecmd, shlex.quote(tmpdir))
>                  runfetchcmd(fetch_cmd, d, workdir=3Dud.clonedir)
> +                # Switch branch ref to a correct hash
> +                for name in ud.names:
> +                    try:
> +                        runfetchcmd("LANG=3DC %s branch -d %s" % (ud.bas=
ecmd, ud.parm.get('branch', ud.branches[name])), d, workdir=3Dud.clonedir)
> +                    except:
> +                        pass
> +                    try:
> +                        runfetchcmd("LANG=3DC %s branch %s %s" % (ud.bas=
ecmd, ud.parm.get('branch', ud.branches[name]), ud.revisions[name]), d, wor=
kdir=3Dud.clonedir)
> +                    except:
> +                        pass
>          repourl =3D self._get_repo_url(ud)
> =20
>          # If the repo still doesn't exist, fallback to cloning it


If I understand what that code is doing, even if the upstream branch
didn't have (and never had) the revision in question, it would force
that revision onto the branch?

I don't think we want to do that.

Cheers,

Richard


