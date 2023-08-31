Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71C4C83F01
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 12:21:35 +0000 (UTC)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 by mx.groups.io with SMTP id smtpd.web10.15489.1693484490851380121
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Aug 2023 05:21:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@myneves.com header.s=protonmail2 header.b=kj+14noT;
 spf=pass (domain: myneves.com, ip: 185.70.40.136, mailfrom: paulo@myneves.com)
Date: Thu, 31 Aug 2023 12:21:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail2; t=1693484487; x=1693743687;
	bh=jIYUd+7k5L+hMJPzgEFaBQ88ImsckmCnr3E2SCK2ACQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kj+14noTZwqQ+BAMFgLte0A4IgBR+XDHGXTYSWslttSpmNl4q2GhUFbO2n8WbRPiQ
	 qxxpgVq5ufRT5h6fWHR0lw8QK5pd6l9TzRpRTtgBcPNd9PdmoZOnNOlkriTH+MWWqd
	 d6u6f9ksgXC2xftbd1IUtsHATKFt4KhTRN83Hjy7V7W88Nicb8JtcP3BozDl6pu48G
	 JYgpWUDGyA1MHpIW/pDgapdgpYFNsOAhFxF3aChQNC6UoL5O5UvGMZpdmxTxUXP+W0
	 KTPqQS0+fvS4V8LB/8sXSDnvb90LD+kcxYl1JdtKDDB/qYTaRiwUFm+v0ArTN7ojnT
	 3lvCGWxVM5Gng==
To: Joshua Watt <JPEWhacker@gmail.com>
From: Paulo Neves <paulo@myneves.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][PATCH v2] fetch2: git: Check if clone directory is a git repo
Message-ID: <9bf28e85-a821-0026-1802-457f87bfff2b@myneves.com>
In-Reply-To: <CAJdd5GbTpHVu7cVWia8PHbjWV=cS7MESjJx3j810OU09F9nXEQ@mail.gmail.com>
References: <20230804155424.1502010-1-JPEWhacker@gmail.com> <20230824195332.851528-1-JPEWhacker@gmail.com> <50329c34-b057-3542-4c45-047e6b24169b@myneves.com> <CAJdd5GbTpHVu7cVWia8PHbjWV=cS7MESjJx3j810OU09F9nXEQ@mail.gmail.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 12:21:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14998

On 25/08/2023 16:19, Joshua Watt wrote:
> On Fri, Aug 25, 2023 at 3:18=E2=80=AFAM Paulo Neves <paulo@myneves.com> w=
rote:
>> On 24/08/2023 21:53, Joshua Watt wrote:
>>> If the clone target directory exists and is a valid git repo, but the
>>> git directory is not a child, it needs to be erased and re-cloned. One
>>> example of how this can happen is if a clone creates the directory, but
>>> then fails to actual clone and make it a git repository. This left-over
>>> directory can be particularly problematic if the download directory is =
a
>>> descent of some top layer git repo (e.g. the default with poky), as the
>>> commands that operate on the remote later will then mangle the layers
>>> git repository instead of the download git repo.
>>>
>>> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>>> ---
>>>    bitbake/lib/bb/fetch2/git.py | 30 +++++++++++++++++++++++++++++-
>>>    1 file changed, 29 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.p=
y
>>> index 2a3c06fe4e9..33895e09b29 100644
>>> --- a/bitbake/lib/bb/fetch2/git.py
>>> +++ b/bitbake/lib/bb/fetch2/git.py
>>> @@ -65,6 +65,7 @@ import fnmatch
>>>    import os
>>>    import re
>>>    import shlex
>>> +import shutil
>>>    import subprocess
>>>    import tempfile
>>>    import bb
>>> @@ -365,8 +366,35 @@ class Git(FetchMethod):
>>>                    runfetchcmd(fetch_cmd, d, workdir=3Dud.clonedir)
>>>            repourl =3D self._get_repo_url(ud)
>>>
>>> +        needs_clone =3D False
>>> +        if os.path.exists(ud.clonedir):
>>> +            # The directory may exist, but not be the top level of a b=
are git
>>> +            # repository in which case it needs to be deleted and re-c=
loned.
>>> +            try:
>>> +                # Since clones can be bare, use --absolute-git-dir ins=
tead of --show-toplevel
>>> +                output =3D runfetchcmd("LANG=3DC %s rev-parse --absolu=
te-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
>>> +            except bb.fetch2.FetchError as e:
>>> +                logger.warning("Unable to get top level for %s (not a =
git directory?): %s", ud.clonedir, e)
>>> +                needs_clone =3D True
>>> +            else:
>>> +                toplevel =3D os.path.abspath(output.rstrip())
>>> +                abs_clonedir =3D os.path.abspath(ud.clonedir).rstrip('=
/')
>>> +                # The top level Git directory must either be the clone=
 directory
>>> +                # or a child of the clone directory. Any ancestor dire=
ctory of
>>> +                # the clone directory is not valid as the Git director=
y (and
>>> +                # probably belongs to some other unrelated repository)=
, so a
>>> +                # clone is required
>>> +                if os.path.commonprefix([abs_clonedir, toplevel]) !=3D=
 abs_clonedir:
>>> +                    logger.warning("Top level directory '%s' doesn't m=
atch expected '%s'. Re-cloning", toplevel, ud.clonedir)
>>> +                    needs_clone =3D True
>>> +
>>> +            if needs_clone:
>>> +                shutil.rmtree(ud.clonedir)
>>> +        else:
>>> +            needs_clone =3D True
>>> +
>>>            # If the repo still doesn't exist, fallback to cloning it
>>> -        if not os.path.exists(ud.clonedir):
>>> +        if needs_clone:
>>>                # We do this since git will use a "-l" option automatica=
lly for local urls where possible,
>>>                # but it doesn't work when git/objects is a symlink, onl=
y works when it is a directory.
>>>                if repourl.startswith("file://"):
>>> --
>>> 2.33.0
>>>
>>>
>>>
>>>
>> Is it possible to factor the try/except else to a function? Then we
>> would not need the else, and would just return immediately and have a
>> self contained code, which in my opinion is easier to read. I also think
>> f-string would be more readable for runfetchcmd. f-string are available
>> since python 3.6.
>>
>> Can you share the rationale for the else clause? I do not see anything
>> inside the else clause that might raise a FetchError, thus the else
>> clause is redundant.
> The else clause is pretty much the entire reason for this patch in the
> first place :)
>
> The problem is that the fetcher assumes that the simple existence of
> the download directory means it can can add a remote and clone there,
> but that is not true. If your clone directory is a subdirectory of
> another git repository, but not a git repository itself, bitbake will
> (incorrectly) add the remote the higher level git repos and fetch
> there, leaving it a mess.
>
> More visually, if your layout is like this:
>
>   poky <-- This is a git repository
>     build
>        downloads
>            git2
>              foo <-- This is NOT a git repository
>
> The old code would see that the foo directory existed, see that it was
> part of a git repo (poky!) add the remotes and start cloning objects
> into the poky git repo, which is not at all what we want.
>
> The else clause corrects this as it makes the fetcher check if "foo"
> is not only a git repo, but that the it is the toplevel of a git repo
> (or at least that it's --git-dir is not a parent of that directory).
> If it's not, it deletes it because it's not a valid place to clone
> things into anymore.

I understand the conceptual point of the patch and I think it is valid.=20
What i mean is that you do not need the else clause. The code under the=20
else clause can continue inside the try clause and not change the logic.=20
The try-else idiom is very unusual and represents a meaning which is not=20
needed here: That the code inside the else should not trigger the except=20
clause.

>> Another change I suggest is to move the rmtree inside the usual
>> need_clone and ignore the error if the path does not exist. Removes
>> another conditional.
>>
>> I also think using needs_clone to assert whether the rmtree should be
>> done is confusing A different variable should be used or use a
>> function's return value. All the code inside if
>> os.path.exists(ud.clonedir): deals with the need for removal and as a
>> side effect will trigger the clone in another part of the code.
>>
>>
>>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14984): https://lists.openembedded.org/g/bitbake-deve=
l/message/14984
> Mute This Topic: https://lists.openembedded.org/mt/100942876/4454782
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [paulo@=
myneves.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>



