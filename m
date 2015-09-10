Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3CA9D73243
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 23:16:05 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id t8ANG58X027383
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 16:16:05 -0700 (PDT)
Received: from Marks-MacBook-Pro.local (172.25.36.227) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.235.1; Thu, 10 Sep 2015 16:16:05 -0700
To: <bitbake-devel@lists.openembedded.org>
References: <1441922754-133875-1-git-send-email-mark.hatle@windriver.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <55F20F34.6020404@windriver.com>
Date: Thu, 10 Sep 2015 18:16:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
	Gecko/20100101 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1441922754-133875-1-git-send-email-mark.hatle@windriver.com>
Subject: Re: [PATCH] [RFC] tests/fetch.py: Add test showing recursion failure in url mapping
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
X-List-Received-Date: Thu, 10 Sep 2015 23:16:05 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

After sending this, I realized there was an easy way to break the recursion.
See the patch sent after this one.

On 9/10/15 5:05 PM, Mark Hatle wrote:
> Adding this test results in a failure:
> 
> RuntimeError: maximum recursion depth exceeded in cmp
> 
> The mirror processing runs over and over and over on the same URL until the
> stack is exhausted.  I do not have a proposed solution ot this problem.
> 
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  lib/bb/tests/fetch.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 8486224..39df138 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -405,7 +405,8 @@ class MirrorUriTest(FetcherTest):
>                                  'http://otherdownloads.yoctoproject.org/downloads/bitbake-1.0.tar.gz',
>                                  'http://downloads2.yoctoproject.org/downloads/bitbake-1.0.tar.gz'])
>  
> -    recmirrorvar = "https://.*/[^/]*    http://AAAA/A/A/A/ \n"
> +    recmirrorvar = "https://.*/[^/]*    http://AAAA/A/A/A/ \n" \
> +                   "https://.*/[^/]*    https://BBBB/B/B/B/ \n"
>  
>      def test_recursive(self):
>          fetcher = bb.fetch.FetchData("https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
> 


