Return-Path: <uvv.mail@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64835E6FE50
	for <webhook@archiver.kernel.org>; Sat,  7 Sep 2024 07:27:26 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.3241.1725694044556094437
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 07 Sep 2024 00:27:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Pqae6o4k;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: uvv.mail@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so5015425e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 07 Sep 2024 00:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725694043; x=1726298843; darn=lists.openembedded.org;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GVKR5C5Ggk2QrIVSGtsYJluPdxxXG7+dJ4Ighg0GMs=;
        b=Pqae6o4kN88v7L7Pe472wgO3qEbg1pQAWOV8q2rN+Q+smK7CbahL7RL9YJqNLFAYHC
         lO67SKWL9EguWKinzJJUYafJIV5s+Q3YRGY+elCi4kpbfDWvBVlPM6Tc5CRV8lWRhEB4
         ONLqpU+mL2zBdB9x0rpgzYno9ZYkleGd6RAKwoeWk/MEfJoVGe814uiijyRyIw5F+n8P
         Y2Oi0PzBbwo5kUEApxYSLSAf9hT0Kl/lpSL6Cqh77AT3GemzTV+YV0aQ0kEqdbYYrVUd
         q5jIdI5aBqGQlZd4223yV4v1vVlgNliowlJtQb01ER47mpNHf22N4eTj4sz//96qWrCe
         DVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725694043; x=1726298843;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0GVKR5C5Ggk2QrIVSGtsYJluPdxxXG7+dJ4Ighg0GMs=;
        b=aCfm+Jg16jWT9XAW89MX4sku7V1RzlhGiu1JbIzB1UriOOZDKaMKlCnnkRmYTip6P+
         ptZ6rEoyou8z0ouSfacB+cOiMV3fOPpN3FqAZai9Xk1QOQd9GTNsF9ukQtd3RzsvMOCB
         iH1AZZ2Bi5b1OBW0t1sZAr4lzBJD3J9SVjJqwwAhS1JvPgeNeExpEOeY7r6pZ5mlEUo5
         L5TXGvhfuTl88EkZ51b42S2F5UqK9YI0eifrPyaLHDvxh4rY/IiWe1d+pm96nCD+eZlB
         Ud2fSEEm3bGgTrejx5x9k8taMCJbn+MOPi4wK9qc2xsLNi7Q2vLUgIJjeXQ8Sr90v+nV
         5S8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1u7hQsWt/gSEcZrD4jMj1f3thxvQlI9BX0YSZcTOD1ZQ70mIckxzE0d8POEJ8Uu1aj4KUPFePIxOLusLA@lists.openembedded.org
X-Gm-Message-State: AOJu0YyrD3JTlXi2qesnRD2YCOpVOae0+EhAdTfjukEC108ZQd3h35+U
	AWq8iQl0o4xF3+UTtb+bYaWTANuk7Mukw/bFr3Hfi4io7KkiA3Xc
X-Google-Smtp-Source: AGHT+IHfUNz7qMWT1caj84bBS4mxGiC37mcP0A4cR0iv8LfpCfQyNYUp7L+ruMN8VaYLE5IgpITXwQ==
X-Received: by 2002:a05:600c:310a:b0:42c:8812:82a6 with SMTP id 5b1f17b1804b1-42c9f98a81cmr37148715e9.21.1725694041944;
        Sat, 07 Sep 2024 00:27:21 -0700 (PDT)
Received: from [10.8.0.6] (dslb-002-205-236-192.002.205.pools.vodafone-ip.de. [2.205.236.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d372dsm728461f8f.73.2024.09.07.00.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 00:27:21 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------cJpkkRrCfN10dOg31pt90qdK"
Message-ID: <79ff6187-aa9e-4dc7-bd79-4f37e1603bb9@gmail.com>
Date: Sat, 7 Sep 2024 09:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2 2/2] fetch2: Add gomodgit fetcher
To: christian.lindeberg@axis.com, bitbake-devel@lists.openembedded.org
References: <20240906092739.930765-1-christli@axis.com>
 <20240906092739.930765-2-christli@axis.com>
Content-Language: en-US
From: Vyacheslav Yurkov <uvv.mail@gmail.com>
In-Reply-To: <20240906092739.930765-2-christli@axis.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 07 Sep 2024 07:27:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16546

This is a multi-part message in MIME format.
--------------cJpkkRrCfN10dOg31pt90qdK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A few questions on the patchset.

- What if the module doesn't use any proxy? (E.g. hosted in a private 
repository)
- The current recipetool approach ( 
https://git.openembedded.org/openembedded-core/tree/scripts/lib/recipetool/create_go.py 
) uses vendoring approach and all dependencies go into the SRC_URI. Thus 
it's required to populate the required license information for the 
manifest generation. Would that be possible with this fetcher as well?

Slava

On 06.09.2024 11:27, Christian Lindeberg via lists.openembedded.org wrote:
> From: Christian Lindeberg<christian.lindeberg@axis.com>
>
> Add a go module fetcher for downloading module dependencies to the
> module cache directly from a git repository. The fetcher can be used
> with the go-mod class in OE-Core.
>
> A module dependency can be specified with:
>
>    SRC_URI += "gomodgit://golang.org/x/net;version=v0.9.0;srcrev=..."
>
> Signed-off-by: Christian Lindeberg<christian.lindeberg@axis.com>
> ---
>
> Changes in V2:
> - Use separate gomodgit:// type instead of the direct=git parameter.
> - Use GO_MOD_CACHE_DIR variable or default instead of requiring the
>    GOMODCACHE environment variable to be set.
> - Add more documentation to make it cleared what is downloaded and what
>    is unpacked.
>
>   lib/bb/fetch2/__init__.py |   1 +
>   lib/bb/fetch2/gomod.py    | 140 +++++++++++++++++++++++++++++++++++++-
>   lib/bb/tests/fetch.py     |  89 ++++++++++++++++++++++++
>   3 files changed, 228 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index f84ce5999..ddee4400b 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -2112,3 +2112,4 @@ methods.append(az.Az())
>   methods.append(crate.Crate())
>   methods.append(gcp.GCP())
>   methods.append(gomod.GoMod())
> +methods.append(gomod.GoModGit())
> diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
> index fe025e367..1b532d03f 100644
> --- a/lib/bb/fetch2/gomod.py
> +++ b/lib/bb/fetch2/gomod.py
> @@ -1,12 +1,13 @@
>   """
>   BitBake 'Fetch' implementation for Go modules
>   
> -The gomod fetcher is used to download Go modules to the module cache from a
> -module proxy.
> +The gomod/gomodgit fetchers are used to download Go modules to the module cache
> +from a module proxy or directly from a version control repository.
>   
>   Example SRC_URI:
>   
>   SRC_URI += "gomod://golang.org/x/net;version=v0.9.0;sha256sum=..."
> +SRC_URI += "gomodgit://golang.org/x/net;version=v0.9.0;repo=go.googlesource.com/net;srcrev=..."
>   
>   Required SRC_URI parameters:
>   
> @@ -27,6 +28,23 @@ Optional SRC_URI parameters:
>       only the go.mod file. Alternatively, set the SRC_URI varible flag for
>       "module@version.sha256sum".
>   
> +- protocol
> +    The method used when fetching directly from a version control repository.
> +    The default is "https" for git.
> +
> +- repo
> +    The URL when fetching directly from a version control repository. Required
> +    when the URL is different from the module path.
> +
> +- srcrev
> +    The revision identifier used when fetching directly from a version control
> +    repository. Alternatively, set the SRCREV varible for "module@version".
> +
> +- subdir
> +    The module subdirectory when fetching directly from a version control
> +    repository. Required when the module is not located in the root of the
> +    repository.
> +
>   Related variables:
>   
>   - GO_MOD_PROXY
> @@ -41,14 +59,19 @@ See the Go modules reference,https://go.dev/ref/mod, for more information
>   about the module cache, module proxies and version control systems.
>   """
>   
> +import hashlib
>   import os
>   import re
>   import shutil
> +import subprocess
>   import zipfile
>   
>   import bb
>   from bb.fetch2 import FetchError
>   from bb.fetch2 import MissingParameterError
> +from bb.fetch2 import runfetchcmd
> +from bb.fetch2 import subprocess_setup
> +from bb.fetch2.git import Git
>   from bb.fetch2.wget import Wget
>   
>   
> @@ -126,3 +149,116 @@ class GoMod(Wget):
>                           # If the module does not have a go.mod file, synthesize
>                           # one containing only a module statement.
>                           mf.write(f'module {module}\n'.encode())
> +
> +
> +class GoModGit(Git):
> +    """Class to fetch Go modules directly from a git repository"""
> +
> +    def supports(self, ud, d):
> +        """Check to see if a given URL is for this fetcher."""
> +        return ud.type == 'gomodgit'
> +
> +    def urldata_init(self, ud, d):
> +        """Set up to download the module from the git repository.
> +
> +        Set up to download the git repository to the module cache directory and
> +        unpack the module zip file and the go.mod file:
> +
> +        cache/vcs/<hash>:                         The bare git repository.
> +        cache/download/<module>/@v/<version>.zip: The module zip file.
> +        cache/download/<module>/@v/<version>.mod: The go.mod file.
> +        """
> +
> +        moddir = d.getVar('GO_MOD_CACHE_DIR') or 'pkg/mod'
> +
> +        if 'version' not in ud.parm:
> +            raise MissingParameterError('version', ud.url)
> +
> +        module = ud.host + ud.path
> +        ud.parm['module'] = module
> +
> +        # Set host, path and srcrev for git download
> +        if 'repo' in ud.parm:
> +            repo = ud.parm['repo']
> +            idx = repo.find('/')
> +            if idx != -1:
> +                ud.host = repo[:idx]
> +                ud.path = repo[idx:]
> +            else:
> +                ud.host = repo
> +                ud.path = ''
> +        if 'protocol' not in ud.parm:
> +            ud.parm['protocol'] = 'https'
> +        name = f"{module}@{ud.parm['version']}"
> +        ud.names = [name]
> +        srcrev = d.getVar('SRCREV_' + name)
> +        if srcrev:
> +            if 'srcrev' not in ud.parm:
> +                ud.parm['srcrev'] = srcrev
> +        else:
> +            if 'srcrev' in ud.parm:
> +                d.setVar('SRCREV_' + name, ud.parm['srcrev'])
> +        if 'branch' not in ud.parm:
> +            ud.parm['nobranch'] = '1'
> +
> +        # Set subpath, subdir and bareclone for git unpack
> +        if 'subdir' in ud.parm:
> +            ud.parm['subpath'] = ud.parm['subdir']
> +        key = f"git3:{ud.parm['protocol']}://{ud.host}{ud.path}".encode()
> +        ud.parm['key'] = key
> +        ud.parm['subdir'] = os.path.join(moddir, 'cache/vcs',
> +                                         hashlib.sha256(key).hexdigest())
> +        ud.parm['bareclone'] = '1'
> +
> +        super().urldata_init(ud, d)
> +
> +    def unpack(self, ud, rootdir, d):
> +        """Unpack the module in the module cache."""
> +
> +        # Unpack the bare git repository
> +        super().unpack(ud, rootdir, d)
> +
> +        moddir = d.getVar('GO_MOD_CACHE_DIR') or 'pkg/mod'
> +
> +        # Create the info file
> +        module = ud.parm['module']
> +        repodir = os.path.join(rootdir, ud.parm['subdir'])
> +        with open(repodir + '.info', 'wb') as f:
> +            f.write(ud.parm['key'])
> +
> +        # Unpack the go.mod file from the repository
> +        unpackdir = os.path.join(rootdir, moddir, 'cache/download',
> +                                 escape(module), '@v')
> +        bb.utils.mkdirhier(unpackdir)
> +        srcrev = ud.parm['srcrev']
> +        version = ud.parm['version']
> +        escaped_version = escape(version)
> +        cmd = f"git ls-tree -r --name-only '{srcrev}'"
> +        if 'subpath' in ud.parm:
> +            cmd += f" '{ud.parm['subpath']}'"
> +        files = runfetchcmd(cmd, d, workdir=repodir).split()
> +        name = escaped_version + '.mod'
> +        bb.note(f"Unpacking {name} to {unpackdir}/")
> +        with open(os.path.join(unpackdir, name), mode='wb') as mf:
> +            f = 'go.mod'
> +            if 'subpath' in ud.parm:
> +                f = os.path.join(ud.parm['subpath'], f)
> +            if f in files:
> +                cmd = ['git', 'cat-file', 'blob', srcrev + ':' + f]
> +                subprocess.check_call(cmd, stdout=mf, cwd=repodir,
> +                                      preexec_fn=subprocess_setup)
> +            else:
> +                # If the module does not have a go.mod file, synthesize one
> +                # containing only a module statement.
> +                mf.write(f'module {module}\n'.encode())
> +
> +        # Synthesize the module zip file from the repository
> +        name = escaped_version + '.zip'
> +        bb.note(f"Unpacking {name} to {unpackdir}/")
> +        with zipfile.ZipFile(os.path.join(unpackdir, name), mode='w') as zf:
> +            prefix = module + '@' + version + '/'
> +            for f in files:
> +                cmd = ['git', 'cat-file', 'blob', srcrev + ':' + f]
> +                data = subprocess.check_output(cmd, cwd=repodir,
> +                                               preexec_fn=subprocess_setup)
> +                zf.writestr(prefix + f, data)
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 2365a5096..832e0dd6a 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -3455,3 +3455,92 @@ class GoModTest(FetcherTest):
>           downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
>           self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in/ini.v1/@v/v1.67.0.zip')))
>           self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in/ini.v1/@v/v1.67.0.mod')))
> +
> +class GoModGitTest(FetcherTest):
> +
> +    @skipIfNoNetwork()
> +    def test_gomodgit_url_repo(self):
> +        urls = ['gomodgit://golang.org/x/net;version=v0.9.0;'
> +                'repo=go.googlesource.com/net;'
> +                'srcrev=694cff8668bac64e0864b552bffc280cd27f21b1']
> +
> +        fetcher = bb.fetch2.Fetch(urls, self.d)
> +        ud = fetcher.ud[urls[0]]
> +        self.assertEqual(ud.host, 'go.googlesource.com')
> +        self.assertEqual(ud.path, '/net')
> +        self.assertEqual(ud.names, ['golang.org/x/net@v0.9.0'])
> +        self.assertEqual(self.d.getVar('SRCREV_golang.org/x/net@v0.9.0'), '694cff8668bac64e0864b552bffc280cd27f21b1')
> +
> +        fetcher.download()
> +        self.assertTrue(os.path.exists(ud.localpath))
> +
> +        fetcher.unpack(self.unpackdir)
> +        vcsdir = os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
> +        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'ed42bd05533fd84ae290a5d33ebd3695a0a2b06131beebd5450825bee8603aca')))
> +        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'golang.org/x/net/@v/v0.9.0.zip')))
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'golang.org/x/net/@v/v0.9.0.mod')))
> +
> +    @skipIfNoNetwork()
> +    def test_gomodgit_url_subdir(self):
> +        urls = ['gomodgit://github.com/Azure/azure-sdk-for-go/sdk/storage/azblob;version=v1.0.0;'
> +                'repo=github.com/Azure/azure-sdk-for-go;subdir=sdk/storage/azblob;'
> +                'srcrev=ec928e0ed34db682b3f783d3739d1c538142e0c3']
> +
> +        fetcher = bb.fetch2.Fetch(urls, self.d)
> +        ud = fetcher.ud[urls[0]]
> +        self.assertEqual(ud.host, 'github.com')
> +        self.assertEqual(ud.path, '/Azure/azure-sdk-for-go')
> +        self.assertEqual(ud.parm['subpath'], 'sdk/storage/azblob')
> +        self.assertEqual(ud.names, ['github.com/Azure/azure-sdk-for-go/sdk/storage/azblob@v1.0.0'])
> +        self.assertEqual(self.d.getVar('SRCREV_github.com/Azure/azure-sdk-for-go/sdk/storage/azblob@v1.0.0'), 'ec928e0ed34db682b3f783d3739d1c538142e0c3')
> +
> +        fetcher.download()
> +        self.assertTrue(os.path.exists(ud.localpath))
> +
> +        fetcher.unpack(self.unpackdir)
> +        vcsdir = os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
> +        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'd31d6145676ed3066ce573a8198f326dea5be45a43b3d8f41ce7787fd71d66b3')))
> +        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.zip')))
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod')))
> +
> +    @skipIfNoNetwork()
> +    def test_gomodgit_url_srcrev_var(self):
> +        urls = ['gomodgit://gopkg.in/ini.v1;version=v1.67.0']
> +        self.d.setVar('SRCREV_gopkg.in/ini.v1@v1.67.0', 'b2f570e5b5b844226bbefe6fb521d891f529a951')
> +
> +        fetcher = bb.fetch2.Fetch(urls, self.d)
> +        ud = fetcher.ud[urls[0]]
> +        self.assertEqual(ud.host, 'gopkg.in')
> +        self.assertEqual(ud.path, '/ini.v1')
> +        self.assertEqual(ud.names, ['gopkg.in/ini.v1@v1.67.0'])
> +        self.assertEqual(ud.parm['srcrev'], 'b2f570e5b5b844226bbefe6fb521d891f529a951')
> +
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +        vcsdir = os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
> +        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'b7879a4be9ba8598851b8278b14c4f71a8316be64913298d1639cce6bde59bc3')))
> +        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in/ini.v1/@v/v1.67.0.zip')))
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in/ini.v1/@v/v1.67.0.mod')))
> +
> +    @skipIfNoNetwork()
> +    def test_gomodgit_url_no_go_mod_in_module(self):
> +        urls = ['gomodgit://gopkg.in/ini.v1;version=v1.67.0;'
> +                'srcrev=b2f570e5b5b844226bbefe6fb521d891f529a951']
> +
> +        fetcher = bb.fetch2.Fetch(urls, self.d)
> +        ud = fetcher.ud[urls[0]]
> +        self.assertEqual(ud.host, 'gopkg.in')
> +        self.assertEqual(ud.path, '/ini.v1')
> +        self.assertEqual(ud.names, ['gopkg.in/ini.v1@v1.67.0'])
> +        self.assertEqual(self.d.getVar('SRCREV_gopkg.in/ini.v1@v1.67.0'), 'b2f570e5b5b844226bbefe6fb521d891f529a951')
> +
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +        vcsdir = os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
> +        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'b7879a4be9ba8598851b8278b14c4f71a8316be64913298d1639cce6bde59bc3')))
> +        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in/ini.v1/@v/v1.67.0.zip')))
> +        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in/ini.v1/@v/v1.67.0.mod')))
>

--------------cJpkkRrCfN10dOg31pt90qdK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">A few questions on the patchset.<br>
      <br>
      - What if the module doesn't use any proxy? (E.g. hosted in a
      private repository)<br>
      - The current recipetool approach (
<a class="moz-txt-link-freetext" href="https://git.openembedded.org/openembedded-core/tree/scripts/lib/recipetool/create_go.py">https://git.openembedded.org/openembedded-core/tree/scripts/lib/recipetool/create_go.py</a>
      ) uses vendoring approach and all dependencies go into the
      SRC_URI. Thus it's required to populate the required license
      information for the manifest generation. Would that be possible
      with this fetcher as well?<br>
      <br>
      Slava<br>
      <br>
      On 06.09.2024 11:27, Christian Lindeberg via
      lists.openembedded.org wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240906092739.930765-2-christli@axis.com">
      <pre wrap="" class="moz-quote-pre">From: Christian Lindeberg <a class="moz-txt-link-rfc2396E" href="mailto:christian.lindeberg@axis.com">&lt;christian.lindeberg@axis.com&gt;</a>

Add a go module fetcher for downloading module dependencies to the
module cache directly from a git repository. The fetcher can be used
with the go-mod class in OE-Core.

A module dependency can be specified with:

  SRC_URI += "gomodgit://golang.org/x/net;version=v0.9.0;srcrev=..."

Signed-off-by: Christian Lindeberg <a class="moz-txt-link-rfc2396E" href="mailto:christian.lindeberg@axis.com">&lt;christian.lindeberg@axis.com&gt;</a>
---

Changes in V2:
- Use separate gomodgit:// type instead of the direct=git parameter.
- Use GO_MOD_CACHE_DIR variable or default instead of requiring the
  GOMODCACHE environment variable to be set.
- Add more documentation to make it cleared what is downloaded and what
  is unpacked.

 lib/bb/fetch2/__init__.py |   1 +
 lib/bb/fetch2/gomod.py    | 140 +++++++++++++++++++++++++++++++++++++-
 lib/bb/tests/fetch.py     |  89 ++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f84ce5999..ddee4400b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -2112,3 +2112,4 @@ methods.append(az.Az())
 methods.append(crate.Crate())
 methods.append(gcp.GCP())
 methods.append(gomod.GoMod())
+methods.append(gomod.GoModGit())
diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
index fe025e367..1b532d03f 100644
--- a/lib/bb/fetch2/gomod.py
+++ b/lib/bb/fetch2/gomod.py
@@ -1,12 +1,13 @@
 """
 BitBake 'Fetch' implementation for Go modules
 
-The gomod fetcher is used to download Go modules to the module cache from a
-module proxy.
+The gomod/gomodgit fetchers are used to download Go modules to the module cache
+from a module proxy or directly from a version control repository.
 
 Example SRC_URI:
 
 SRC_URI += "gomod://golang.org/x/net;version=v0.9.0;sha256sum=..."
+SRC_URI += "gomodgit://golang.org/x/net;version=v0.9.0;repo=go.googlesource.com/net;srcrev=..."
 
 Required SRC_URI parameters:
 
@@ -27,6 +28,23 @@ Optional SRC_URI parameters:
     only the go.mod file. Alternatively, set the SRC_URI varible flag for
     <a class="moz-txt-link-rfc2396E" href="mailto:module@version.sha256sum">"module@version.sha256sum"</a>.
 
+- protocol
+    The method used when fetching directly from a version control repository.
+    The default is "https" for git.
+
+- repo
+    The URL when fetching directly from a version control repository. Required
+    when the URL is different from the module path.
+
+- srcrev
+    The revision identifier used when fetching directly from a version control
+    repository. Alternatively, set the SRCREV varible for "module@version".
+
+- subdir
+    The module subdirectory when fetching directly from a version control
+    repository. Required when the module is not located in the root of the
+    repository.
+
 Related variables:
 
 - GO_MOD_PROXY
@@ -41,14 +59,19 @@ See the Go modules reference, <a class="moz-txt-link-freetext" href="https://go.dev/ref/mod">https://go.dev/ref/mod</a>, for more information
 about the module cache, module proxies and version control systems.
 """
 
+import hashlib
 import os
 import re
 import shutil
+import subprocess
 import zipfile
 
 import bb
 from bb.fetch2 import FetchError
 from bb.fetch2 import MissingParameterError
+from bb.fetch2 import runfetchcmd
+from bb.fetch2 import subprocess_setup
+from bb.fetch2.git import Git
 from bb.fetch2.wget import Wget
 
 
@@ -126,3 +149,116 @@ class GoMod(Wget):
                         # If the module does not have a go.mod file, synthesize
                         # one containing only a module statement.
                         mf.write(f'module {module}\n'.encode())
+
+
+class GoModGit(Git):
+    """Class to fetch Go modules directly from a git repository"""
+
+    def supports(self, ud, d):
+        """Check to see if a given URL is for this fetcher."""
+        return ud.type == 'gomodgit'
+
+    def urldata_init(self, ud, d):
+        """Set up to download the module from the git repository.
+
+        Set up to download the git repository to the module cache directory and
+        unpack the module zip file and the go.mod file:
+
+        cache/vcs/&lt;hash&gt;:                         The bare git repository.
+        cache/download/&lt;module&gt;/@v/&lt;version&gt;.zip: The module zip file.
+        cache/download/&lt;module&gt;/@v/&lt;version&gt;.mod: The go.mod file.
+        """
+
+        moddir = d.getVar('GO_MOD_CACHE_DIR') or 'pkg/mod'
+
+        if 'version' not in ud.parm:
+            raise MissingParameterError('version', ud.url)
+
+        module = ud.host + ud.path
+        ud.parm['module'] = module
+
+        # Set host, path and srcrev for git download
+        if 'repo' in ud.parm:
+            repo = ud.parm['repo']
+            idx = repo.find('/')
+            if idx != -1:
+                ud.host = repo[:idx]
+                ud.path = repo[idx:]
+            else:
+                ud.host = repo
+                ud.path = ''
+        if 'protocol' not in ud.parm:
+            ud.parm['protocol'] = 'https'
+        name = f<a class="moz-txt-link-rfc2396E" href="mailto:{module}@{ud.parm['version']}">"{module}@{ud.parm['version']}"</a>
+        ud.names = [name]
+        srcrev = d.getVar('SRCREV_' + name)
+        if srcrev:
+            if 'srcrev' not in ud.parm:
+                ud.parm['srcrev'] = srcrev
+        else:
+            if 'srcrev' in ud.parm:
+                d.setVar('SRCREV_' + name, ud.parm['srcrev'])
+        if 'branch' not in ud.parm:
+            ud.parm['nobranch'] = '1'
+
+        # Set subpath, subdir and bareclone for git unpack
+        if 'subdir' in ud.parm:
+            ud.parm['subpath'] = ud.parm['subdir']
+        key = f"git3:{ud.parm['protocol']}://{ud.host}{ud.path}".encode()
+        ud.parm['key'] = key
+        ud.parm['subdir'] = os.path.join(moddir, 'cache/vcs',
+                                         hashlib.sha256(key).hexdigest())
+        ud.parm['bareclone'] = '1'
+
+        super().urldata_init(ud, d)
+
+    def unpack(self, ud, rootdir, d):
+        """Unpack the module in the module cache."""
+
+        # Unpack the bare git repository
+        super().unpack(ud, rootdir, d)
+
+        moddir = d.getVar('GO_MOD_CACHE_DIR') or 'pkg/mod'
+
+        # Create the info file
+        module = ud.parm['module']
+        repodir = os.path.join(rootdir, ud.parm['subdir'])
+        with open(repodir + '.info', 'wb') as f:
+            f.write(ud.parm['key'])
+
+        # Unpack the go.mod file from the repository
+        unpackdir = os.path.join(rootdir, moddir, 'cache/download',
+                                 escape(module), '@v')
+        bb.utils.mkdirhier(unpackdir)
+        srcrev = ud.parm['srcrev']
+        version = ud.parm['version']
+        escaped_version = escape(version)
+        cmd = f"git ls-tree -r --name-only '{srcrev}'"
+        if 'subpath' in ud.parm:
+            cmd += f" '{ud.parm['subpath']}'"
+        files = runfetchcmd(cmd, d, workdir=repodir).split()
+        name = escaped_version + '.mod'
+        bb.note(f"Unpacking {name} to {unpackdir}/")
+        with open(os.path.join(unpackdir, name), mode='wb') as mf:
+            f = 'go.mod'
+            if 'subpath' in ud.parm:
+                f = os.path.join(ud.parm['subpath'], f)
+            if f in files:
+                cmd = ['git', 'cat-file', 'blob', srcrev + ':' + f]
+                subprocess.check_call(cmd, stdout=mf, cwd=repodir,
+                                      preexec_fn=subprocess_setup)
+            else:
+                # If the module does not have a go.mod file, synthesize one
+                # containing only a module statement.
+                mf.write(f'module {module}\n'.encode())
+
+        # Synthesize the module zip file from the repository
+        name = escaped_version + '.zip'
+        bb.note(f"Unpacking {name} to {unpackdir}/")
+        with zipfile.ZipFile(os.path.join(unpackdir, name), mode='w') as zf:
+            prefix = module + '@' + version + '/'
+            for f in files:
+                cmd = ['git', 'cat-file', 'blob', srcrev + ':' + f]
+                data = subprocess.check_output(cmd, cwd=repodir,
+                                               preexec_fn=subprocess_setup)
+                zf.writestr(prefix + f, data)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 2365a5096..832e0dd6a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3455,3 +3455,92 @@ class GoModTest(FetcherTest):
         downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
         self.assertTrue(os.path.exists(os.path.join(downloaddir, '<a class="moz-txt-link-abbreviated" href="mailto:gopkg.in/ini.v1/@v/v1.67.0.zip">gopkg.in/ini.v1/@v/v1.67.0.zip</a>')))
         self.assertTrue(os.path.exists(os.path.join(downloaddir, '<a class="moz-txt-link-abbreviated" href="mailto:gopkg.in/ini.v1/@v/v1.67.0.mod">gopkg.in/ini.v1/@v/v1.67.0.mod</a>')))
+
+class GoModGitTest(FetcherTest):
+
+    @skipIfNoNetwork()
+    def test_gomodgit_url_repo(self):
+        urls = ['gomodgit://golang.org/x/net;version=v0.9.0;'
+                'repo=go.googlesource.com/net;'
+                'srcrev=694cff8668bac64e0864b552bffc280cd27f21b1']
+
+        fetcher = bb.fetch2.Fetch(urls, self.d)
+        ud = fetcher.ud[urls[0]]
+        self.assertEqual(ud.host, 'go.googlesource.com')
+        self.assertEqual(ud.path, '/net')
+        self.assertEqual(ud.names, ['<a class="moz-txt-link-abbreviated" href="mailto:golang.org/x/net@v0.9.0">golang.org/x/net@v0.9.0</a>'])
+        self.assertEqual(self.d.getVar('<a class="moz-txt-link-abbreviated" href="mailto:SRCREV_golang.org/x/net@v0.9.0">SRCREV_golang.org/x/net@v0.9.0</a>'), '694cff8668bac64e0864b552bffc280cd27f21b1')
+
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+
+        fetcher.unpack(self.unpackdir)
+        vcsdir = os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
+        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'ed42bd05533fd84ae290a5d33ebd3695a0a2b06131beebd5450825bee8603aca')))
+        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, '<a class="moz-txt-link-abbreviated" href="mailto:golang.org/x/net/@v/v0.9.0.zip">golang.org/x/net/@v/v0.9.0.zip</a>')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, '<a class="moz-txt-link-abbreviated" href="mailto:golang.org/x/net/@v/v0.9.0.mod">golang.org/x/net/@v/v0.9.0.mod</a>')))
+
+    @skipIfNoNetwork()
+    def test_gomodgit_url_subdir(self):
+        urls = ['gomodgit://github.com/Azure/azure-sdk-for-go/sdk/storage/azblob;version=v1.0.0;'
+                'repo=github.com/Azure/azure-sdk-for-go;subdir=sdk/storage/azblob;'
+                'srcrev=ec928e0ed34db682b3f783d3739d1c538142e0c3']
+
+        fetcher = bb.fetch2.Fetch(urls, self.d)
+        ud = fetcher.ud[urls[0]]
+        self.assertEqual(ud.host, 'github.com')
+        self.assertEqual(ud.path, '/Azure/azure-sdk-for-go')
+        self.assertEqual(ud.parm['subpath'], 'sdk/storage/azblob')
+        self.assertEqual(ud.names, ['<a class="moz-txt-link-abbreviated" href="mailto:github.com/Azure/azure-sdk-for-go/sdk/storage/azblob@v1.0.0">github.com/Azure/azure-sdk-for-go/sdk/storage/azblob@v1.0.0</a>'])
+        self.assertEqual(self.d.getVar('<a class="moz-txt-link-abbreviated" href="mailto:SRCREV_github.com/Azure/azure-sdk-for-go/sdk/storage/azblob@v1.0.0">SRCREV_github.com/Azure/azure-sdk-for-go/sdk/storage/azblob@v1.0.0</a>'), 'ec928e0ed34db682b3f783d3739d1c538142e0c3')
+
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+
+        fetcher.unpack(self.unpackdir)
+        vcsdir = os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
+        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'd31d6145676ed3066ce573a8198f326dea5be45a43b3d8f41ce7787fd71d66b3')))
+        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, '<a class="moz-txt-link-abbreviated" href="mailto:github.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.zip">github.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.zip</a>')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, '<a class="moz-txt-link-abbreviated" href="mailto:github.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod">github.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod</a>')))
+
+    @skipIfNoNetwork()
+    def test_gomodgit_url_srcrev_var(self):
+        urls = ['gomodgit://gopkg.in/ini.v1;version=v1.67.0']
+        self.d.setVar('<a class="moz-txt-link-abbreviated" href="mailto:SRCREV_gopkg.in/ini.v1@v1.67.0">SRCREV_gopkg.in/ini.v1@v1.67.0</a>', 'b2f570e5b5b844226bbefe6fb521d891f529a951')
+
+        fetcher = bb.fetch2.Fetch(urls, self.d)
+        ud = fetcher.ud[urls[0]]
+        self.assertEqual(ud.host, 'gopkg.in')
+        self.assertEqual(ud.path, '/ini.v1')
+        self.assertEqual(ud.names, ['<a class="moz-txt-link-abbreviated" href="mailto:gopkg.in/ini.v1@v1.67.0">gopkg.in/ini.v1@v1.67.0</a>'])
+        self.assertEqual(ud.parm['srcrev'], 'b2f570e5b5b844226bbefe6fb521d891f529a951')
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        vcsdir = os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
+        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'b7879a4be9ba8598851b8278b14c4f71a8316be64913298d1639cce6bde59bc3')))
+        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, '<a class="moz-txt-link-abbreviated" href="mailto:gopkg.in/ini.v1/@v/v1.67.0.zip">gopkg.in/ini.v1/@v/v1.67.0.zip</a>')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, '<a class="moz-txt-link-abbreviated" href="mailto:gopkg.in/ini.v1/@v/v1.67.0.mod">gopkg.in/ini.v1/@v/v1.67.0.mod</a>')))
+
+    @skipIfNoNetwork()
+    def test_gomodgit_url_no_go_mod_in_module(self):
+        urls = ['gomodgit://gopkg.in/ini.v1;version=v1.67.0;'
+                'srcrev=b2f570e5b5b844226bbefe6fb521d891f529a951']
+
+        fetcher = bb.fetch2.Fetch(urls, self.d)
+        ud = fetcher.ud[urls[0]]
+        self.assertEqual(ud.host, 'gopkg.in')
+        self.assertEqual(ud.path, '/ini.v1')
+        self.assertEqual(ud.names, ['<a class="moz-txt-link-abbreviated" href="mailto:gopkg.in/ini.v1@v1.67.0">gopkg.in/ini.v1@v1.67.0</a>'])
+        self.assertEqual(self.d.getVar('<a class="moz-txt-link-abbreviated" href="mailto:SRCREV_gopkg.in/ini.v1@v1.67.0">SRCREV_gopkg.in/ini.v1@v1.67.0</a>'), 'b2f570e5b5b844226bbefe6fb521d891f529a951')
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        vcsdir = os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
+        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'b7879a4be9ba8598851b8278b14c4f71a8316be64913298d1639cce6bde59bc3')))
+        downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, '<a class="moz-txt-link-abbreviated" href="mailto:gopkg.in/ini.v1/@v/v1.67.0.zip">gopkg.in/ini.v1/@v/v1.67.0.zip</a>')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, '<a class="moz-txt-link-abbreviated" href="mailto:gopkg.in/ini.v1/@v/v1.67.0.mod">gopkg.in/ini.v1/@v/v1.67.0.mod</a>')))
</pre>
      <span style="white-space: pre-wrap">
</span>
      <fieldset class="moz-mime-attachment-header"></fieldset>
    </blockquote>
    <br>
  </body>
</html>

--------------cJpkkRrCfN10dOg31pt90qdK--

