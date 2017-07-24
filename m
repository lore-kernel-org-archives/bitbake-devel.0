Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 9158578296
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 15:04:17 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Jul 2017 08:04:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,407,1496127600"; d="scan'208";a="130458262"
Received: from lsandov1-mobl2.zpn.intel.com ([10.219.128.119])
	by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2017 08:04:18 -0700
Message-ID: <1500909168.2230.21.camel@linux.intel.com>
From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Mon, 24 Jul 2017 10:12:48 -0500
In-Reply-To: <15159983.UbMySVM7WB@peggleto-mobl.ger.corp.intel.com>
References: <20170619150018.22287-1-leonardo.sandoval.gonzalez@linux.intel.com>
	<15159983.UbMySVM7WB@peggleto-mobl.ger.corp.intel.com>
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: Chris Larson <chris_larson@mentor.com>, Brian Avery <brian.avery@intel.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] action: bitbake-layers new plugin to create a layer
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
X-List-Received-Date: Mon, 24 Jul 2017 15:04:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2017-07-20 at 17:58 +0200, Paul Eggleton wrote:
> (Brian reminded me of this, sorry for not replying earlier)
> 
> On Monday, 19 June 2017 5:00:18 PM CEST 
> leonardo.sandoval.gonzalez@linux.intel.com wrote:
> > From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
> > 
> > Creates a simple layer with a example recipe, where the latter
> > has just a single task (do_build). Layer's license is MIT and
> > layer's priority defaults to 6. Recipe name and layer's priority
> > can changed specified through the command line.
> 
> So I'm generally in favour of adding this functionality to bitbake-layers and 
> making it more widely available in preference to yocto-layer. However, I'm a 
> bit concerned about the template recipe - it really doesn't belong in bitbake. 
> We could resolve that in one of two ways:
> 
> 1) Look for the template within the metadata and provide one in OE-Core, or
> 
> 2) Put the template *and* the plugin in OE-Core, since bitbake-layers should 
> support loading plugins from the metadata
> 

When I started this, I did not think about using OE-Core so this can be
more generic, meaning that there is no need for OE-Core metadata to have
this feature working. 

Now with your inputs, I can see point 2 as an option so let I can work
in that direction if all agree.

Leo


> I don't mind which but I'd lean towards #2 since it will probably require less 
> additional plumbing.
> 
> Additionally we'll probably want to change "yocto-layer create" to call this 
> and show a deprecation warning for the next release or two, and then drop it 
> afterwards.
> 
> Cheers,
> Paul
> 



