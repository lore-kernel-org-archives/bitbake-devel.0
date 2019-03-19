Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 592156D68F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 03:41:55 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x2J3ftWZ001685
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Mar 2019 20:41:55 -0700 (PDT)
Received: from [128.224.163.177] (128.224.163.177) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.439.0;
	Mon, 18 Mar 2019 20:41:54 -0700
To: Mark Hatle <mark.hatle@windriver.com>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
	<d73ce5c9d372d09ff28654f55640611fe0b36e3c.1552555629.git.liezhi.yang@windriver.com>
	<339b2a82-b650-0781-7311-71ef931978bd@windriver.com>
	<40a095c7-c69e-2b9e-711c-05847227509d@windriver.com>
	<d816dd17-fa5c-6480-b82f-96c87d467a33@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <95d3c482-e593-50b1-c700-145cf9502ec5@windriver.com>
Date: Tue, 19 Mar 2019 11:47:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <d816dd17-fa5c-6480-b82f-96c87d467a33@windriver.com>
Subject: Re: [PATCH 5/5] fetch2: Add gitsm's function process_submodules()
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
X-List-Received-Date: Tue, 19 Mar 2019 03:41:55 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 3/15/19 11:55 PM, Mark Hatle wrote:
> On 3/14/19 10:37 PM, Robert Yang wrote:
>> Hi Mark,
>>
>> On 3/14/19 10:46 PM, Mark Hatle wrote:
>>> On 3/14/19 4:28 AM, Robert Yang wrote:
>>>> So that bbclass can call it as fetcher.process_submodules(), otherwise, the
>>>> bbclass has to handle submodules itself.
>>>
>>> Are there any general equivalent to submodules in any other SCM?
>>>
>>> I think SVN has something similar, but I'm not sure if it requires special
>>> fetching or processing activities.  I don't think other SCMs do.
>>
>> Yes, I agree with that.
>>
>>>
>>> Why is this needed, for do_clean/do_cleanall?
>>
>> We have an internal bbclass (fetcher_helper.bbclass) to collect all SRC_URI, and
>> add the sources into corresponding download layer. I can get the submodule's
>> SRC_URI in fetcher_helper.bbclass as I had already done, but I think that
>> others (e.g., tinfoil.py) may also have the similar requirements, so I think
>> that we'd better export the API in bitbake/lib/bb/fetch2/__init__.py,
>> then we can use it as:
>>
>> fetcher = bb.fetch2.Fetch(src_uri, d)
>> fetcher.process_submodules(ud, ud.clonedir, customized_function)
>>
>>
>> Otherwise, we have to handle submodules manually as I had done in
>> fetcher_helper.bbclass.
>>
>>
>>>
>>> Theoretically it should be up to the fetch implementation itself to walk
>>> everything and do the clean operation.  (another comment below)
>>>
>>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>>> ---
>>>>    bitbake/lib/bb/fetch2/__init__.py | 25 +++++++++++++++++++++++++
>>>>    1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
>>>> index 64d7526..78bea1f 100644
>>>> --- a/bitbake/lib/bb/fetch2/__init__.py
>>>> +++ b/bitbake/lib/bb/fetch2/__init__.py
>>>> @@ -1807,6 +1807,31 @@ class Fetch(object):
>>>>                if ud.lockfile:
>>>>                    bb.utils.unlockfile(lf)
>>>>    
>>>> +    def process_submodules(self, ud, workdir, function, urls=None):
>>>> +        if not urls:
>>>> +            urls = self.urls
>>>> +
>>>> +        for url in urls:
>>>> +            if url not in self.ud:
>>>> +                self.ud[url] = FetchData(url, d)
>>>> +            ud = self.ud[url]
>>>> +            ud.setup_localpath(self.d)
>>>> +
>>>> +            if not ud.localfile and ud.localpath is None:
>>>> +                continue
>>>> +
>>>> +
>>>> +            if ud.lockfile:
>>>> +                lf = bb.utils.lockfile(ud.lockfile)
>>>> +
>>>> +            ud.method.process_submodules(ud, workdir, function, self.d)
>>>
>>> Since most fetchers won't have this implemented, shouldn't you check if the
>>> function is available, and if not simply continue (nothing to do)?
>>
>> Yes, make sense, fixed it in the pull repo:
>>
>> +    def process_submodules(self, ud, workdir, function, urls=None):
>> +        if not hasattr(ud.method, 'process_submodules'):
>> +            bb.warn('process_submodules() is not implented.')
>> +            return
>> [snip]
> 
> I think it's more simple then that.
> 
> def process_submodules(self, ud, workdir, function, urls=None):
>      if not hasattr(ud.method, 'process_submodules'):
>          return
> 
> Since most things won't have a process_submodules, I don't think we want any
> sort of warning, it should just return if nothing has happened.

Thanks, fixed in the repo.

// Robert

> 
> As for the question above if it's a good idea or not, I'll leave that to RP.
> I'm not sure either way.
> 
> --Mark
> 
>>
>> // Robert
>>
>>
>>>
>>>> +            if ud.donestamp:
>>>> +                bb.utils.remove(ud.donestamp)
>>>> +
>>>> +            if ud.lockfile:
>>>> +                bb.utils.unlockfile(lf)
>>>> +
>>>> +
>>>>    class FetchConnectionCache(object):
>>>>        """
>>>>            A class which represents an container for socket connections.
>>>>
>>>
>>>
> 
> 

