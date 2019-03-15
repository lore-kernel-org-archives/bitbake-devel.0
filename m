Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id F15047C77E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Mar 2019 15:56:07 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2FFtCXX015578
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Mar 2019 08:55:58 -0700
Received: from soho-mhatle-m.local (172.25.36.235) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.439.0;
	Fri, 15 Mar 2019 08:55:49 -0700
To: Robert Yang <liezhi.yang@windriver.com>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
	<d73ce5c9d372d09ff28654f55640611fe0b36e3c.1552555629.git.liezhi.yang@windriver.com>
	<339b2a82-b650-0781-7311-71ef931978bd@windriver.com>
	<40a095c7-c69e-2b9e-711c-05847227509d@windriver.com>
From: Mark Hatle <mark.hatle@windriver.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.hatle@windriver.com; prefer-encrypt=mutual; keydata=
	mQENBFYKxFgBCACt/pzutBp6p/xVKTFJjHbM3KpQKCblyot/YP+bpTr51Hrc5xDXBQhoG7TC
	aIRvRIvbhEevEQK9y04gW3JK/5lobq5ORebolcsHlYBUvpNeIPjupLQwGvz/TPtrLRNGLqDC
	rvsM6OA2XbQ2bwzxWaSQS3ImE2O2iXOZn9HhThMGeDB4Nff3fgUvXOTDIrgWOn9K2DgLL7Yc
	zkUIlFdj+Nraksd/7BSk8oH6tjeBVhFqSFvKta9QxWgdr58oPaTYaW/xNqUjlLrbJuMw/MSe
	xzuYfdfDfm6J8kRjMOnwQ0n8svJElzqAk+d83ow38gpGQ+LkjGgnf8ZFJ4rUJFADroX3ABEB
	AAG0JU1hcmsgSGF0bGUgPG1hcmsuaGF0bGVAd2luZHJpdmVyLmNvbT6JATcEEwEIACEFAlYK
	xFgCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQfv796/r0vvlvZAf9Gs+eN320yhRW
	V/fZCsngKhmOK4v3HrTwFrkSmoD9QHQiE/5IPdNacHwIPwZx07tNBohB8xOeNqCPRYRBwGhA
	AnxKOPyd0nnm6ZhPzbA57v4x3IGRQr4QzvcBTASJq91l3Ew4lpAslyx5w1DPPqRD7G8ycDKg
	peKyDwmdkvCunVisSAQI3XIMq2y230biTO98tDPEezg+lg+yTsz9ZT33F5KNuWrpf8VL5fG/
	mt+kAv7wtsx/KTRbqhH3iFXF6eBSwMjAfTXFlkLfbM9riJGXrWEl9n2S2R3cDHNHug0lb8f4
	whK370KEO4OwRKIYW/VUBmzk5XZUE9DTlDSV8ycsrrkBDQRWCsRYAQgAwK3FuHCE+HW3YWdH
	PUjeSn5p//xJ57u8g2rng8zm9zNjmYgpPv5UxozaD9i2jf4mlQLHGGOezhHae8K4Nj70oVcv
	8AmwcrJa9i9WL1oy/9R3fHMWf/Ctt9VXTO0qlCuq6PDzaUfvsXR61aJIjTKNQTOjCLjY1vXm
	VSewUgARysmA8WrjTfwGBihMBxAX0+kIjx8nOlam0WvekMBXZ0AbS56oTLRxYao6DI3GeB/N
	oWPy/5DfuTKaSdM0Pf8al20x9RuNN5/HLMlyDH/k8bIa1xd9aAqW+Feiw5gC107V2E6ULyIy
	q6em2UrsmIRxrvpHqbNgQKqvTehJ+V/i4g/uOwARAQABiQEfBBgBCAAJBQJWCsRYAhsMAAoJ
	EH7+/ev69L755XAH/3ZcNhooqd9OBhFkvXm1iWZ8EoC7motWqVn2oEyxoonsg8AD9kFXiN+T
	dYp7dH99EZu9q4ptj56AXm4uHzOgywL/5/V2TY6twCGAjUGzDjAB5gzoi+JLIBlDiyOip0eL
	QswIhRk473xy3j8DA4oVamnSPWgyNJ+qsdt37YWDzoDFFvtDoRU7Eb+znfIMDKzlny0XU/8L
	cW1bNHJlpv/78GPdfP4tjysEd8MuA5jf5o5w4XqcwTqalffEJtQ/s3pbkstEi7qm5uPui5Kt
	gq6YYLSqcSNe0GWAF9/T+qwyo7burSTxUWCWtMmlXdAQLW9SynLhB3Jbch0nFAh0fCKi6yY=
Organization: Wind River Systems
Message-ID: <d816dd17-fa5c-6480-b82f-96c87d467a33@windriver.com>
Date: Fri, 15 Mar 2019 10:55:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <40a095c7-c69e-2b9e-711c-05847227509d@windriver.com>
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
X-List-Received-Date: Fri, 15 Mar 2019 15:56:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 3/14/19 10:37 PM, Robert Yang wrote:
> Hi Mark,
> 
> On 3/14/19 10:46 PM, Mark Hatle wrote:
>> On 3/14/19 4:28 AM, Robert Yang wrote:
>>> So that bbclass can call it as fetcher.process_submodules(), otherwise, the
>>> bbclass has to handle submodules itself.
>>
>> Are there any general equivalent to submodules in any other SCM?
>>
>> I think SVN has something similar, but I'm not sure if it requires special
>> fetching or processing activities.  I don't think other SCMs do.
> 
> Yes, I agree with that.
> 
>>
>> Why is this needed, for do_clean/do_cleanall?
> 
> We have an internal bbclass (fetcher_helper.bbclass) to collect all SRC_URI, and
> add the sources into corresponding download layer. I can get the submodule's
> SRC_URI in fetcher_helper.bbclass as I had already done, but I think that
> others (e.g., tinfoil.py) may also have the similar requirements, so I think
> that we'd better export the API in bitbake/lib/bb/fetch2/__init__.py,
> then we can use it as:
> 
> fetcher = bb.fetch2.Fetch(src_uri, d)
> fetcher.process_submodules(ud, ud.clonedir, customized_function)
> 
> 
> Otherwise, we have to handle submodules manually as I had done in 
> fetcher_helper.bbclass.
> 
> 
>>
>> Theoretically it should be up to the fetch implementation itself to walk
>> everything and do the clean operation.  (another comment below)
>>
>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>> ---
>>>   bitbake/lib/bb/fetch2/__init__.py | 25 +++++++++++++++++++++++++
>>>   1 file changed, 25 insertions(+)
>>>
>>> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
>>> index 64d7526..78bea1f 100644
>>> --- a/bitbake/lib/bb/fetch2/__init__.py
>>> +++ b/bitbake/lib/bb/fetch2/__init__.py
>>> @@ -1807,6 +1807,31 @@ class Fetch(object):
>>>               if ud.lockfile:
>>>                   bb.utils.unlockfile(lf)
>>>   
>>> +    def process_submodules(self, ud, workdir, function, urls=None):
>>> +        if not urls:
>>> +            urls = self.urls
>>> +
>>> +        for url in urls:
>>> +            if url not in self.ud:
>>> +                self.ud[url] = FetchData(url, d)
>>> +            ud = self.ud[url]
>>> +            ud.setup_localpath(self.d)
>>> +
>>> +            if not ud.localfile and ud.localpath is None:
>>> +                continue
>>> +
>>> +
>>> +            if ud.lockfile:
>>> +                lf = bb.utils.lockfile(ud.lockfile)
>>> +
>>> +            ud.method.process_submodules(ud, workdir, function, self.d)
>>
>> Since most fetchers won't have this implemented, shouldn't you check if the
>> function is available, and if not simply continue (nothing to do)?
> 
> Yes, make sense, fixed it in the pull repo:
> 
> +    def process_submodules(self, ud, workdir, function, urls=None):
> +        if not hasattr(ud.method, 'process_submodules'):
> +            bb.warn('process_submodules() is not implented.')
> +            return
> [snip]

I think it's more simple then that.

def process_submodules(self, ud, workdir, function, urls=None):
    if not hasattr(ud.method, 'process_submodules'):
        return

Since most things won't have a process_submodules, I don't think we want any
sort of warning, it should just return if nothing has happened.

As for the question above if it's a good idea or not, I'll leave that to RP.
I'm not sure either way.

--Mark

> 
> // Robert
> 
> 
>>
>>> +            if ud.donestamp:
>>> +                bb.utils.remove(ud.donestamp)
>>> +
>>> +            if ud.lockfile:
>>> +                bb.utils.unlockfile(lf)
>>> +
>>> +
>>>   class FetchConnectionCache(object):
>>>       """
>>>           A class which represents an container for socket connections.
>>>
>>
>>


