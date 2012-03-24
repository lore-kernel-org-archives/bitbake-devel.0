Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SBFEr-0001ek-0Q
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:53:49 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 Mar 2012 17:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124491547"
Received: from unknown (HELO [10.255.12.82]) ([10.255.12.82])
	by orsmga002.jf.intel.com with ESMTP; 23 Mar 2012 17:44:51 -0700
Message-ID: <4F6D1902.8070601@linux.intel.com>
Date: Fri, 23 Mar 2012 17:44:50 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
	<0873c2b5ad4810eb019ec860760b46c917dc6d68.1332545580.git.josh@linux.intel.com>
	<1332549139.1849.12.camel@dongxiao-osel>
In-Reply-To: <1332549139.1849.12.camel@dongxiao-osel>
Cc: bitbake-devel@lists.openembedded.org, Giulia Piu <giulia@closertag.com>
Subject: Re: [PATCH 3/9] lib/bb/ui/crumbs/recipeselectionpage: add 'Build image' button per design
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
X-List-Received-Date: Sat, 24 Mar 2012 00:53:49 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/03/12 17:32, Xu, Dongxiao wrote:
> On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
>> The design calls for the 'Build packages' button to be a secondary action
>> and a 'Build image' primary action to exist on the recipe selection page.
>
> Sorry, I think this design doesn't make sense.
>
> Thinking of this scenario, if a user clicks "Create your own image" in
> base image drop down list, and then clicks "View Recipes" to select some
> recipes, if we allow user to directly click "Build image" here, it is
> wrong since nothing has been set to PACKAGE_INSTALL variable and the
> image build will fail.
>
> Also it will confuse user that, they would think what they selected in
> the recipe page will be packed into the final image, however it isn't.
> Therefore I suggest removing the "build image" button in recipe
> selection page.

Hmm, I missed that but sounds like it doesn't make sense to include this 
patch as is.

I guess we need to either:
a) Change the 'Build packages' button to be the primary action. A simple 
change to ensure a consistent GUI.
b) Figure out some logic for mapping the selected recipes to packages in 
the case of the user clicking the 'Build image' button.

I would imagine a) makes most sense for the 1.2 timeframe?

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


