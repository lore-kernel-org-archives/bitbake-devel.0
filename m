Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 961B8601DC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jan 2015 14:51:07 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 29 Jan 2015 06:44:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,486,1418112000"; d="scan'208";a="658638485"
Received: from jamiewei-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.23.125])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2015 06:51:06 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Jan 2015 14:51:06 +0000
Message-ID: <1915662.1K5ZXqbggV@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.3 (Linux/3.17.8-200.fc20.x86_64; KDE/4.14.3; x86_64; ; )
In-Reply-To: <CAGpdKULqOhkU1YqEKrm1Yc9vPN4+SStAv=woPMi=Ey6CzwCTrQ@mail.gmail.com>
References: <CAGpdKULqOhkU1YqEKrm1Yc9vPN4+SStAv=woPMi=Ey6CzwCTrQ@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: Bitbake inherit graph
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
X-List-Received-Date: Thu, 29 Jan 2015 14:51:14 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 29 January 2015 13:47:12 Roman Savchenko wrote:
> How can I build inherit graph?

Can you explain what you're looking for exactly? BitBake can produce (very 
large) task, PN and package graphs in .dot format with the -g option, but I'm 
not sure that that's what you're asking for.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

