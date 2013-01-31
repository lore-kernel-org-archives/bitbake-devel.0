Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1U0uzg-0004MJ-Sk
	for bitbake-devel@lists.openembedded.org;
	Thu, 31 Jan 2013 15:20:01 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 31 Jan 2013 06:04:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,577,1355126400"; d="scan'208";a="197069072"
Received: from unknown (HELO helios.localnet) ([10.252.120.26])
	by AZSMGA002.ch.intel.com with ESMTP; 31 Jan 2013 06:04:16 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Thu, 31 Jan 2013 14:04:15 +0000
Message-ID: <7274465.7DSL83VslB@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9.4 (Linux/3.5.0-22-generic; KDE/4.9.4; i686; ; )
In-Reply-To: <cover.1359080497.git.liezhi.yang@windriver.com>
References: <cover.1359080497.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/2] bitbake-layers: print the recipe's depends that crosses a layer boundary
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
X-List-Received-Date: Thu, 31 Jan 2013 14:20:05 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Robert,

On Friday 25 January 2013 16:35:08 Robert Yang wrote:
> The following changes since commit 8d6e55bf2192524bda84138b5356a2791adbbe61:
> 
>   prserv: add LOCALCOUNT to AUTOINCs migration feature (2013-01-22 16:01:32
> +0000)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib robert/bitbake-layers
>  
> http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/bitbake-layers
> 
> Robert Yang (2):
>   bitbake-layers: fix get_file_layer
>   bitbake-layers: print the recipe's depends that crosses a layer
>     boundary

Looks good, thanks for implementing this. I think we might be able to improve 
the output formatting for this subcommand in a similar manner to the other 
subcommands a while ago (i.e. avoiding long paths but with an option to go 
back to the full path format - see show-overlayed and its -f option for an 
example) however this can be done at a later date.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


