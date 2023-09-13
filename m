Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8177EDEC71
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 15:00:29 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.748.1694617224483746979
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 08:00:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=V+vr+NFD;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-500913779f5so11997845e87.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 08:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694617223; x=1695222023; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+9bX0DoYTRcItyRh/mr1FIL53gpm4cA5kIfh00V2vk=;
        b=V+vr+NFDT5Mb9BOWO0u89VZcvDZAcH54ptzwxP3Vc0ZvKpB3PrgHvjDZvaqRBxq/7a
         NfyjOoe5MnhFiZpruehF0VMJFklHmjrJhPKu0fL24CusH7dCOJl1f/RIfbtmYR57gyoz
         ftIghdipQ6kKu7ypQMXGAl2YJbO8c/DLTCgbyXhWqiTul3Mm+ZEggMSuXOKShnxmFp/z
         LtwrFy6uD774MmWvKF7xnE/Z0bQM5y0QLPZhACTNJgxEkvnrzmdKXqjk3f77m0KPkkXU
         lVn42+IK8EFVqLmyebWCWfsyTSzER6JSCBlkciEfCKHLwvoayIMKlsmOk9rFlowI4Al7
         DLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694617223; x=1695222023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+9bX0DoYTRcItyRh/mr1FIL53gpm4cA5kIfh00V2vk=;
        b=Mcqt6quQX2pOEv+NRG1VTuQXJLhxz3Uy7NlzerqjfnpDX7uEXeva8JszCYCxG+g9Wg
         3WC4DyeMWC7WAYVViKSFGzQppf4stsoiCQxY5DlHoiQ2mgasvk0G7cDpepXBWigGjb/L
         FGHmwaw4EzSmzT7zEusvY9Se1LZ/HudRuDYMAIeoh8YjAb4CTqL70Y2nr/nBUt944w3k
         KxQL6NPZawDmI5cJiwuOB3QHo9YTINiLt5QBKtYq+LMwU9fzVhhujdA1i3llFbXez1y3
         NTjLd06COAZ7kONACMWy14UxN6cBrNGbMm20WaMZh5NYTbZme35jk3rDS4F2ZW1FncIp
         AE/w==
X-Gm-Message-State: AOJu0YzrHhsTO9dNCVi9m9/9rEnHMz/qjTLZiesHfWSGCs7nodikyqvD
	pwEHbEtG48IvxYtfO31R1c8QPf8eC0wwvvQbvLA=
X-Google-Smtp-Source: AGHT+IFppAlt8mm80Mgr1eQpA5nDVZjFHiWqJGEwQyLVqKYvI094eLCKuIJarBHxoFyvnLUxAok+7AELqoWeupsQmac=
X-Received: by 2002:ac2:5e6b:0:b0:4fd:cae7:2393 with SMTP id
 a11-20020ac25e6b000000b004fdcae72393mr2283314lfr.2.1694617222390; Wed, 13 Sep
 2023 08:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230913084344.29928-1-mikko.rapeli@linaro.org>
 <969bbf65ba6459eedd8df5a3b2cc3f378fdf05d2.camel@linuxfoundation.org>
 <ZQF7NWTYQQvVX3JE@nuoska> <ee62b58ba8e8b1bd085631b8fdd55d0dad698b2e.camel@linuxfoundation.org>
 <CA+chaQdO_cYPxeT1Ss1GhYdcWRenBy+1eYUH4675YdChqeTY4Q@mail.gmail.com>
 <CAJdd5GbJh2YPppw-irio8NVmiMjhcb9XfX44LDw-+MUr5MSTvg@mail.gmail.com> <CA+chaQf9TbgA_d62573A4v4Dr4zhuEv=524LLUnfadVPB5bdNQ@mail.gmail.com>
In-Reply-To: <CA+chaQf9TbgA_d62573A4v4Dr4zhuEv=524LLUnfadVPB5bdNQ@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 13 Sep 2023 09:00:10 -0600
Message-ID: <CAJdd5GbyGn8hJ2wuWOM1uHwHYc9JooCvU+xqm4MXv9+rbfXNLg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: git: revert path checks
To: Martin Jansa <martin.jansa@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 15:00:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15053

On Wed, Sep 13, 2023 at 8:53=E2=80=AFAM Martin Jansa <martin.jansa@gmail.co=
m> wrote:
>
> > not related to Mikkos problem.
> > I think I have a fix for Mikkos symlink problem though
>
> Maybe it is related in the end, to my surprise /mnt/mirror-write/download=
s is on some servers a symlink to /data001/work/downloads and then this /mn=
t/mirror-write/download is used as DL_DIR there (not /data001/work/download=
s directly).

Ah, OK. That is the same problem as Mikko. I was assuming you were
seeing that locally where the two aren't symlinked together. That is a
much simpler explanation :)

>
> On Wed, Sep 13, 2023 at 4:45=E2=80=AFPM Joshua Watt <jpewhacker@gmail.com=
> wrote:
>>
>> On Wed, Sep 13, 2023 at 3:42=E2=80=AFAM Martin Jansa <martin.jansa@gmail=
.com> wrote:
>> >
>> > FWIW: I'm also seeing warnings like:
>> >
>> > WARNING: Top level directory '/data001/work/downloads/git2/git.libssh.=
org.projects.libssh.git' doesn't match expected '/mnt/mirror-write/download=
s/git2/git.libssh.org.projects.libssh.git'. Re-cloning
>> >
>> > Where /mnt/mirror-write/downloads/ is configured DL_DIR and /data001/w=
ork/downloads/ was probably the DL_DIR of the jenkins jobs which originally=
 fetched the libssh and created the tarball with it for premirror.
>>
>> Ya, that /data001 path is _really_ weird. That path comes from running
>> `git rev-parse --absolute-git-dir` in the extracted directory
>> (ud.clonedir, '/mnt/mirror-write/downloads/git2/git.libssh.org.projects.=
libssh.git').
>> The should be no absolute paths encoded in the mirror tarballs, so
>> this seems like it's some sort of misconfiguration(?), and not related
>> to Mikkos problem.
>>
>>
>> I think I have a fix for Mikkos symlink problem though
>>
>> >
>> > Cheers,
>> >
>> > On Wed, Sep 13, 2023 at 11:22=E2=80=AFAM Richard Purdie <richard.purdi=
e@linuxfoundation.org> wrote:
>> >>
>> >> On Wed, 2023-09-13 at 12:04 +0300, Mikko Rapeli wrote:
>> >> > Hi,
>> >> >
>> >> > On Wed, Sep 13, 2023 at 09:51:39AM +0100, Richard Purdie wrote:
>> >> > > On Wed, 2023-09-13 at 11:43 +0300, Mikko Rapeli wrote:
>> >> > > > Commit 10f38157a069cb6938323cadd5e523037a29ace9
>> >> > > > triggers re-clones of uptodate repositories when their
>> >> > > > access path changes. This is wrong. It is enough that
>> >> > > > needed commits are found from the git repo. For example
>> >> > > > when same DL_DIR is accessed using two different paths
>> >> > > > due to a symlink, then the resulting absolute paths will
>> >> > > > differ but the content is the same. Trust the content.
>> >> > > >
>> >> > > > Avoids extra downloads of large repositories like linux-yocto
>> >> > > > for kernel when the local cache was already uptodate.
>> >> > > >
>> >> > > > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
>> >> > > > ---
>> >> > > >  bitbake/lib/bb/fetch2/git.py | 14 +-------------
>> >> > > >  1 file changed, 1 insertion(+), 13 deletions(-)
>> >> > > >
>> >> > > > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetc=
h2/git.py
>> >> > > > index e11271b757..0c547ea303 100644
>> >> > > > --- a/bitbake/lib/bb/fetch2/git.py
>> >> > > > +++ b/bitbake/lib/bb/fetch2/git.py
>> >> > > > @@ -371,19 +371,7 @@ class Git(FetchMethod):
>> >> > > >              # The directory may exist, but not be the top leve=
l of a bare git
>> >> > > >              # repository in which case it needs to be deleted =
and re-cloned.
>> >> > > >              try:
>> >> > > > -                # Since clones can be bare, use --absolute-git=
-dir instead of --show-toplevel
>> >> > > > -                output =3D runfetchcmd("LANG=3DC %s rev-parse =
--absolute-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
>> >> > > > -
>> >> > > > -                toplevel =3D os.path.abspath(output.rstrip())
>> >> > > > -                abs_clonedir =3D os.path.abspath(ud.clonedir).=
rstrip('/')
>> >> > > > -                # The top level Git directory must either be t=
he clone directory
>> >> > > > -                # or a child of the clone directory. Any ances=
tor directory of
>> >> > > > -                # the clone directory is not valid as the Git =
directory (and
>> >> > > > -                # probably belongs to some other unrelated rep=
ository), so a
>> >> > > > -                # clone is required
>> >> > > > -                if os.path.commonprefix([abs_clonedir, topleve=
l]) !=3D abs_clonedir:
>> >> > > > -                    logger.warning("Top level directory '%s' d=
oesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
>> >> > > > -                    needs_clone =3D True
>> >> > > > +                runfetchcmd("LANG=3DC %s rev-parse --absolute-=
git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
>> >> > > >              except bb.fetch2.FetchError as e:
>> >> > > >                  logger.warning("Unable to get top level for %s=
 (not a git directory?): %s", ud.clonedir, e)
>> >> > > >                  needs_clone =3D True
>> >> > >
>> >> > > Doesn't this give rise to some of the original issues (it could f=
ind a
>> >> > > parent git repo instead of the one being cloned)?
>> >> >
>> >> > Yes, but this has not been a problem for me. Re-cloning existing fu=
lly cached
>> >> > repositories is the effect I see.
>> >> >
>> >> > I think the git commit id and branch should decide if fetch or re-c=
lone steps are needed.
>> >> > The path of the repository should not matter. The git remotes also =
not. Both of those can
>> >> > and do change.
>> >>
>> >> In that case you're effectively sending a revert and we should probab=
ly
>> >> be clear about that...
>> >>
>> >> We really need to find a way to resolve things for everyone.
>> >>
>> >> Cheers,
>> >>
>> >> Richard
>> >>
>> >> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> >> Links: You receive all messages sent to this group.
>> >> View/Reply Online (#15045): https://lists.openembedded.org/g/bitbake-=
devel/message/15045
>> >> Mute This Topic: https://lists.openembedded.org/mt/101333074/3617156
>> >> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> >> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/leave/802=
1546/3617156/1661570722/xyzzy [martin.jansa@gmail.com]
>> >> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> >>

