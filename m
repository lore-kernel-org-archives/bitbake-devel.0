Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>)
	id 1QwdL1-0000xq-Ll; Thu, 25 Aug 2011 19:03:32 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 25 Aug 2011 09:58:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,281,1312182000"; d="scan'208";a="11052283"
Received: from unknown (HELO helios.localnet) ([10.255.18.129])
	by AZSMGA002.ch.intel.com with ESMTP; 25 Aug 2011 09:58:24 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Khem Raj <raj.khem@gmail.com>
Date: Thu, 25 Aug 2011 17:58:23 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic-pae; KDE/4.6.2; i686; ; )
References: <201108021226.34560.paul.eggleton@linux.intel.com>
	<201108251150.01236.paul.eggleton@linux.intel.com>
	<CAMKF1spSE=nuQ1LGOmub3XaH-z+6oJT+n5hC7LdKvdKeScLWNw@mail.gmail.com>
In-Reply-To: <CAMKF1spSE=nuQ1LGOmub3XaH-z+6oJT+n5hC7LdKvdKeScLWNw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201108251758.23451.paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Layer priorities influencing default version selection
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
X-List-Received-Date: Thu, 25 Aug 2011 17:03:32 -0000
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thursday 25 August 2011 16:56:28 you wrote:
> with layers we dont control policies of all the layers that may be used on
> top so fixing meta-oe does not solve problem completely and we can not ask
> for exclusive  recipes. People would want to override the recipes from other
> layers.

Generally, the less duplication we have across layers the better; if a 
maintainer is duplicating a recipe they should have a very good reason to do 
so. We can avoid some of this duplication by making it easier to figure out 
where the right place for recipes is and doing everything we can encourage 
people to get stuff merged there. I'm not convinced we are doing very well on 
either count yet, but I expect this will improve over time.

> bitbake could report the layer the recipe comes from which can make it
> evident or may be special command to inform the layer priorities. This will
> guide the users to diagnose the problems quickly and help developers to
> identify the issues faster. There could be a complete bill of recipes
> printed for a given target as well so if someone wants to check all
> the recipes that were built.

I had not considered BitBake itself reporting these, that might be useful 
especially in the case of errors (although the full path to the recipe is 
already reported during the build, so you should be able to tell in most cases 
from that if you need to). Outputting a specific report of parsed recipes and 
bbappends as part of the build also might be useful.

FYI, bitbake-layers exists as a separate utility to answer a lot of these 
kinds of questions, and recently has become a lot more powerful - I would 
strongly recommend everyone check it out and if it's not able to report what 
you want then please tell me and I'll try to make it do so. I already have a 
few ideas for future improvements there which I will hopefully get time to 
look into in the Yocto 1.2 cycle.

> In any case I agree that problems should be fixed. However this does
> not scale to all layers and we can not police all the layers and we should
> not. We should try to make it possible for people to glue layers together
> without  issues.

How does merely being able to alter the priorities help here though? I could 
begin to understand if you were asking for some way to blacklist individual 
recipes in individual layers, but moving the priority of an entire layer is 
likely to have much more of an effect than just obscuring a few errant recipes 
that you don't want.

We can't "police" all the layers, no. But if those who maintain that layer 
can't respond to and resolve problems then they shouldn't be maintainers or 
those layers can't be considered well-maintained. When you add a layer to your 
build you are placing some trust in the maintainer of that layer; it is up to 
the maintainer to make sure they don't abuse that trust.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


