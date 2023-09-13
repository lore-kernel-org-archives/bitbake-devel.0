Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640A5EDEC5D
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 14:09:46 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web11.12989.1694614176831424356
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 07:09:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=BV840dP8;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-500760b296aso1258693e87.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694614175; x=1695218975; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKk23NtqSM6Jz4dfnUyhbWX7/WJLfSpaL2vKDqrTHyk=;
        b=BV840dP8EI8IO+03606tLF7+cDGjTI2Jc9xSMHYegwOUZzw0mQJ+dvGKwLId2l9BQH
         nr+5fnhsr4zp1ndov5Ii56czq1whAoDl0pn0ku9QHskEcekGTHtlWGapOryPB7ANSLFd
         4dnq9jyyUKkHTudUTnEnSINPJKfdUdGYvdH91//8/MwMxNMHbO8T+Yi9VPncFmYQlv6u
         XGEYvZGgQ+Iyvdl4sH2RAQPK6fxTThVf7Zu0DAhMnzg4Rmm5aZlwCfwNYvsyTW0iBkeO
         iBS5TkQgQvj3uUcmxsxSMy3cI4TufcLTSGeWA3+rArGUdkjxhI3z4YUZIrXySACfeyzE
         RhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694614175; x=1695218975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKk23NtqSM6Jz4dfnUyhbWX7/WJLfSpaL2vKDqrTHyk=;
        b=fUOADuQ3TPUcYMYaLD7OfEeU2JnoONF5vcUEIMJBuJ/fUuBs9kWjLjDwxUmKvKKE5u
         6ub6JIxXb6pLrl3ASszf2Lteo2TgJy+ms5xErrle/EyhhAkR6XFWUViRiVZtAwtVtYzp
         vPu94mbPY4SldW9x51rfzkVVkcfiNElornJ4z9gLcnUlyC+G6SvdfLX63BCbzr9TVfba
         B7+O3LYTa/3gL/y5IlemhjUhDERLb4wnSsdTZgHo+2U5gP80R+i+oSAOR4RKIiEay6Ix
         EnWXLEtpsewCQSj2L13IlKknaTj5dptFs3+RZRYnPtuoXMfkzpet2xyrqgRllDZk0Nhy
         ZV9g==
X-Gm-Message-State: AOJu0Yz62x+14mZsGHEzUlG5U0vaLJnjS62PfnESiedgbh8f8UR8JH9K
	H+7JHZg1Vh9Cx8NmHQmsv+yn4ju9OpVdw4U73prQKs+P
X-Google-Smtp-Source: AGHT+IHa0Q3NcNWm1VTPXL194I4pLN1csjrcS3ryF4ZKuwmip8vokOi0fkkJPzpHX8yg4u6Ci8mvSEVzyUbKgRFCzi0=
X-Received: by 2002:a19:2d50:0:b0:4fe:bfa:9d8b with SMTP id
 t16-20020a192d50000000b004fe0bfa9d8bmr896952lft.12.1694614174610; Wed, 13 Sep
 2023 07:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230913084344.29928-1-mikko.rapeli@linaro.org>
 <969bbf65ba6459eedd8df5a3b2cc3f378fdf05d2.camel@linuxfoundation.org>
 <ZQF7NWTYQQvVX3JE@nuoska> <ee62b58ba8e8b1bd085631b8fdd55d0dad698b2e.camel@linuxfoundation.org>
 <CA+chaQdO_cYPxeT1Ss1GhYdcWRenBy+1eYUH4675YdChqeTY4Q@mail.gmail.com>
In-Reply-To: <CA+chaQdO_cYPxeT1Ss1GhYdcWRenBy+1eYUH4675YdChqeTY4Q@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 13 Sep 2023 08:09:22 -0600
Message-ID: <CAJdd5GYds+rH9VHcLOyB1UG_H450Hf=C0HE7Zf8Lyi=SqzBiGw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: git: revert path checks
To: Martin Jansa <martin.jansa@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 14:09:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15048

On Wed, Sep 13, 2023 at 3:42=E2=80=AFAM Martin Jansa <martin.jansa@gmail.co=
m> wrote:
>
> FWIW: I'm also seeing warnings like:
>
> WARNING: Top level directory '/data001/work/downloads/git2/git.libssh.org=
.projects.libssh.git' doesn't match expected '/mnt/mirror-write/downloads/g=
it2/git.libssh.org.projects.libssh.git'. Re-cloning
>
> Where /mnt/mirror-write/downloads/ is configured DL_DIR and /data001/work=
/downloads/ was probably the DL_DIR of the jenkins jobs which originally fe=
tched the libssh and created the tarball with it for premirror.

That's strange.... I'll take a look real quick and see whats going on

>
> Cheers,
>
> On Wed, Sep 13, 2023 at 11:22=E2=80=AFAM Richard Purdie <richard.purdie@l=
inuxfoundation.org> wrote:
>>
>> On Wed, 2023-09-13 at 12:04 +0300, Mikko Rapeli wrote:
>> > Hi,
>> >
>> > On Wed, Sep 13, 2023 at 09:51:39AM +0100, Richard Purdie wrote:
>> > > On Wed, 2023-09-13 at 11:43 +0300, Mikko Rapeli wrote:
>> > > > Commit 10f38157a069cb6938323cadd5e523037a29ace9
>> > > > triggers re-clones of uptodate repositories when their
>> > > > access path changes. This is wrong. It is enough that
>> > > > needed commits are found from the git repo. For example
>> > > > when same DL_DIR is accessed using two different paths
>> > > > due to a symlink, then the resulting absolute paths will
>> > > > differ but the content is the same. Trust the content.
>> > > >
>> > > > Avoids extra downloads of large repositories like linux-yocto
>> > > > for kernel when the local cache was already uptodate.
>> > > >
>> > > > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
>> > > > ---
>> > > >  bitbake/lib/bb/fetch2/git.py | 14 +-------------
>> > > >  1 file changed, 1 insertion(+), 13 deletions(-)
>> > > >
>> > > > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/=
git.py
>> > > > index e11271b757..0c547ea303 100644
>> > > > --- a/bitbake/lib/bb/fetch2/git.py
>> > > > +++ b/bitbake/lib/bb/fetch2/git.py
>> > > > @@ -371,19 +371,7 @@ class Git(FetchMethod):
>> > > >              # The directory may exist, but not be the top level o=
f a bare git
>> > > >              # repository in which case it needs to be deleted and=
 re-cloned.
>> > > >              try:
>> > > > -                # Since clones can be bare, use --absolute-git-di=
r instead of --show-toplevel
>> > > > -                output =3D runfetchcmd("LANG=3DC %s rev-parse --a=
bsolute-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
>> > > > -
>> > > > -                toplevel =3D os.path.abspath(output.rstrip())
>> > > > -                abs_clonedir =3D os.path.abspath(ud.clonedir).rst=
rip('/')
>> > > > -                # The top level Git directory must either be the =
clone directory
>> > > > -                # or a child of the clone directory. Any ancestor=
 directory of
>> > > > -                # the clone directory is not valid as the Git dir=
ectory (and
>> > > > -                # probably belongs to some other unrelated reposi=
tory), so a
>> > > > -                # clone is required
>> > > > -                if os.path.commonprefix([abs_clonedir, toplevel])=
 !=3D abs_clonedir:
>> > > > -                    logger.warning("Top level directory '%s' does=
n't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
>> > > > -                    needs_clone =3D True
>> > > > +                runfetchcmd("LANG=3DC %s rev-parse --absolute-git=
-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
>> > > >              except bb.fetch2.FetchError as e:
>> > > >                  logger.warning("Unable to get top level for %s (n=
ot a git directory?): %s", ud.clonedir, e)
>> > > >                  needs_clone =3D True
>> > >
>> > > Doesn't this give rise to some of the original issues (it could find=
 a
>> > > parent git repo instead of the one being cloned)?
>> >
>> > Yes, but this has not been a problem for me. Re-cloning existing fully=
 cached
>> > repositories is the effect I see.
>> >
>> > I think the git commit id and branch should decide if fetch or re-clon=
e steps are needed.
>> > The path of the repository should not matter. The git remotes also not=
. Both of those can
>> > and do change.
>>
>> In that case you're effectively sending a revert and we should probably
>> be clear about that...
>>
>> We really need to find a way to resolve things for everyone.
>>
>> Cheers,
>>
>> Richard
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#15045): https://lists.openembedded.org/g/bitbake-dev=
el/message/15045
>> Mute This Topic: https://lists.openembedded.org/mt/101333074/3617156
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/leave/802154=
6/3617156/1661570722/xyzzy [martin.jansa@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>

