Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 90EF47F8A7
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Nov 2019 14:18:19 +0000 (UTC)
Received: from Marks-MacBook-Pro.local ([76.164.61.198]) (authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id xA5EI6o9020791
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Tue, 5 Nov 2019 08:18:12 -0600
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <20191102180558.5116-1-richard.purdie@linuxfoundation.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <6994ac88-7928-2a64-c004-1e3159ae26fb@kernel.crashing.org>
Date: Tue, 5 Nov 2019 08:18:06 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191102180558.5116-1-richard.purdie@linuxfoundation.org>
Subject: Re: [PATCH] fetch2: Ensure cached url data is matched to a datastore
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
X-List-Received-Date: Tue, 05 Nov 2019 14:18:19 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Just an FYI -- I did test this against the problem we found last week with
devtool modify linux-yocto (and virtual/kernel).  It DID resolved the problem.

--Mark

On 11/2/19 1:05 PM, Richard Purdie wrote:
> There was a weird error in OE-Core where "devtool modify virtual/kernel"
> was showing basehash mismatch errors. This was due to SRCPV sometimes being:
> AUTOINC+b867b78b50_47b80ef7bd and sometimes AUTOINC+b867b78b50_255a750d28.
> 
> The latter hash comes from KBRANCH and meant sometimes the correct branch
> was seen, sometimes it was not. The issue was complicated by the execution
> using a remote datastore over tinfoil.
> 
> The problem turns out to be a fetcher caching error. If the datastore
> changes, the cached url data may not be valid.
> 
> We therefore ensure we match cached url data against the datastore that
> generated it, which appears to fix this issue.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/__init__.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 1f5f8f1f14..07de6c2693 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1593,7 +1593,7 @@ class Fetch(object):
>          fn = d.getVar('FILE')
>          mc = d.getVar('__BBMULTICONFIG') or ""
>          if cache and fn and mc + fn in urldata_cache:
> -            self.ud = urldata_cache[mc + fn]
> +            self.ud = urldata_cache[mc + fn + str(id(d))]
>  
>          for url in urls:
>              if url not in self.ud:
> @@ -1605,7 +1605,7 @@ class Fetch(object):
>                          pass
>  
>          if fn and cache:
> -            urldata_cache[mc + fn] = self.ud
> +            urldata_cache[mc + fn + str(id(d))] = self.ud
>  
>      def localpath(self, url):
>          if url not in self.urls:
> 

