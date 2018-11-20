Return-Path: <jan.kiszka@web.de>
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by mail.openembedded.org (Postfix) with ESMTP id EC6836C42D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Nov 2018 08:48:55 +0000 (UTC)
Received: from [167.87.9.10] ([95.157.57.47]) by smtp.web.de (mrweb003
	[213.165.67.108]) with ESMTPSA (Nemesis) id 0Ma2V5-1g9pPf3uhT-00Lj0M;
	Tue, 20 Nov 2018 09:48:53 +0100
From: Jan Kiszka <jan.kiszka@web.de>
To: bitbake-devel@lists.openembedded.org, Alejandro Enedino Hernandez Samaniego
	<alejandro.enedino.hernandez-samaniego@xilinx.com>
References: <dcf35fbf-e76a-4e93-c0c7-19cc26ecfe2c@web.de>
Message-ID: <7cba6091-29e0-f476-65f1-eb6c941bd268@web.de>
Date: Tue, 20 Nov 2018 09:48:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
	Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <dcf35fbf-e76a-4e93-c0c7-19cc26ecfe2c@web.de>
X-Provags-ID: V03:K1:IBGpsfW92SdXmTL7cEMAmKXV5RLb/KUVFP1qHb/v5k/W+3puHbp
	xT+0E/FsvzdTTr1SrDfFejtGFMwf8hrpANkkutW6hc+NQckR7XCM3MN1p2F56hmwI3cslDl
	P24+M97MTFyg8vD8UcIlNiDq2XZD6KOKet6u5F5poVqXtTsO1KB9Mmk+h/7i57OY4uCWXht
	sEAI0Ggu6JsIZp09z+oHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V01:K0:0m3/Rr2J6WA=:uo1kARPKqZ8uGHjU9Bhn24
	WUkYJwqYJVTYP/tsRHmH4RLMYOcLawaGQfGrwc1rb/UoUcaAsdW0tDZwRToNvAFv9D2q25AEs
	ScDHUtA73S8CZVJId11CqQuR/NI8Ww/ggyl60M0eF97lzES3JhRB3HpExWD5wAvWAH5qKNRti
	ztzCPvA6zplL9p8j+AzZCCN5aW7aPXuLI1UsHKVe/OTA0vvnsS4qd8VTLCAboYLLBAqLPee4J
	xIN13yXNN4KCSt6Ery8jD6VKoWqrWR1h0YMjKn3s1PqEN55XjoGirde3eolthX0w6yAYo0N+l
	/+BHh6+mjNFK75yqVOF5vyuKHboQYYGRAimtl6f3o+J9l5JSl+igoi2TSvR6eieex47TBFAm7
	Szv+EJCUYCj5T/ShzbzJb3vEasM1SppWLsxO79L2ZE1j5e9GwZLJcV4LR8qo+KSILTZGsMYJG
	EuU9+eDIhahkTd66YKcWbprOjxyDHTGkx7hWOH1gKILcj6O77BtONpY6MiUVZVwzFJIhS2uND
	yqrXl4i0XiTfpuKNLJjB4RIyfbYoIf0lpSafRPXaOVq56Ugc5KI3fQdySeH/4jxPfFbwkxcRv
	2GvBLk6o5nUGDDxIfaDP0h3Ejd7uJ6EYsgYmR8XZtxa16dhC0cpwEQZiLHif0hSGzzRb2RZ5t
	a/xySCf3nKCVXOGQ5P0cWoOVHx74FA9WcyiZgwFEIR2qxQ14OKcOo6Pnn/6nPCo+5zRm6p3Xv
	mslbhFmRTOLxie+z7MV7UyGQwicZLUqcyaTUwHpUFBRiJKfN6w0LdMZxjix+FUI3r73ZkM6XQ
	fAyicoBJkhlE61gwwoIPyACapdMj4/o8tPh1JsoGWuzVkUHcZaxhCe4/kEKffyex2x4FWDnuG
	66tz46DR6bcZ9iUYZYR92pD/7Pd3iR1sivhoHlOtJFvbTlihO4u/SZUtTMkJ/n
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
X-List-Received-Date: Tue, 20 Nov 2018 08:48:56 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 18.11.18 10:59, Jan Kiszka wrote:
> Hi all,
> 
> since da8cb8633504 ("bitbake: Add support for multiconfig dependencies"), it's 
> no longer possible to write recipes that have multiconfig-dependent names:
> 
> 
> mc1.conf:
> MACHINE = "a"
> 
> mc2.conf:
> MACHINE = "b"
> 
> some-target.bb:
> PN = "some-target-${MACHINE}"
> 
> local.conf:
> BBMULTICONFIG = "mc1 mc2"
> 
> 
> # bitbake multiconfig:mc1:some-target-a
> [...]
> ERROR: Nothing PROVIDES 'some-target-a'. Close matches:
>    some-target-b
> 
> # bitbake multiconfig:mc2:some-target-b
> ERROR: Nothing PROVIDES 'some-target-b'. Close matches:
>    some-target-a
> 
> 
> That works fine when going back to da8cb8633504^ or when only having the 
> selected multiconfig in BBMULTICONFIG. Seems the parser stumbles while 
> processing the unselected multiconfig paths.
> 
> Jan

Including also the author of that commit.

I'm not really understanding the internals of bitbake yet, I just started to track down the issue to a code change:

def buildTaskData(...):
    ...
            if mc:
                # Provider might be from another mc
                for mcavailable in self.multiconfigs:
                    # The first element is empty
                    if mcavailable:
                        taskdata[mcavailable].add_provider(localdata[mcavailable], self.recipecaches[mcavailable], k)

If we do multiconfig:mc1:some-target-a, add_provider() still works fine for mcavailable = "mc1", but it fails with the error above for "mc2", apparently because "some-target-a" cannot be resolved in mc2. Any idea how that can be avoided? I don't get why we should check for the build target when adding the mc with all its targets as providers.

Thanks,
Jan

