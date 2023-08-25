Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D184C88CB2
	for <webhook@archiver.kernel.org>; Fri, 25 Aug 2023 14:19:46 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.14715.1692973180162234356
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Aug 2023 07:19:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=UFBBdtbX;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2bbbda48904so14362291fa.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 25 Aug 2023 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692973178; x=1693577978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4OTnMKZCI5cxAds7RxeUZOLXu2KZu5Uw2WhA/aE7/w=;
        b=UFBBdtbX2SFpT/DeCUc4smZeE6QxA/dvXlBpsd3EYafLighFYIkjx3+uw44NLXg23d
         vqQeOcQZGgxI/s1BA/JXYgkJsi1XnBTBT/Bf4Dhz8xabHVFR8i9Vj8fSmq1dNDGxV25S
         +smKjOCx63nDXxvov691pwewP4YFqtebY6MuPMIjiExsDhWem7epm42cqOd1gntseZJl
         WDPKSn0HraFocNzpKupX1UY3bsH13RL7w7jlGWeP+CuBEJYRAoRsNDi3vDWXoOsHqo3N
         hngcyByZsjwPIQgO38qoOEyipgpCIJ/cXa77EKaKz6Wyfxss3KVrq4WkwYkQTK3kIoGq
         52Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692973178; x=1693577978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4OTnMKZCI5cxAds7RxeUZOLXu2KZu5Uw2WhA/aE7/w=;
        b=LYAm5UMwXErID170F1WWVI8iELF294l+LXcjhW0sd7JR8DV92VvcIz3vHPKEsL0ba2
         phjHAQN3A6PVO3CT6OmM4Su2zsZT/hg2eqWZKgQcoFgKs9LRuKb2v7WgCaiVgPLGmuid
         AQXALZXZEahZcJ/DN1v4U9ucSYqHzReeCGb8zrwTlXXF1lM/oQOxhkmJOR4SBdGOB6gK
         5xOLUwO4vVHG5ch3jQVSp4g94Cl/fJfpl8+Fkbe1FqFZPzmqUDwpYqcmW57/nvEaN6Ei
         6xsO+YYh4Iy3rx/NA2rA+aacZb9DXSCR8Fu0sLawfwHl9d/JV2pAZLsBnYBId5cfWqQo
         ZFGg==
X-Gm-Message-State: AOJu0YzYsnGA9jeRQ48PdkguvzwxrQJ8QGSzk1wOuDKSLzdEDS9XKoYM
	qOtjUcKPxsWed65JubWMhkHTbHuW2gjQ5Mi+oEk=
X-Google-Smtp-Source: AGHT+IF3eDq4b0gpWUTg/n8vYjKrpn+x4QfUf1JiAZXccnQbxr5FMyciO5lyAJkTgT95oJtRdlLHVKJFRw65OBd4UKY=
X-Received: by 2002:a2e:bb8a:0:b0:2bc:f78a:e5e0 with SMTP id
 y10-20020a2ebb8a000000b002bcf78ae5e0mr1007440lje.43.1692973177795; Fri, 25
 Aug 2023 07:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230804155424.1502010-1-JPEWhacker@gmail.com>
 <20230824195332.851528-1-JPEWhacker@gmail.com> <50329c34-b057-3542-4c45-047e6b24169b@myneves.com>
In-Reply-To: <50329c34-b057-3542-4c45-047e6b24169b@myneves.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 25 Aug 2023 08:19:25 -0600
Message-ID: <CAJdd5GbTpHVu7cVWia8PHbjWV=cS7MESjJx3j810OU09F9nXEQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] fetch2: git: Check if clone directory
 is a git repo
To: Paulo Neves <paulo@myneves.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Aug 2023 14:19:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14984

On Fri, Aug 25, 2023 at 3:18=E2=80=AFAM Paulo Neves <paulo@myneves.com> wro=
te:
>
> On 24/08/2023 21:53, Joshua Watt wrote:
> > If the clone target directory exists and is a valid git repo, but the
> > git directory is not a child, it needs to be erased and re-cloned. One
> > example of how this can happen is if a clone creates the directory, but
> > then fails to actual clone and make it a git repository. This left-over
> > directory can be particularly problematic if the download directory is =
a
> > descent of some top layer git repo (e.g. the default with poky), as the
> > commands that operate on the remote later will then mangle the layers
> > git repository instead of the download git repo.
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >   bitbake/lib/bb/fetch2/git.py | 30 +++++++++++++++++++++++++++++-
> >   1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.p=
y
> > index 2a3c06fe4e9..33895e09b29 100644
> > --- a/bitbake/lib/bb/fetch2/git.py
> > +++ b/bitbake/lib/bb/fetch2/git.py
> > @@ -65,6 +65,7 @@ import fnmatch
> >   import os
> >   import re
> >   import shlex
> > +import shutil
> >   import subprocess
> >   import tempfile
> >   import bb
> > @@ -365,8 +366,35 @@ class Git(FetchMethod):
> >                   runfetchcmd(fetch_cmd, d, workdir=3Dud.clonedir)
> >           repourl =3D self._get_repo_url(ud)
> >
> > +        needs_clone =3D False
> > +        if os.path.exists(ud.clonedir):
> > +            # The directory may exist, but not be the top level of a b=
are git
> > +            # repository in which case it needs to be deleted and re-c=
loned.
> > +            try:
> > +                # Since clones can be bare, use --absolute-git-dir ins=
tead of --show-toplevel
> > +                output =3D runfetchcmd("LANG=3DC %s rev-parse --absolu=
te-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> > +            except bb.fetch2.FetchError as e:
> > +                logger.warning("Unable to get top level for %s (not a =
git directory?): %s", ud.clonedir, e)
> > +                needs_clone =3D True
> > +            else:
> > +                toplevel =3D os.path.abspath(output.rstrip())
> > +                abs_clonedir =3D os.path.abspath(ud.clonedir).rstrip('=
/')
> > +                # The top level Git directory must either be the clone=
 directory
> > +                # or a child of the clone directory. Any ancestor dire=
ctory of
> > +                # the clone directory is not valid as the Git director=
y (and
> > +                # probably belongs to some other unrelated repository)=
, so a
> > +                # clone is required
> > +                if os.path.commonprefix([abs_clonedir, toplevel]) !=3D=
 abs_clonedir:
> > +                    logger.warning("Top level directory '%s' doesn't m=
atch expected '%s'. Re-cloning", toplevel, ud.clonedir)
> > +                    needs_clone =3D True
> > +
> > +            if needs_clone:
> > +                shutil.rmtree(ud.clonedir)
> > +        else:
> > +            needs_clone =3D True
> > +
> >           # If the repo still doesn't exist, fallback to cloning it
> > -        if not os.path.exists(ud.clonedir):
> > +        if needs_clone:
> >               # We do this since git will use a "-l" option automatical=
ly for local urls where possible,
> >               # but it doesn't work when git/objects is a symlink, only=
 works when it is a directory.
> >               if repourl.startswith("file://"):
> > --
> > 2.33.0
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#14979): https://lists.openembedded.org/g/bitbake-de=
vel/message/14979
> > Mute This Topic: https://lists.openembedded.org/mt/100942876/4454782
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [paul=
o@myneves.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> Is it possible to factor the try/except else to a function? Then we
> would not need the else, and would just return immediately and have a
> self contained code, which in my opinion is easier to read. I also think
> f-string would be more readable for runfetchcmd. f-string are available
> since python 3.6.
>
> Can you share the rationale for the else clause? I do not see anything
> inside the else clause that might raise a FetchError, thus the else
> clause is redundant.

The else clause is pretty much the entire reason for this patch in the
first place :)

The problem is that the fetcher assumes that the simple existence of
the download directory means it can can add a remote and clone there,
but that is not true. If your clone directory is a subdirectory of
another git repository, but not a git repository itself, bitbake will
(incorrectly) add the remote the higher level git repos and fetch
there, leaving it a mess.

More visually, if your layout is like this:

 poky <-- This is a git repository
   build
      downloads
          git2
            foo <-- This is NOT a git repository

The old code would see that the foo directory existed, see that it was
part of a git repo (poky!) add the remotes and start cloning objects
into the poky git repo, which is not at all what we want.

The else clause corrects this as it makes the fetcher check if "foo"
is not only a git repo, but that the it is the toplevel of a git repo
(or at least that it's --git-dir is not a parent of that directory).
If it's not, it deletes it because it's not a valid place to clone
things into anymore.

>
> Another change I suggest is to move the rmtree inside the usual
> need_clone and ignore the error if the path does not exist. Removes
> another conditional.
>
> I also think using needs_clone to assert whether the rmtree should be
> done is confusing A different variable should be used or use a
> function's return value. All the code inside if
> os.path.exists(ud.clonedir): deals with the need for removal and as a
> side effect will trigger the clone in another part of the code.
>
>
>

