Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id AD5487D695
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Apr 2019 09:05:37 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3P94jDO003823
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 25 Apr 2019 02:04:55 -0700
Received: from localhost.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.439.0; Thu, 25 Apr 2019 02:04:34 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Burton, Ross"
	<ross.burton@intel.com>
References: <cover.1556005325.git.liezhi.yang@windriver.com>
	<26bea95ed677fdf7d4c18f80e1e34ffb7c9fa364.1556005325.git.liezhi.yang@windriver.com>
	<190b82dc-9ee7-2ea6-6b1a-bf1aecdfaa08@windriver.com>
	<8655ad4f72ebb29e080a3e3802a5f04d9c43ba4c.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <6a1de576-84fb-2aa5-60a5-75c990c11a1c@windriver.com>
Date: Thu, 25 Apr 2019 17:04:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8655ad4f72ebb29e080a3e3802a5f04d9c43ba4c.camel@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] wget.py: Print warning when checkstatus() failed
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
X-List-Received-Date: Thu, 25 Apr 2019 09:05:37 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 4/23/19 9:58 PM, Richard Purdie wrote:
> On Tue, 2019-04-23 at 15:53 +0800, Robert Yang wrote:
>> Hi Ross,
>>
>> On 4/23/19 3:43 PM, Robert Yang wrote:
>>> This makes it easier to debug, for example, when I ran:
>>>
>>> $ bitbake-selftest bb.tests.fetch.FetchCheckStatusTest
>>>
>>> It said failed:
>>> FAIL: test_wget_checkstatus_connection_cache
>>> (bb.tests.fetch.FetchCheckStatusTest) (url='
>>> ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz')
>>>
>>> But didn't know the reason, this warning message can help me find
>>> that
>>> something is wrong with my ftp settings (I set a wrong proxy for
>>> ftp).
>>>
>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>> ---
>>>    bitbake/lib/bb/fetch2/wget.py | 5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/bitbake/lib/bb/fetch2/wget.py
>>> b/bitbake/lib/bb/fetch2/wget.py
>>> index 3bb3e3b..ffcd40a 100644
>>> --- a/bitbake/lib/bb/fetch2/wget.py
>>> +++ b/bitbake/lib/bb/fetch2/wget.py
>>> @@ -216,7 +216,7 @@ class Wget(FetchMethod):
>>>                            # Apparently urllib then uses the file
>>> descriptor, expecting it to be
>>>                            # connected, when in reality the
>>> connection is already gone.
>>>                            # We let the request fail and expect it
>>> to be
>>> -                        # tried once more ("try_again" in
>>> check_status()),
>>> +                        # tried once more ("try_again" in
>>> checkstatus()),
>>>                            # with the dead connection removed from
>>> the cache.
>>>                            # If it still fails, we give up, which
>>> can happend for bad
>>>                            # HTTP proxy settings.
>>> @@ -338,8 +338,7 @@ class Wget(FetchMethod):
>>>                    logger.debug(2, "checkstatus: trying again")
>>>                    return self.checkstatus(fetch, ud, d, False)
>>>                else:
>>> -                # debug for now to avoid spamming the logs in e.g.
>>> remote sstate searches
>>> -                logger.debug(2, "checkstatus() urlopen failed: %s"
>>> % e)
>>
>> You added these comments in the past, is the "spamming" still an
>> issue, please?
>> Or how can I reproduce it?
> 
> Set a remote (http) sstate mirror which doesn't exist and then try a
> core-image-sato-sdk with no local sstate?

Thanks, yes, indeed, I got a lot of warnings with a invalid remote sstate
mirror, so please ignore this patch.

// Robert

> 
> Cheers,
> 
> Richard
> 
> 

