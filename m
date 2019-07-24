Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5EBEF7F162
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Jul 2019 13:33:17 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x6ODXHqg020640
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 24 Jul 2019 06:33:17 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.468.0;
	Wed, 24 Jul 2019 06:33:16 -0700
To: Mike Crowe <mac@mcrowe.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
References: <20181217171645.8145-1-richard.purdie@linuxfoundation.org>
	<20190723160909.wdj7fwboiy65kfet@mcrowe.com>
	<00066477-9727-3081-a300-e030ef733333@windriver.com>
	<1e930c00f2f1ef60bda5c7d25d2850d438f3345a.camel@linuxfoundation.org>
	<20190724091134.kqctx32x3daxiwjq@mcrowe.com>
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
Message-ID: <f0513c19-7c81-5767-6954-6bbecfbd8d57@windriver.com>
Date: Wed, 24 Jul 2019 08:33:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724091134.kqctx32x3daxiwjq@mcrowe.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] data/siggen: Switch md5 -> sha256
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
X-List-Received-Date: Wed, 24 Jul 2019 13:33:17 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 7/24/19 4:11 AM, Mike Crowe wrote:
> On Wednesday 24 July 2019 at 09:11:09 +0100, Richard Purdie wrote:
>> On Tue, 2019-07-23 at 11:59 -0500, Mark Hatle wrote:
>>> On 7/23/19 11:09 AM, Mike Crowe wrote:
>>>> On Monday 17 December 2018 at 17:16:45 +0000, Richard Purdie wrote:
>>>>> Similarly to the codeparser change, change to sha256 hashes due
>>>>> to worries
>>>>> over collisions. The main impact of this change is slightly
>>>>> slower parsing
>>>>> time as well as longer sstate file names.
>>>>>
>>>>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org
>>>>>>
>>>>
>>>> This change has given us several sstate cache filenames that exceed
>>>> the 255
>>>> character limit of ext4. :(
>>>
>>> I wonder if another approach might be easier.  Instead use change the
>>> filename
>>> to be:
>>>
>>> sstate:<sstate_version>:<hash>:recipe:version:...:task.<type>
>>>
>>> (<type> such as .tgz.signifo)
>>>
>>> If the filename becomes too long, simply truncate the middle section)
>>> preserving:
>>>
>>> sstate:<state_version>:<hash> and <type>
> 
> We make use of the recipe name in our sstate cache pruning script, since
> some recipes have more churn and we expire them more quickly. That
> shouldn't be a problem as long as the recipe name is kept in preference to
> the version.

Ya, this is the human readable part.  However, you can still dump the contents
of the siginfo using the bitbake-dumpsig and get anything that was truncated
off.  So I would still consider it 'human readable', that happens to be machine
readable in most cases.

>>> So the same truncation when matching, and it should be safe.  The
>>> recipe,
>>> version ... task bit is nice to have for a human reader, but I don't
>>> think it's
>>> actually needed by the system itself.
>>>
>>> This should avoid any collisions and keep the maximum information
>>> that will fit
>>> in the filename(s).
>>
>> In some ways regardless of what we do, we need to abstract it so that
>> we have one function generating the filenames.
>>
>> So yes, think we need a patch which abstracts the filename generation.
>> It needs to be able to truncate elements of the constructed name other
>> than the hash. I do prefer truncating the other elements than changing
>> the hash.
> 
> If we're going to keep the 64-character SHA-256 hash and instead elide
> parts of the sstate filenames, then I think only sstate.bbclass needs to
> change, so this isn't a Bitbake issue and we should probably move this
> thread it openembedded-core.
> 
> Or perhaps I'm misunderstanding your suggestion.

I'm not sure where all of the filenames are handled, if it's in oe-core  sstate
class, then yes.. I think moving the discussion is the right next move.

It may be a joint change though, if filename generation needs an API or sync
with bitbake.  (I've not touched this part before, so I really don't know how
that part is generated.)

--Mark

> Thanks.
> 
> Mike.
> 


