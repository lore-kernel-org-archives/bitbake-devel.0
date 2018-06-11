Return-Path: <armccurdy@gmail.com>
Received: from mail-ua0-f180.google.com (mail-ua0-f180.google.com
	[209.85.217.180])
	by mail.openembedded.org (Postfix) with ESMTP id F0EA078BA6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Jun 2018 19:43:56 +0000 (UTC)
Received: by mail-ua0-f180.google.com with SMTP id i3-v6so14347660uad.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Jun 2018 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to; 
	bh=DJTNrbudawaqgUSTukrZt19+3rABVp789bu6rQmZix4=;
	b=ZhFfLnMu3MiOalSDphZG1oikBBmtaCwv+8Kiq4ErPoQ7LabPIaLuXpIEhPVYJXYXyu
	Zh+bZpYTs1LNjm40J9iLxui1IDqtYNzVutrtiNj4x3DerwUNos4KTHAFmxYceh8kQ95Q
	j0AodA7rMbHtIQLe92zRoR+/16QpEN+nNKxVeImEpfbR0u5kLydZeoN8m8kXGhbBJAjX
	KgtQQTY69WejXoxmMHEt46rHvXTsG77ZWp8mX6AvJPjkLAG9BgNT0EV62Tkx6AGoTxTT
	I71/a2grAmYeU2gkhjX7SSnf7g67cx6cQzNam5UboKO355RA+elg1ZWSQPv9N3v0V0uw
	KQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to;
	bh=DJTNrbudawaqgUSTukrZt19+3rABVp789bu6rQmZix4=;
	b=Gby8voCzy65rebL4Qwb3+h8wI+8h5iIHUUwLbvJJFhVRdj7ryodLR6BfSKDPkzPAGc
	9yUiyxuQ24fkWOnoYBkvshl39/OrZi/slkclV4osgNnfv7KmOMvt+iyWZ6BG83aRbz3V
	Ge8ovA/NawZcHS2SK7ASf+DeLPY/f6Uo5tIpQN0PkY9v8alE5ohWxxB4QPGCpdk9L5Oa
	iblsZsBoBKbd3pnDIKHZVXvWSinCpvxkEdEHyUmiLHPDGNVu7FPWjXBVyZ6ipCkvPiEK
	7QrHWHr8ENQnnMT0JF4gp0vV8NUQVKiB9zlZ27ICxnd02xX2yEzoP9P1mmhK5qkv/2ai
	txSw==
X-Gm-Message-State: APt69E2qMsHOy6QS2+UcjTtEYBIe1u8w1y6quQsKS9CEU0UyS4xokkjz
	JX6MCUU6IMN86hOlh6CK+GiQ/TmWiioOsZp3phw=
X-Google-Smtp-Source: ADUXVKK5vXRRTLvqJSNTNCZtYbPNK9wCPIryuk/j1MIGkmOLSI0tIi/qYqWGQ0j3xkZu0Cojveea+KeQulP4Qw7V6BU=
X-Received: by 2002:ab0:50ba:: with SMTP id
	c55-v6mr401276uaa.150.1528746237608; 
	Mon, 11 Jun 2018 12:43:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:28a:0:0:0:0:0 with HTTP;
	Mon, 11 Jun 2018 12:43:56 -0700 (PDT)
In-Reply-To: <1528226030-19361-1-git-send-email-armccurdy@gmail.com>
References: <1528226030-19361-1-git-send-email-armccurdy@gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Mon, 11 Jun 2018 12:43:56 -0700
Message-ID: <CAJ86T=WVyA9uRmGW9e5md6JOqbgEcoikp+QcAAKk8rbsvHt_bg@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: unify the way fetchers determine DL_DIR and FETCHCMD
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
X-List-Received-Date: Mon, 11 Jun 2018 19:43:57 -0000
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 5, 2018 at 12:13 PM, Andre McCurdy <armccurdy@gmail.com> wrote:
> Currently there is quite some variation between the fetchers in terms
> of how they determine the subdirectory within DL_DIR and the base
> fetch command to run. Some rely on variables being set externally
> (e.g. from bitbake.conf in oe-core), some respect these external
> variables but provide fallback defaults and some use only hardcoded
> internal values. Try to unify the approach used across the various
> fetchers.

Ping.

Any issues with this?

> Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
> ---
>  lib/bb/fetch2/bzr.py      |  5 +++--
>  lib/bb/fetch2/cvs.py      |  5 +++--
>  lib/bb/fetch2/git.py      |  2 +-
>  lib/bb/fetch2/hg.py       |  2 +-
>  lib/bb/fetch2/osc.py      |  5 +++--
>  lib/bb/fetch2/perforce.py |  8 ++------
>  lib/bb/fetch2/repo.py     | 12 +++++++-----
>  lib/bb/fetch2/svn.py      |  5 +++--
>  8 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
> index 16123f8..658502f 100644
> --- a/lib/bb/fetch2/bzr.py
> +++ b/lib/bb/fetch2/bzr.py
> @@ -41,8 +41,9 @@ class Bzr(FetchMethod):
>          init bzr specific variable within url data
>          """
>          # Create paths to bzr checkouts
> +        bzrdir = d.getVar("BZRDIR") or (d.getVar("DL_DIR") + "/bzr")
>          relpath = self._strip_leading_slashes(ud.path)
> -        ud.pkgdir = os.path.join(d.expand('${BZRDIR}'), ud.host, relpath)
> +        ud.pkgdir = os.path.join(bzrdir, ud.host, relpath)
>
>          ud.setup_revisions(d)
>
> @@ -57,7 +58,7 @@ class Bzr(FetchMethod):
>          command is "fetch", "update", "revno"
>          """
>
> -        basecmd = d.expand('${FETCHCMD_bzr}')
> +        basecmd = d.getVar("FETCHCMD_bzr") or "/usr/bin/env bzr"
>
>          proto =  ud.parm.get('protocol', 'http')
>
> diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
> index 490c954..0e0a319 100644
> --- a/lib/bb/fetch2/cvs.py
> +++ b/lib/bb/fetch2/cvs.py
> @@ -110,7 +110,7 @@ class Cvs(FetchMethod):
>          if ud.tag:
>              options.append("-r %s" % ud.tag)
>
> -        cvsbasecmd = d.getVar("FETCHCMD_cvs")
> +        cvsbasecmd = d.getVar("FETCHCMD_cvs") or "/usr/bin/env cvs"
>          cvscmd = cvsbasecmd + " '-d" + cvsroot + "' co " + " ".join(options) + " " + ud.module
>          cvsupdatecmd = cvsbasecmd + " '-d" + cvsroot + "' update -d -P " + " ".join(options)
>
> @@ -121,7 +121,8 @@ class Cvs(FetchMethod):
>          # create module directory
>          logger.debug(2, "Fetch: checking for module directory")
>          pkg = d.getVar('PN')
> -        pkgdir = os.path.join(d.getVar('CVSDIR'), pkg)
> +        cvsdir = d.getVar("CVSDIR") or (d.getVar("DL_DIR") + "/cvs")
> +        pkgdir = os.path.join(cvsdir, pkg)
>          moddir = os.path.join(pkgdir, localdir)
>          workdir = None
>          if os.access(os.path.join(moddir, 'CVS'), os.R_OK):
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index b733be9..612aac4 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -261,7 +261,7 @@ class Git(FetchMethod):
>                  gitsrcname = gitsrcname + '_' + ud.revisions[name]
>
>          dl_dir = d.getVar("DL_DIR")
> -        gitdir = d.getVar("GITDIR") or (dl_dir + "/git2/")
> +        gitdir = d.getVar("GITDIR") or (dl_dir + "/git2")
>          ud.clonedir = os.path.join(gitdir, gitsrcname)
>          ud.localfile = ud.clonedir
>
> diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
> index d0857e6..936d043 100644
> --- a/lib/bb/fetch2/hg.py
> +++ b/lib/bb/fetch2/hg.py
> @@ -80,7 +80,7 @@ class Hg(FetchMethod):
>          ud.fullmirror = os.path.join(d.getVar("DL_DIR"), mirrortarball)
>          ud.mirrortarballs = [mirrortarball]
>
> -        hgdir = d.getVar("HGDIR") or (d.getVar("DL_DIR") + "/hg/")
> +        hgdir = d.getVar("HGDIR") or (d.getVar("DL_DIR") + "/hg")
>          ud.pkgdir = os.path.join(hgdir, hgsrcname)
>          ud.moddir = os.path.join(ud.pkgdir, ud.module)
>          ud.localfile = ud.moddir
> diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
> index 2b4f7d9..6c60456 100644
> --- a/lib/bb/fetch2/osc.py
> +++ b/lib/bb/fetch2/osc.py
> @@ -32,8 +32,9 @@ class Osc(FetchMethod):
>          ud.module = ud.parm["module"]
>
>          # Create paths to osc checkouts
> +        oscdir = d.getVar("OSCDIR") or (d.getVar("DL_DIR") + "/osc")
>          relpath = self._strip_leading_slashes(ud.path)
> -        ud.pkgdir = os.path.join(d.getVar('OSCDIR'), ud.host)
> +        ud.pkgdir = os.path.join(oscdir, ud.host)
>          ud.moddir = os.path.join(ud.pkgdir, relpath, ud.module)
>
>          if 'rev' in ud.parm:
> @@ -54,7 +55,7 @@ class Osc(FetchMethod):
>          command is "fetch", "update", "info"
>          """
>
> -        basecmd = d.expand('${FETCHCMD_osc}')
> +        basecmd = d.getVar("FETCHCMD_osc") or "/usr/bin/env osc"
>
>          proto = ud.parm.get('protocol', 'ocs')
>
> diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
> index 3debad5..903a8e6 100644
> --- a/lib/bb/fetch2/perforce.py
> +++ b/lib/bb/fetch2/perforce.py
> @@ -43,13 +43,9 @@ class Perforce(FetchMethod):
>          provided by the env, use it.  If P4PORT is specified by the recipe, use
>          its values, which may override the settings in P4CONFIG.
>          """
> -        ud.basecmd = d.getVar('FETCHCMD_p4')
> -        if not ud.basecmd:
> -            ud.basecmd = "/usr/bin/env p4"
> +        ud.basecmd = d.getVar("FETCHCMD_p4") or "/usr/bin/env p4"
>
> -        ud.dldir = d.getVar('P4DIR')
> -        if not ud.dldir:
> -            ud.dldir = '%s/%s' % (d.getVar('DL_DIR'), 'p4')
> +        ud.dldir = d.getVar("P4DIR") or (d.getVar("DL_DIR") + "/p4")
>
>          path = ud.url.split('://')[1]
>          path = path.split(';')[0]
> diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
> index c22d9b5..8c7e818 100644
> --- a/lib/bb/fetch2/repo.py
> +++ b/lib/bb/fetch2/repo.py
> @@ -45,6 +45,8 @@ class Repo(FetchMethod):
>          "master".
>          """
>
> +        ud.basecmd = d.getVar("FETCHCMD_repo") or "/usr/bin/env repo"
> +
>          ud.proto = ud.parm.get('protocol', 'git')
>          ud.branch = ud.parm.get('branch', 'master')
>          ud.manifest = ud.parm.get('manifest', 'default.xml')
> @@ -60,8 +62,8 @@ class Repo(FetchMethod):
>              logger.debug(1, "%s already exists (or was stashed). Skipping repo init / sync.", ud.localpath)
>              return
>
> +        repodir = d.getVar("REPODIR") or (d.getVar("DL_DIR") + "/repo")
>          gitsrcname = "%s%s" % (ud.host, ud.path.replace("/", "."))
> -        repodir = d.getVar("REPODIR") or os.path.join(d.getVar("DL_DIR"), "repo")
>          codir = os.path.join(repodir, gitsrcname, ud.manifest)
>
>          if ud.user:
> @@ -72,11 +74,11 @@ class Repo(FetchMethod):
>          repodir = os.path.join(codir, "repo")
>          bb.utils.mkdirhier(repodir)
>          if not os.path.exists(os.path.join(repodir, ".repo")):
> -            bb.fetch2.check_network_access(d, "repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), ud.url)
> -            runfetchcmd("repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=repodir)
> +            bb.fetch2.check_network_access(d, "%s init -m %s -b %s -u %s://%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), ud.url)
> +            runfetchcmd("%s init -m %s -b %s -u %s://%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=repodir)
>
> -        bb.fetch2.check_network_access(d, "repo sync %s" % ud.url, ud.url)
> -        runfetchcmd("repo sync", d, workdir=repodir)
> +        bb.fetch2.check_network_access(d, "%s sync %s" % (ud.basecmd, ud.url), ud.url)
> +        runfetchcmd("%s sync" % ud.basecmd, d, workdir=repodir)
>
>          scmdata = ud.parm.get("scmdata", "")
>          if scmdata == "keep":
> diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
> index 3f172ee..ed70bcf 100644
> --- a/lib/bb/fetch2/svn.py
> +++ b/lib/bb/fetch2/svn.py
> @@ -49,7 +49,7 @@ class Svn(FetchMethod):
>          if not "module" in ud.parm:
>              raise MissingParameterError('module', ud.url)
>
> -        ud.basecmd = d.getVar('FETCHCMD_svn')
> +        ud.basecmd = d.getVar("FETCHCMD_svn") or "/usr/bin/env svn --non-interactive --trust-server-cert"
>
>          ud.module = ud.parm["module"]
>
> @@ -59,8 +59,9 @@ class Svn(FetchMethod):
>              ud.path_spec = ud.parm["path_spec"]
>
>          # Create paths to svn checkouts
> +        svndir = d.getVar("SVNDIR") or (d.getVar("DL_DIR") + "/svn")
>          relpath = self._strip_leading_slashes(ud.path)
> -        ud.pkgdir = os.path.join(d.expand('${SVNDIR}'), ud.host, relpath)
> +        ud.pkgdir = os.path.join(svndir, ud.host, relpath)
>          ud.moddir = os.path.join(ud.pkgdir, ud.module)
>
>          ud.setup_revisions(d)
> --
> 1.9.1
>

