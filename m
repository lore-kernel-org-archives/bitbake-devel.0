Return-Path: <paul.eggleton@linux.intel.com>
X-Greylist: delayed 629 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 18 Jun 2014 16:01:02 UTC
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 16C8B6FE30
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 16:01:02 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 18 Jun 2014 08:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,501,1400050800"; d="scan'208";a="549893798"
Received: from tlankage-mobl.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.87])
	by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2014 08:50:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 18 Jun 2014 16:50:32 +0100
Message-ID: <3485367.eXfHHFnm7Z@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.12.5 (Linux/3.14.7-200.fc20.x86_64; KDE/4.12.5; x86_64; ; )
In-Reply-To: <alpine.LFD.2.11.1406180908370.25541@localhost>
References: <alpine.LFD.2.11.1406180908370.25541@localhost>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: curious about setting of PROVIDES in bitbake.conf
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
X-List-Received-Date: Wed, 18 Jun 2014 16:01:12 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 18 June 2014 09:10:00 Robert P. J. Day wrote:
>   from current bitbake.conf file:
> 
> PROVIDES = ""
> PROVIDES_prepend = "${PN} "
> 
> is there a reason that PROVIDES is set to null, only to immediately
> set it based on the following line? is there some subtle issue this is
> meant to address?

I think the intention is to set the initial value to blank, and ensure that 
${PN} is the first item in the list (since _prepend gets applied later). If you 
just simply had PROVIDES = "${PN}" then it could be overridden somewhere else 
such that ${PN} was not in PROVIDES at all, which would be counter-intuitive.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

