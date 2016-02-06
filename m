Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 8E5F577258;
	Sat,  6 Feb 2016 06:38:11 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 05 Feb 2016 22:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,404,1449561600"; d="scan'208";a="741523483"
Received: from hloo1-mobl4.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.176.79])
	by orsmga003.jf.intel.com with ESMTP; 05 Feb 2016 22:38:09 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Sat, 06 Feb 2016 19:38:07 +1300
Message-ID: <2240342.nbMP20jZIu@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.3.4-300.fc23.x86_64; KDE/4.14.16; x86_64; ;
	)
In-Reply-To: <1454457340.27087.143.camel@linuxfoundation.org>
References: <1454457340.27087.143.camel@linuxfoundation.org>
MIME-Version: 1.0
Cc: openembedded-architecture@lists.openembedded.org,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] [PATCH] data_smart: Drop default expand=False to getVar [API change]
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
X-List-Received-Date: Sat, 06 Feb 2016 06:38:13 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tue, 02 Feb 2016 23:55:40 Richard Purdie wrote:
> At some point in the future, getVar should expand by default. To get
> there from the current position, we need a period of time where the
> expand parameter is mandatory.
> 
> This patch starts that process. Clear errors will result from any code
> which doesn't provide this. Layers can be fixed with an expression
> like:
> 
> sed -e 's:\(\.getVar([^,()]*, [^,()]*\)):\1, False):g' -i `grep -ril getVar
> *`
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
> index 8c3e9ef..79bec1b 100644
> --- a/bitbake/lib/bb/data_smart.py
> +++ b/bitbake/lib/bb/data_smart.py
> @@ -566,7 +566,7 @@ class DataSmart(MutableMapping):
>                  if len(shortvar) == 0:
>                      override = None
> 
> -    def getVar(self, var, expand=False, noweakdefault=False,
> parsing=False): +    def getVar(self, var, expand, noweakdefault=False,
> parsing=False): return self.getVarFlag(var, "_content", expand,
> noweakdefault, parsing)
> 
>      def renameVar(self, key, newkey, **loginfo):

This change is reasonable and we've been discussing it on and off for years 
now, so I'm generally in favour.

However, what I would really like to see us do is write a script that people 
can use to upgrade their layers to accommodate this and any other breaking 
changes so they don't have to go and figure out what to do themselves; the more 
of these kinds of changes we make the more useful this script will be. I'll 
file a bug.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

