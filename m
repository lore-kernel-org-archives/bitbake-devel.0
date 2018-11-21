Return-Path: <jan.kiszka@web.de>
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by mail.openembedded.org (Postfix) with ESMTP id B37796C4ED
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Nov 2018 08:30:31 +0000 (UTC)
Received: from [139.22.112.73] ([95.157.57.47]) by smtp.web.de (mrweb002
	[213.165.67.108]) with ESMTPSA (Nemesis) id 0MQ5zf-1gLEuH2LS7-005Gqs;
	Wed, 21 Nov 2018 09:30:26 +0100
To: Alejandro Enedino Hernandez Samaniego
	<alejandro.enedino.hernandez-samaniego@xilinx.com>,
	bitbake-devel@lists.openembedded.org
References: <dcf35fbf-e76a-4e93-c0c7-19cc26ecfe2c@web.de>
	<7cba6091-29e0-f476-65f1-eb6c941bd268@web.de>
	<901cac62-924e-3831-f165-d7d95e9ec107@xilinx.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <30d9bb71-cec5-41d2-18c7-c06e931df191@web.de>
Date: Wed, 21 Nov 2018 09:30:22 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
	Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <901cac62-924e-3831-f165-d7d95e9ec107@xilinx.com>
X-Provags-ID: V03:K1:mTR96RHHFpo/yJtwH3D7KngL6NCGsB4+mEjqerPEwSpA1Kur6E0
	IITg73sAdkhH+2Ox+Hv8ScYsfA9orwuM6j2oTCwMj1rSW7L5uJQm+l3GHexhH36oBDivYcE
	KBXNQikSQ2WhM71mqrislZtAR0ElYmNX8KkR2LRYtywCNP+FfLPoYv9tmWe8niff02O4v/2
	HTEMwOF8ovM67YGRLqgzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V01:K0:sko9fp3Hrn0=:sw9MmpbpRQupHtbTDNIXtz
	Wa8boWb8auUhYdO5uuPLThxpTrSPb7QBn+spc35lZBxJayeUrIpR/GHxmJOLSRHP78KvgN3HA
	Q0iNqY8CgTy7tYrRxTNqAvTfb3hwawALqnK6MfPNdaqaqfnSfxGfW/q3K4Joxb4oFxokJ6tkq
	/CbdkQZYAjqGfxQ/7qMzYZHiwXs+Prn8pc+Li5A6/bgcO6s2M6k/DQRo7GKqp2ltkiaexl4gH
	m5/ni7WU8mb4vE9XoXmOpYKmaM5/GiDuecE17fAT44aGMbIi/8ZOM3htVClAt5CO9UHq3ltJU
	8IotgYhAhAwD8lTgvkKNnezCq8d/3KhMhna94j6tntjS8EkR1COFxwGp7E3QdBwJVPN/tBjvK
	TtZzjfK6NYT0rhP+7sbbJMEyi7yehsbNQ/iWkdzLkxcLxFBH+DKQ2k2FeYTlOT8Ypf0zouza2
	uSuA3MQ1Bd3zy0DfHrq88TO3VJdMT1Lpufls9pQ+68YxYtwFioanSGtNjsOx9dVXfjCyzK+gJ
	x+STMzLaP9dBFfwRHBP4Ty9Gz05NhfPmU3klTYKCLT97A0u4ECPGmLCG1fOfH/FhH6gd8iZU3
	JlDiiqZpkV13+bjxhKQ5knBBTint2/REf5mepMCDYTa+hxTTX1wW6HEiOlYf2hXE1i3e0HYDS
	h2b2VqZqAViY/O6NgpSLFso+MJWatlmKspVQiLt0qBNCkfN/cpAtG1aheP0/kcww4Cqg2SF5q
	LjWTKuj8+gHRJGdTO1Kg4GNS/w5AMzDd9EfIUhWRDLUJ+H9Ux3rOlCmNvnNGrdm4LTsWkMtk4
	Q8V/1JqDe4RRpL8qu4Z4JXWYjLZWzPvbXCPjD/reu0dkgGd7juqN3aK6QiZBQiinZTtypR5YD
	0ZGAovNjo5J4JJ0hC9hfHpqZTCTaqS4mm5oP/CfuIZlXVnJe9Ydh9ufK4JAMrB
Subject: Re: Regression caused by new multiconfig dependency
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
X-List-Received-Date: Wed, 21 Nov 2018 08:30:32 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 20.11.18 19:23, Alejandro Enedino Hernandez Samaniego wrote:
> Hey Jan,
> 
> I literally just sent out a patch to fix this issue, it should work fine after 
> that is applied.
> 

Thanks a lot, your patch [1] is working fine for us as well.

Jan

[1] 
https://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=aehs29/multiconfig_provides&id=c075cac18c32f4b178fc4f62b4326118b43dc99f

> 
> Cheers,
> 
> Alejandro
> 
> 
> On 11/20/2018 12:48 AM, Jan Kiszka wrote:
>> On 18.11.18 10:59, Jan Kiszka wrote:
>>> Hi all,
>>>
>>> since da8cb8633504 ("bitbake: Add support for multiconfig dependencies"), it's
>>> no longer possible to write recipes that have multiconfig-dependent names:
>>>
>>>
>>> mc1.conf:
>>> MACHINE = "a"
>>>
>>> mc2.conf:
>>> MACHINE = "b"
>>>
>>> some-target.bb:
>>> PN = "some-target-${MACHINE}"
>>>
>>> local.conf:
>>> BBMULTICONFIG = "mc1 mc2"
>>>
>>>
>>> # bitbake multiconfig:mc1:some-target-a
>>> [...]
>>> ERROR: Nothing PROVIDES 'some-target-a'. Close matches:
>>>     some-target-b
>>>
>>> # bitbake multiconfig:mc2:some-target-b
>>> ERROR: Nothing PROVIDES 'some-target-b'. Close matches:
>>>     some-target-a
>>>
>>>
>>> That works fine when going back to da8cb8633504^ or when only having the
>>> selected multiconfig in BBMULTICONFIG. Seems the parser stumbles while
>>> processing the unselected multiconfig paths.
>>>
>>> Jan
>> Including also the author of that commit.
>>
>> I'm not really understanding the internals of bitbake yet, I just started to 
>> track down the issue to a code change:
>>
>> def buildTaskData(...):
>>      ...
>>              if mc:
>>                  # Provider might be from another mc
>>                  for mcavailable in self.multiconfigs:
>>                      # The first element is empty
>>                      if mcavailable:
>>                          
>> taskdata[mcavailable].add_provider(localdata[mcavailable], 
>> self.recipecaches[mcavailable], k)
>>
>> If we do multiconfig:mc1:some-target-a, add_provider() still works fine for 
>> mcavailable = "mc1", but it fails with the error above for "mc2", apparently 
>> because "some-target-a" cannot be resolved in mc2. Any idea how that can be 
>> avoided? I don't get why we should check for the build target when adding the 
>> mc with all its targets as providers.
>>
>> Thanks,
>> Jan
> 


