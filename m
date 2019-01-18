Return-Path: <raj.khem@gmail.com>
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
	[209.85.222.175])
	by mail.openembedded.org (Postfix) with ESMTP id 9D6CF7C076
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 15:08:14 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id c21so8201759qkl.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 07:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=9PH6cBwwkgNgSJGm/7FacFRfkCAvg4qup1MRAdJa+Qc=;
	b=f+PMKbWGWtlsZkSDLs7ricJqHPbChMMD04dikPKztNAfr1By55FcMsDIZq2AulF8ot
	LScRqibT4GZcfDGdB9pUIa0SoaTbU3mHC3kFAhT5pqsYMjGNNslFWJ6lLqc5IMozK7xj
	gcBZpo3PQznvIXkr0R5ArBihl0rYT0Y1yP7TgkLtbOV1dHDs/sRT8Nl8MKRW4+25grjS
	MgNjQw0aMM20BfdDAtmcR7S49eKLyRNr62LSBpo/jD/HyGFeQttYbKuNo4ojTfTGA2/i
	4JKFkIWLY7qWZ8XPov5mmVeIR8TsyhcdXjVedQG1OpesiyVCIogjJdG5oSII4YdDalEQ
	2fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=9PH6cBwwkgNgSJGm/7FacFRfkCAvg4qup1MRAdJa+Qc=;
	b=lXCv5jWGK3w3BsG8lEfmSmcbAkDPJ5j4/faEv40VZBhBsHTxec3tImEFfchJKZ8mKv
	t3nISifCqYmU/g6ItLyxQNP7KuvQ9R58VK7Ggt/G35SJ1kFNN8nfuF2LnxvXHMCDA8TG
	Lt8meQHrxKLjlZy/BgaPZv+9OmmIad5+Normj9FI7hJXOzr2Q3jHad7QKeLrgQq/0mmW
	KCU8gwsnIxXNvGwqRErGhCN2Ze3R3LlJumiM3rfFjKZyiAgSskOVBpt9lpVc9ttQ4SEq
	aScWzorRNbdiIcfdwAtSI7Y8qo+OcOQZJ8jTGGnImv0X55vG6wwFPheUBDJBqSa3ApO0
	QMWA==
X-Gm-Message-State: AJcUukfyzrecxwq2iV3w5HPbH/fevOnYx/mC3n/T7Ebeyiey2lBjjtms
	wbrui7Ltd9fpNQK/ouIRMWgN21HGAHUCVQxvInU=
X-Google-Smtp-Source: ALg8bN7EvuIE4/gEn8WLjQTadRcSrK/tObdbLViuQUWZqdSRCJkZH1M4nMfCaOJoulRJD4S+tC2mV8V2YAVeOjyJOiE=
X-Received: by 2002:a37:d408:: with SMTP id l8mr15237172qki.315.1547824095293; 
	Fri, 18 Jan 2019 07:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20190115213137.113956-1-mark.hatle@windriver.com>
	<20190115213137.113956-2-mark.hatle@windriver.com>
In-Reply-To: <20190115213137.113956-2-mark.hatle@windriver.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 18 Jan 2019 07:07:49 -0800
Message-ID: <CAMKF1srg335yq2xUtiLxvGkXMQPsTga-4UepQzFD0dem3RTrKw@mail.gmail.com>
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
X-List-Received-Date: Fri, 18 Jan 2019 15:08:14 -0000
Content-Type: text/plain; charset="UTF-8"

 I am seeing

http://errors.yoctoproject.org/Errors/Details/217408/
http://errors.yoctoproject.org/Errors/Details/217412/

On Tue, Jan 15, 2019 at 1:33 PM Mark Hatle <mark.hatle@windriver.com> wrote:
>
> It is possible for a submodule to be defined in the .gitmodules file, but
> never initialized in the repository itself.  This shows itself when searching
> for the defined module hash you will get back a empty value.
>
> Similarly we need to identify and skip defined but not initialized submodules
> during the unpack stages as well.
>
> Thanks to raphael.lisicki@siemens.com for their help is figuring out how
> to resolve this issue.
>
> Additionally a problem was found where, while unlikely, it may be possible
> for the wrong revision to have been searched using ls-tree.  This has been
> resolved in the update_submodules function by keeping the correct revision
> along with the submodule path.
>
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  lib/bb/fetch2/gitsm.py | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 35729db..b7959ff 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -64,6 +64,7 @@ class GitSM(Git):
>      def update_submodules(self, ud, d):
>          submodules = []
>          paths = {}
> +        revision = {}
>          uris = {}
>          local_paths = {}
>
> @@ -77,6 +78,7 @@ class GitSM(Git):
>              for m, md in self.parse_gitmodules(gitmodules).items():
>                  submodules.append(m)
>                  paths[m] = md['path']
> +                revision[m] = ud.revisions[name]
>                  uris[m] = md['url']
>                  if uris[m].startswith('..'):
>                      newud = copy.copy(ud)
> @@ -84,7 +86,17 @@ class GitSM(Git):
>                      uris[m] = Git._get_repo_url(self, newud)
>
>          for module in submodules:
> -            module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=True, workdir=ud.clonedir)
> +            try:
> +                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, revision[module], paths[module]), d, quiet=True, workdir=ud.clonedir)
> +            except:
> +                # If the command fails, we don't have a valid file to check.  If it doesn't
> +                # fail -- it still might be a failure, see next check...
> +                module_hash = ""
> +
> +            if not module_hash:
> +                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
> +                continue
> +
>              module_hash = module_hash.split()[2]
>
>              # Build new SRC_URI
> @@ -143,7 +155,7 @@ class GitSM(Git):
>          if not ud.shallow or ud.localpath != ud.fullshallow:
>              self.update_submodules(ud, d)
>
> -    def copy_submodules(self, submodules, ud, destdir, d):
> +    def copy_submodules(self, submodules, ud, name, destdir, d):
>          if ud.bareclone:
>              repo_conf = destdir
>          else:
> @@ -156,6 +168,18 @@ class GitSM(Git):
>              srcpath = os.path.join(ud.clonedir, 'modules', md['path'])
>              modpath = os.path.join(repo_conf, 'modules', md['path'])
>
> +            # Check if the module is initialized
> +            try:
> +                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], md['path']), d, quiet=True, workdir=ud.clonedir)
> +            except:
> +                # If the command fails, we don't have a valid file to check.  If it doesn't
> +                # fail -- it still might be a failure, see next check...
> +                module_hash = ""
> +
> +            if not module_hash:
> +                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
> +                continue
> +
>              if os.path.exists(srcpath):
>                  if os.path.exists(os.path.join(srcpath, '.git')):
>                      srcpath = os.path.join(srcpath, '.git')
> @@ -188,7 +212,7 @@ class GitSM(Git):
>                  continue
>
>              submodules = self.parse_gitmodules(gitmodules)
> -            self.copy_submodules(submodules, ud, dest, d)
> +            self.copy_submodules(submodules, ud, name, dest, d)
>
>      def unpack(self, ud, destdir, d):
>          Git.unpack(self, ud, destdir, d)
> @@ -211,7 +235,7 @@ class GitSM(Git):
>                  continue
>
>              submodules = self.parse_gitmodules(gitmodules)
> -            self.copy_submodules(submodules, ud, ud.destdir, d)
> +            self.copy_submodules(submodules, ud, name, ud.destdir, d)
>
>              submodules_queue = [(module, os.path.join(repo_conf, 'modules', md['path'])) for module, md in submodules.items()]
>              while len(submodules_queue) != 0:
> --
> 1.8.3.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

