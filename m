Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 717157831C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jul 2017 15:58:51 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 Jul 2017 08:58:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,384,1496127600"; d="scan'208";a="1174788120"
Received: from rpieper-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.39.83])
	by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2017 08:58:45 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: leonardo.sandoval.gonzalez@linux.intel.com
Date: Thu, 20 Jul 2017 17:58:43 +0200
Message-ID: <15159983.UbMySVM7WB@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <20170619150018.22287-1-leonardo.sandoval.gonzalez@linux.intel.com>
References: <20170619150018.22287-1-leonardo.sandoval.gonzalez@linux.intel.com>
MIME-Version: 1.0
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
X-List-Received-Date: Thu, 20 Jul 2017 15:58:51 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

(Brian reminded me of this, sorry for not replying earlier)

On Monday, 19 June 2017 5:00:18 PM CEST 
leonardo.sandoval.gonzalez@linux.intel.com wrote:
> From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
> 
> Creates a simple layer with a example recipe, where the latter
> has just a single task (do_build). Layer's license is MIT and
> layer's priority defaults to 6. Recipe name and layer's priority
> can changed specified through the command line.

So I'm generally in favour of adding this functionality to bitbake-layers and 
making it more widely available in preference to yocto-layer. However, I'm a 
bit concerned about the template recipe - it really doesn't belong in bitbake. 
We could resolve that in one of two ways:

1) Look for the template within the metadata and provide one in OE-Core, or

2) Put the template *and* the plugin in OE-Core, since bitbake-layers should 
support loading plugins from the metadata

I don't mind which but I'd lean towards #2 since it will probably require less 
additional plumbing.

Additionally we'll probably want to change "yocto-layer create" to call this 
and show a deprecation warning for the next release or two, and then drop it 
afterwards.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

