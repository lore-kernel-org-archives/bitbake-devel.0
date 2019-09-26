Return-Path: <mark.hatle@kernel.crashing.org>
X-Greylist: delayed 1087 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 26 Sep 2019 23:22:58 UTC
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 6B4A27F276
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 23:22:58 +0000 (UTC)
Received: from Marks-MacBook-Pro.local ([76.164.61.198]) (authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id x8QN4aEO030553
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Thu, 26 Sep 2019 18:04:37 -0500
To: "Jeremy A. Puhlman" <jpuhlman@mvista.com>,
	bitbake-devel@lists.openembedded.org, grzegorz.heldt@gmail.com
References: <CAK5ws+EfD=A3ROQmZe9A0Enb-83NcrW_9er2BB7-e9N1H=xmEQ@mail.gmail.com>
	<d6a33b15-e28a-b2b8-3359-8c4b38afe5eb@mvista.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <9022a7bc-7f91-dddb-5bfc-530b42a2d1bf@kernel.crashing.org>
Date: Thu, 26 Sep 2019 18:04:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d6a33b15-e28a-b2b8-3359-8c4b38afe5eb@mvista.com>
Subject: Re: bitbake-layers add-layer issue
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
X-List-Received-Date: Thu, 26 Sep 2019 23:23:01 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 9/26/19 4:00 PM, Jeremy A. Puhlman wrote:
> 
> 
> On 9/25/2019 1:38 PM, Grzegorz Heldt wrote:
>> Hello.
>>
>> To setup my projects im usually using bash scripts like that performs
>> following steps:
>>
>> -------------------------------
>> wiesniak@desk:~/projects/yocto-rasp/poky/build/conf$ cat ../../../setup
>> #!/bin/bash
>>
>> BRANCH=warrior
>> git clone git://git.yoctoproject.org/meta-raspberrypi
>> <http://git.yoctoproject.org/meta-raspberrypi> -b $BRANCH
>> git clone git://git.yoctoproject.org/poky <http://git.yoctoproject.org/poky>
>> -b $BRANCH
>> git clone git://git.openembedded.org/meta-openembedded
>> <http://git.openembedded.org/meta-openembedded> -b $BRANCH
>>
>> cd poky
>> . oe-init-build-env
>> bitbake-layers add-layer ../../meta-raspberrypi/
>> bitbake-layers add-layer ../../meta-openembedded/meta-python/
>> bitbake-layers add-layer ../../meta-openembedded/meta-oe/
>> bitbake-layers add-layer ../../meta-openembedded/meta-multimedia/
>> bitbake-layers add-layer ../../meta-openembedded/meta-networking/
>>
>> echo INHERIT += \"rm_work\" >> conf/local.conf
>> echo DL_DIR = \"/home/yocto-downloads\" >> conf/local.conf
>>
> You need to add meta-oe before meta-python since meta-python depends on it. Once
> meta-python is added bitbake the next add
> fail because it cannot satisfy the meta-oe requirement. The error is not really
> helpful.
> 
> This is what you get on thud.
> 
> [cluge@jptest01 build]$ bitbake-layers add-layer ../meta-openembedded/meta-python/
> NOTE: Starting bitbake server...
> [cluge@jptest01 build]$ bitbake-layers add-layer ../meta-openembedded/meta-oe/
> NOTE: Starting bitbake server...

Ya, the dredded circular dependency.  I thought you could add them both at the
same time to resolve this.  (You can via the layer index mechanism at least..)
I believe the circular dependency has been resolved in master.)

--Mark

> Traceback (most recent call last):
>   File
> "/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/bin/bitbake-layers",
> line 103, in <module>
>     ret = main()
>   File
> "/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/bin/bitbake-layers",
> line 71, in main
>     tinfoil.prepare(True)
>   File
> "/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/tinfoil.py",
> line 418, in prepare
>     self.run_command('parseConfiguration')
>   File
> "/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/tinfoil.py",
> line 476, in run_command
>     raise TinfoilCommandFailed(result[1])
> bb.tinfoil.TinfoilCommandFailed: Traceback (most recent call last):
>   File
> "/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/command.py",
> line 84, in runCommand
>     result = command_method(self, commandline)
>   File
> "/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/command.py",
> line 285, in parseConfiguration
>     command.cooker.parseConfiguration()
>   File
> "/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/cooker.py",
> line 438, in parseConfiguration
>     self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS"))
>   File
> "/local/cluge/builds/2.6/x86-generic-64-4.19-2.6-cgx/layers/poky/bitbake/lib/bb/cooker.py",
> line 1232, in handleCollections
>     raise CollectionError("Errors during parsing layer configuration")
> bb.cooker.CollectionError: Errors during parsing layer configuration
>>
>>
>> <http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=emailclient>
>> 	Virus-free. www.avg.com
>> <http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=emailclient>
>>
>>
>> <#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2>
>>
> 
> -- 
> Jeremy A. Puhlman
> jpuhlman@mvista.com
> 
> 

