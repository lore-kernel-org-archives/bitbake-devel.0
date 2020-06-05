Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web12.909.1591401278678585367
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 16:54:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id 13CF340C36;
	Fri,  5 Jun 2020 23:54:38 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sBFKXQW9xfbw; Fri,  5 Jun 2020 23:54:38 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-86-127.washdc.fios.verizon.net [100.15.86.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id DAF5240A13;
	Fri,  5 Jun 2020 23:54:35 +0000 (UTC)
Received: by mail.denix.org (Postfix, from userid 1000)
	id 9E6BA173217; Fri,  5 Jun 2020 19:54:35 -0400 (EDT)
Date: Fri, 5 Jun 2020 19:54:35 -0400
From: "Denys Dmytriyenko" <denis@denix.org>
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [bitbake-devel] [RFC PATCH 0/3] Include mcdepends in signature generation
Message-ID: <20200605235435.GR17660@denix.org>
References: <20200605181754.32883-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200605181754.32883-1-JPEWhacker@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Joshua,

I see you've been actively working recently on multiconfig-related fixes in 
bitbake, thanks! While at it, would you also be able to take a look at 
multiconfig-aware RDEPENDS implementation, as discussed here[1]? Thanks!

[1] https://lists.openembedded.org/g/bitbake-devel/topic/74485221


On Fri, Jun 05, 2020 at 01:17:51PM -0500, Joshua Watt wrote:
> Updates signature generation so that mcdepends are included. Previously,
> they were not which meant that if recipe A mcdepends on recipe B, and
> recipe B changed, it would not automatically cause recipe A to also
> rebuild.
> 
> In order for signature generation classes to correctly handle mcdepends,
> they need access to all the data caches, so all are passed instead of
> just the one for the recipe in question.
> 
> This breaks the bitbake siggen API and makes it incompatible with
> previous signature generators, hence the cross-posting between bitbake
> and oe-core.
> 
> Joshua Watt (3):
>   bitbake: siggen: Pass all data caches to hash functions
>   bitbake: tests: Add mcdepends test
>   sstatesig: Account for all dataCaches being passed
> 
>  bitbake/lib/bb/runqueue.py                    |  6 +-
>  bitbake/lib/bb/siggen.py                      | 32 ++++----
>  .../lib/bb/tests/runqueue-tests/recipes/f1.bb |  1 +
>  bitbake/lib/bb/tests/runqueue.py              | 30 ++++++++
>  meta/lib/oe/sstatesig.py                      | 77 ++++++++++---------
>  5 files changed, 89 insertions(+), 57 deletions(-)
>  create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb
> 
> -- 
> 2.26.2
> 

> 

