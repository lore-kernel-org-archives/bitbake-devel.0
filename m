Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1ULII5-0005St-21
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Mar 2013 20:15:29 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2013 11:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,367,1363158000"; d="scan'208";a="285920493"
Received: from unknown (HELO helios.localnet) ([10.255.13.158])
	by orsmga001.jf.intel.com with ESMTP; 28 Mar 2013 11:58:07 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Trevor Woerner <twoerner@gmail.com>
Date: Thu, 28 Mar 2013 18:58:06 +0000
Message-ID: <2410150.0URcKKJt6X@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.1 (Linux/3.5.0-26-generic; KDE/4.10.1; i686; ; )
In-Reply-To: <CAHUNapRpG++6MYT0JcD7Y=o3Hj2Q=jaQVRhbUwewhKFDwcECjQ@mail.gmail.com>
References: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
	<CAHUNapRpG++6MYT0JcD7Y=o3Hj2Q=jaQVRhbUwewhKFDwcECjQ@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] Add file information to package information window
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
X-List-Received-Date: Thu, 28 Mar 2013 19:15:30 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 March 2013 14:45:13 Trevor Woerner wrote:
> On Thu, Mar 28, 2013 at 4:23 AM, Andrei Dinu
> <andrei.adrianx.dinu@intel.com> wrote:
> > Listing the files that are brought into an image
> > from each package.
> 
> This sounds like a great feature! Is this also available from the
> bitbake command-line as well?

Just so it's clear, this information is only available after packages have 
been built, and is saved in the tmp/pkgdata directory. I'm not sure if it 
would really be appropriate to add this functionality to BitBake itself, 
however in OE-Core there's a very basic command-line tool called oe-pkgdata-
util which performs one type of querying on the pkgdata/ directory and could 
be extended to query the package file lists.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


