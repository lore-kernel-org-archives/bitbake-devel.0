Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5A85E606D1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 09:25:07 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 19 Jul 2016 02:25:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,388,1464678000"; d="scan'208";a="736532467"
Received: from ssuppiah-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.140.160])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2016 02:25:06 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Date: Tue, 19 Jul 2016 21:25:03 +1200
Message-ID: <12775485.NNVrWsqQxr@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.5.7-202.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <4025671C58A6E340B47F5CA342BC783A42BF96F4@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <4025671C58A6E340B47F5CA342BC783A42BF96F4@XAP-PVEXMBX02.xlnx.xilinx.com>
MIME-Version: 1.0
Cc: Manjukumar Harthikote Matha <MANJUKUM@xilinx.com>,
	Vineeth Karumanchi <VINEETHC@xilinx.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: recipetool issue with empty bbappends
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
X-List-Received-Date: Tue, 19 Jul 2016 09:25:08 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi there,

On Tue, 19 Jul 2016 07:33:00 Sai Pavan Boddu wrote:
> I see an issue, working with recipetool, which  basically gives error when I
> point out an empty bbappend file generated form recipetool itself. Below
> are the steps
> recipetool newappend meta-saip/ linux-xlnx
> recipetool setvar -r meta-saip/recipes-kernel/linux/linux-xlnx_4.4.bbappend
> XSCTH_PROC "arm" Traceback (most recent call last):
>   File "<path>/yocto/scripts/recipetool", line 116, in <module>
>     ret = main()
>   File "<path>/yocto/scripts/recipetool", line 107, in main
>     ret = args.func(args)
>   File "<path>/components/yocto/scripts/lib/recipetool/setvar.py", line 52,
> in setvar patches = [oe.recipeutils.patch_recipe_file(args.recipefile,
> varvalues, patch=args.patch)] File
> "<path>/yocto/meta/lib/oe/recipeutils.py", line 258, in patch_recipe_file
> if tolines[-1].strip() != '':
> IndexError: list index out of range
> 
> But I don't see the error if, bbappend file has atlease one line

I've just reproduced this and have filed the following bug for the issue:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=9972

BTW in future for issues with recipetool / devtool could you please use the 
openembedded-core@lists.openembedded.org (or yocto@yoctoproject.org if you 
prefer) since recipetool isn't part of BitBake.

Thanks,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

