Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web09.295.1623787988003164639
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Jun 2021 13:13:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id B0C3740BEA;
	Tue, 15 Jun 2021 20:13:06 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jBwO9TDlPL1P; Tue, 15 Jun 2021 20:13:06 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-86-127.washdc.fios.verizon.net [100.15.86.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id 9677740BE8;
	Tue, 15 Jun 2021 20:13:05 +0000 (UTC)
Received: by mail.denix.org (Postfix, from userid 1000)
	id E7BA3174604; Tue, 15 Jun 2021 16:13:04 -0400 (EDT)
Date: Tue, 15 Jun 2021 16:13:04 -0400
From: "Denys Dmytriyenko" <denis@denix.org>
To: Ross Burton <ross@burtonini.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH][1.48] bitbake: providers: selected version not available should be a warning
Message-ID: <20210615201304.GD1528@denix.org>
References: <20210511092723.3916148-1-ross.burton@arm.com>
MIME-Version: 1.0
In-Reply-To: <20210511092723.3916148-1-ross.burton@arm.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This has been picked up into 1.46/dunfell and now gives these extra warnings:

WARNING: .../bitbake/lib/bb/providers.py:154: DeprecationWarning: The 'warn' method is deprecated, use 'warning' instead
  logger.warn("preferred version %s of %s not available%s", pv_str, pn, itemstr)

WARNING: .../bitbake/lib/bb/providers.py:166: DeprecationWarning: The 'warn' method is deprecated, use 'warning' instead
  logger.warn("versions of %s available: %s", pn, ' '.join(available_vers))



On Tue, May 11, 2021 at 10:27:23AM +0100, Ross Burton wrote:
> From: Ross Burton <ross@burtonini.com>
> 
> If the selected version if not available, bitbake will happily attempt
> to build something else. This should be a loud warning not a small note.
> 
> (Bitbake rev: 78cd63285713fde59506eb2e71a7b7ee59a594ff)
> 
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bitbake/lib/bb/providers.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
> index 81459c36d56..3f66a3d99fa 100644
> --- a/bitbake/lib/bb/providers.py
> +++ b/bitbake/lib/bb/providers.py
> @@ -151,7 +151,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
>          if item:
>              itemstr = " (for item %s)" % item
>          if preferred_file is None:
> -            logger.info("preferred version %s of %s not available%s", pv_str, pn, itemstr)
> +            logger.warn("preferred version %s of %s not available%s", pv_str, pn, itemstr)
>              available_vers = []
>              for file_set in pkg_pn:
>                  for f in file_set:
> @@ -163,7 +163,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
>                          available_vers.append(ver_str)
>              if available_vers:
>                  available_vers.sort()
> -                logger.info("versions of %s available: %s", pn, ' '.join(available_vers))
> +                logger.warn("versions of %s available: %s", pn, ' '.join(available_vers))
>          else:
>              logger.debug(1, "selecting %s as PREFERRED_VERSION %s of package %s%s", preferred_file, pv_str, pn, itemstr)
>  
> -- 
> 2.25.1
> 

-- 
Regards,
Denys Dmytriyenko <denis@denix.org>
PGP: 0x420902729A92C964 - https://denix.org/0x420902729A92C964
Fingerprint: 25FC E4A5 8A72 2F69 1186  6D76 4209 0272 9A92 C964
