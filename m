Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 8138F719BA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 15:07:11 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v0JF7AIJ024506
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 19 Jan 2017 07:07:10 -0800
Received: from soho-mhatle-m.local (172.25.36.235) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Thu, 19 Jan 2017 07:07:10 -0800
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Robert Yang
	<liezhi.yang@windriver.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
References: <f8610648-ea83-06ab-01fa-f8260597973c@windriver.com>
	<a8d463a0-f40a-afaf-c326-1f3bdffd49b7@windriver.com>
	<1484821262.4367.424.camel@linuxfoundation.org>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <8d3f903a-0ff2-8c27-e2bc-258ad2c7fd7d@windriver.com>
Date: Thu, 19 Jan 2017 09:07:09 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
	Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <1484821262.4367.424.camel@linuxfoundation.org>
Subject: Re: Filename too long
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
X-List-Received-Date: Thu, 19 Jan 2017 15:07:11 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 1/19/17 4:21 AM, Richard Purdie wrote:
> On Thu, 2017-01-19 at 14:13 +0800, Robert Yang wrote:
>> Hi Mark,
>>
>> We have a local patch to fix the problem, I had sent it to bitbake-
>> devel
>> before, but not merged:
>>
>> https://patchwork.openembedded.org/patch/61321/
>>
>> Here is the updated patch in our bitbake:
>>
>> commit ebb1190c01a15fc6e91c9810c46313c3b3fb305c
>> Author: Robert Yang <liezhi.yang@windriver.com>
>> Date:   Fri Nov 8 23:32:11 2013 +0800
>>
>>      fetch2/git.py: fix the filename too long error
>>
>>      When we use the PREMIRROR/MIRROR from the local disk, and if it
>> is in a
>>      deep directory, for example, when len(path) > 255 (The
>> NAME_MAX), we
>>      will get the "filename too long error".
>>
>>      This is becuase we use ud.path.replace('/', '.') to change the
>> path to
>>      the filename. We seldom see such a long url, but it is easy to
>> produce
>>      it on the local machine.
>>
>>      Another problem is that:
>>
>>      file:///local/path
>>
>>      will be converted into .local.path which is a hidden file by
>> default.
> 
> Looking at the code in your patch, this second piece clearly isn't true
> due to this code:
> 
>           if gitsrcname.startswith('.'):
>               gitsrcname = gitsrcname[1:]
> 
> I also don't believe this patch is correct since we're meant to be
> creating a filename, not a path and if you leave the '/' characters in,
> it isn't a filename. I think we likely just need to truncate the path
> to the last say 225 chars if its over length. The unique piece should
> be towards the right hand end of the name.

Ok.. I can certainly implement that.  Should the truncation be in the lockfile
code or in the code that generatd the name itself?

BTW I did some further looking, the issue is that we have a recipe that includes
a local git repository.  So essentially the recipe does:

recipe-foo/foo/foo_1.0.bb:

SRC_URI = "git://${THISDIR}/foo.git;type=file"

When I was looking through everything I was mistaking the path and premirror
work.  It's actually the SRC_URI that is very long, and changes dynamically
based on the path to the recipe itself.... leading to the problem.

--Mark

> Cheers,
> 
> Richard
> 


