Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E76D46C04
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 21:56:32 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1609.1769637390354117372
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 13:56:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=xTVgE6K8;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GmNNRPpAmKrowws8ZZsEMHIolCnyFJ3YLCfcapo5WzE=; b=xTVgE6K8OwXiUrQGhf/R6kgDdJ
	5imN4+WSH6w41SabanYuta9QixedIWnoG/E84WkRX299W7SIme+p8wN2vD25ozsbQEl/0X9PlBTy3
	CDVg88K/HFnE3ahItOe/n2v9yw84WMVz2OOi3ZofVV2WjzQIKm3KezcaETNTHEkObso6XJEwkVLo8
	OaEe6shMpkdxPWgSABGmTDUnaSssPCj8P4beDxPUnRnPe6xc31Sqrb6KJLvChVBqK5gEkK8r1SgCp
	jEGs0retXrZUEF0Mq0nFi0k4XgE0Jg/lSpPhRhzAKJNy2B3uL0j7y+10zxrKLMBzzgpcjm+J9gPUF
	JmAHYDFg==;
Received: from pool-174-115-41-146.cpe.net.cable.rogers.com ([174.115.41.146]:60416 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vlDWU-000000037m6-2fau;
	Wed, 28 Jan 2026 16:56:29 -0500
Date: Wed, 28 Jan 2026 16:57:08 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Quentin Schulz <foss@0leil.net>
cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
    Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual-intro: improve bbappend
 file matching doc
In-Reply-To: <20260128-bbappend-matching-v1-1-29fef2d63489@cherry.de>
Message-ID: <5d9a1e87-f8d4-19f6-4367-74f361d5d3f7@crashcourse.ca>
References: <20260128-bbappend-matching-v1-1-29fef2d63489@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel10.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel10.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel10.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 21:56:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18927

On Wed, 28 Jan 2026, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The recipe name matching wasn't fully explained and were missing a few
> important corner cases such as recipes without a version, or using the %
> character outside of the version part of the filename for example.
>
> This adds the last missing bits to cover every append naming scenario
> that exist today.
>
> This was derived from lib/bb/cooker.py:get_file_appends().
>
> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  .../bitbake-user-manual-intro.rst                  | 51 +++++++++++++++++-----
>  1 file changed, 40 insertions(+), 11 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> index baad71304..c971976d3 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -271,12 +271,9 @@ same root filename. The filenames can differ only in the file type
>  suffix used (e.g. ``formfactor_0.0.bb`` and
>  ``formfactor_0.0.bbappend``).
>
> -Information in append files extends or overrides the information in the
> -underlying, similarly-named recipe files.
> -
>  When you name an append file, you can use the "``%``" wildcard character
> -to allow for matching recipe names. For example, suppose you have an
> -append file named as follows::
> +to allow for a less strict recipe name matching. For example, suppose you have
> +an append file named as follows::
>
>    busybox_1.21.%.bbappend
>
> @@ -290,12 +287,6 @@ the append file would match the following recipe names::
>    busybox_1.21.10.bb
>    busybox_1.21.11.bb
>
> -.. note::
> -
> -   The use of the " % " character is limited in that it only works directly in
> -   front of the .bbappend portion of the append file's name. You cannot use the
> -   wildcard character in any other location of the name.
> -
>  If the ``busybox`` recipe was updated to ``busybox_1.3.0.bb``, the
>  append name would not match. However, if you named the append file
>  ``busybox_1.%.bbappend``, then you would have a match.
> @@ -303,6 +294,44 @@ append name would not match. However, if you named the append file
>  In the most general case, you could name the append file something as
>  simple as ``busybox_%.bbappend`` to be entirely version independent.
>
> +The "``%``" character is a marker for BitBake, and everything after that marker
> +will not be used for matching recipe names. That is, an append file named::
> +
> +   busybox_1.%.11.bb

  that's not an append file.

rday

