Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD38C83F01
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 14:28:06 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web10.18600.1693492080235476981
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Aug 2023 07:28:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=HVxfy9vg;
 spf=pass (domain: gmail.com, ip: 209.85.208.172, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b962535808so16550411fa.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693492078; x=1694096878; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSBrFt1puEjY7MHiRzSuKPzzJ2R0OOzQb1ketzLrwbM=;
        b=HVxfy9vgQtv/BIuGfNyaxLDVB6qzNRRvq2FEyn2a5/wIeT300anSscpmvOArGwO4Da
         V60sl7ItF1iu73jO5mOKf6H38Vza4JKI0kWhIKQsjauVVvrEwYjZSSPcXWpcUqvjeyrA
         bYvD+KKZfcUJeUWzvhVdf5vke0tmJ38VZuM7w/5g60pdjSLB9qmReZVUIvBURs6Frzc7
         NaDqZ6RBCeBAiXuNTVQXzx/QZA1VnvUH5T6Rz40onkp2nGCzLYIKTtO0WRhuA2K8zPhR
         phRvqdIfvKuWyYlp3S6G8ilY19zh7vlzJpxnlRXqjr0NAAl0XFEcQQEjWKCtrBmVDoYs
         Baqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693492078; x=1694096878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSBrFt1puEjY7MHiRzSuKPzzJ2R0OOzQb1ketzLrwbM=;
        b=c+LoiOhN+cYRl9VrFE9Rn+EywXAEqASt822ZazUnnrZrZKJSOffUZEar+dma8rZVwS
         cITIHeycC8BAtH3WO4jKQiuRQEAcl3ZpM7Fb1yCNmFE9alS/omXWVFh4pGlx3hzcz1cl
         U4EqP/XuAiSjo5XYgvTVL2hxDSgv4hb+VmORm0geBMx7dh1+VVKZqDQ+UTcIb9dUJkpX
         w/G9m+7yB5aUHd0oXPO1bFHeEbgFFRNHbvRUA2AEjAy54t7tf3y2TmRoGm0jEdxy33La
         F2Yxalic/vLJ1F0BXO3Q94dPWdR9BHpvriixgXixcaJEDHamy/e7Cddlig981OBgwskw
         aVZA==
X-Gm-Message-State: AOJu0YyNASTGtKoEzAxv9VopGh55/HPv7T052vFfC1ogCEpOhkDdSvw0
	SnAAJk2PzAX/X8kzItHropogftjTDXMsamMiXOY=
X-Google-Smtp-Source: AGHT+IHusQW3suxdHbNQI4MNqVZscMdUEuep9IFvSeYjBJHvPFdCX5BckLhJ20TqwgczS1GdgCp3wEShB4OvlEpZUAs=
X-Received: by 2002:a2e:90d3:0:b0:2b9:f007:9910 with SMTP id
 o19-20020a2e90d3000000b002b9f0079910mr4135670ljg.53.1693492078055; Thu, 31
 Aug 2023 07:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230804155424.1502010-1-JPEWhacker@gmail.com>
 <20230824195332.851528-1-JPEWhacker@gmail.com> <50329c34-b057-3542-4c45-047e6b24169b@myneves.com>
 <CAJdd5GbTpHVu7cVWia8PHbjWV=cS7MESjJx3j810OU09F9nXEQ@mail.gmail.com> <9bf28e85-a821-0026-1802-457f87bfff2b@myneves.com>
In-Reply-To: <9bf28e85-a821-0026-1802-457f87bfff2b@myneves.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 31 Aug 2023 08:27:46 -0600
Message-ID: <CAJdd5GaLEmnvYEOXsBZ+GoqByhv9=hapReir=d3u8=bp8jLmWw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] fetch2: git: Check if clone directory
 is a git repo
To: Paulo Neves <paulo@myneves.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 14:28:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14999

On Thu, Aug 31, 2023 at 6:21=E2=80=AFAM Paulo Neves <paulo@myneves.com> wro=
te:
>
> On 25/08/2023 16:19, Joshua Watt wrote:
> > On Fri, Aug 25, 2023 at 3:18=E2=80=AFAM Paulo Neves <paulo@myneves.com>=
 wrote:
> >> On 24/08/2023 21:53, Joshua Watt wrote:
> >>> If the clone target directory exists and is a valid git repo, but the
> >>> git directory is not a child, it needs to be erased and re-cloned. On=
e
> >>> example of how this can happen is if a clone creates the directory, b=
ut
> >>> then fails to actual clone and make it a git repository. This left-ov=
er
> >>> directory can be particularly problematic if the download directory i=
s a
> >>> descent of some top layer git repo (e.g. the default with poky), as t=
he
> >>> commands that operate on the remote later will then mangle the layers
> >>> git repository instead of the download git repo.
> >>>
> >>> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> >>> ---
> >>>    bitbake/lib/bb/fetch2/git.py | 30 +++++++++++++++++++++++++++++-
> >>>    1 file changed, 29 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git=
.py
> >>> index 2a3c06fe4e9..33895e09b29 100644
> >>> --- a/bitbake/lib/bb/fetch2/git.py
> >>> +++ b/bitbake/lib/bb/fetch2/git.py
> >>> @@ -65,6 +65,7 @@ import fnmatch
> >>>    import os
> >>>    import re
> >>>    import shlex
> >>> +import shutil
> >>>    import subprocess
> >>>    import tempfile
> >>>    import bb
> >>> @@ -365,8 +366,35 @@ class Git(FetchMethod):
> >>>                    runfetchcmd(fetch_cmd, d, workdir=3Dud.clonedir)
> >>>            repourl =3D self._get_repo_url(ud)
> >>>
> >>> +        needs_clone =3D False
> >>> +        if os.path.exists(ud.clonedir):
> >>> +            # The directory may exist, but not be the top level of a=
 bare git
> >>> +            # repository in which case it needs to be deleted and re=
-cloned.
> >>> +            try:
> >>> +                # Since clones can be bare, use --absolute-git-dir i=
nstead of --show-toplevel
> >>> +                output =3D runfetchcmd("LANG=3DC %s rev-parse --abso=
lute-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> >>> +            except bb.fetch2.FetchError as e:
> >>> +                logger.warning("Unable to get top level for %s (not =
a git directory?): %s", ud.clonedir, e)
> >>> +                needs_clone =3D True
> >>> +            else:
> >>> +                toplevel =3D os.path.abspath(output.rstrip())
> >>> +                abs_clonedir =3D os.path.abspath(ud.clonedir).rstrip=
('/')
> >>> +                # The top level Git directory must either be the clo=
ne directory
> >>> +                # or a child of the clone directory. Any ancestor di=
rectory of
> >>> +                # the clone directory is not valid as the Git direct=
ory (and
> >>> +                # probably belongs to some other unrelated repositor=
y), so a
> >>> +                # clone is required
> >>> +                if os.path.commonprefix([abs_clonedir, toplevel]) !=
=3D abs_clonedir:
> >>> +                    logger.warning("Top level directory '%s' doesn't=
 match expected '%s'. Re-cloning", toplevel, ud.clonedir)
> >>> +                    needs_clone =3D True
> >>> +
> >>> +            if needs_clone:
> >>> +                shutil.rmtree(ud.clonedir)
> >>> +        else:
> >>> +            needs_clone =3D True
> >>> +
> >>>            # If the repo still doesn't exist, fallback to cloning it
> >>> -        if not os.path.exists(ud.clonedir):
> >>> +        if needs_clone:
> >>>                # We do this since git will use a "-l" option automati=
cally for local urls where possible,
> >>>                # but it doesn't work when git/objects is a symlink, o=
nly works when it is a directory.
> >>>                if repourl.startswith("file://"):
> >>> --
> >>> 2.33.0
> >>>
> >>>
> >>>
> >>>
> >> Is it possible to factor the try/except else to a function? Then we
> >> would not need the else, and would just return immediately and have a
> >> self contained code, which in my opinion is easier to read. I also thi=
nk
> >> f-string would be more readable for runfetchcmd. f-string are availabl=
e
> >> since python 3.6.
> >>
> >> Can you share the rationale for the else clause? I do not see anything
> >> inside the else clause that might raise a FetchError, thus the else
> >> clause is redundant.
> > The else clause is pretty much the entire reason for this patch in the
> > first place :)
> >
> > The problem is that the fetcher assumes that the simple existence of
> > the download directory means it can can add a remote and clone there,
> > but that is not true. If your clone directory is a subdirectory of
> > another git repository, but not a git repository itself, bitbake will
> > (incorrectly) add the remote the higher level git repos and fetch
> > there, leaving it a mess.
> >
> > More visually, if your layout is like this:
> >
> >   poky <-- This is a git repository
> >     build
> >        downloads
> >            git2
> >              foo <-- This is NOT a git repository
> >
> > The old code would see that the foo directory existed, see that it was
> > part of a git repo (poky!) add the remotes and start cloning objects
> > into the poky git repo, which is not at all what we want.
> >
> > The else clause corrects this as it makes the fetcher check if "foo"
> > is not only a git repo, but that the it is the toplevel of a git repo
> > (or at least that it's --git-dir is not a parent of that directory).
> > If it's not, it deletes it because it's not a valid place to clone
> > things into anymore.
>
> I understand the conceptual point of the patch and I think it is valid.
> What i mean is that you do not need the else clause. The code under the
> else clause can continue inside the try clause and not change the logic.
> The try-else idiom is very unusual and represents a meaning which is not
> needed here: That the code inside the else should not trigger the except
> clause.

Ah, yes. I see what you are saying now

>
> >> Another change I suggest is to move the rmtree inside the usual
> >> need_clone and ignore the error if the path does not exist. Removes
> >> another conditional.
> >>
> >> I also think using needs_clone to assert whether the rmtree should be
> >> done is confusing A different variable should be used or use a
> >> function's return value. All the code inside if
> >> os.path.exists(ud.clonedir): deals with the need for removal and as a
> >> side effect will trigger the clone in another part of the code.
> >>
> >>
> >>
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#14984): https://lists.openembedded.org/g/bitbake-de=
vel/message/14984
> > Mute This Topic: https://lists.openembedded.org/mt/100942876/4454782
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [paul=
o@myneves.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>
>

