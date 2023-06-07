Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84880C77B7A
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 12:43:47 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.7390.1686141824171568864
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Jun 2023 05:43:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=VQBF/EKY;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexandre.belloni@bootlin.com)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1686141821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0bKre/RRQlxEblgdHAFL/sbBlhV86q7truJNe34CoE=;
	b=VQBF/EKYsowrfiBleGvFIyQlxKQ1wYv1JZfsdFvUM6IUQPEdJIjiYLhdLiKsPTKidJa0Ah
	RqlwFyQhl/kWoBUmHjnP5aF23fEucabklve8hvxXdEZTa1R7+3rkr0wg/iS8JEi2GzVwln
	3YLrXVGjbRphYBJD3J70IDR4WMVT8i9SXn/SIpZ/LF2n2w7E91aBypvGI4S10VGTpsY+Ld
	WqVHdDEuqYSgtjV9qgPesDAUZHz380aqArJNtICGld3fpNrhWeZB185QL+o9HX1W1VG3oZ
	v06/DdLq+s54BexHFJX5ZQV+8c0l+0z6n8F3JYav/w8x8svdQi+Ti2WRPF1Z+Q==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72CAE1C0005;
	Wed,  7 Jun 2023 12:43:41 +0000 (UTC)
Date: Wed, 7 Jun 2023 14:43:41 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: belouargamohamed@gmail.com
Cc: bitbake-devel@lists.openembedded.org,
	BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: Re: [bitbake-devel] [master][PATCH v2 1/3] bitbake: fetch2: npmsw:
 Add support for the new format of the shrinkwrap file
Message-ID: <20230607124341cf23201f@mail.local>
References: <20230604013919.13904-1-m.belouarga@technologyandstrategy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604013919.13904-1-m.belouarga@technologyandstrategy.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Jun 2023 12:43:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14832

Hello,

this series fails on the autobuilders:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5298/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/1548/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/5288/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/5323/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/5244/steps/11/logs/stdio

ERROR: test_npmsw_no_network_no_tarball (bb.tests.fetch.NPMTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/lib/bb/tests/fetch.py", line 2850, in test_npmsw_no_network_no_tarball
    fetcher.download()
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/lib/bb/fetch2/__init__.py", line 1738, in download
    if m.verify_donestamp(ud, self.d) and not m.need_update(ud, self.d):
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/lib/bb/fetch2/npmsw.py", line 224, in verify_donestamp
    return all(self._foreach_proxy_method(ud, _handle))
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/lib/bb/fetch2/npmsw.py", line 211, in _foreach_proxy_method
    for proxy_url in ud.proxy.urls:
AttributeError: 'FetchData' object has no attribute 'proxy'

On 04/06/2023 03:39:17+0200, belouargamohamed@gmail.com wrote:
> From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
> 
> Npm is a package manager that has its own manner to handle installation of packages.
> But it is not yocto friendly, for instance NPM fetch dependencies in the middle of compilation.
> 
> The shrinkwrap file changed its format over npm versions, but npm does not version
> this file, so we can use it properly.
> The actual changes make NPM depencies work with the actual shrinkwrap format.
> 
> Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
> ---
>  lib/bb/fetch2/npmsw.py | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
> index cc81100b3a..359192a29e 100644
> --- a/lib/bb/fetch2/npmsw.py
> +++ b/lib/bb/fetch2/npmsw.py
> @@ -41,20 +41,15 @@ def foreach_dependencies(shrinkwrap, callback=None, dev=False):
>          with:
>              name = the package name (string)
>              params = the package parameters (dictionary)
> -            deptree = the package dependency tree (array of strings)
> +            destdir = the destination of the package (string)
>      """
> -    def _walk_deps(deps, deptree):
> -        for name in deps:
> -            subtree = [*deptree, name]
> -            _walk_deps(deps[name].get("dependencies", {}), subtree)
> -            if callback is not None:
> -                if deps[name].get("dev", False) and not dev:
> -                    continue
> -                elif deps[name].get("bundled", False):
> -                    continue
> -                callback(name, deps[name], subtree)
> -
> -    _walk_deps(shrinkwrap.get("dependencies", {}), [])
> +    packages = shrinkwrap.get("packages", {})
> +
> +    for package in packages:
> +        if package != "":
> +            name = package.split('node_modules/')[-1]
> +            package_infos = packages.get(package, {})
> +            callback(name, package_infos, package)
>  
>  class NpmShrinkWrap(FetchMethod):
>      """Class to fetch all package from a shrinkwrap file"""
> @@ -75,12 +70,10 @@ class NpmShrinkWrap(FetchMethod):
>          # Resolve the dependencies
>          ud.deps = []
>  
> -        def _resolve_dependency(name, params, deptree):
> +        def _resolve_dependency(name, params, destsuffix):
>              url = None
>              localpath = None
>              extrapaths = []
> -            destsubdirs = [os.path.join("node_modules", dep) for dep in deptree]
> -            destsuffix = os.path.join(*destsubdirs)
>              unpack = True
>  
>              integrity = params.get("integrity", None)
> -- 
> 2.25.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14827): https://lists.openembedded.org/g/bitbake-devel/message/14827
> Mute This Topic: https://lists.openembedded.org/mt/99314980/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

