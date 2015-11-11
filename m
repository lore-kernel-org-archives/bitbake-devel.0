Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 082D277146
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Nov 2015 21:10:26 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id tABLAQ58015248
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Nov 2015 13:10:26 -0800 (PST)
Received: from Marks-MacBook-Pro.local (172.25.36.227) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.248.2; Wed, 11 Nov 2015 13:10:25 -0800
To: <bitbake-devel@lists.openembedded.org>
References: <1447260992.3559.244.camel@linuxfoundation.org>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <5643AEC1.1020307@windriver.com>
Date: Wed, 11 Nov 2015 15:10:25 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
	Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1447260992.3559.244.camel@linuxfoundation.org>
Subject: Re: [PATCH] codeparser: Only load the codeparser chace once
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
X-List-Received-Date: Wed, 11 Nov 2015 21:10:30 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

Is that a typo in the symmary "chace"?

On 11/11/15 10:56 AM, Richard Purdie wrote:
> The server state gets reset multiple times during startup and currently
> we reload the codeparser cache each time. This is pointless and causes
> unnecessary interaction time with bitbake.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
> index 82a3af4..6c9a42d 100644
> --- a/bitbake/lib/bb/codeparser.py
> +++ b/bitbake/lib/bb/codeparser.py
> @@ -144,6 +144,10 @@ class CodeParserCache(MultiProcessCache):
>          return cacheline
>  
>      def init_cache(self, d):
> +        # Check if we already have the caches
> +        if self.pythoncache:
> +            return
> +
>          MultiProcessCache.init_cache(self, d)
>  
>          # cachedata gets re-assigned in the parent
> 
> 


