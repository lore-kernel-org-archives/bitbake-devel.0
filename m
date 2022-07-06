Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C17C433EF
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 15:13:14 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.7441.1657120390149200476
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Jul 2022 08:13:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=EpWm9M/C;
 spf=pass (domain: gmail.com, ip: 209.85.215.171,
 mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pg1-f171.google.com with SMTP id i190so1647190pge.7
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Jul 2022 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buHWxFFKjPj8d2b8CfgyzS7ZwiuXyrrunkFxBkJfrcs=;
        b=EpWm9M/CNID7HC8/H2vj37OO0xLgHJJ6f/SR9dAK/ldwk1gQWAWJ6FOGQ4aLcFc15J
         zIBLCTV1EFHFcP4s4n7tiKS0LaEcq0gKuRA8gkYNlKkIKqxsetMOL5sKIxkUr34bKRQn
         KziziQ6FoQwszppauS/Sbl0LjpsywTb25w6NGZIV9ZdXXnIP7l4gnkPlzdfX5JqJb8ww
         v3X7NoDQww8i2/ahD3ZHMj7CIfpLXDTEUpbevMRz6lilJT8O2t6naKs/jQeSAUyEOBbN
         z36t4Acyus1FaLMbooUZn6r2wPj+ji61ufz+Cj0cxOZpDrbbAPD64HUlRFxns8of6Xqs
         Kdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buHWxFFKjPj8d2b8CfgyzS7ZwiuXyrrunkFxBkJfrcs=;
        b=AbTG02gh5r6GiBrF1Gei0Twaw9BXGZFfTsdbiMq3IC/J546QTu0PIql1SgyxvhYp5F
         qGFo5T+PUnBx6bModK5HQ1Xk3j/3vM47X+lOpzUycajGKYyKFqOMP1QKu41XIz9P48mU
         8K3Rp9Yki+LVgH4GGK+Da8pqftUX/GfpM/DdIhA/kHd4FwaT4UGk6lJC/QQlsYieVbaN
         VfG+M1iYJzDSwkqiedmFJUAGKOWZ0sJGWkZ3mqLl1lID5mda0Asa0WoXSEAw+hnns6wm
         PSMvHrcfpL7+kgRFhJ6suHVUeL6Vun7EFSEHy5/A2JwT+CHNHgQeQWc2PeQbWyCiF0Na
         phzg==
X-Gm-Message-State: AJIora9KPpQax2Uyr4uZ/W67WdE2hNiveDbsbfi7RKrejmu3f+eK8txS
	JPNuPO6piTti73r9ZvHdUOlInbGaNsaBpazqh4E=
X-Google-Smtp-Source: 
 AGRyM1tDQ4qbJ3ol1qNY5VQaNT+p3omhZ+bBXMQqUj30byNli4J6Ufh7S2tBBxnjmH/gQmIJs7gyNydv0roZ8VG5PQ4=
X-Received: by 2002:a63:8341:0:b0:40d:268f:d8ed with SMTP id
 h62-20020a638341000000b0040d268fd8edmr35733276pge.232.1657120389535; Wed, 06
 Jul 2022 08:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220705174630.13360-1-t-maiaxiao@linux.microsoft.com>
In-Reply-To: <20220705174630.13360-1-t-maiaxiao@linux.microsoft.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 6 Jul 2022 11:12:57 -0400
Message-ID: 
 <CADkTA4O_bxHU9hdEiMRo=yKoY1HMd-OCzX2ey9VFJqDs08coJQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Check srcrev exists in
 checkstatus()
To: Maia Xiao <t-maiaxiao@linux.microsoft.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Paul Eggleton <Paul.Eggleton@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Jul 2022 15:13:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13802

On Tue, Jul 5, 2022 at 1:46 PM Maia Xiao <t-maiaxiao@linux.microsoft.com> wrote:
>
> Currently we only check that we can list the remote, but do not validate
> if the srcrev actually exists. Now we ensure that the rev exists by
> attempting to shallow clone it from the remote.
>
> Fixes [YOCTO #11199].
>
> Signed-off-by: Maia Xiao <t-maiaxiao@linux.microsoft.com>
> ---
>  lib/bb/fetch2/git.py  | 28 +++++++++++++++++++++++-----
>  lib/bb/tests/fetch.py | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 5 deletions(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 07b3d9a7..99780de8 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -832,8 +832,26 @@ class Git(FetchMethod):
>              return True, str(rev)
>
>      def checkstatus(self, fetch, ud, d):
> -        try:
> -            self._lsremote(ud, d, "")
> -            return True
> -        except bb.fetch2.FetchError:
> -            return False
> +        repourl = self._get_repo_url(ud)
> +        for name in ud.names:
> +            tmpdir = tempfile.mkdtemp()
> +            revision = ud.revisions[name]
> +
> +            try:
> +                # Initialise an empty git repo for shallow fetching
> +                runfetchcmd("%s init" % ud.basecmd, d, workdir=tmpdir)
> +                runfetchcmd("%s remote add origin %s" %
> +                            (ud.basecmd, shlex.quote(repourl)),
> +                            d,
> +                            workdir=tmpdir)
> +
> +                # Try to fetch only the specified srcrev
> +                runfetchcmd("%s fetch -f --progress --depth 1 origin %s" %

I think this is something that has to be optional, and not always enabled.
I'm sure Richard can advise better than I can on the options for that.

I've written some python modules that do something similar to this, and
there's no guarantee that the git hash you are validating can be reached
with a depth 1 clone. In that case, we need to decide if it's a warning, an
error, or something else.

Bruce

> +                            (ud.basecmd, revision),
> +                            d,
> +                            workdir=tmpdir)
> +            except bb.fetch2.FetchError:
> +                return False
> +            finally:
> +                bb.utils.remove(tmpdir, recurse=True)
> +        return True
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index ee41bff4..00def1bd 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -1478,6 +1478,40 @@ class FetchCheckStatusTest(FetcherTest):
>
>          connection_cache.close_connections()
>
> +    @skipIfNoNetwork()
> +    def test_git_checkstatus(self):
> +        CHECKSTATUS_GOOD_REPO = "git://git.yoctoproject.org/yocto-docs;branch=master"
> +        CHECKSTATUS_GOOD_HASH = "2bd14d3810a68082ce01b459cf2799d796a32e63"
> +
> +        def do_git_checkstatus(url, srcrev):
> +            self.d.setVar("SRCREV", srcrev)
> +            fetch = bb.fetch2.Fetch([url], self.d)
> +            ud = fetch.ud[url]
> +            m = ud.method
> +            return m.checkstatus(fetch, ud, self.d)
> +
> +        # Valid URI + SRCREV returns true
> +        ret = do_git_checkstatus(CHECKSTATUS_GOOD_REPO, CHECKSTATUS_GOOD_HASH)
> +        self.assertTrue(ret,
> +                        msg="URI %s, can't check status" %
> +                        (CHECKSTATUS_GOOD_REPO))
> +
> +        # Unavailable server returns false
> +        invalid_git_uri = 'git://git.test.invalid/yocto-docs;branch=master'
> +        ret = do_git_checkstatus(invalid_git_uri, CHECKSTATUS_GOOD_HASH)
> +        self.assertFalse(
> +            ret,
> +            msg="URI %s, checkstatus() returns true for invalid Git server" %
> +            (invalid_git_uri))
> +
> +        # Invalid/disappeared SRCREV returns false
> +        rev_bad = "f" * 40
> +        ret = do_git_checkstatus(CHECKSTATUS_GOOD_REPO, rev_bad)
> +        self.assertFalse(
> +            ret,
> +            msg="URI %s, REF %s, checkstatus() returns true for invalid ref" %
> +            (CHECKSTATUS_GOOD_REPO, rev_bad))
> +
>
>  class GitMakeShallowTest(FetcherTest):
>      def setUp(self):
> --
> 2.17.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13799): https://lists.openembedded.org/g/bitbake-devel/message/13799
> Mute This Topic: https://lists.openembedded.org/mt/92190251/1050810
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [bruce.ashfield@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

