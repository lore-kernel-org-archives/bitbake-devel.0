Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAR7v-0007gR-L1
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 20:23:21 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 21 Mar 2012 12:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="80073017"
Received: from unknown (HELO [10.255.15.222]) ([10.255.15.222])
	by AZSMGA002.ch.intel.com with ESMTP; 21 Mar 2012 12:14:24 -0700
Message-ID: <4F6A2890.7080803@linux.intel.com>
Date: Wed, 21 Mar 2012 12:14:24 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1332288516.git.josh@linux.intel.com>
In-Reply-To: <cover.1332288516.git.josh@linux.intel.com>
Subject: Re: [PATCH 0/5] Hob GUI tweaks
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
X-List-Received-Date: Wed, 21 Mar 2012 19:23:21 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/03/12 17:15, Joshua Lock wrote:
> All,
>
> Here are some tweaks to the Hob GUI.
>
> Firstly I include a tweaked version of my recent LayerSelectionDialog patch, this
> includes Dongxiao's suggestion to use a prelight on the clickable pixbuf in the
> TreeView. Sadly on Ubuntu this isn't hugely noticable as the remove icon is
> largely whitespace.
> We should be able to replace the stock icon with a custom one soon.

I've received an asset to use for the remove icon so will send an 
updated pull request later today.

Please disregard this series.

Thanks,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


