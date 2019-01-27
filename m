Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id ADA7E7C35A
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 27 Jan 2019 01:19:04 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0R1IwDb009173
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Sat, 26 Jan 2019 17:18:58 -0800 (PST)
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.435.0;
	Sat, 26 Jan 2019 17:18:57 -0800
To: Stefan Agner <stefan@agner.ch>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
References: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
	<238483ee79cc017f2b6603d562c26cb18036a037.camel@linuxfoundation.org>
	<7d80c538faadfdc9d2259bc37956835b@agner.ch>
	<fc0c4b8d-13a9-ad32-a017-27feb97fb8bd@windriver.com>
	<832b2810-7e11-fa18-b50e-b40b07c6e265@windriver.com>
	<3ea9bbe919c928366d71417e1cb8b73f@agner.ch>
	<CAG+wK9nzO3WQfPTbf_8we_2xEm0JfevbrKM-E-Zov6qSz-sgrA@mail.gmail.com>
	<a20f847aaf0c90f4659147bf5f2e2bbe3e74bf40.camel@linuxfoundation.org>
	<4fe3bea47ebbb8977f87a6031d332e43@agner.ch>
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
Message-ID: <8a6a4a1f-4de6-22f1-c678-9d67481a2416@windriver.com>
Date: Sat, 26 Jan 2019 19:18:56 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4fe3bea47ebbb8977f87a6031d332e43@agner.ch>
Cc: Patrick Vacek <patrickvacek@gmail.com>,
	bitbake-devel@lists.openembedded.org, stefan.agner@toradex.com,
	luka.pivk@toradex.com, liu.ming50@gmail.com
Subject: Re: [PATCH V2] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Sun, 27 Jan 2019 01:19:04 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 1/26/19 7:50 AM, Stefan Agner wrote:
> On 26.01.2019 14:35, Richard Purdie wrote:
>> On Sat, 2019-01-26 at 13:07 +0100, Patrick Vacek wrote:
>>> On Sat, Jan 26, 2019 at 11:15 AM Stefan Agner <stefan@agner.ch>
>>> wrote:
>>>>> So it seems to be that something in the recipe was expecting
>>>> semi-broken
>>>>> behavior.. and its actually a recipe problem.
>>>>
>>>> Agreed, in this case we need to fix the recipe.
>>>
>>> Sorry, I must be missing something. What might be wrong with the
>>> recipe? Is there more that needs to be specified than a SRCREV and a
>>> branch? As far as I understand git, it keeps track of the submodules,
>>> so I don't know what other information there would be to provide. The
>>> reason this particular case is difficult is because there are
>>> recursive submodules. When we build aktualizr, we have to be careful
>>> to specify that. See
>>> https://github.com/advancedtelematic/aktualizr#building:
>>>
>>> git submodule update --init --recursive
>>
>> The problem is the checkout from the old version of the fetcher was
>> broken, it incorrectly checked out that SRCREV. The recipe was written
>> to build that broken checkout.
>>
>> We've fixed the fetcher and Mark is saying that it now checks out the
>> correct thing (as compared with a git checkout outside of the build
>> system, independent of the fetcher).
>>
>> The recipe assumed the old broken code so now fails to build. The
>> recipe therefore needs to change to adapt to the now correct source
>> code.
> 
> I was not able to reproduce Marks findings.
> 
> In particular:
> 
>> For instance, the submodule partial/extern/isotp-c:
>>
>> In the current version is checked out on
>> 4c5904bff3ed83ec471c8586b5faed62898d0224.  (Which matches the manual git behavior.)
>>
>> While the gitsm fetcher in the older system checkedout commit
>> 614fe48fe55aeea98b49804b7e31ef2d304f62de.  Which is incorrect.
> 
> That wasn't the case for me, the old code checked out 4c5904bf just
> fine.
> 
> However, I think Ming Liu's recent findings point out the culprit.
> 
> The submodule isotp-c requires a submodule on its own, and the new code
> seems not to unpack that.

i see what you are saying, but for some reason the version of git on my machine
(using the steps I mentioned in the original email) for some reason did not pull
down the recursive git submodule, which would explain why my diff didn't find
it.  (It's pretty clear to me that even within git itself, some submodule
operations have been broken in various versions in the past.. my guess is that
I'm hitting one of those errant behaviors locally.)

If I manually go to the isotp-c directory and run git init ; git submodule
update it -then- downloads it.  (So apparently the --recursive argument isn't in
some versions.  My system has 1.8.3.1 on it BTW.)

Looking at this quickly, I suspect I know what the problem is:

        if not ud.bareclone and self.process_submodules(ud, ud.destdir,
unpack_submodules, d):

if ud.bareclone is set, then python will optimize and not even run the
process_submodules which is what does the unpack.  This is set for recursive
submodule parsing.

I'm getting ready to board a plane in a few hours.  So it'll be a day or so
before I can get back to this.  I think I have a fix, see:

http://git.openembedded.org/bitbake-contrib/commit/?h=mgh/gitsm&id=ce5bb0056e6c510855811a26afb95073daf90f2a

If you see this and can test it... I can formally send it for review if it's
resolved the issues when I get to my destination.

--Mark

