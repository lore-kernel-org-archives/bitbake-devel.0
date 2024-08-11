Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C0C52D7B
	for <webhook@archiver.kernel.org>; Sun, 11 Aug 2024 20:16:09 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.31275.1723407367998209385
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Aug 2024 13:16:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=BNexHEM+;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE97E60002;
	Sun, 11 Aug 2024 20:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723407366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dkFUTp/BnYDXXkybLuZXhAmQ3XDBK0ZBsJT0be6EWXg=;
	b=BNexHEM+NySPAEhR5mIdtSiv2VXY3G5ZWBvl72tbR/H2UTDE1Tm0W6sJBefPsWxxeZbjUS
	OZOBwh0qRfrKvdp83CrJKjU/4Qr64jQNTG2Ve5o7FF8ougvqFM6Ma3t4PE3BALk9wgxlqp
	TDRrE5r7Yn2y5Ce4Uco10ZqibAJsV4SgVzBeLSnkSLIzPsq7dB+dej3a8F4JBQGu7G+xr6
	6u2JMlJH97jE5w6XYACGmu0nDMxuotkXoLurQcnllZ1stq4RgNwEBL1PL7RVGmP/jPj92v
	PkbET6sMln5BaDkpnlUvuwHMr4uCTM++NCjfBaRnxFl1egnk6JjJeTvEKq4Spg==
Date: Sun, 11 Aug 2024 22:16:05 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org,
	tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	stefan.herbrechtsmeier@weidmueller.com
Subject: Re: [bitbake-devel] [PATCH v3 5/6] recipetool: create: split
 guess_license function
Message-ID: <2024081120160526af398b@mail.local>
References: <20240808144824.543208-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240808144824.543208-6-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808144824.543208-6-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 11 Aug 2024 20:16:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16462

Hello,

When you resend, can you group the bitbake patches together please? That
will make the series easier to apply.

On 08/08/2024 16:48:23+0200, Enguerrand de Ribaucourt wrote:
> +def match_licenses(licfiles, srctree, d):
> +    import bb
> +    md5sums = get_license_md5sums(d)
> +
> +    crunched_md5sums = crunch_known_licenses(d)
> +
> +    licenses = []
>      for licfile in sorted(licfiles):
> -        md5value = bb.utils.md5_file(licfile)
> +        resolved_licfile = d.expand(licfile)

I believe you need to rebase because this causes:

https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/7055/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/3708/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/7063/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/7041/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/6998/steps/14/logs/stdio

2024-08-09 09:19:32,800 - oe-selftest - INFO - recipetool.RecipetoolTests.test_recipetool_handle_license_vars (subunit.RemotedTestCase)
2024-08-09 09:19:32,800 - oe-selftest - INFO -  ... ERROR
2024-08-09 09:19:32,801 - oe-selftest - INFO - 6: 43/50 253/601 (5.86s) (0 failed) (recipetool.RecipetoolTests.test_recipetool_handle_license_vars)
2024-08-09 09:19:32,801 - oe-selftest - INFO - testtools.testresult.real._StringException: Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/meta/lib/oeqa/selftest/cases/recipetool.py", line 1091, in test_recipetool_handle_license_vars
    licvalues = handle_license_vars(srctree, lines_before, handled, extravalues, d)
  File "/home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/scripts/lib/recipetool/create.py", line 963, in handle_license_vars
    licvalues = find_licenses(srctree, d)
  File "/home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/scripts/lib/recipetool/create.py", line 1261, in find_licenses
    licenses = match_licenses(licfiles, srctree, d)
  File "/home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/scripts/lib/recipetool/create.py", line 1243, in match_licenses
    resolved_licfile = d.expand(licfile)
AttributeError: type object 'DataConnectorCopy' has no attribute 'expand'



> +        md5value = bb.utils.md5_file(resolved_licfile)
>          license = md5sums.get(md5value, None)
>          if not license:
> -            crunched_md5, lictext = crunch_license(licfile)
> +            crunched_md5, lictext = crunch_license(resolved_licfile)
>              license = crunched_md5sums.get(crunched_md5, None)
>              if lictext and not license:
>                  license = 'Unknown'
> @@ -1249,13 +1254,19 @@ def guess_license(srctree, d):
>          if license:
>              licenses.append((license, os.path.relpath(licfile, srctree), md5value))
>  
> +    return licenses
> +
> +def find_licenses(srctree, d):
> +    licfiles = find_license_files(srctree)
> +    licenses = match_licenses(licfiles, srctree, d)
> +
>      # FIXME should we grab at least one source file with a license header and add that too?
>  
>      return licenses
>  
>  def split_pkg_licenses(licvalues, packages, outlines, fallback_licenses=None, pn='${PN}'):
>      """
> -    Given a list of (license, path, md5sum) as returned by guess_license(),
> +    Given a list of (license, path, md5sum) as returned by match_licenses(),
>      a dict of package name to path mappings, write out a set of
>      package-specific LICENSE values.
>      """
> @@ -1418,4 +1429,3 @@ def register_commands(subparsers):
>      parser_create.add_argument('--devtool', action="store_true", help=argparse.SUPPRESS)
>      parser_create.add_argument('--mirrors', action="store_true", help='Enable PREMIRRORS and MIRRORS for source tree fetching (disabled by default).')
>      parser_create.set_defaults(func=create_recipe)
> -
> diff --git a/scripts/lib/recipetool/create_go.py b/scripts/lib/recipetool/create_go.py
> index a85a2f2786..5cc53931f0 100644
> --- a/scripts/lib/recipetool/create_go.py
> +++ b/scripts/lib/recipetool/create_go.py
> @@ -14,7 +14,7 @@ from collections import namedtuple
>  from enum import Enum
>  from html.parser import HTMLParser
>  from recipetool.create import RecipeHandler, handle_license_vars
> -from recipetool.create import guess_license, tidy_licenses, fixup_license
> +from recipetool.create import find_licenses, tidy_licenses, fixup_license
>  from recipetool.create import determine_from_url
>  from urllib.error import URLError, HTTPError
>  
> @@ -624,7 +624,7 @@ class GoRecipeHandler(RecipeHandler):
>  
>          licenses = []
>          lic_files_chksum = []
> -        licvalues = guess_license(tmp_vendor_dir, d)
> +        licvalues = find_licenses(tmp_vendor_dir, d)
>          shutil.rmtree(tmp_vendor_dir)
>  
>          if licvalues:
> diff --git a/scripts/lib/recipetool/create_npm.py b/scripts/lib/recipetool/create_npm.py
> index dd0ac01c3e..78dc248f31 100644
> --- a/scripts/lib/recipetool/create_npm.py
> +++ b/scripts/lib/recipetool/create_npm.py
> @@ -17,7 +17,7 @@ from bb.fetch2.npm import npm_package
>  from bb.fetch2.npmsw import foreach_dependencies
>  from recipetool.create import RecipeHandler
>  from recipetool.create import get_license_md5sums
> -from recipetool.create import guess_license
> +from recipetool.create import find_licenses
>  from recipetool.create import split_pkg_licenses
>  logger = logging.getLogger('recipetool')
>  
> @@ -320,7 +320,7 @@ class NpmRecipeHandler(RecipeHandler):
>              return (licenses, chksums, fallback_licenses)
>  
>          (licenses, extravalues["LIC_FILES_CHKSUM"], fallback_licenses) = _guess_odd_license(licfiles)
> -        split_pkg_licenses([*licenses, *guess_license(srctree, d)], packages, lines_after, fallback_licenses)
> +        split_pkg_licenses([*licenses, *find_licenses(srctree, d)], packages, lines_after, fallback_licenses)
>  
>          classes.append("npm")
>          handled.append("buildsystem")
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16458): https://lists.openembedded.org/g/bitbake-devel/message/16458
> Mute This Topic: https://lists.openembedded.org/mt/107790971/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

