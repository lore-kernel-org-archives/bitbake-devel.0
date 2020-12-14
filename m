Received: from dan.rpsys.net (dan.rpsys.net [217.169.23.60])
 by mx.groups.io with SMTP id smtpd.web08.33472.1607948177135800918
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Dec 2020 04:16:17 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=softfail (domain: linuxfoundation.org, ip: 217.169.23.60, mailfrom: richard.purdie@linuxfoundation.org)
Received: from hex ([192.168.3.26])
	(authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-18) with ESMTPSA id 0BECG14M3259911
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Dec 2020 12:16:02 GMT
Message-ID: <d450bfe62461d254752c989e995fcb141f32f48e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch/git: Fix usehead for non-default names
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Joey Degges <jdegges@gmail.com>, bitbake-devel@lists.openembedded.org
In-Reply-To: <20201214094459.15545-1-jdegges@gmail.com>
References: <20201214094459.15545-1-jdegges@gmail.com>
MIME-Version: 1.0
Date: Mon, 14 Dec 2020 12:15:27 +0000
User-Agent: Evolution 3.36.4-0ubuntu1 
X-Virus-Scanned: clamav-milter 0.102.3 at dan
X-Virus-Status: Clean
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-12-14 at 01:44 -0800, Joey Degges wrote:
> The usehead url parameter for git repositories causes bitbake to use
> whatever commit the repository HEAD is pointing to if the repository
> happens to have the name 'default'. This is the default name so in many
> cases it works just fine, but if a different name is specified with the
> url parameter 'name=newName' then it will fail to parse the recipe with
> an error along the lines of:
> 
> ERROR: ExpansionError during parsing /path/to/my/recipe.bb
> Traceback (most recent call last):
>   File "/path/to/poky/bitbake/lib/bb/fetch2/git.py", line 235, in Git.urldata_init:
>     >        ud.setup_revisions(d)
>   File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1302, in FetchData.setup_revisions:
>              for name in self.names:
>     >            self.revisions[name] = srcrev_internal_helper(self, d, name)
>   File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1167, in srcrev_internal_helper(name='newName'):
>          if srcrev == "AUTOINC":
>     >        srcrev = ud.method.latest_revision(ud, d, name)
>   File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1562, in Git.latest_revision(name='newName'):
>              except KeyError:
>     >            revs[key] = rev = self._latest_revision(ud, d, name)
>                  return rev
>   File "/path/to/poky/bitbake/lib/bb/fetch2/git.py", line 650, in Git._latest_revision(name='newName'):
>              raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output for %s" % \
>     >            (ud.unresolvedrev[name], ud.host+ud.path))
> bb.data_smart.ExpansionError: Failure expanding variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)} which triggered exception FetchError: Fetcher failure: Unable to resolve 'master' in upstream git repository in git ls-remote output for /path/to/local/git/repo
> 
> Let's fix this by setting the unresolved rev of _all_ repository names
> to 'HEAD' when the usehead url parameter is specified.
> 
> This change preserves existing behavior that allows usehead to be
> overridden by a valid looking revision if one happens to be specified
> instead of AUTOREV.
> 
> Signed-off-by: Joey Degges <jdegges@gmail.com>
> ---
>  lib/bb/fetch2/git.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 490d57fb..df9538a6 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -220,7 +220,12 @@ class Git(FetchMethod):
>              ud.shallow = False
>  
>          if ud.usehead:
> -            ud.unresolvedrev['default'] = 'HEAD'
> +            # When usehead is set let's associate 'HEAD' with the unresolved
> +            # rev of this repository. This will get resolved into a revision
> +            # later. If an actual revision happens to have also been provided
> +            # then this setting will be overridden.
> +            for name in ud.names:
> +                ud.unresolvedrev[name] = 'HEAD'
>  
>          ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0"
>  

The fix looks reasonable, thanks. Would you be able to extend the tests
in lib/bb/tests/fetch.py though please? They're run with "bitbake-
selftest". Its useful to stop these kinds of things regressing again!

Cheers,

Richard

