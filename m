Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C28B5757B9;
	Tue,  2 Jun 2015 04:38:18 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t524cHdb012605
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 1 Jun 2015 21:38:17 -0700 (PDT)
Received: from [128.224.162.200] (128.224.162.200) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.224.2;
	Mon, 1 Jun 2015 21:38:16 -0700
Message-ID: <556D3337.7020905@windriver.com>
Date: Tue, 2 Jun 2015 12:38:15 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Ash Charles <ashcharles@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	<danismostlikely@gmail.com>
References: <20150427105100.GB2379@jama>
	<1432309170-5575-1-git-send-email-ashcharles@gmail.com>
	<5567C5B1.7010901@windriver.com>
	<CAK8F28mc2C=r4n42xFmNaxNveectuB8esrkt4M2BkSknH-mFxw@mail.gmail.com>
	<CA+chaQe_T9zPjckAm+NZrZpdw5BO81eL-vxrAA-2kYymMRbd1w@mail.gmail.com>
	<CAK8F28=cu6z2m3hNGkO-qkzDhyfuZwPG-Q-n+2rY95NvmwuStg@mail.gmail.com>
In-Reply-To: <CAK8F28=cu6z2m3hNGkO-qkzDhyfuZwPG-Q-n+2rY95NvmwuStg@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-devel <openembedded-devel@lists.openembedded.org>
Subject: Re: [oe] [PATCH] fetch/hg: Disable checksums for archived downloads
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
X-List-Received-Date: Tue, 02 Jun 2015 04:38:20 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 06/02/2015 08:08 AM, Ash Charles wrote:
> Hi,
>
> I verified that the "fetch/hg: support submodules" [1] patch, in
> combination with this [2] patch is causing do_unpack failures for me.
> Based on the logs from the world build, I suspect this is also
> breaking dvb-apps.  I don't have a fix so perhaps the best plan is
> reverting [2] now that cleanall for hg packages actually works.
>
> [1] http://lists.openembedded.org/pipermail/bitbake-devel/2015-May/005725.html
> [2] http://lists.openembedded.org/pipermail/bitbake-devel/2015-May/005758.html
>

I'm working on fixing the issues now, will send patches sooner.

// Robert

> --Ash
>
> On Fri, May 29, 2015 at 2:18 AM, Martin Jansa <martin.jansa@gmail.com> wrote:
>> FWIW: I see vim unpack failing now in world builds:
>>
>> NOTE: recipe vim-7.4.481-r0: task do_unpack: Started
>> ERROR: Function failed: Fetcher failure: Fetch command failed with exit code
>> 255, output:
>> abort: repository
>> /home/jenkins/oe/world/shr-core/downloads/hg/vim.googlecode.com/hg/vim not
>> found!
>>
>> ERROR: Logfile of failure stored in:
>> /home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/vim/7.4.481-r0/temp/log.do_unpack.28505
>> Log data follows:
>> | DEBUG: Executing python function do_unpack
>> | DEBUG: Executing python function base_do_unpack
>> | DEBUG: Unpack: creating new hg repository in
>> '/home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/vim/7.4.481-r0/vim'
>> | DEBUG: Running export
>> PATH="/home/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/usr/bin/arm-oe-linux-gnueabi:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/qemuarm/usr/bin/crossscripts:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/usr/sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/usr/bin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/bin:/home/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/jenkins/oe/world/shr-core/bitbake/bin:/home/jenkins/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games";
>> export HOME="/home/jenkins"; /usr/bin/env hg init
>> /home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/vim/7.4.481-r0/vim
>> | DEBUG: Unpack: updating source in
>> '/home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/vim/7.4.481-r0/vim'
>> | DEBUG: Running export
>> PATH="/home/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/usr/bin/arm-oe-linux-gnueabi:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/qemuarm/usr/bin/crossscripts:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/usr/sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/usr/bin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/bin:/home/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/jenkins/oe/world/shr-core/bitbake/bin:/home/jenkins/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games";
>> export HOME="/home/jenkins"; /usr/bin/env hg pull
>> /home/jenkins/oe/world/shr-core/downloads/hg/vim.googlecode.com/hg/vim
>> | DEBUG: Python function base_do_unpack finished
>> | DEBUG: Python function do_unpack finished
>> | ERROR: Function failed: Fetcher failure: Fetch command failed with exit
>> code 255, output:
>> | abort: repository
>> /home/jenkins/oe/world/shr-core/downloads/hg/vim.googlecode.com/hg/vim not
>> found!
>> |
>> NOTE: recipe vim-7.4.481-r0: task do_unpack: Failed
>> ERROR: Task 5789
>> (/home/jenkins/oe/world/shr-core/meta-openembedded/meta-oe/recipes-support/vim/vim_7.4.481.bb,
>> do_unpack) failed with exit code '1'
>>
>>
>>
>> On Fri, May 29, 2015 at 7:46 AM, Ash Charles <ashcharles@gmail.com> wrote:
>>>
>>>> I wonder how did you test the patch, please ? Did you revert the patch:
>>>>   fetch/hg: support submodules ?
>>> Hi Robert,
>>> I tested the patch in a Yocto environment which had a prepopulated
>>> downloads directory. In particular, I had seen the failure described [1] for
>>> vim.
>>> My version of bitbake was slightly older so the submodule patch that was
>>> breaking the mirroring hadn't yet been applied.
>>>
>>> [1]
>>> https://www.mail-archive.com/openembedded-devel@lists.openembedded.org/msg41328.html
>>>
>>> --Ash
>>>
>>>
>>> --
>>> _______________________________________________
>>> bitbake-devel mailing list
>>> bitbake-devel@lists.openembedded.org
>>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>>
>>
>
>

