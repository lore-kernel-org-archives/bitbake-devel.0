Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394DFEDEC6C
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 14:45:49 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.387.1694616348602369458
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 07:45:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=CWkO6sju;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b703a0453fso119139381fa.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694616346; x=1695221146; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmQ9BOSiV/8vwCCoObZQnvmBOzaSTQiQ6/fLLpyVv6g=;
        b=CWkO6sjujf4tP0oZePb1v7MXtGVPF1Y4pC2nU5E9tHIumXfYUpCNu3r/lrcH/SEqNM
         +VqVTgu8ZwhZskFnhCiv5kGPVwj4CXhOxvDVKQeJSsVfUvwmz+U1zVBGgR6DaOpVURcb
         UreQryp0ezzhaSHX/qIR1xheLeCbmJZJvFqv0AeK0eOdhrd6vIz72spgjQnnBqYv8PpW
         q/Hz1eeQs02z2gFyp2wtDECdHnt8ciQmhmW+uW9ex9ux1eeq3e2NYakbhmz28SRP3Ha1
         zJo1I4nRdhsmtz0AoJdOA61LWgwHKuhIzEiIu1xo7ovHZB2odEjO3i5lTBLPLvkdmzLa
         lKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694616346; x=1695221146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmQ9BOSiV/8vwCCoObZQnvmBOzaSTQiQ6/fLLpyVv6g=;
        b=tqEGAehyHsrR2MBbevZjTl107lA5EIEqeEY0lDrYWblLdyQ0fEfxp2wR53vRhSpBWx
         rb93OAYqkzPGemjRVai7ms2/AL/RjZlCKkU3gjVOzpY1VKkzzNksofHpX6lpOaZ6H05k
         2xtpPRIdHsCArrlLF+yqvVtaxN42Abwnimtg/Zrni+cJ4eCxjPnRkaTNyqv7qBuHPGEY
         dYOvGs4aoyQAGWbFxhhRvCYKbWjG4YhuwoNjH9QBLYBIY4ZJa8Q2xG54KUie2MOiQSB/
         WeOC5KWC7zhL8BUzmXjUq9fQyyXMo34Z69IUSjKFnc2W+DFn4cAUGfhFlooYFQvh9BM7
         7H4A==
X-Gm-Message-State: AOJu0YwCQO2IBjY9vXWtMJpNmfDqbIJz6cxfIlYsKHsc1xoDCzlm6pjX
	CSgHsr9uzkqh1stgP28c9NvOoM0CPUEQjftNiBo=
X-Google-Smtp-Source: AGHT+IHfzeBKLVqNtbXi8cS3Zv3LFrKr6uliYNLKPHfDPZP0DNmjWfVh8sO3/Djpl6hZtCaEvEBDdVMGVP8QfUSzPW8=
X-Received: by 2002:ac2:4bc9:0:b0:4fe:85c:aeba with SMTP id
 o9-20020ac24bc9000000b004fe085caebamr2740588lfq.21.1694616346167; Wed, 13 Sep
 2023 07:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230913084344.29928-1-mikko.rapeli@linaro.org>
 <969bbf65ba6459eedd8df5a3b2cc3f378fdf05d2.camel@linuxfoundation.org>
 <ZQF7NWTYQQvVX3JE@nuoska> <ee62b58ba8e8b1bd085631b8fdd55d0dad698b2e.camel@linuxfoundation.org>
 <CA+chaQdO_cYPxeT1Ss1GhYdcWRenBy+1eYUH4675YdChqeTY4Q@mail.gmail.com>
In-Reply-To: <CA+chaQdO_cYPxeT1Ss1GhYdcWRenBy+1eYUH4675YdChqeTY4Q@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 13 Sep 2023 08:45:34 -0600
Message-ID: <CAJdd5GbJh2YPppw-irio8NVmiMjhcb9XfX44LDw-+MUr5MSTvg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: git: revert path checks
To: Martin Jansa <martin.jansa@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 14:45:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15051

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

Ya, that /data001 path is _really_ weird. That path comes from running
`git rev-parse --absolute-git-dir` in the extracted directory
(ud.clonedir, '/mnt/mirror-write/downloads/git2/git.libssh.org.projects.lib=
ssh.git').
The should be no absolute paths encoded in the mirror tarballs, so
this seems like it's some sort of misconfiguration(?), and not related
to Mikkos problem.


I think I have a fix for Mikkos symlink problem though

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

