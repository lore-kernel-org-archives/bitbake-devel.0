Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76010C3DA66
	for <webhook@archiver.kernel.org>; Fri, 25 Aug 2023 09:18:24 +0000 (UTC)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 by mx.groups.io with SMTP id smtpd.web10.9639.1692955093621179092
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Aug 2023 02:18:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@myneves.com header.s=protonmail2 header.b=WDLfLMRh;
 spf=pass (domain: myneves.com, ip: 185.70.40.136, mailfrom: paulo@myneves.com)
Date: Fri, 25 Aug 2023 09:18:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail2; t=1692955091; x=1693214291;
	bh=j3G3QXBbynTgO1HYvAuf6wPPWYzYVUkA1UOaMte9KwQ=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WDLfLMRhhgxjfdNkv0O7yWldyKaE3O2vBNCZlvmnPl/T7pa35jFeFvBVdmP8GWU6T
	 fnjEP5qNKtBTE6/Z6JHeRtqaV1e92dFktfZximfOdLZiNL9jkkSGLa2OtBcjGwfh1V
	 eNRk98ZjNPxHHPrcoF415ekQBIOq8Nn9JFtpSE8EgJi8vh8jiNwfI10g+ugshlGcMt
	 J7gzSEecCquQ3qMEegAUWaJfL/ytrvUa1HTNxq5cA+f9/XYIY7ij/dk89LHuLPOYpS
	 WHqA9WxsrS5Rz01KZlQRIuKPesvwq0hIS929kXNfta8NsaqJN4AwLex1GqzA4Med57
	 EJRqIzkz8evrw==
To: Joshua Watt <JPEWhacker@gmail.com>, bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Subject: Re: [bitbake-devel][PATCH v2] fetch2: git: Check if clone directory is a git repo
Message-ID: <50329c34-b057-3542-4c45-047e6b24169b@myneves.com>
In-Reply-To: <20230824195332.851528-1-JPEWhacker@gmail.com>
References: <20230804155424.1502010-1-JPEWhacker@gmail.com> <20230824195332.851528-1-JPEWhacker@gmail.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Aug 2023 09:18:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14982

On 24/08/2023 21:53, Joshua Watt wrote:
> If the clone target directory exists and is a valid git repo, but the
> git directory is not a child, it needs to be erased and re-cloned. One
> example of how this can happen is if a clone creates the directory, but
> then fails to actual clone and make it a git repository. This left-over
> directory can be particularly problematic if the download directory is a
> descent of some top layer git repo (e.g. the default with poky), as the
> commands that operate on the remote later will then mangle the layers
> git repository instead of the download git repo.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   bitbake/lib/bb/fetch2/git.py | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 2a3c06fe4e9..33895e09b29 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -65,6 +65,7 @@ import fnmatch
>   import os
>   import re
>   import shlex
> +import shutil
>   import subprocess
>   import tempfile
>   import bb
> @@ -365,8 +366,35 @@ class Git(FetchMethod):
>                   runfetchcmd(fetch_cmd, d, workdir=3Dud.clonedir)
>           repourl =3D self._get_repo_url(ud)
>
> +        needs_clone =3D False
> +        if os.path.exists(ud.clonedir):
> +            # The directory may exist, but not be the top level of a bar=
e git
> +            # repository in which case it needs to be deleted and re-clo=
ned.
> +            try:
> +                # Since clones can be bare, use --absolute-git-dir inste=
ad of --show-toplevel
> +                output =3D runfetchcmd("LANG=3DC %s rev-parse --absolute=
-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> +            except bb.fetch2.FetchError as e:
> +                logger.warning("Unable to get top level for %s (not a gi=
t directory?): %s", ud.clonedir, e)
> +                needs_clone =3D True
> +            else:
> +                toplevel =3D os.path.abspath(output.rstrip())
> +                abs_clonedir =3D os.path.abspath(ud.clonedir).rstrip('/'=
)
> +                # The top level Git directory must either be the clone d=
irectory
> +                # or a child of the clone directory. Any ancestor direct=
ory of
> +                # the clone directory is not valid as the Git directory =
(and
> +                # probably belongs to some other unrelated repository), =
so a
> +                # clone is required
> +                if os.path.commonprefix([abs_clonedir, toplevel]) !=3D a=
bs_clonedir:
> +                    logger.warning("Top level directory '%s' doesn't mat=
ch expected '%s'. Re-cloning", toplevel, ud.clonedir)
> +                    needs_clone =3D True
> +
> +            if needs_clone:
> +                shutil.rmtree(ud.clonedir)
> +        else:
> +            needs_clone =3D True
> +
>           # If the repo still doesn't exist, fallback to cloning it
> -        if not os.path.exists(ud.clonedir):
> +        if needs_clone:
>               # We do this since git will use a "-l" option automatically=
 for local urls where possible,
>               # but it doesn't work when git/objects is a symlink, only w=
orks when it is a directory.
>               if repourl.startswith("file://"):
> --
> 2.33.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14979): https://lists.openembedded.org/g/bitbake-deve=
l/message/14979
> Mute This Topic: https://lists.openembedded.org/mt/100942876/4454782
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [paulo@=
myneves.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
Is it possible to factor the try/except else to a function? Then we=20
would not need the else, and would just return immediately and have a=20
self contained code, which in my opinion is easier to read. I also think=20
f-string would be more readable for runfetchcmd. f-string are available=20
since python 3.6.

Can you share the rationale for the else clause? I do not see anything=20
inside the else clause that might raise a FetchError, thus the else=20
clause is redundant.

Another change I suggest is to move the rmtree inside the usual=20
need_clone and ignore the error if the path does not exist. Removes=20
another conditional.

I also think using needs_clone to assert whether the rmtree should be=20
done is confusing A different variable should be used or use a=20
function's return value. All the code inside if=20
os.path.exists(ud.clonedir): deals with the need for removal and as a=20
side effect will trigger the clone in another part of the code.




