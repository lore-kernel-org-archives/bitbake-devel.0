Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id DEDBB70331
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 13:51:42 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 26 May 2015 06:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,498,1427785200"; d="scan'208";a="700358330"
Received: from leeshawn-mobl3.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.22.214])
	by orsmga001.jf.intel.com with ESMTP; 26 May 2015 06:51:42 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Trevor Woerner <twoerner@gmail.com>
Date: Tue, 26 May 2015 14:51:41 +0100
Message-ID: <7025804.ZvuMXxFa1D@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.7 (Linux/3.19.7-200.fc21.x86_64; KDE/4.14.7; x86_64; ; )
In-Reply-To: <555FA65A.1020505@gmail.com>
References: <555FA65A.1020505@gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake-layers layerindex-fetch
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
X-List-Received-Date: Tue, 26 May 2015 13:51:43 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Trevor,

On Friday 22 May 2015 17:57:46 Trevor Woerner wrote:
> I'm curious to know what heuristic "bitbake-layers layerindex-fetch"
> uses to determine where to place the fetched layers?
> 
> I asked my system to:
> 
>   $ bitbake-layers layerindex-fetch meta-qt5
> 
> and it keeps insisting on installing meta-qt5 and meta-openembedded
> under my openembedded-core layers resulting in:
> 
>   /z/master/layers/openembedded-core/meta-openembedded/meta-ruby \
>   /z/master/layers/openembedded-core/meta-qt5 \
> 
> Is there a way that I can tell bitbake-layers that my layers are located
> at /z/master/layers and have it work from there?

This is controlled by BBLAYERS_FETCH_DIR; by default this is set to 
"${COREBASE}" with ??= so you can set it to your preferred value in local.conf 
as desired. (We should definitely document this, I acknowledge at the moment it 
isn't documented anywhere.)

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

