Return-Path: <andrew@bradfordembedded.com>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27])
	by mail.openembedded.org (Postfix) with ESMTP id 48BF56013D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Jul 2016 13:21:15 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 779482047D;
	Thu,  7 Jul 2016 09:21:15 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
	by compute1.internal (MEProxy); Thu, 07 Jul 2016 09:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	bradfordembedded.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=X2QDZfFVAvJCf8jrKe7bkHdRSJI=; b=KxiZda
	/8HdEgLjagXdIIhXZJCuJTOtEP48Da30oVByE4PJUyGAH5/sIw1kMvc2AmyaZDIm
	j4daSZyyGuryDE84UHFdgg4TMYlInqNp0OVevcjMWcBLpYnkPj78L8WgBaRlLn6p
	hkUibqY25KK3Pkk5pm7pJIAYX16hDm1kjCdys=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=X2QDZfFVAvJCf8jrKe7bkHdRSJI=; b=OSQCr
	53RTicGmMBoMu9zzHGAuAVkXh2HGHmwwRmU2JIVQuJTj34tMgmTpPRvRxNBPJx0C
	BHOxGDuufDgJIw1FjHRTT0GrS55if1GStKbwRWYzaBRXpMY4u6qZZiLYYm1uJZXt
	zO4SAk4awUfbVaQ2RJ+u6yIEn+8MmcnzUD0DxI=
X-Sasl-enc: G12udSWUu22XQVySx8a6tPiUGkyzi2uNl1zUgCvwjtII 1467897675
Received: from kaim-eeyore.kodakalaris.net (clr-vpn01.kodakalaris.com
	[198.140.222.129])
	by mail.messagingengine.com (Postfix) with ESMTPA id 19A3AF29FA;
	Thu,  7 Jul 2016 09:21:15 -0400 (EDT)
Date: Thu, 7 Jul 2016 09:21:13 -0400
From: Andrew Bradford <andrew@bradfordembedded.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20160707132113.GA2782@kaim-eeyore.kodakalaris.net>
References: <1465479849-28634-1-git-send-email-andrew@bradfordembedded.com>
	<1465479849-28634-3-git-send-email-andrew@bradfordembedded.com>
MIME-Version: 1.0
In-Reply-To: <1465479849-28634-3-git-send-email-andrew@bradfordembedded.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Cc: Scott Rifenbark <srifenbark@gmail.com>,
	Andrew Bradford <andrew.bradford@kodakalaris.com>
Subject: Re: [PATCH v2 2/2] doc: Document use of Perforce fetcher
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
X-List-Received-Date: Thu, 07 Jul 2016 13:21:16 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

On 06/09 09:44, Andrew Bradford wrote:
> From: Andrew Bradford <andrew.bradford@kodakalaris.com>
> 
> Signed-off-by: Andrew Bradford <andrew.bradford@kodakalaris.com>
> ---
>  .../bitbake-user-manual-fetching.xml               | 68 +++++++++++++++++++++-
>  .../bitbake-user-manual-ref-variables.xml          | 11 +++-
>  2 files changed, 75 insertions(+), 4 deletions(-)

Adding Scott Rifenbark to CC, sorry I left you off before.  Any chance
this patch could get picked up to go with the already applied perforce
fetcher changes which it documents?

Or are there any changes I should make so that it can be applied?

Thanks,
Andrew


