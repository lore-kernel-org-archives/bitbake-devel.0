Return-Path: <pbarker@toganlabs.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id E2754785EE
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Feb 2018 19:25:57 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id x7so11043680wmc.0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Feb 2018 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=toganlabs-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=vu0SucZ5VOiG5I0V9eF12UjYUa0sN4PO5+n85i6XMvg=;
	b=eZgdCydOSSiCX28C4usGKKatMT/Lns1UZQudtqLbjhNY7kr0+wKKsnCf7RTosWXqtV
	9vnnBos0RIgEirDVPHHz900gOLM05khsxaBuaWksxJi8c88bNyADO+HFazjpznDgWOTI
	adSXoeylWvaPrPjSKkom3qW5q/uhKpfy6h7p1f4/7eT6DvD2MC4mOiTMxfkMzIVFbJIf
	E4lUkM0kCzzsuw20esFO2cvi9QUaPiJXHcYMwUzdgr2FenRMjYNmcUAqg+ZnXdUEUdC3
	ACbP5UYdfnCfstGRQzN8hBMOdThbKf89az5ZwMz24ODdZ1EG2vEUKMZkfavZw0dCcZft
	85KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=vu0SucZ5VOiG5I0V9eF12UjYUa0sN4PO5+n85i6XMvg=;
	b=FF+6TNHGFPDCAuAishbX30+MyGxYpA2+l2chs1JIBE7LLbSwELL07tfleZKOWQXXYv
	pVdfvh2Nise8GJivUpdkV+Z2EkkRSMjXIDQ5y9U/DrzEMHT9WULUkdYzCj+So2kAeTRE
	tp4RhHBBCifd5qzlP2xFuWKdgBwEzmXkuVfBKPjmOXUnjmevc5G12uylffSzuzsOTnaw
	+D5IOWevQRpo+MKuFHnsvDLVJPScXkvKPemqTVjg6CTSCTQUwsH9YT6KnJqZH4tSvYmY
	nACf5y5HrCk6PZB3u6hIO0vVaA/NXFEVWd0EIYwLPe3Os1o+OVnE1V1d6nEzYHjxIzHD
	6pQg==
X-Gm-Message-State: APf1xPA+ehCSJn2Sy9EoUC0OR4v97Q9wWjorXA8vzI9gU7kz4OU3MsAP
	/Z31HdebDGVtI8nvvprdheO5i1vQcwZkMqyQzx9ELA==
X-Google-Smtp-Source: AG47ELsGqSYkiDng1180gR29asjq4xP7s5NRrb1D+2g8SVlMHTPExwX/ROIW90EmCevSk2Wd8wKvkxpYHSBfMKrWClk=
X-Received: by 10.28.0.17 with SMTP id 17mr1247066wma.158.1519586758470; Sun,
	25 Feb 2018 11:25:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.153.48 with HTTP; Sun, 25 Feb 2018 11:25:58 -0800 (PST)
In-Reply-To: <1517314210-25684-4-git-send-email-richard.purdie@linuxfoundation.org>
References: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
	<1517314210-25684-4-git-send-email-richard.purdie@linuxfoundation.org>
From: Paul Barker <pbarker@toganlabs.com>
Date: Sun, 25 Feb 2018 19:25:58 +0000
Message-ID: <CAPyrkgwKMnb7OchXGr8OE3f_NK90ehxphS1HzGpOYjuyaKemhQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] runqueue: Rewrite and optimize recrdepends handling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 25 Feb 2018 19:25:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 12:10 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> This is a performance sensitive piece of code and the shear number
> of recursive loops is causing a significant and unscalable performance
> pain point.
>
> This change moves to a two step approach, firstly generating a list of re=
cursive
> dependencies for any task, then applying this to the recursive tasks, ite=
rating
> over things until no further dependencies are added.
>
> It was noticed an optimisation is possible and the list of recursive task=
s need not
> contain the taskname, only the base task id. This allows a significant pe=
rformance
> improvement and limits the size of the resursive task lists, improving sp=
eed.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/runqueue.py | 134 +++++++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 83 insertions(+), 51 deletions(-)
>
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index bbfe9ee..d7acfab 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -74,9 +74,6 @@ def build_tid(mc, fn, taskname):
>          return "multiconfig:" + mc + ":" + fn + ":" + taskname
>      return fn + ":" + taskname
>
> -def tid_replacetask(tid, taskname):
> -    return tid.rsplit(":", 1)[0] + ":" + taskname
> -
>  class RunQueueStats:
>      """
>      Holds statistics on the tasks handled by the associated runQueue
> @@ -670,71 +667,106 @@ class RunQueueData:
>                              recursiveitasks[tid].append(newdep)
>
>                  self.runtaskentries[tid].depends =3D depends
> +                # Remove all self references
> +                self.runtaskentries[tid].depends.discard(tid)
>
>          #self.dump_data()
>
> +        self.init_progress_reporter.next_stage()
> +
>          # Resolve recursive 'recrdeptask' dependencies (Part B)
>          #
>          # e.g. do_sometask[recrdeptask] =3D "do_someothertask"
>          # (makes sure sometask runs after someothertask of all DEPENDS, =
RDEPENDS and intertask dependencies, recursively)
>          # We need to do this separately since we need all of runtaskentr=
ies[*].depends to be complete before this is processed
> -        self.init_progress_reporter.next_stage()
> -        extradeps =3D True
> +
> +        # Generating/interating recursive lists of dependencies is painf=
ul and potentially slow
> +        # Precompute recursive task dependencies here by:
> +        #     a) create a temp list of reverse dependencies (revdeps)
> +        #     b) walk up the ends of the chains (when a given task no lo=
nger has dependencies i.e. len(deps) =3D=3D 0)
> +        #     c) combine the total list of dependencies in cumulativedep=
s
> +        #     d) optimise by pre-truncating 'task' off the items in cumu=
lativedeps (keeps items in sets lower)
> +
> +
> +        revdeps =3D {}
> +        deps =3D {}
> +        cumulativedeps =3D {}
> +        for tid in self.runtaskentries:
> +            deps[tid] =3D set(self.runtaskentries[tid].depends)
> +            revdeps[tid] =3D set()
> +            cumulativedeps[tid] =3D set()
> +        # Generate a temp list of reverse dependencies
> +        for tid in self.runtaskentries:
> +            for dep in self.runtaskentries[tid].depends:
> +                revdeps[dep].add(tid)
> +        # Find the dependency chain endpoints
> +        endpoints =3D set()
> +        for tid in self.runtaskentries:
> +            if len(deps[tid]) =3D=3D 0:
> +                endpoints.add(tid)
> +        # Iterate the chains collating dependencies
> +        while endpoints:
> +            next =3D set()
> +            for tid in endpoints:
> +                for dep in revdeps[tid]:
> +                    cumulativedeps[dep].add(fn_from_tid(tid))
> +                    cumulativedeps[dep].update(cumulativedeps[tid])
> +                    if tid in deps[dep]:
> +                        deps[dep].remove(tid)
> +                    if len(deps[dep]) =3D=3D 0:
> +                        next.add(dep)
> +            endpoints =3D next
> +        #for tid in deps:
> +        #    if len(deps[tid]) !=3D 0:
> +        #        bb.warn("Sanity test failure, dependencies left for %s =
(%s)" % (tid, deps[tid]))
> +
>          # Loop here since recrdeptasks can depend upon other recrdeptask=
s and we have to
>          # resolve these recursively until we aren't adding any further e=
xtra dependencies
> +        extradeps =3D True
>          while extradeps:
> -            extradeps =3D {}
> -
> -            for taskcounter, tid in enumerate(recursivetasks):
> -                extradeps[tid] =3D set()
> -
> +            extradeps =3D 0
> +            for tid in recursivetasks:
>                  tasknames =3D recursivetasks[tid]
> -                seendeps =3D set()
> -                seenbasedeps =3D set()
> -
> -                def generate_recdeps(t):
> -                    newdeps =3D set()
> -                    basetid =3D fn_from_tid(t)
> -                    if basetid not in seenbasedeps:
> -                        for taskname in tasknames:
> -                            newtid =3D tid_replacetask(t, taskname)
> -                            if newtid in self.runtaskentries and newtid =
not in seendeps:
> -                                newdeps.add(newtid)
> -                                extradeps[tid].add(newtid)
> -                        seenbasedeps.add(basetid)
> -                    seendeps.add(t)
> -                    newdeps.add(t)
> -                    for i in newdeps:
> -                        if i not in self.runtaskentries:
> -                            # Not all recipes might have the recrdeptask=
 task as a task
> -                            continue
> -                        for n in self.runtaskentries[i].depends:
> -                            if n not in seendeps:
> -                                 generate_recdeps(n)
> -                generate_recdeps(tid)
>
> +                totaldeps =3D set(self.runtaskentries[tid].depends)
>                  if tid in recursiveitasks:
> +                    totaldeps.update(recursiveitasks[tid])
>                      for dep in recursiveitasks[tid]:
> -                        generate_recdeps(dep)
> +                        if dep not in self.runtaskentries:
> +                            continue
> +                        totaldeps.update(self.runtaskentries[dep].depend=
s)
>
> -            for tid in self.runtaskentries:
> -                # Add in extra dependencies
> -                if tid in extradeps:
> -                     extradeps[tid].difference_update(self.runtaskentrie=
s[tid].depends)
> -                     self.runtaskentries[tid].depends.update(extradeps[t=
id])
> -                     # Remove circular references so that do_a[recrdepta=
sk] =3D "do_a do_b" can work
> -                     self.runtaskentries[tid].depends.difference_update(=
recursivetasksselfref)
> -                     extradeps[tid].difference_update(recursivetasksself=
ref)
> -                     if not len(extradeps[tid]):
> -                         del extradeps[tid]
> -                     if tid not in recursivetasks:
> -                        bb.warn(tid)
> -                # Remove all self references
> -                if tid in self.runtaskentries[tid].depends:
> -                    logger.debug(2, "Task %s contains self reference!", =
tid)
> -                    self.runtaskentries[tid].depends.remove(tid)
> +                deps =3D set()
> +                for dep in totaldeps:
> +                    if dep in cumulativedeps:
> +                        deps.update(cumulativedeps[dep])
> +
> +                for t in deps:
> +                    for taskname in tasknames:
> +                        newtid =3D t + ":" + taskname
> +                        if newtid =3D=3D tid:
> +                            continue
> +                        if newtid in self.runtaskentries and newtid not =
in self.runtaskentries[tid].depends:
> +                            extradeps +=3D 1
> +                            self.runtaskentries[tid].depends.add(newtid)
>
> -            bb.debug(1, "Added %s recursive dependencies in this loop" %=
 len(extradeps))
> +                # Handle recursive tasks which depend upon other recursi=
ve tasks
> +                deps =3D set()
> +                for dep in self.runtaskentries[tid].depends.intersection=
(recursivetasks):
> +                    deps.update(self.runtaskentries[dep].depends.differe=
nce(self.runtaskentries[tid].depends))
> +                for newtid in deps:
> +                    for taskname in tasknames:
> +                        if not newtid.endswith(":" + taskname):
> +                            continue
> +                        if newtid in self.runtaskentries:
> +                            extradeps +=3D 1
> +                            self.runtaskentries[tid].depends.add(newtid)
> +
> +            bb.debug(1, "Added %s recursive dependencies in this loop" %=
 extradeps)
> +
> +        # Remove recrdeptask circular references so that do_a[recrdeptas=
k] =3D "do_a do_b" can work
> +        for tid in self.runtaskentries:
> +            self.runtaskentries[tid].depends.difference_update(recursive=
tasksselfref)
>
>          self.init_progress_reporter.next_stage()
>

I've been having build failures recently which I've tracked down to
this commit in bitbake via git bisect.

I have an image recipe, oryx-image, and a publish recipe,
oryx-publish. In oryx-publish I have a do_publish task that copies
files out of "tmp/deploy/images/*" to their final places and so it
needs to run after the tasks in oryx-image that create the relevant
files. So I've explicitly added oryx-image:do_build to
do_publish[depends].

Via a long and winding inheritance chain, oryx-image inherits meta.bbclass:

    oryx-image
        -> core-image.bbclass
        -> image.bbclass
        -> populate_sdk_ext.bbclass
        -> populate_sdk_base.bbclass
        -> meta.bbclass

In meta.bbclass we have:

        do_build[recrdeptask] =3D "do_build"

So oryx-image:do_build is showing up in recursivetasksselfref and
being dropped from the dep chain. This will occur for any recipe while
pulls in meta.bbclass.

Is it valid to depend on do_build here? Or should I be depending on
something more specific like do_image_complete? I'd prefer to keep the
dependency on do_build as it's safe against any further re-factoring
of tasks within the image recipes.

If what I'm doing is valid, we probably need to fix the logic so that
the self reference is removed from its own set of dependencies but not
from the dependencies of other tasks. If that makes sense.

--=20
Paul Barker
Tog=C3=A1n Labs Ltd

