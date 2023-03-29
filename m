Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06030C6FD18
	for <webhook@archiver.kernel.org>; Wed, 29 Mar 2023 19:30:17 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web11.6854.1680118213764874160
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Mar 2023 12:30:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=MzdPyK2e;
 spf=softfail (domain: sakoman.com, ip: 209.85.208.47, mailfrom: steve@sakoman.com)
Received: by mail-ed1-f47.google.com with SMTP id h8so67648138ede.8
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Mar 2023 12:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112; t=1680118212; x=1682710212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GkvTPQp5LhE7bspr2ATXoCpN9flLmpN8AxzrQoPBYQ=;
        b=MzdPyK2ery2OjSa2lThooPaUQomCDy/6u1Rg5Wvp+yI9XBhsTvkpFf8GA8EpNoxkDF
         yo/l4vopDuOCCLGYY86zL0tRT4Y21B8lqR5b/pOTS0k0jk+RvGmQVKDoM4porzV1C1Do
         gmmzulknW+plQxNw+D04ZR4913fxnY8ypBzKJToKt/sAWGgqC6TmdHh2Kjn2R7pQESl2
         kwcZXepaZXxQxwJp9qaMnvako4ub+YTX7hiQ7ZOA0DxTy2HpNfX7PGuaZrYlMmjotkNn
         /Erq2IBoGCJ5gTbEgfusWs7Kbi5qn6lxXb9CYgXCi6PXXFcYjXf1S951FTtisgACAOs4
         zR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118212; x=1682710212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GkvTPQp5LhE7bspr2ATXoCpN9flLmpN8AxzrQoPBYQ=;
        b=TshYRoXEBBfM3uTwgB/QbsruWz1brMKwvWkDQ1t5mbkP7CQIRLjNd0spqlA21ssJvD
         maEztKxpCtnI5BElznOqLhgZucxtf1721moYvaTtjHqYmj1GbNEgVY2SoSDzxgMvKDkG
         94MQlwsBGXENwO3fCtnjaivZEVotO1tWNJB+muXKDJTlB5j7VgswkpxSXxP6LQx7W8NI
         uv0LS1YB3e5rlGTA/Evv9dj8u3FopNDLWHEFkRNR8WbvWXK6VP52sZG3mR6kLse+Zvqw
         XQck2shm3DtJyFqfP3EfKGiy4IW4iwed66fc2S8v3p0GIoRo+9vT0OpUk6RnJbyywj/w
         7Ywg==
X-Gm-Message-State: AAQBX9f+UoL2K5ysKrEZFVbOqf0vJ+KxVcqwt/KKMPuayZcPG8Yvn0b/
	apPiFJwaeCu9fka/kNeaEwCN5zVlIlEdiau0DiTEWg==
X-Google-Smtp-Source: AKy350YC9HjRwqOJME71O06Vlb3ywX+1/puS9qhO6vMjFzOE9zdJwPUxUnmIs+f1YLklGihrbK6wTbvBp6RJgZsbAIM=
X-Received: by 2002:a17:907:20bc:b0:92a:581:ac49 with SMTP id
 pw28-20020a17090720bc00b0092a0581ac49mr9256955ejb.3.1680118211756; Wed, 29
 Mar 2023 12:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160044.3302416-1-preeti.sachan@intel.com>
In-Reply-To: <20230329160044.3302416-1-preeti.sachan@intel.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Wed, 29 Mar 2023 09:30:00 -1000
Message-ID: <CAOSpxdb+TrLgBjzy0c2BGa17+2qtMkb8=oPVg4pwDhs3okizLA@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][kirkstone][2.0][PATCH] fetch/git: Fix
 local clone url to make it work with repo
To: preeti.sachan@intel.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Mar 2023 19:30:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14628

I can take this once it hits the master branch.

Steve

On Wed, Mar 29, 2023 at 6:02=E2=80=AFAM <preeti.sachan@intel.com> wrote:
>
> From: Robert Yang <liezhi.yang@windriver.com>
>
> The "git clone /path/to/git/objects_symlink" couldn't work after the foll=
owing
> change:
>
> https://github.com/git/git/commit/6f054f9fb3a501c35b55c65e547a244f14c38d5=
6
>
> But repo command manages the git repo as symlinks, so check whether the o=
bjects
> is an symlink to fix the problem:
>
> * Nothing is changed if git/objects is not a symlink
> * Use "git clone file://" when git/objects is a symlink
>
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 4e286ca9..4d6e57ad 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -359,9 +359,13 @@ class Git(FetchMethod):
>
>          # If the repo still doesn't exist, fallback to cloning it
>          if not os.path.exists(ud.clonedir):
> -            # We do this since git will use a "-l" option automatically =
for local urls where possible
> +            # We do this since git will use a "-l" option automatically =
for local urls where possible,
> +            # but it doesn't work when git/objects is a symlink, only wo=
rks when it is a directory.
>              if repourl.startswith("file://"):
> -                repourl =3D repourl[7:]
> +                repourl_path =3D repourl[7:]
> +                objects =3D os.path.join(repourl_path, 'objects')
> +                if os.path.isdir(objects) and not os.path.islink(objects=
):
> +                    repourl =3D repourl_path
>              clone_cmd =3D "LANG=3DC %s clone --bare --mirror %s %s --pro=
gress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
>              if ud.proto.lower() !=3D 'file':
>                  bb.fetch2.check_network_access(d, clone_cmd, ud.url)
> --
> 2.40.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14627): https://lists.openembedded.org/g/bitbake-deve=
l/message/14627
> Mute This Topic: https://lists.openembedded.org/mt/97931812/3620601
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [steve@=
sakoman.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

