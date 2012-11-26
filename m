Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Tcwxt-0001qt-Tt
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Nov 2012 12:35:06 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Nov 2012 03:19:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,319,1352102400"; d="scan'208";a="252529225"
Received: from unknown (HELO helios.localnet) ([10.252.122.215])
	by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2012 03:19:48 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Mon, 26 Nov 2012 11:19:47 +0000
Message-ID: <29436129.kTOWlB2TST@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9.3 (Linux/3.2.0-33-generic-pae; KDE/4.9.3; i686; ; )
In-Reply-To: <alpine.DEB.2.02.1211240910580.934@oneiric>
References: <alpine.DEB.2.02.1211240910580.934@oneiric>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: wanting clarification on overrides, _append, += and combinations of those
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
X-List-Received-Date: Mon, 26 Nov 2012 11:35:06 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 24 November 2012 09:23:20 Robert P. J. Day wrote:
>   preparing my own write-up on how bitbake processes combinations of
> overrides, _append and += and ran across an example in oe-core that is
> unnecessarily whitespacey, just wanted to make sure i was
> understanding this properly.
> 
>   in the current bitbake user manual, there's this example of mixing
> overrides, _append and +=:
> 
>   OVERRIDES = "foo"
>   A_foo_append = "X"
>   A_foo_append += "Y"
> 
>   This behaves as per the first case above, but the value of A would
>   be "X Y" instead of just "X".
> 
>   that, of course, makes sense as the "+=" operator automatically adds
> a leading space to what is being appended.  so for fun, i scanned all
> of oe-core looking for examples of "_append.*+=" for classroom demo
> purposes, and the *only* examples i found were in
> meta/recipes-devtools/python/python-smartpm_1.4.1.bb:
> 
> RDEPENDS_python-smartpm_append = " python-smartpm-backend-rpm python-codecs
> python-textutils python-xml" RDEPENDS_python-smartpm_append += "
> python-fcntl python-pickle python-crypt python-compression python-shell"
> RDEPENDS_python-smartpm_append += " python-resource python-netclient
> python-threading python-unixadmin"
> 
>   i can see that that first line *does* need an explicit leading space
> in the value being assigned, but the next two "+=" lines don't, do
> they?  it won't hurt, of course, you'll just *two* spaces inserted
> instead of one.  but i just want to make sure i understand what's
> happening there since it has the potential to be confusing for someone
> trying to follow along.

I would strongly discourage the use of += in conjunction with _append because 
the intent is unclear - I think we've discussed this before; this is just a 
case where it slipped through. Ideally this would just be done as a += split 
onto multiple lines and I will make sure it gets changed to that if someone 
else doesn't get to it first.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


