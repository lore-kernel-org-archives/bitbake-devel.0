Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web08.2727.1627933547362046838
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Aug 2021 12:45:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id 98CCD40BEB;
	Mon,  2 Aug 2021 19:45:46 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5r7ZMrtYTHrN; Mon,  2 Aug 2021 19:45:46 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-86-127.washdc.fios.verizon.net [100.15.86.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id 7916840BE6;
	Mon,  2 Aug 2021 19:45:45 +0000 (UTC)
Received: by mail.denix.org (Postfix, from userid 1000)
	id 2A56A17464F; Mon,  2 Aug 2021 15:45:45 -0400 (EDT)
Date: Mon, 2 Aug 2021 15:45:45 -0400
From: "Denys Dmytriyenko" <denis@denix.org>
To: bitbake-devel@lists.openembedded.org
Cc: Steve Sakoman <steve@sakoman.com>
Subject: Re: [bitbake-devel] [PATCH][1.46/1.48] providers: replace newly added logger.warn() with logger.warning()
Message-ID: <20210802194545.GM1528@denix.org>
References: <168F5A432E4959C7.26257@lists.openembedded.org>
MIME-Version: 1.0
In-Reply-To: <168F5A432E4959C7.26257@lists.openembedded.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ping.

On Tue, Jul 06, 2021 at 08:20:27PM -0400, Denys Dmytriyenko wrote:
> Commit https://git.openembedded.org/bitbake/commit/?id=78cd63285713fde59506eb2e71a7b7ee59a594ff
> converted logger.info() to logger.warn(), which is deprecated and instead
> should use logger.warning():
> 
> https://lists.openembedded.org/g/bitbake-devel/topic/82742194#12377
> 
> Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> ---
>  lib/bb/providers.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/providers.py b/lib/bb/providers.py
> index 3f66a3d..484e1ea 100644
> --- a/lib/bb/providers.py
> +++ b/lib/bb/providers.py
> @@ -151,7 +151,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
>          if item:
>              itemstr = " (for item %s)" % item
>          if preferred_file is None:
> -            logger.warn("preferred version %s of %s not available%s", pv_str, pn, itemstr)
> +            logger.warning("preferred version %s of %s not available%s", pv_str, pn, itemstr)
>              available_vers = []
>              for file_set in pkg_pn:
>                  for f in file_set:
> @@ -163,7 +163,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
>                          available_vers.append(ver_str)
>              if available_vers:
>                  available_vers.sort()
> -                logger.warn("versions of %s available: %s", pn, ' '.join(available_vers))
> +                logger.warning("versions of %s available: %s", pn, ' '.join(available_vers))
>          else:
>              logger.debug(1, "selecting %s as PREFERRED_VERSION %s of package %s%s", preferred_file, pv_str, pn, itemstr)
>  
> -- 
> 2.7.4
> 

-- 
Regards,
Denys Dmytriyenko <denis@denix.org>
PGP: 0x420902729A92C964 - https://denix.org/0x420902729A92C964
Fingerprint: 25FC E4A5 8A72 2F69 1186  6D76 4209 0272 9A92 C964
