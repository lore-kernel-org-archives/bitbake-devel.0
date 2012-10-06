Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TKd8B-0004ok-54
	for bitbake-devel@lists.openembedded.org;
	Sun, 07 Oct 2012 00:45:59 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 06 Oct 2012 15:32:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,545,1344236400"; d="scan'208";a="153258258"
Received: from unknown (HELO helios.localnet) ([10.252.122.64])
	by AZSMGA002.ch.intel.com with ESMTP; 06 Oct 2012 15:32:52 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Chris Larson <clarson@kergoth.com>
Date: Sat, 06 Oct 2012 23:32:51 +0100
Message-ID: <2059965.DPhKPFNMcC@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9.2 (Linux/3.2.0-31-generic-pae; KDE/4.9.2; i686; ; )
In-Reply-To: <CABcZAN=FnKvxMDB_WHVdAXFz66RMXWtV-9yhHc7D=NpfY=VmMA@mail.gmail.com>
References: <1349267277-1380-1-git-send-email-paul.eggleton@linux.intel.com>
	<CABcZAN=FnKvxMDB_WHVdAXFz66RMXWtV-9yhHc7D=NpfY=VmMA@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: raise an exception if user specifies protocol=git with http://
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
X-List-Received-Date: Sat, 06 Oct 2012 22:45:59 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 06 October 2012 15:27:42 Chris Larson wrote:
> On Wed, Oct 3, 2012 at 5:27 AM, Paul Eggleton
> 
> <paul.eggleton@linux.intel.com> wrote:
> > It is a common mistake to use http:// and protocol=git when attempting
> > to fetch from a git repository using the http protocol; if this is
> > detected then throw an error explaining that you need to use git:// with
> > protocol=http instead.
> > 
> > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> 
> Perhaps this should check the protocol= value against the protocols
> supported by wget (ftp, http, https, etc), if the parameter is passed,
> rather than hardcoding the exceptions.

I don't think protocol= is currently used with the wget fetcher is it?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


