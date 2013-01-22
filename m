Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TxbTy-00067M-U6
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Jan 2013 11:53:47 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Jan 2013 02:35:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,513,1355126400"; d="scan'208";a="275107547"
Received: from unknown (HELO helios.localnet) ([10.252.123.171])
	by orsmga002.jf.intel.com with ESMTP; 22 Jan 2013 02:36:57 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: lei yang <yanglei.fage@gmail.com>
Date: Tue, 22 Jan 2013 10:36:56 +0000
Message-ID: <3325513.8ZibJSvNVU@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9.4 (Linux/3.5.0-22-generic; KDE/4.9.4; i686; ; )
In-Reply-To: <CAHsH0E96h=aT6t-u-ACY7MGFHJv4_TTqSMfCmMpSKiq3NBjciw@mail.gmail.com>
References: <CAHsH0E96h=aT6t-u-ACY7MGFHJv4_TTqSMfCmMpSKiq3NBjciw@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] git address in SRC_URI, doesn't works for me
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
X-List-Received-Date: Tue, 22 Jan 2013 10:53:47 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 19 January 2013 17:13:01 lei yang wrote:
> One git address's prefix is "http" --->
> http://git.opensvc.com/multipath-tools/.git,
> 
> it means
> 
> git clone  http://git.opensvc.com/multipath-tools/.git  ---------> works
> git clone git://git.opensvc.com/multipath-tools/.git ---------> doesn't work
> 
> I tried SRC_URI with below, both failed
> 
> SRC_URI = "http://git.opensvc.com/multipath-tools/.git;protocol=git"
> it tells
> fatal: reference is not a tree: c23c0d33ed98a1dcee40115018b73cb3d4cda8d7
> 
> 
> SRC_URI = "git://git.opensvc.com/multipath-tools/.git;protocol=http"
> it doe noting,and trying to find COPING,but it doesn't clone it

I think you already got this answered on IRC, but for reference you need to 
use git://....;protocol=http and not http://.....;protocol=git. BitBake uses 
the prefix to determine which fetcher to use (matching the type of repository 
being fetched from) and then each individual fetcher decides the meaning of 
the protocol argument. In this case you're fetching from a git repository 
using the HTTP transport protocol.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


