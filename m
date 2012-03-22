Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAWVU-0007Yc-QF
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 02:08:01 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 17:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="142880203"
Received: from unknown (HELO [10.255.15.222]) ([10.255.15.222])
	by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2012 17:59:02 -0700
Message-ID: <4F6A7956.1040400@linux.intel.com>
Date: Wed, 21 Mar 2012 17:59:02 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 00/17][PULL] Hob: Bunch of bug fixes
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
X-List-Received-Date: Thu, 22 Mar 2012 01:08:01 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/03/12 05:55, Dongxiao Xu wrote:
> Hi Richard,
>
> This pull request is Hob related bug fixes. Please help to review and pull.
>
> Thanks,
> Dongxiao
>
> The following changes since commit d595960fea0988df9004d927bc2ec3439540dd9c:
>
>    Hob: save CONF_VERSION and LCONF_VERSION into template (2012-03-20 14:39:45 +0000)
>
> are available in the git repository at:
>    git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
>    http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix
>
> Dongxiao Xu (14):
>    Hob: Still use initcmd != None as the if judgement
>    Hob: Remove split model in GTK Hob
>    cooker: terminate each process when quitting recipe parsing
>    Hob: change package classes selection GUI
>    Hob: Change template button name from "Template" to "Templates"

These all look fine.

>    command.py: Change parseConfigurationFiles API from async to sync
>    process.py: Increase the timeout value for polling commands
>    Hob: Change parseConfigurationFiles API usage

Can you explain some of the reasoning behind this set of changes? If the 
command truly belongs as an asynchronous one I'm not sure why we need to 
increase the timeout duration specifically for it.

>    Hob: Fix the workaround to get image types
>    Hob: Change recipe selection tab order
>    Hob: Change package selection tab order
>    Hob: Move "Create your own image" to the bottom of image list
>    cooker: add inherit information when generating package tree
>    Hob: Use inherit information to judge if a recipe is image type
>
> Shane Wang (3):
>    Hob: Change window title from HOB to Hob
>    Hob: Change "View Packages" description
>    Hob: Change the titles for recipe view and package view

These also look OK to me.

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


