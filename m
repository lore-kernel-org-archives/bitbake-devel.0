Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id B5AC673B83
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jul 2015 15:38:17 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 06 Jul 2015 08:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,415,1432623600"; d="scan'208";a="600966514"
Received: from tgsmith2-mobl5.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.6.176])
	by orsmga003.jf.intel.com with ESMTP; 06 Jul 2015 08:38:16 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Felipe F. Tonello" <eu@felipetonello.com>
Date: Mon, 06 Jul 2015 16:38:14 +0100
Message-ID: <5748294.71kfXCBSzc@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.0.6-200.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <1436195638-24806-1-git-send-email-eu@felipetonello.com>
References: <1436195638-24806-1-git-send-email-eu@felipetonello.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: Remove unecessary code for git submodules
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
X-List-Received-Date: Mon, 06 Jul 2015 15:38:18 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Felipe,

On Monday 06 July 2015 16:13:58 eu@felipetonello.com wrote:
> From: "Felipe F. Tonello" <eu@felipetonello.com>
> 
> Only do git submodule update after upack, otherwise the branch and commit id
> will be ignored, causing to run git submodules on a wrong ref.
> 
> Since .gitmodules file is used to check if there is any submodule, we don't
> need to worry about copying .git/modules directory into the unpacked source
> tree.
> 
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
>  lib/bb/fetch2/gitsm.py | 73
> -------------------------------------------------- 1 file changed, 73
> deletions(-)
> 
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index c125cff..405cd87 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -31,10 +31,8 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://"
> requires a clean of your r
> 
>  import os
>  import bb
> -from   bb    import data
>  from   bb.fetch2.git import Git
>  from   bb.fetch2 import runfetchcmd
> -from   bb.fetch2 import logger
> 
>  class GitSM(Git):
>      def supports(self, ud, d):
> @@ -52,85 +50,14 @@ class GitSM(Git):
>                  pass
>          return False
> 
> -    def _set_relative_paths(self, repopath):
> -        """
> -        Fix submodule paths to be relative instead of absolute,
> -        so that when we move the repo it doesn't break
> -        (In Git 1.7.10+ this is done automatically)
> -        """
> -        submodules = []
> -        with open(os.path.join(repopath, '.gitmodules'), 'r') as f:
> -            for line in f.readlines():
> -                if line.startswith('[submodule'):
> -                    submodules.append(line.split('"')[1])
> -
> -        for module in submodules:
> -            repo_conf = os.path.join(repopath, module, '.git')
> -            if os.path.exists(repo_conf):
> -                with open(repo_conf, 'r') as f:
> -                    lines = f.readlines()
> -                newpath = ''
> -                for i, line in enumerate(lines):
> -                    if line.startswith('gitdir:'):
> -                        oldpath = line.split(': ')[-1].rstrip()
> -                        if oldpath.startswith('/'):
> -                            newpath = '../' * (module.count('/') + 1) +
> '.git/modules/' + module -                            lines[i] = 'gitdir:
> %s\n' % newpath
> -                            break
> -                if newpath:
> -                    with open(repo_conf, 'w') as f:
> -                        for line in lines:
> -                            f.write(line)
> -
> -            repo_conf2 = os.path.join(repopath, '.git', 'modules', module,
> 'config') -            if os.path.exists(repo_conf2):
> -                with open(repo_conf2, 'r') as f:
> -                    lines = f.readlines()
> -                newpath = ''
> -                for i, line in enumerate(lines):
> -                    if line.lstrip().startswith('worktree = '):
> -                        oldpath = line.split(' = ')[-1].rstrip()
> -                        if oldpath.startswith('/'):
> -                            newpath = '../' * (module.count('/') + 3) +
> module -                            lines[i] = '\tworktree = %s\n' %
> newpath -                            break
> -                if newpath:
> -                    with open(repo_conf2, 'w') as f:
> -                        for line in lines:
> -                            f.write(line)
> -
> -    def update_submodules(self, ud, d):
> -        # We have to convert bare -> full repo, do the submodule bit, then
> convert back -        tmpclonedir = ud.clonedir + ".tmp"
> -        gitdir = tmpclonedir + os.sep + ".git"
> -        bb.utils.remove(tmpclonedir, True)
> -        os.mkdir(tmpclonedir)
> -        os.rename(ud.clonedir, gitdir)
> -        runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*true/bare
> = false/'", d) -        os.chdir(tmpclonedir)
> -        runfetchcmd(ud.basecmd + " reset --hard", d)
> -        runfetchcmd(ud.basecmd + " submodule init", d)
> -        runfetchcmd(ud.basecmd + " submodule update", d)
> -        self._set_relative_paths(tmpclonedir)
> -        runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare
> = true/'", d) -        os.rename(gitdir, ud.clonedir,)
> -        bb.utils.remove(tmpclonedir, True)
> -
>      def download(self, ud, d):
>          Git.download(self, ud, d)
> 
> -        os.chdir(ud.clonedir)
> -        submodules = self.uses_submodules(ud, d)
> -        if submodules:
> -            self.update_submodules(ud, d)
> -
>      def unpack(self, ud, destdir, d):
>          Git.unpack(self, ud, destdir, d)
> -
>          os.chdir(ud.destdir)
>          submodules = self.uses_submodules(ud, d)
>          if submodules:
> -            runfetchcmd("cp -r " + ud.clonedir + "/modules " + ud.destdir +
> "/.git/", d) runfetchcmd(ud.basecmd + " submodule init", d)
>              runfetchcmd(ud.basecmd + " submodule update", d)

So, I might have been the one that implemented the _set_relative_paths() part 
of this - I don't remember the full details, however the comment suggests that 
this is necessary for older versions of git. If we wish to remain compatible 
with those then we still need this code surely?

Here's the commit that added it:

http://cgit.openembedded.org/bitbake/commit/?id=e700d5a41deed4ee837465af526ed30c8a579933

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

