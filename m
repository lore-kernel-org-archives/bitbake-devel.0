Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52DEC433FE
	for <webhook@archiver.kernel.org>; Fri, 18 Feb 2022 07:44:35 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by mx.groups.io with SMTP id smtpd.web10.8195.1645170274349384264
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 23:44:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=j9CktS6V;
 spf=pass (domain: gmail.com, ip: 209.85.217.54,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-vs1-f54.google.com with SMTP id g21so9028598vsp.6
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 23:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYkuTeSvFW+7HPmF17QQzQh7FKLiYHiq7WX8oAq4k3A=;
        b=j9CktS6Vw/60ygG/cTToA60lHpjidaqSG7Nfw6kC8fHES7MUeJbZIkuj9SCA8mOWvI
         IaewVUnEqm7pzYmzVSnbvGRBzouJH+n0rB05L94cyRluFvXDH+op+gUgiVHL0j7UQKoh
         0MrO+3Kl47T8osPnPj9aond4gkmCSsc9PQ8JEnvltHxqw6qJuBbGx62EUeES0QW652iB
         C3CgNMjIGG/Hma8r7+s+44KtdT90tsgtXZo6A8qb1Htkh/3LjXiirx1EyHPh3SKcFXNB
         Xq8dePLYP6T9AwgUtFswhzVNON23otIBbbCjWP8V/egDXDXQNd6DhOLaKAMK2BBNopst
         yEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYkuTeSvFW+7HPmF17QQzQh7FKLiYHiq7WX8oAq4k3A=;
        b=A4cQy10Ib8fkhMGeEoExZ2wOn/3d006CFgU5s9T+y2XaLtKL1rEW3dLwHg12/S+0u2
         AF+MmcvojGQrfUo6ySgSK3NtdHWfJdMljMenzngS+6ic0BLFRN05dt0xpn7ov4k9KayP
         yFeZF5x6e476vE1CqsC6e3jLMWWALUJMHCDdZvXgvLV3xP2u45XR2l4CTBC+SxM1kXHs
         3FTnV+K2M3wU+R+dRdAjMxbCPx2qHfmk2MttQMwDAS7HjtRN/Z0K5/kiTJ02DimEgUoc
         juYnGEbs6UaPzholOiIMCxkPq4kNOqhD8OZy9i/XOPt9KPwUqH4ktlilh3rMGxyzy8cM
         ySTQ==
X-Gm-Message-State: AOAM531ZlQNKNVjVvzuXW8K5LEMTP5o4ryba9kRBC6zkfqxkgKQDIM4Z
	EDqXx6KDAHp/qhwPWe2ZhMxLz5pB0QKTT85HWhU=
X-Google-Smtp-Source: 
 ABdhPJxwgMrbeuXgAlx7+CeZkdzHKzxhhonwGZnB9nY0I9CAb4cK7QreIGBnwkI1j1UAVIPBChFrSrkw0zB5Xz3k/hI=
X-Received: by 2002:a67:e087:0:b0:31b:57fe:7ac1 with SMTP id
 f7-20020a67e087000000b0031b57fe7ac1mr2885028vsl.81.1645170273387; Thu, 17 Feb
 2022 23:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20220210175426.2695614-1-richard.purdie@linuxfoundation.org>
 <bbab3b39fefc448199235b2c458ba378@axis.com>
 <8229aa5ea01b346aa9c2519c7c46883e4c06b48b.camel@linuxfoundation.org>
In-Reply-To: 
 <8229aa5ea01b346aa9c2519c7c46883e4c06b48b.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 18 Feb 2022 08:44:22 +0100
Message-ID: 
 <CANNYZj8mR7Ov9w+=b3mv1QVLc_0G9Nusj1D3ZmzYq3yn3pA5MA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/cooker: Fix source revision
 handling with floating upstreams
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Feb 2022 07:44:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13365

This change broke upstream version checks. Also, 'KeyError:
'git:git.yoctoproject.org.dbus-waitmaster' looks odd - where's the
separator?

alex@nereus:~/development/poky/build-64-alt$ devtool
check-upgrade-status dbus-wait
NOTE: Starting bitbake server...
NOTE: Reconnecting to bitbake server...
NOTE: Previous bitbake instance shutting down?, waiting to retry...
NOTE: Retrying server connection (#1)...
Loading cache: 100%
|###############################################################################################################################################################################|
Time: 0:00:00
Loaded 1518 entries from dependency cache.
Parsing recipes: 100%
|#############################################################################################################################################################################|
Time: 0:00:01
Parsing of 843 .bb files complete (697 cached, 146 parsed). 1518
targets, 35 skipped, 0 masked, 0 errors.
concurrent.futures.process._RemoteTraceback:
"""
Traceback (most recent call last):
  File "/home/alex/development/poky/bitbake/lib/bb/fetch2/__init__.py",
line 1610, in latest_revision
    return revs[key]
  File "/home/alex/development/poky/bitbake/lib/bb/persist_data.py",
line 50, in wrap_func
    return f(self, *args, **kwargs)
  File "/home/alex/development/poky/bitbake/lib/bb/persist_data.py",
line 79, in wrap_func
    return f(self, cursor, *args, **kwargs)
  File "/home/alex/development/poky/bitbake/lib/bb/persist_data.py",
line 165, in __getitem__
    raise KeyError(key)
KeyError: 'git:git.yoctoproject.org.dbus-waitmaster'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/lib/python3.8/concurrent/futures/process.py", line 239,
in _process_worker
    r = call_item.fn(*call_item.args, **call_item.kwargs)
  File "/usr/lib/python3.8/concurrent/futures/process.py", line 198,
in _process_chunk
    return [fn(*args) for args in chunk]
  File "/usr/lib/python3.8/concurrent/futures/process.py", line 198,
in <listcomp>
    return [fn(*args) for args in chunk]
  File "/home/alex/development/poky/meta/lib/oe/recipeutils.py", line
1052, in _get_recipe_upgrade_status
    uv = get_recipe_upstream_version(data)
  File "/home/alex/development/poky/meta/lib/oe/recipeutils.py", line
1032, in get_recipe_upstream_version
    revision = ud.method.latest_revision(ud, rd, 'default')
  File "/home/alex/development/poky/bitbake/lib/bb/fetch2/__init__.py",
line 1612, in latest_revision
    revs[key] = rev = self._latest_revision(ud, d, name)
  File "/home/alex/development/poky/bitbake/lib/bb/fetch2/git.py",
line 731, in _latest_revision
    raise bb.fetch2.FetchError("Recipe uses a floating tag/branch
without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use
SRCPV in PV for OE).")
bb.fetch2.FetchError: Fetcher failure: Recipe uses a floating
tag/branch without a fixed SRCREV yet doesn't call
bb.fetch2.get_srcrev() (use SRCPV in PV for OE).
"""

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/home/alex/development/poky/scripts/devtool", line 334, in <module>
    ret = main()
  File "/home/alex/development/poky/scripts/devtool", line 321, in main
    ret = args.func(args, config, basepath, workspace)
  File "/home/alex/development/poky/scripts/lib/devtool/upgrade.py",
line 617, in check_upgrade_status
    for result in results:
  File "/usr/lib/python3.8/concurrent/futures/process.py", line 484,
in _chain_from_iterable_of_lists
    for element in iterable:
  File "/usr/lib/python3.8/concurrent/futures/_base.py", line 611, in
result_iterator
    yield fs.pop().result()
  File "/usr/lib/python3.8/concurrent/futures/_base.py", line 432, in result
    return self.__get_result()
  File "/usr/lib/python3.8/concurrent/futures/_base.py", line 388, in
__get_result
    raise self._exception
bb.fetch2.FetchError: Fetcher failure: Recipe uses a floating
tag/branch without a fixed SRCREV yet doesn't call
bb.fetch2.get_srcrev() (use SRCPV in PV for OE).


Alex

On Mon, 14 Feb 2022 at 00:51, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Sun, 2022-02-13 at 22:13 +0000, Peter Kjellerstedt wrote:
> > > -----Original Message-----
> > > From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Richard Purdie
> > > Sent: den 10 februari 2022 18:54
> > > To: bitbake-devel@lists.openembedded.org
> > > Subject: [bitbake-devel] [PATCH] fetch2/cooker: Fix source revision handling with floating upstreams
> > >
> > > Where a git url uses a tag instead of a full source revision, breakage
> > > can currently occur in builds. Issues include:
> > >
> > > * the revision being looked up in multiple tasks (fetch and unpack)
> > > * the risk a different revision may be obtained in those tasks
> > > * that some tasks may not be allowed to access the network
> > > * that a revision may not be consistent throughout a given build
> > > * rerunning a specific task may given inconsistent results
> > >
> > > To fix this, stop the workers from cleaning out the source revision store. This
> > > should only be done in the cooker itself (based on current policy).
> > >
> > > Also, where the code "sees" an upstream access, mark the recipe as not to be
> > > cached. The reparse re-triggers the upstream lookup by the server.
> > >
> > > Add a test to ensure that if get_srcrev isn't called, the user is told they're
> > > using a configuration that is known to break.
> > >
> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > ---
> > >  bin/bitbake-worker        | 2 +-
> > >  lib/bb/cookerdata.py      | 4 ++--
> > >  lib/bb/fetch2/__init__.py | 1 +
> > >  lib/bb/fetch2/git.py      | 6 ++++++
> > >  4 files changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> > > index 063cf37926..9d850ec77c 100755
> > > --- a/bin/bitbake-worker
> > > +++ b/bin/bitbake-worker
> > > @@ -440,7 +440,7 @@ class BitbakeWorker(object):
> > >      def handle_cookercfg(self, data):
> > >          self.cookercfg = pickle.loads(data)
> > >          self.databuilder = bb.cookerdata.CookerDataBuilder(self.cookercfg, worker=True)
> > > -        self.databuilder.parseBaseConfiguration()
> > > +        self.databuilder.parseBaseConfiguration(worker=True)
> > >          self.data = self.databuilder.data
> > >
> > >      def handle_extraconfigdata(self, data):
> > > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> > > index 397b43dfa7..a961f36574 100644
> > > --- a/lib/bb/cookerdata.py
> > > +++ b/lib/bb/cookerdata.py
> > > @@ -258,12 +258,12 @@ class CookerDataBuilder(object):
> > >          self.data = self.basedata
> > >          self.mcdata = {}
> > >
> > > -    def parseBaseConfiguration(self):
> > > +    def parseBaseConfiguration(self, worker=False):
> > >          data_hash = hashlib.sha256()
> > >          try:
> > >              self.data = self.parseConfigurationFiles(self.prefiles, self.postfiles)
> > >
> > > -            if self.data.getVar("BB_WORKERCONTEXT", False) is None:
> > > +            if self.data.getVar("BB_WORKERCONTEXT", False) is None and not worker:
> > >                  bb.fetch.fetcher_init(self.data)
> > >              bb.parse.init_parser(self.data)
> > >              bb.codeparser.parser_cache_init(self.data)
> > > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > > index 28a3e54c7f..d099cd1092 100644
> > > --- a/lib/bb/fetch2/__init__.py
> > > +++ b/lib/bb/fetch2/__init__.py
> > > @@ -765,6 +765,7 @@ def get_srcrev(d, method_name='sortable_revision'):
> > >      that fetcher provides a method with the given name and the same signature as sortable_revision.
> > >      """
> > >
> > > +    d.setVar("__BBSEENSRCREV", "1")
> > >      recursion = d.getVar("__BBINSRCREV")
> > >      if recursion:
> > >          raise FetchError("There are recursive references in fetcher variables, likely through SRC_URI")
> > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > > index 30da8e95b7..836ef1c49a 100644
> > > --- a/lib/bb/fetch2/git.py
> > > +++ b/lib/bb/fetch2/git.py
> > > @@ -727,6 +727,12 @@ class Git(FetchMethod):
> > >          """
> > >          Compute the HEAD revision for the url
> > >          """
> > > +        if not d.getVar("__BBSEENSRCREV"):
> > > +            raise bb.fetch2.FetchError("Recipe uses a floating tag/branch without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE).")
> >
> > This does not seem correct. We use SRCREV = "<tag>" for all our own recipes.
>
> In that case you do have the potential issue described in this bug where
> revision resolution can hit the network unexpectedly. Since you're using
> BB_SRCREV_POLICY of cache, you probably would need to do a -c fetch on a recipe,
> delete the cache, then do a -c unpack at which point you'd hit a network error
> if your system supports the unshare call. I'd agree that is a bit more contrived
> than the usual cache of the clear policy but the risk is still there.
>
> I'd suggest you add something which triggers if even if it isn't PV, so that the
> network resolution happens deterministicly at parse time.
>
> > However, we never use ${SRCPV} if SRCREV is set to a tag that matches PV.
> > Why should we? We only use it if the SRCREV _does not_ match PV.
> >
> > > +
> > > +        # Ensure we mark as not cached
> > > +        bb.fetch2.get_autorev(d)
> > > +
> >
> > How will this affect us that use BB_SRCREV_POLICY = "cache", which we do to
> > avoid unnecessary `git ls-remote` since we know our own tags do not move?
>
>
> def get_autorev(d):
>     #  only not cache src rev in autorev case
>     if d.getVar('BB_SRCREV_POLICY') != "cache":
>         d.setVar('BB_DONT_CACHE', '1')
>     return "AUTOINC"
>
> so the answer with that cache policy is that line of code won't affect you.
>
> Cheers,
>
> Richard
>
>
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13344): https://lists.openembedded.org/g/bitbake-devel/message/13344
> Mute This Topic: https://lists.openembedded.org/mt/89051455/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

