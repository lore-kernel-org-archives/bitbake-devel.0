Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 672BB77A4F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 12:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v2SCtg6H011210; 
	Tue, 28 Mar 2017 13:56:58 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id w-ZDOBifPh70; Tue, 28 Mar 2017 13:56:58 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2SCusxN011348
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 28 Mar 2017 13:56:55 +0100
Message-ID: <1490705814.13980.278.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Elizabeth 'pidge' Flanagan" <pidge@toganlabs.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 28 Mar 2017 13:56:54 +0100
In-Reply-To: <1490701183-20278-1-git-send-email-pidge@toganlabs.com>
References: <1490701183-20278-1-git-send-email-pidge@toganlabs.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] s3.py: Add support for fetching source mirrors/minor cleanup
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
X-List-Received-Date: Tue, 28 Mar 2017 12:56:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2017-03-28 at 13:39 +0200, Elizabeth 'pidge' Flanagan wrote:
> This commits main purpose is to add support for fetching source
> mirrors. In the current incarnation:
> 
> SOURCE_MIRROR_URL ?= "s3://mybucket/downloads"
> 
> will fail for two reasons. First, download doesn't support it,
> but second, without aws included in HOSTTOOLS you'll end up
> with aws not being found by bitbake (for either source mirrors or
> sstate mirrors).
> 
> Part of this is fixed with this commit. However, this will still
> fail if HOSTTOOLS doesn't include 'aws' in bitbake.conf. I've another
> commit or two to fix that as well.
> 
> I've also DRYed up some of the error handling, removed the hardcoded
> aws and added some logging.
> 
> Signed-off-by: Elizabeth 'pidge' Flanagan <pidge@toganlabs.com>
> ---
>  lib/bb/fetch2/s3.py | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
> index 27993aa..dbd86f4 100644
> --- a/lib/bb/fetch2/s3.py
> +++ b/lib/bb/fetch2/s3.py
> @@ -34,6 +34,7 @@ import urllib.request, urllib.parse, urllib.error
>  from bb.fetch2 import FetchMethod
>  from bb.fetch2 import FetchError
>  from bb.fetch2 import runfetchcmd
> +from bb.fetch2 import logger
>  
>  class S3(FetchMethod):
>      """Class to fetch urls via 'aws s3'"""
> @@ -60,8 +61,13 @@ class S3(FetchMethod):
>          Fetch urls
>          Assumes localpath was called first
>          """
> -
> -        cmd = 'aws s3 cp s3://%s%s %s' % (ud.host, ud.path,
> ud.localpath)
> +        if 'downloadfilename' in ud.parm:
> +            dldir = d.getVar("DL_DIR", True)
> +            bb.utils.mkdirhier(os.path.dirname(dldir + os.sep +
> ud.localfile))
> +            cmd = '%s cp s3://%s%s %s%s%s' %
> (d.getVar("FETCHCMD_s3"), ud.host, ud.path, dldir, os.sep,
> ud.localpath)
> +        else:
> +            cmd = '%s cp s3://%s%s %s' % (d.getVar("FETCHCMD_s3"),
> ud.host, ud.path, ud.localpath)
> +        logger.debug(2, "Fetching %s using command '%s'" % (ud.url,
> cmd))

Do you actually need/use FETCHCMD_s3 ?

I'd prefer not to add this unless we really do need it.

Cheers,

Richard

