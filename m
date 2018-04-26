Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 06ADA60107
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Apr 2018 06:58:05 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w3Q6w2aJ006507
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 25 Apr 2018 23:58:02 -0700 (PDT)
Received: from [128.224.16.138] (128.224.16.138) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.361.1;
	Wed, 25 Apr 2018 23:58:01 -0700
To: Mauro Ziliani <mauro@faresoftware.it>,
	<bitbake-devel@lists.openembedded.org>
References: <490261f1-ed2d-286c-a75d-6798008cef2c@faresoftware.it>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <447bb621-fe80-b89c-53ec-d366fda05375@windriver.com>
Date: Thu, 26 Apr 2018 14:57:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <490261f1-ed2d-286c-a75d-6798008cef2c@faresoftware.it>
Subject: Re: PREFERRED_VERSION_db-native doesn't work?
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
X-List-Received-Date: Thu, 26 Apr 2018 06:58:06 -0000
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit


Hi,

On 04/20/2018 05:42 PM, Mauro Ziliani wrote:
> Hi all
> 
> I'm Mauro from Parma, Italy.
> 
> I hope this is not OT from this mailing-list.
> 
> 
> I'm working with Krogoth 15.0.3.
> 
> When I bitbake core-image-minimal bitbake fails compiling db-native recipe 
> because it can't apply a patch
> 
> This is the error.
> 
> ERROR: db-native-6.0.30-r0 do_patch: Command Error: 'quilt --quiltrc 
> /media/mauro/Sviluppo/CatellaniGroup/ibr115/bsp/clini5-build/tmp/sysroots/x86_64-linux/etc/quiltrc 
> push' exited with 1  Output:
> Applying patch fix-parallel-build.patch
> patching file Makefile.in
> Hunk #1 FAILED at 1034.
> 1 out of 1 hunk FAILED -- rejects in file Makefile.in
> Patch fix-parallel-build.patch can be reverse-applied
> 
> So I try to compile against db-native_5.3.28 setting PREFERRED_VERSION_db-native 
> = "5.%" in my conf/local.conf.

Maybe it is because of:

meta/conf/distro/include/default-versions.inc:PREFERRED_VERSION_db-native = 
"${@incompatible_license_contains('AGPL-3.0', '5.%', '6.%', d)}"

Try:
PREFERRED_VERSION_db-native_forcevariable = "5.%"

// Robert

> 
> 
> But bitbake keep on running db-native_6.0.30-r0 recipe.
> 
> 
> Why?
> 
> 
> Best regards,
> 
>     Mauro
> 

