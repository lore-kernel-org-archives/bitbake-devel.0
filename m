Return-Path: <matthias.schiffer@ew.tq-group.com>
Received: from mx1.tq-group.com (mx1.tq-group.com [62.157.118.193])
	by mail.openembedded.org (Postfix) with ESMTP id CAFDF7C37F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 07:35:05 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.62,388,1554760800"; 
   d="scan'208";a="7859876"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
	by mx1-pgp.tq-group.com with ESMTP; 18 Jun 2019 09:35:05 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
	by tq-pgp-pr1.tq-net.de (PGP Universal service);
	Tue, 18 Jun 2019 09:35:05 +0200
X-PGP-Universal: processed;
	by tq-pgp-pr1.tq-net.de on Tue, 18 Jun 2019 09:35:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
	t=1560843305; x=1592379305;
	h=message-id:subject:from:to:date:in-reply-to:references:
	mime-version:content-transfer-encoding;
	bh=9qBk/0HcmmqAZC5lAr06D33U33hkv89lvgGOBC9o7gY=;
	b=HM9FPfHq5BW646GJ4FT44zCAYRAUDMNppXMPVQzSb/rCqmr3dhf5rS1d
	dHxlmueJ+bl+TMK5NJeWb01ugdU5by/SLw6G8mG4k2lGcH9C0QRoD0UvI
	8gloouK36PTn++7odBzwIZvxcLfZi7h+5X5+5iMzZDGBY5cO+tmh/dbEq
	RxdWh/n53Ne/ghNniAqkvIgsQIha6NQWhdm3dEzR2+jih2rDAoVT4bMEU
	qiDk5EzNsw66phQn7qDunSOJThE3oyDVCHUoGcHGdhR4uCGy0JGIKdN7s
	GgSMUrQWRxJuxI7nsKZa5x+5GHbV8Oto6KyrLqKYEDvhMriQ6gWV43gZN Q==;
X-IronPort-AV: E=Sophos;i="5.62,388,1554760800"; 
   d="scan'208";a="7859875"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
	by mx1.tq-group.com with ESMTP; 18 Jun 2019 09:35:05 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de
	[10.117.49.26])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id E05C4280074
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 09:35:21 +0200 (CEST)
Message-ID: <b6d3bcd74d29e575c8bf39ee9b878083ef0b4578.camel@ew.tq-group.com>
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jun 2019 09:35:03 +0200
In-Reply-To: <20190522091310.14470-1-matthias.schiffer@ew.tq-group.com>
References: <20190522091310.14470-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Subject: Re: [PATCH master 1.42] fetch2: runfetchcmd(): unset _PYTHON_SYSCONFIGDATA_NAME
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
X-List-Received-Date: Tue, 18 Jun 2019 07:35:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-05-22 at 11:13 +0200, Matthias Schiffer wrote:
> Since warrior, python3native.bbclass sets _PYTHON_SYSCONFIGDATA_NAME;
> unfortunately, this also affects Python scripts run as fetch commands
> like
> git-make-shallow, breaking it with a message like
> 
>     Failed to import the site module
>     Traceback (most recent call last):
>       File "/usr/lib/python3.6/site.py", line 570, in <module>
>         main()
>       File "/usr/lib/python3.6/site.py", line 556, in main
>         known_paths = addusersitepackages(known_paths)
>       File "/usr/lib/python3.6/site.py", line 288, in
> addusersitepackages
>         user_site = getusersitepackages()
>       File "/usr/lib/python3.6/site.py", line 264, in
> getusersitepackages
>         user_base = getuserbase() # this will also set USER_BASE
>       File "/usr/lib/python3.6/site.py", line 254, in getuserbase
>         USER_BASE = get_config_var('userbase')
>       File "/usr/lib/python3.6/sysconfig.py", line 607, in
> get_config_var
>         return get_config_vars().get(name)
>       File "/usr/lib/python3.6/sysconfig.py", line 550, in
> get_config_vars
>         _init_posix(_CONFIG_VARS)
>       File "/usr/lib/python3.6/sysconfig.py", line 421, in
> _init_posix
>         _temp = __import__(name, globals(), locals(),
> ['build_time_vars'], 0)
>     ModuleNotFoundError: No module named '_sysconfigdata'
> 
> on an Ubuntu 18.04 system (and likely others) when building with
> BB_GIT_SHALLOW and BB_GENERATE_SHALLOW_TARBALLS.
> 
> Unset _PYTHON_SYSCONFIGDATA_NAME in runfetchcmd() to work around
> this.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> I think this (or a different fix for this issue) should be added to
> both
> master and 1.42, as Yocto warrior is affected.

Thanks, this has been in master for ~3 weeks. Please also apply to
1.42, as we're currently seeing this issue with Yocto warrior.

Regards,
Matthias


> 
> Note that this fix assumes that the host Python does not need a
> _PYTHON_SYSCONFIGDATA_NAME, which should be true on most systems. A
> more
> complete fix would be to reset _PYTHON_SYSCONFIGDATA_NAME to its
> original
> value, but I don't know the Bitbake code well enough to do that.
> 
>  lib/bb/fetch2/__init__.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 0126e0d7..f6b5529b 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -843,6 +843,11 @@ def runfetchcmd(cmd, d, quiet=False,
> cleanup=None, log=None, workdir=None):
>          if val:
>              cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
>  
> +    # Ensure that a _PYTHON_SYSCONFIGDATA_NAME value set by a recipe
> +    # (for example via python3native.bbclass since warrior) is not
> set for
> +    # host Python (otherwise tools like git-make-shallow will fail)
> +    cmd = 'unset _PYTHON_SYSCONFIGDATA_NAME; ' + cmd
> +
>      # Disable pseudo as it may affect ssh, potentially causing it to
> hang.
>      cmd = 'export PSEUDO_DISABLED=1; ' + cmd
>  


