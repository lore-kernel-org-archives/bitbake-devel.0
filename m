Return-Path: <wak@google.com>
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by mail.openembedded.org (Postfix) with ESMTP id ABE687CDC1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Mar 2019 20:22:40 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id f23so15635101ljc.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Mar 2019 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=afWNZkLNrQUWqCKik4TK3wcgXudNjmF7h49ILFx7Rvs=;
	b=tuUny5b9HO0Qh4kLFqwcPCqunpIK/MEvXOD+YEC4o9LNBtC65rtOWE73DGc1Zr5DZd
	rewfnEH6e+IILtErsAruNbMC/ZesHLzUxEErFwwpfjSvlu+M5Ls/irTNI/w3kxwSSbx0
	q/21R52L5pHxoqvevXZP/I2X4DbK2pUA7hEj4aXWXvI0pm1s99xbF7QKqNkQpN87xVyU
	VOhzAW0dAl9UlYR5p1UVoIeSl3ysvGB3srlmWoD+SZ8FS/INRz0Ts/ySeqRsTKxzatKZ
	cM9ql2VLONi3dOE5RAuGJUjEan7oPWWnVnbreMb60cGwYDENjCQgcwJ8jePYpGcFjQOg
	JPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=afWNZkLNrQUWqCKik4TK3wcgXudNjmF7h49ILFx7Rvs=;
	b=Q3QTYPRShMILunIVL5quQMBjQezoJ3CDxLcWYQUS4GO+BBC7c8+5AqKSFeZjnAAEoQ
	TBp9+cUxN/MgUNn6Tni0uojYHl1Nyu1YGknGNQxdL0BXMO2fymEdzLkUOypbPKSwIbtl
	IQ+qVDloxHs1ZA/bLozIZVBurHoBDmz9Pvue6rPRFwZ0wZH5z4Xv3x7tgQv8jeE7LAgA
	Z24gJDtdekKDErycNQR9PtfG0VGMa9rL/jp5T4ELxQMOEdWcooFSyLt3SALIhapGbk+c
	SY1ztz9kM2P5jz7uJgl3AnEPcveIXe17wTw5gZ/VoofZx4Ije90ldJ7Nbij8aafHoApL
	edkA==
X-Gm-Message-State: APjAAAVNI7xfFLQyvSzsLh1ysZajdLZ7ytsXYafboltal7vrHQCPZDN7
	HiDzq/xPtbd9DsfUnRsj0ciLDBL6S3s0CuxQmTJdUQ==
X-Google-Smtp-Source: APXvYqxrCV6+2uO4Diu9TfOPSuapwN343AlzFPSCM1/24CyQLqqFdKp5Zktz4cotXYyPBXQN3UKvfL+7FdZ9iHZahBw=
X-Received: by 2002:a2e:b016:: with SMTP id y22mr20643416ljk.133.1553718160952;
	Wed, 27 Mar 2019 13:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190327174042.97926-1-mark.hatle@windriver.com>
	<20190327174042.97926-2-mark.hatle@windriver.com>
In-Reply-To: <20190327174042.97926-2-mark.hatle@windriver.com>
From: William Kennington <wak@google.com>
Date: Wed, 27 Mar 2019 13:22:29 -0700
Message-ID: <CAPnigKk3_gv8izX0kMqCZKs7ngwH3-bYk7-hW094N-fbHrTSzQ@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] gitsm: Add need_update method to determine when we are going to a new SRCREV
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
X-List-Received-Date: Wed, 27 Mar 2019 20:22:41 -0000
Content-Type: text/plain; charset="UTF-8"

I think this looks good in terms of fixing the issue. It might be
overly pessimistic in triggering need_update since it doesn't re-use
git metadata, so it isn't just looking at the tree for each download.

Out of curiosity, since git does its own locking, is there any harm in
not taking the download locks but reading the metadata of the bare git
repos? No downloader should ever be purging commits from the tree, so
needs_update would never return a false negative.

On Wed, Mar 27, 2019 at 10:41 AM Mark Hatle <mark.hatle@windriver.com> wrote:
>
> If the system had previously fetched a source repository for use by gitsm,
> and then the SRCREV was updated and the new commit already existed, the system
> would not re-evaluate the submodules and update them accordingly.
>
> The cause of this issue was that need_update was being used, unmodified, from
> the base git fetcher.  It did not have any knowledge, nor did it care if we
> were moving commits and needed to re-evaluate what was happening due to this
> switch.
>
> To fix the issue, during the download process we add all processed (by
> gitsm) srcrevs to the git config file, as bitbake.srcrev.  This allows us to
> use a new need_update function that not only checks if the git commit is
> present, but if we have previously processed this commit to ensure all of the
> submodule components are also present.
>
> This approach is used, instead of iterating over the submodules in need_update
> to avoid a potential race condition that has affected us in the past.  The
> need_update is called only with the parent locking.  Any time we need to dive
> into the submodules, we need to lock, and unlock them, at each stage.  This
> opens the possibility of errors in either the code, or unintended race
> conditions with rm_work.
>
> This issue was discovered by William A. Kennington III <wak@google.com>.  The
> included test case was also written by him, and included unmodified.
>
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  lib/bb/fetch2/gitsm.py | 20 ++++++++++++++++++++
>  lib/bb/tests/fetch.py  | 19 +++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index b21fed26..32389130 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -147,6 +147,23 @@ class GitSM(Git):
>
>          return submodules != []
>
> +    def need_update(self, ud, d):
> +        if Git.need_update(self, ud, d):
> +            return True
> +
> +        try:
> +            # Check for the nugget dropped by the download operation
> +            known_srcrevs = runfetchcmd("%s config --get-all bitbake.srcrev" % \
> +                            (ud.basecmd), d, workdir=ud.clonedir)
> +
> +            if ud.revisions[ud.names[0]] not in known_srcrevs.split():
> +                return True
> +        except bb.fetch2.FetchError:
> +            # No srcrev nuggets, so this is new and needs to be updated
> +            return True
> +
> +        return False
> +
>      def download(self, ud, d):
>          def download_submodule(ud, url, module, modpath, d):
>              url += ";bareclone=1;nobranch=1"
> @@ -157,6 +174,9 @@ class GitSM(Git):
>              try:
>                  newfetch = Fetch([url], d, cache=False)
>                  newfetch.download()
> +                # Drop a nugget to add each of the srcrevs we've fetched (used by need_update)
> +                runfetchcmd("%s config --add bitbake.srcrev %s" % \
> +                            (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=ud.clonedir)
>              except Exception as e:
>                  logger.error('gitsm: submodule download failed: %s %s' % (type(e).__name__, str(e)))
>                  raise
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 25732627..429998b3 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -942,6 +942,25 @@ class FetcherNetworkTest(FetcherTest):
>          self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
>          self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
>
> +    def test_git_submodule_update_CLI11(self):
> +        """ Prevent regression on update detection not finding missing submodule, or modules without needed commits """
> +        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714"
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        fetcher.download()
> +
> +        # CLI11 that pulls in a newer nlohmann-json
> +        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca"
> +        fetcher = bb.fetch.Fetch([url], self.d)
> +        fetcher.download()
> +        # Previous cwd has been deleted
> +        os.chdir(os.path.dirname(self.unpackdir))
> +        fetcher.unpack(self.unpackdir)
> +
> +        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/googletest/config')), msg='Missing submodule config "extern/googletest"')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
> +        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
> +
>      def test_git_submodule_aktualizr(self):
>          url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
>          fetcher = bb.fetch.Fetch([url], self.d)
> --
> 2.16.0.rc2
>

