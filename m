Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1TViKt-0004t2-HA
	for bitbake-devel@lists.openembedded.org;
	Tue, 06 Nov 2012 13:32:55 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id qA6CJ8He021323
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 6 Nov 2012 04:19:08 -0800 (PST)
Received: from [128.224.163.142] (128.224.163.142) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Tue, 6 Nov 2012 04:19:08 -0800
Message-ID: <5099003A.9030303@windriver.com>
Date: Tue, 6 Nov 2012 20:19:06 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:16.0) Gecko/20121011 Thunderbird/16.0.1
MIME-Version: 1.0
To: Greg Perry <gregperry999@gmail.com>
References: <CA+ZhUHnqOTdCtXMC-y_QtdmH+Gkse80XjDgQnPqUStuBvS2A2g@mail.gmail.com>
In-Reply-To: <CA+ZhUHnqOTdCtXMC-y_QtdmH+Gkse80XjDgQnPqUStuBvS2A2g@mail.gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Using bitbake with older kernel revisions
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 06 Nov 2012 12:32:55 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit



On 11/06/2012 08:38 AM, Greg Perry wrote:
> Hello,
>
> Hopefully this is the right mailing list to ask this question, if not I
> apologize in advance and ask that you send me to the appropriate mailing
> list.
>

Hi Greg,

The right mailing list should be openembedded-core@lists.openembedded.org .


> I have a BeagleBone cross compile setup (ARM-based board), and I've
> successfully used the OE/bitbake process described at OpenEmbedded.org to
> setup of a cross compile toolchain, download source, and build an entire
> system plus software from scratch.
>
> However, the kernel revision used is several versions ahead of the patch
> branch that I want to integrate (3.2.28), as I want to integrate the
> Xenomai RTOS extensions which require kernel version 3.2.21.
>

You can set the PREFERRED_VERSION if there is already a recipe, for example,
there are the fllowing kernel recipes on the oe-core's master branch:

recipes-kernel/linux/linux-yocto_3.0.bb
recipes-kernel/linux/linux-yocto_3.2.bb
recipes-kernel/linux/linux-yocto_3.4.bb

You can look into the recipe and check the variable LINUX_VERSION for the
accurate kernel version, unfortunately, I didn't find the version (3.2.21)
which you need, the most near one is recipes-kernel/linux/linux-yocto_3.2.bb
which is 3.2.18, if this one works (just a suppose), you can set it as:

PREFERRED_VERSION_linux-yocto = "3.2"

in the .conf file, then bitbake will build linux-yocto_3.2.bb, rather than
linux-yocto_3.4.bb or linux-yocto_3.0.bb.

The setting is similar if you a 3.2.21 recipe.

// Robert

> Is it possible with OE/bitbake to specify an older kernel revision with
> accompanying system to build an older kernel and Angstrom distribution?
>   Ideally I would like to regress back to the 3.2.21 kernel release and do a
> full build of that Angstrom distribution after applying the Xenomai patches
> to the 3.2.21 kernel.
>
> Thanks in advance for your help
>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>


