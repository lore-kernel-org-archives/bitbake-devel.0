Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 483466041D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2013 15:05:52 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 26 Jul 2013 08:05:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,752,1367996400"; d="scan'208";a="376613228"
Received: from unknown (HELO helios.localnet) ([10.252.122.182])
	by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2013 08:05:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Voicu, Cristiana" <cristiana.voicu@intel.com>
Date: Fri, 26 Jul 2013 16:05:46 +0100
Message-ID: <8489419.sH39sV5aTi@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-26-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7F428A@IRSMSX105.ger.corp.intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
	<1972381.8tId4Nj9gB@helios>
	<BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7F428A@IRSMSX105.ger.corp.intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH_V2 13/16] bitbake: save packages in IMAGE_INSTALL instead of PACKAGE_INSTALL
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 26 Jul 2013 15:05:53 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 July 2013 14:48:24 Voicu, Cristiana wrote:
> There is for sure a previous value, because all the recipes saved this way
> require an image from the layers. Regarding the "append" suffix, I've found
> in the documentation that : When you use this variable, it is best to use
> it as follows:
> 
>      IMAGE_INSTALL_append = " package-name"

That's more about using it in local.conf than individual image recipes.

I had forgotten that we were "require"ing an existing recipe here and missed 
it in the code. However isn't there then a problem if you use _append and the 
user wants to remove something added by the original image using Hob? Won't 
the removed package just be forced back in by virtue of appending to the 
original value of IMAGE_INSTALL?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

