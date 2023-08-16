Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992E5C04E69
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 18:06:00 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.167633.1692209150464245529
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Aug 2023 11:05:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=IYMDoz+e;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2BA741BF203;
	Wed, 16 Aug 2023 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1692209148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=upkki55RasJx5m3ARIWPs1dgU4O4f6ltQc4g5H2St4w=;
	b=IYMDoz+egvSK24fZ0Paqxu+sw97SqacrRlGwtcr+cr1QlTqPgzLA8Oua6SQp8AED2TjEug
	7j1J9LqNTQf/eHU16RY12EcFktzSnuWdcPPhxejGwUWRY54e57NcXvkDSvWPIXvilsm92R
	ry+VB/1Sz1Bn4lSGtqc5BpoHvtZW/2I+Qk34uSP+Tf36iiI6qHc7dn2gF/T1CFX/qFa6al
	B6EmTth46w4k+MZl4h6NWITkW5WjkwqZkxoc70lH5ve8KOKatZZbdUpPTk9EYWgq/5sFNk
	B9tU25z6hSSLK0/HG81h1cioUCS7AmPYpnkk2ORKRT6IcdOja/rcpqmmhJMceA==
Date: Wed, 16 Aug 2023 20:05:46 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add new srcrev fetcher API
Message-ID: <2023081618054635e1a5b3@mail.local>
References: <20230811130453.29278-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811130453.29278-1-richard.purdie@linuxfoundation.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Aug 2023 18:06:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14946

Hello,

On 11/08/2023 14:04:53+0100, Richard Purdie wrote:
> Add new functions to return some of the get_srcrev data in new and different
> ways. We need two different forms of the data, one is a string to inject into
> PKGV, the other is the full revisions as a string to include in hash computations
> so that the hash changes when the input revisions change.
> 
> This allows us to clean up and simplify the code in OE-Core and move the
> version information from PV to PKGV.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/__init__.py | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 2428a26fa6..c42961cb04 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -753,7 +753,7 @@ def get_autorev(d):
>      d.setVar("__BBAUTOREV_SEEN", True)
>      return "AUTOINC"
>  
> -def get_srcrev(d, method_name='sortable_revision'):
> +def _get_srcrev(d, method_name='sortable_revision'):
>      """
>      Return the revision string, usually for use in the version string (PV) of the current package
>      Most packages usually only have one SCM so we just pass on the call.
> @@ -774,6 +774,7 @@ def get_srcrev(d, method_name='sortable_revision'):
>      d.setVar("__BBINSRCREV", True)
>  
>      scms = []
> +    revs = []
>      fetcher = Fetch(d.getVar('SRC_URI').split(), d)
>      urldata = fetcher.ud
>      for u in urldata:
> @@ -781,16 +782,19 @@ def get_srcrev(d, method_name='sortable_revision'):
>              scms.append(u)
>  
>      if not scms:
> -        raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
> +        d.delVar("__BBINSRCREV")
> +        return "", revs
> +
>  
>      if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
>          autoinc, rev = getattr(urldata[scms[0]].method, method_name)(urldata[scms[0]], d, urldata[scms[0]].names[0])
> +        revs.append(rev)
>          if len(rev) > 10:
>              rev = rev[:10]
>          d.delVar("__BBINSRCREV")
>          if autoinc:
> -            return "AUTOINC+" + rev
> -        return rev
> +            return "AUTOINC+" + rev, revs
> +        return rev, revs
>  
>      #
>      # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
> @@ -806,6 +810,7 @@ def get_srcrev(d, method_name='sortable_revision'):
>          ud = urldata[scm]
>          for name in ud.names:
>              autoinc, rev = getattr(ud.method, method_name)(ud, d, name)
> +            revs.append(rev)
>              seenautoinc = seenautoinc or autoinc
>              if len(rev) > 10:
>                  rev = rev[:10]
> @@ -823,7 +828,21 @@ def get_srcrev(d, method_name='sortable_revision'):
>          format = "AUTOINC+" + format
>  
>      d.delVar("__BBINSRCREV")
> -    return format
> +    return format, revs
> +
> +def get_hashvalue(d, method_name='sortable_revision'):
> +    pkgv, revs = _get_srcrev(d, method_name=method_name)
> +    return " ".join(revs)
> +

I guess you already know but this causes:

ERROR: Failure expanding variable fetcher_hashes_dummyfunc[vardepvalue], expression was ${@bb.fetch.get_hashvalue(d)} which triggered exception AttributeError: module 'bb.fetch2' has no attribute 'get_hashvalue'
The variable dependency chain for the failure is: fetcher_hashes_dummyfunc[vardepvalue]


> +def get_pkgv_string(d, method_name='sortable_revision'):
> +    pkgv, revs = _get_srcrev(d, method_name=method_name)
> +    return pkgv
> +
> +def get_srcrev(d, method_name='sortable_revision'):
> +    pkgv, revs = _get_srcrev(d, method_name=method_name)
> +    if not pkgv:
> +        raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
> +    return pkgv
>  
>  def localpath(url, d):
>      fetcher = bb.fetch2.Fetch([url], d)
> -- 
> 2.39.2
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14936): https://lists.openembedded.org/g/bitbake-devel/message/14936
> Mute This Topic: https://lists.openembedded.org/mt/100683001/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/leave/10431315/3617179/474273136/xyzzy [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

