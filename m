Return-Path: <raj.khem@gmail.com>
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
	[209.85.222.175])
	by mail.openembedded.org (Postfix) with ESMTP id 15A247C27F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 18:31:55 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id q8so8639473qke.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 10:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=r/7BMHio+Ee0n0SVDjUeEH0PC8qJSZOt7urs3SsrVec=;
	b=NUhwnR9hmJwDghRioyIxeQ/q1ABsVJSVrOf5gfgTFX1eJB2wAGm6GkWKiubn5lZbB2
	AOdA6lkZWjYSdSCrZLSObfNdpQxGMLuwDJBqsb6IRyzAQZwUENnQQqSWfM5ZrqAU+dfu
	43OGQSz5rWeBTe0/PuRAgIn6THs4mZY9dDHCpEGRKE11ZJEJJt3J0Vwpa0e3Li8ELnax
	v0FLT36FB8Jk9DfuXudCSijE/mZWGk0B8WHnr9XHLCSxDlFF5qe4lqx1GEbwtGikjsMN
	Tm2mirdr/4pvBMDpetIuXLY5oWLJOFGyHu9ZAxuzch+EKThU8NaRbRd0ptaM5R/K9GOC
	Ji8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=r/7BMHio+Ee0n0SVDjUeEH0PC8qJSZOt7urs3SsrVec=;
	b=EPwoZV6AXC6XdqLU+CjF4uBPghLm/fO9ZQppqZjcXWuSrLiNgmzmbRzKIcRNhBj4yM
	LqCEjSV5nW7SVWE/tUUwwr3hBUVx50RYkFM8sjsx/STu5drp/aIhuEAPd1dS+nzB72lE
	w5mclK6+ZUsQTM4rg6hxQmy4oSPVeg1AKSe3FhFZ2WRJfM9K7sFW4wALzqecn8jfC4GV
	w55lVmeY7kL8TNodNux2LoFh9le4v87LAzeBQEzBxgF7ETLBqvgt+PrqaLItWrcjFHR/
	6doyyGKuwIp8lYY15ijCQUOozszwKNBHx4PkJZyaV4pnMoErj1WweYHHmkLkIZuTidPz
	pFUQ==
X-Gm-Message-State: AJcUukcpKbLOOplwNQl/+7Xdb88ko7vO79jtTQMmydBaJwHbRgTbs8jI
	ucanpFgPVgbhED2hQmEndwpynEs0jxUYqf1/xaw=
X-Google-Smtp-Source: ALg8bN51SK6gOCQZ9+TlA3PtOkMzvgLXzvtoCYoEVRGZ6W5EBSck/vnWwCNUk7aC3j2lWAS9gQoZfGeuhNMjcNAooOc=
X-Received: by 2002:ae9:dc43:: with SMTP id q64mr15821196qkf.223.1547836316623;
	Fri, 18 Jan 2019 10:31:56 -0800 (PST)
MIME-Version: 1.0
References: <20190115213137.113956-1-mark.hatle@windriver.com>
	<20190115213137.113956-2-mark.hatle@windriver.com>
	<CAMKF1srg335yq2xUtiLxvGkXMQPsTga-4UepQzFD0dem3RTrKw@mail.gmail.com>
	<ee28ea34-ed07-47a7-60d2-fdee3473b499@windriver.com>
In-Reply-To: <ee28ea34-ed07-47a7-60d2-fdee3473b499@windriver.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 18 Jan 2019 10:31:30 -0800
Message-ID: <CAMKF1spW09mU-D4U0DwypHxwwEc5NUb1hAA=o-cZi8kpYd+BVA@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/7] gitsm.py: Fix when a submodule is defined, but not initialized
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
X-List-Received-Date: Fri, 18 Jan 2019 18:31:56 -0000
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 18, 2019 at 10:08 AM Mark Hatle <mark.hatle@windriver.com> wrote:
>
> On 1/18/19 9:07 AM, Khem Raj wrote:
> >  I am seeing
> >
> > http://errors.yoctoproject.org/Errors/Details/217408/
> > http://errors.yoctoproject.org/Errors/Details/217412/
>
> Do you know where these failing recipes are so that I can reproduce it locally?
>
> rwmem looks like it might be meta-ti?
> cli11 looks like something from meta-oe.
>

yes thats right.
http://cgit.openembedded.org/meta-openembedded/tree/meta-oe/recipes-support/cli11/cli11_1.6.2.bb?h=master

gitsm version of rwmem is not yes applied in meta-ti so you might have
to get it from my staging branch

https://github.com/YoeDistro/meta-ti/commit/3418beda1869882d5f94dc405d2727f09ffe20c4

> --Mark
>
> > On Tue, Jan 15, 2019 at 1:33 PM Mark Hatle <mark.hatle@windriver.com> wrote:
> >>
> >> It is possible for a submodule to be defined in the .gitmodules file, but
> >> never initialized in the repository itself.  This shows itself when searching
> >> for the defined module hash you will get back a empty value.
> >>
> >> Similarly we need to identify and skip defined but not initialized submodules
> >> during the unpack stages as well.
> >>
> >> Thanks to raphael.lisicki@siemens.com for their help is figuring out how
> >> to resolve this issue.
> >>
> >> Additionally a problem was found where, while unlikely, it may be possible
> >> for the wrong revision to have been searched using ls-tree.  This has been
> >> resolved in the update_submodules function by keeping the correct revision
> >> along with the submodule path.
> >>
> >> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> >> ---
> >>  lib/bb/fetch2/gitsm.py | 32 ++++++++++++++++++++++++++++----
> >>  1 file changed, 28 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> >> index 35729db..b7959ff 100644
> >> --- a/lib/bb/fetch2/gitsm.py
> >> +++ b/lib/bb/fetch2/gitsm.py
> >> @@ -64,6 +64,7 @@ class GitSM(Git):
> >>      def update_submodules(self, ud, d):
> >>          submodules = []
> >>          paths = {}
> >> +        revision = {}
> >>          uris = {}
> >>          local_paths = {}
> >>
> >> @@ -77,6 +78,7 @@ class GitSM(Git):
> >>              for m, md in self.parse_gitmodules(gitmodules).items():
> >>                  submodules.append(m)
> >>                  paths[m] = md['path']
> >> +                revision[m] = ud.revisions[name]
> >>                  uris[m] = md['url']
> >>                  if uris[m].startswith('..'):
> >>                      newud = copy.copy(ud)
> >> @@ -84,7 +86,17 @@ class GitSM(Git):
> >>                      uris[m] = Git._get_repo_url(self, newud)
> >>
> >>          for module in submodules:
> >> -            module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=True, workdir=ud.clonedir)
> >> +            try:
> >> +                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, revision[module], paths[module]), d, quiet=True, workdir=ud.clonedir)
> >> +            except:
> >> +                # If the command fails, we don't have a valid file to check.  If it doesn't
> >> +                # fail -- it still might be a failure, see next check...
> >> +                module_hash = ""
> >> +
> >> +            if not module_hash:
> >> +                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
> >> +                continue
> >> +
> >>              module_hash = module_hash.split()[2]
> >>
> >>              # Build new SRC_URI
> >> @@ -143,7 +155,7 @@ class GitSM(Git):
> >>          if not ud.shallow or ud.localpath != ud.fullshallow:
> >>              self.update_submodules(ud, d)
> >>
> >> -    def copy_submodules(self, submodules, ud, destdir, d):
> >> +    def copy_submodules(self, submodules, ud, name, destdir, d):
> >>          if ud.bareclone:
> >>              repo_conf = destdir
> >>          else:
> >> @@ -156,6 +168,18 @@ class GitSM(Git):
> >>              srcpath = os.path.join(ud.clonedir, 'modules', md['path'])
> >>              modpath = os.path.join(repo_conf, 'modules', md['path'])
> >>
> >> +            # Check if the module is initialized
> >> +            try:
> >> +                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], md['path']), d, quiet=True, workdir=ud.clonedir)
> >> +            except:
> >> +                # If the command fails, we don't have a valid file to check.  If it doesn't
> >> +                # fail -- it still might be a failure, see next check...
> >> +                module_hash = ""
> >> +
> >> +            if not module_hash:
> >> +                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
> >> +                continue
> >> +
> >>              if os.path.exists(srcpath):
> >>                  if os.path.exists(os.path.join(srcpath, '.git')):
> >>                      srcpath = os.path.join(srcpath, '.git')
> >> @@ -188,7 +212,7 @@ class GitSM(Git):
> >>                  continue
> >>
> >>              submodules = self.parse_gitmodules(gitmodules)
> >> -            self.copy_submodules(submodules, ud, dest, d)
> >> +            self.copy_submodules(submodules, ud, name, dest, d)
> >>
> >>      def unpack(self, ud, destdir, d):
> >>          Git.unpack(self, ud, destdir, d)
> >> @@ -211,7 +235,7 @@ class GitSM(Git):
> >>                  continue
> >>
> >>              submodules = self.parse_gitmodules(gitmodules)
> >> -            self.copy_submodules(submodules, ud, ud.destdir, d)
> >> +            self.copy_submodules(submodules, ud, name, ud.destdir, d)
> >>
> >>              submodules_queue = [(module, os.path.join(repo_conf, 'modules', md['path'])) for module, md in submodules.items()]
> >>              while len(submodules_queue) != 0:
> >> --
> >> 1.8.3.1
> >>
> >> --
> >> _______________________________________________
> >> bitbake-devel mailing list
> >> bitbake-devel@lists.openembedded.org
> >> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

