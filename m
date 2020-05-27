Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web12.592.1590609964984907995
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 May 2020 13:06:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id 5760A40C06;
	Wed, 27 May 2020 20:06:04 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id He1Y7W7-3ibS; Wed, 27 May 2020 20:06:04 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-86-127.washdc.fios.verizon.net [100.15.86.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id 64F4640A93;
	Wed, 27 May 2020 20:06:02 +0000 (UTC)
Received: by mail.denix.org (Postfix, from userid 1000)
	id 8F8761731FF; Wed, 27 May 2020 16:06:01 -0400 (EDT)
Date: Wed, 27 May 2020 16:06:01 -0400
From: "Denys Dmytriyenko" <denis@denix.org>
To: Jacob Kroon <jacob.kroon@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] doc: Clarify how task dependencies relate to RDEPENDS
Message-ID: <20200527200601.GN17660@denix.org>
References: <20200526192146.420290-1-jacob.kroon@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200526192146.420290-1-jacob.kroon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2020 at 09:21:46PM +0200, Jacob Kroon wrote:
> Clarify that BitBake knows how to map entries defined in the runtime
> dependency namespace back to build-time dependencies (recipes) in
> which tasks are defined.
> 
> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> index 10b58835..95a8b95b 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> @@ -2526,6 +2526,9 @@
>                  In the previous example, the <filename>do_packagedata</filename>
>                  task of each item in <filename>RDEPENDS</filename> must have
>                  completed before <filename>do_package_qa</filename> can execute.
> +                Although <filename>RDEPENDS</filename> contains entries from the
> +                runtime dependency namespace, BitBake knows how to map them back
> +                to the build-time dependency namespace, in which the tasks are defined.

That is quite an important clarification!

While working on multiconfig, I faced this issue - I can get build 
dependencies covered by "mcdepends", but there's no way to pull the 
resulting packages into images or SDK, as RDEPENDS or anything that 
results in RDEPENDS (IMAGE_INSTALL, PACKAGE_INSTALL, etc) all trigger 
this build-time dependency namespace check in bitbake and end up in 
errors like "Nothing RPROVIDES <blah>".
I wonder if multiconfig-aware RDEPENDS is needed to bypass this?

-- 
Denys
