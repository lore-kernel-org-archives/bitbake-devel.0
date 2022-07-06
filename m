Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F908C43334
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 15:14:14 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web08.7471.1657120446527656610
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Jul 2022 08:14:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Ur+G9oJG;
 spf=pass (domain: gmail.com, ip: 209.85.216.49,
 mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id
 y14-20020a17090a644e00b001ef775f7118so12334592pjm.2
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Jul 2022 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odkXFVRtvgq5BQTPm9c8A52+sWaLhOnR7GDB00xDGMY=;
        b=Ur+G9oJGRgRhPFVgHiCfnUbEPHyo1QiQ15RYvPwxmQHimMAXIlY2O/FHCoI8quZ39h
         eBFljBJjAzGcgT9+SrVv6/uD4fF4BdorvSLT7zGETdwRoBX5BukUJjV/hhTO9SSKbSil
         UB8jfJ3nfMwGBvS6DTl+EE4ecdrMF6DKf8r/tsUYIyZe/IkXXGwHiBpwCzPjZ7zMLwN0
         LUVH3t4GSRD/+ORZuyOJ45vCr6THW/vbqtUFwbz67DTop0CNTpWmkvHqFJksEj4EfI+B
         BW4Nj32N56pViZ0E3gPR/nDxN1Pg/RqfCaOH3ilhCUD5qvlQ20lVPy9uTpZvK9bKLn9u
         2TcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odkXFVRtvgq5BQTPm9c8A52+sWaLhOnR7GDB00xDGMY=;
        b=FlG414rsJTTX2cmj+kuJw1DNsEMfJA16+j7Oevgx21mLFHfDtuy1Qrg5cIW9UzN0Dn
         JAK2ofJso0GuxvLMugOvWHuYmPmPs0DYoucBrmniIhOeEtLBv1MryuuI9//KgfVp+f/4
         MQzQEPS//gHR9KzlySxr1yOe1AqfkTsny0XwTQHNgv4pOUuqoXo4a2Jj9f9lzohAJK0r
         j694AgsKVYeeVBZZmRmjzMGP4yqKiSlBpkGOHRBe99+fvTNTgjCSNlLPTWlTWnuFYIQI
         PLrtz/z0pgnskx36PFZ6svfFQ2NJ4FC04nnfxgI7l3HcrNRIj+ZwT+fcUdiaBCQqTiMS
         KXqA==
X-Gm-Message-State: AJIora98aLActrMZrUFoEdScctdV96TW9t/hPnacMQxZP7dqMmR6ZwRV
	B+tjCyP9Nh2pHefelO7aANE22j/2esxZNOSjXrI=
X-Google-Smtp-Source: 
 AGRyM1vDxlxFfD3e+z27eispI4/keFzW83yArDgahCxKMOyimZ6bGnXOE3/reJrzWUwYMejM3t2q6Em3UWe2ZCYAxJA=
X-Received: by 2002:a17:90b:1807:b0:1ef:8aa5:1158 with SMTP id
 lw7-20020a17090b180700b001ef8aa51158mr19373974pjb.163.1657120445914; Wed, 06
 Jul 2022 08:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220705174630.13360-1-t-maiaxiao@linux.microsoft.com>
 <CADkTA4O_bxHU9hdEiMRo=yKoY1HMd-OCzX2ey9VFJqDs08coJQ@mail.gmail.com>
In-Reply-To: 
 <CADkTA4O_bxHU9hdEiMRo=yKoY1HMd-OCzX2ey9VFJqDs08coJQ@mail.gmail.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 6 Jul 2022 11:13:53 -0400
Message-ID: 
 <CADkTA4P_9hfBFO1Pbj+cMpiaBQPL3xaCOPgnRYnO=tyKVS0n-g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Check srcrev exists in
 checkstatus()
To: Maia Xiao <t-maiaxiao@linux.microsoft.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Paul Eggleton <Paul.Eggleton@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Jul 2022 15:14:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13803

On Wed, Jul 6, 2022 at 11:12 AM Bruce Ashfield <bruce.ashfield@gmail.com> wrote:
>
> On Tue, Jul 5, 2022 at 1:46 PM Maia Xiao <t-maiaxiao@linux.microsoft.com> wrote:
> >
> > Currently we only check that we can list the remote, but do not validate
> > if the srcrev actually exists. Now we ensure that the rev exists by
> > attempting to shallow clone it from the remote.
> >
> > Fixes [YOCTO #11199].
> >
> > Signed-off-by: Maia Xiao <t-maiaxiao@linux.microsoft.com>
> > ---
> >  lib/bb/fetch2/git.py  | 28 +++++++++++++++++++++++-----
> >  lib/bb/tests/fetch.py | 34 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 57 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index 07b3d9a7..99780de8 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -832,8 +832,26 @@ class Git(FetchMethod):
> >              return True, str(rev)
> >
> >      def checkstatus(self, fetch, ud, d):
> > -        try:
> > -            self._lsremote(ud, d, "")
> > -            return True
> > -        except bb.fetch2.FetchError:
> > -            return False
> > +        repourl = self._get_repo_url(ud)
> > +        for name in ud.names:
> > +            tmpdir = tempfile.mkdtemp()
> > +            revision = ud.revisions[name]
> > +
> > +            try:
> > +                # Initialise an empty git repo for shallow fetching
> > +                runfetchcmd("%s init" % ud.basecmd, d, workdir=tmpdir)
> > +                runfetchcmd("%s remote add origin %s" %
> > +                            (ud.basecmd, shlex.quote(repourl)),
> > +                            d,
> > +                            workdir=tmpdir)
> > +
> > +                # Try to fetch only the specified srcrev
> > +                runfetchcmd("%s fetch -f --progress --depth 1 origin %s" %
>
> I think this is something that has to be optional, and not always enabled.
> I'm sure Richard can advise better than I can on the options for that.
>

Actually never mind on this first point, assuming that this isn't run on all
fetch paths (I didn't check that).

But my second comment about the depth is something to consider.

Bruce

> I've written some python modules that do something similar to this, and
> there's no guarantee that the git hash you are validating can be reached
> with a depth 1 clone. In that case, we need to decide if it's a warning, an
> error, or something else.
>
> Bruce
>
> > +                            (ud.basecmd, revision),
> > +                            d,
> > +                            workdir=tmpdir)
> > +            except bb.fetch2.FetchError:
> > +                return False
> > +            finally:
> > +                bb.utils.remove(tmpdir, recurse=True)
> > +        return True
> > diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> > index ee41bff4..00def1bd 100644
> > --- a/lib/bb/tests/fetch.py
> > +++ b/lib/bb/tests/fetch.py
> > @@ -1478,6 +1478,40 @@ class FetchCheckStatusTest(FetcherTest):
> >
> >          connection_cache.close_connections()
> >
> > +    @skipIfNoNetwork()
> > +    def test_git_checkstatus(self):
> > +        CHECKSTATUS_GOOD_REPO = "git://git.yoctoproject.org/yocto-docs;branch=master"
> > +        CHECKSTATUS_GOOD_HASH = "2bd14d3810a68082ce01b459cf2799d796a32e63"
> > +
> > +        def do_git_checkstatus(url, srcrev):
> > +            self.d.setVar("SRCREV", srcrev)
> > +            fetch = bb.fetch2.Fetch([url], self.d)
> > +            ud = fetch.ud[url]
> > +            m = ud.method
> > +            return m.checkstatus(fetch, ud, self.d)
> > +
> > +        # Valid URI + SRCREV returns true
> > +        ret = do_git_checkstatus(CHECKSTATUS_GOOD_REPO, CHECKSTATUS_GOOD_HASH)
> > +        self.assertTrue(ret,
> > +                        msg="URI %s, can't check status" %
> > +                        (CHECKSTATUS_GOOD_REPO))
> > +
> > +        # Unavailable server returns false
> > +        invalid_git_uri = 'git://git.test.invalid/yocto-docs;branch=master'
> > +        ret = do_git_checkstatus(invalid_git_uri, CHECKSTATUS_GOOD_HASH)
> > +        self.assertFalse(
> > +            ret,
> > +            msg="URI %s, checkstatus() returns true for invalid Git server" %
> > +            (invalid_git_uri))
> > +
> > +        # Invalid/disappeared SRCREV returns false
> > +        rev_bad = "f" * 40
> > +        ret = do_git_checkstatus(CHECKSTATUS_GOOD_REPO, rev_bad)
> > +        self.assertFalse(
> > +            ret,
> > +            msg="URI %s, REF %s, checkstatus() returns true for invalid ref" %
> > +            (CHECKSTATUS_GOOD_REPO, rev_bad))
> > +
> >
> >  class GitMakeShallowTest(FetcherTest):
> >      def setUp(self):
> > --
> > 2.17.1
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#13799): https://lists.openembedded.org/g/bitbake-devel/message/13799
> > Mute This Topic: https://lists.openembedded.org/mt/92190251/1050810
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [bruce.ashfield@gmail.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
>
>
> --
> - Thou shalt not follow the NULL pointer, for chaos and madness await
> thee at its end
> - "Use the force Harry" - Gandalf, Star Trek II



-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

