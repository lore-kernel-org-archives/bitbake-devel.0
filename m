Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id EAA2B6041D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2013 15:02:06 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 26 Jul 2013 08:01:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,752,1367996400"; d="scan'208";a="273762595"
Received: from unknown (HELO helios.localnet) ([10.252.122.182])
	by AZSMGA002.ch.intel.com with ESMTP; 26 Jul 2013 08:01:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Voicu, Cristiana" <cristiana.voicu@intel.com>
Date: Fri, 26 Jul 2013 16:01:45 +0100
Message-ID: <7556809.18sYmxpky4@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-26-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7F4270@IRSMSX105.ger.corp.intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
	<49104416.fdFscICMXV@helios>
	<BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7F4270@IRSMSX105.ger.corp.intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH_V2 06/16] hob & bitbake: append a value to a variable from hob throught bitbake
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
X-List-Received-Date: Fri, 26 Jul 2013 15:02:07 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 July 2013 14:35:38 Voicu, Cristiana wrote:
> > 1) We should not be expanding ${TOPDIR} using direct string replacement.
> > Do we even need to do this?
> 
> > 2) In any case it appears to be using a hardcoded value instead of val
> > when it calls append_var_in_file()
> 
> I have implemented this way because Hob receives BB_FILES already expanded,
> when it uses getVariable() method.

OK, but if you're going to expand the value you should use bitbake's own means 
of expanding it rather than trying to do so yourself.

> Also I chose to save it hardcoded (using TOPDIR), to be more general in
> local.conf (in case the local.conf is moved)

I agree you'd want ${TOPDIR} unexpanded in the value set in local.conf. 
However, if you pass in a path to the function (which in this case includes 
the ${TOPDIR} reference) surely that's the value you'd save into local.conf 
and not an additional hardcoded value?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

