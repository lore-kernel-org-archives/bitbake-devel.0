Return-Path: <armccurdy@gmail.com>
Received: from mail-ua0-f169.google.com (mail-ua0-f169.google.com
	[209.85.217.169])
	by mail.openembedded.org (Postfix) with ESMTP id 82C647450D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jun 2018 04:09:12 +0000 (UTC)
Received: by mail-ua0-f169.google.com with SMTP id r18-v6so4052890ual.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Jun 2018 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=L/ddwzyZazd4eFCdeHO4pLILsn2i7JCVIjpqGLUa1ZE=;
	b=cd53EB4gXDQeOgsHqLAz6Yd2tVTPNaWtVUwg8UDcKFRYcTbBESOagvk0aj65ks00/q
	K5Msx908CglKGjhbf6OfLZRu69mpVCHKY8LtrXyILYmEMIT1TTJ7p+VFSwzuAnhIaXLf
	FRSQz9L+00O0U/GbeJ5HsBkvhlQ1EhEBdz7gRetiBcSsnD1rP++jHGGBFtFecQwSqzHi
	plxHdlSqPn+jC1L7fMAvpTnaGUVcrXl0FBP/pfr/3K8W869Xhk326SIOok4qKxoVVclD
	FbyhRReXGiSnUaGd5ZC2AWIUDW7Cw6XbmC2tCT67vDxQjKd+qFUgllIqEKji3PUEME40
	aQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=L/ddwzyZazd4eFCdeHO4pLILsn2i7JCVIjpqGLUa1ZE=;
	b=UvsZVE7eVoT30cNs7eA6ft/HR7G59w/yL7pIxjMJwPXuztA27fx240le9fqt/dxKwb
	j0+uAzOR6rfMhPIfdG4m6Ga3ik86WKPI2RWQQjb1T0YW89/+dSdE+2IcNuDu9ZznUk2H
	cWepph+69Dan5wrxjsgvug7LIBy8vTWcs+7pXry7uLkxTqRvoDA/E+xEtkfeLhRYj8v2
	yK8zvEBzP5h//C+slglgpjB7Wr8JU2Wie/v8SISeC4lss9KYM1g6+WmUH5nyN/4rndr/
	iIpPNkOxCzQM2FbUmJMHj+01ENYfYlivwb17kjDEAPcAiiDdS5AvrSvlUf3LjsH8TpLQ
	Hi3Q==
X-Gm-Message-State: APt69E11PiMx4VxS2E5saEEWzjC9eyqOfg3rL4NL9Fjwbn0cKxULsGPG
	Cabf3xXYlOQVGs7dBy1mwVNahrSIqugsqv1LcnY=
X-Google-Smtp-Source: ADUXVKJkDsUtyfdUYPpTmoWLTfpCzEOVD0N/htFK6UbrxgTRh6a+TGEXV7OC5CYRMZ0DwLvt77o4zDsQl5npzEXTgXY=
X-Received: by 2002:ab0:4045:: with SMTP id
	h63-v6mr9646680uad.66.1529986153432; 
	Mon, 25 Jun 2018 21:09:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:28a:0:0:0:0:0 with HTTP;
	Mon, 25 Jun 2018 21:09:13 -0700 (PDT)
In-Reply-To: <20180620061320.6846-1-nicolac76@yahoo.fr>
References: <20180620061320.6846-1-nicolac76@yahoo.fr>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Mon, 25 Jun 2018 21:09:13 -0700
Message-ID: <CAJ86T=WnwFJuhqhnKq+nKRh_1Awe91LoUAPBLv2tROGEXxs8RA@mail.gmail.com>
To: Nicolas Cornu <nicolac76@yahoo.fr>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Nicolas Cornu <n.cornu@overkiz.com>
Subject: Re: [PATCH] fetch2/repo.py: improve unpack to copy only asked project.
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
X-List-Received-Date: Tue, 26 Jun 2018 04:09:12 -0000
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 19, 2018 at 11:13 PM, Nicolas Cornu via bitbake-devel
<bitbake-devel@lists.openembedded.org> wrote:
> From: Nicolas Cornu <n.cornu@overkiz.com>
>
> Today this fetcher copy the whole repo projects in each sub-project.
> ---
> This patch is not here to be merged, but to have review on it.
> The problem is that if your google-repo got 150 projects, and you want to build each with a specific recipe, sources
> will be copied for each.

If your manifest contains 150 repos but you want to fetch and build
them individually then perhaps it's better not to use the repo fetcher
all?

You could either just put the git URIs directly into your recipes or
(if your manifest changes frequently and you don't want the recipes to
get out of sync) perhaps write a script to process the output of "repo
manifest" and auto generate a .conf file containing the git based
SRC_URI definitions which your recipes can include.

>  lib/bb/fetch2/repo.py | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
> index 8c7e8185..a01a548d 100644
> --- a/lib/bb/fetch2/repo.py
> +++ b/lib/bb/fetch2/repo.py
> @@ -89,6 +89,23 @@ class Repo(FetchMethod):
>          # Create a cache
>          runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.join(".", "*") ), d, workdir=codir)
>
> +    def unpack(self, ud, destdir, d):
> +        """unpack the project from repo source directories"""
> +
> +        repodir = d.getVar("REPODIR") or (d.getVar("DL_DIR") + "/repo")
> +        gitsrcname = "%s%s" % (ud.host, ud.path.replace("/", "."))
> +        codir = os.path.join(repodir, gitsrcname, ud.manifest)
> +        repodir = os.path.join(codir, "repo")
> +
> +        # With this command I get the full path to the project in the "repo" download dir.
> +        full_path_to_download = runfetchcmd("%s list --path-only --fullpath %s" % ("repo", d.getVar("PN")), d, workdir=repodir)
> +
> +        # I do this or git clone say the directory is not empty.
> +        runfetchcmd("rm -rf %s" % d.getVar("S"), d, workdir=destdir)
> +
> +        # Is it ok, here to use "S" directly? I see no fetcher do that.
> +        runfetchcmd("git clone %s %s" % (full_path_to_download.strip(), d.getVar("S")), d, workdir=destdir)
> +
>      def supports_srcrev(self):
>          return False
>
> --
> 2.17.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

