Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1Tcy8V-0004F0-MJ
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Nov 2012 13:50:08 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:40842 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1Tcxum-00022T-SU; Mon, 26 Nov 2012 07:35:56 -0500
Date: Mon, 26 Nov 2012 07:35:52 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <29436129.kTOWlB2TST@helios>
Message-ID: <alpine.DEB.2.02.1211260724070.6200@oneiric>
References: <alpine.DEB.2.02.1211240910580.934@oneiric>
	<29436129.kTOWlB2TST@helios>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Mon, 26 Nov 2012 12:50:08 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 26 Nov 2012, Paul Eggleton wrote:

> On Saturday 24 November 2012 09:23:20 Robert P. J. Day wrote:

> > RDEPENDS_python-smartpm_append = " python-smartpm-backend-rpm python-codecs
> > python-textutils python-xml" RDEPENDS_python-smartpm_append += "
> > python-fcntl python-pickle python-crypt python-compression python-shell"
> > RDEPENDS_python-smartpm_append += " python-resource python-netclient
> > python-threading python-unixadmin"
>
> I would strongly discourage the use of += in conjunction with
> _append because the intent is unclear - I think we've discussed this
> before; this is just a case where it slipped through. Ideally this
> would just be done as a += split onto multiple lines and I will make
> sure it gets changed to that if someone else doesn't get to it
> first.

  two more bits of pedantry that i think would improve the
code/documentation, related to the above.

  first, as i understand it, the "_append" feature is used to do
appending at the *end* of the, what, parsing?  what do you call that
step, and how would you describe what happens when you use "_append"?
because it seems that, while it's a useful feature when ordering *is*
important, it's overkill when ordering doesn't matter.

  consider this snippet from linux-yocto_3.2.bb:

KERNEL_FEATURES_append=" features/netfilter"
KERNEL_FEATURES_append=" features/taskstats"
KERNEL_FEATURES_append_qemux86=" cfg/sound"
KERNEL_FEATURES_append_qemux86-64=" cfg/sound"

since the above is defining kernel features, is there anything
important about the ordering?  unless there's something tricky going
on, couldn't one just have coded:

KERNEL_FEATURES += "features/netfilter"
KERNEL_FEATURES += "features/taskstats"
KERNEL_FEATURES_qemux86 += "cfg/sound"
KERNEL_FEATURES_qemux86-64 +="cfg/sound"

  that second form is clearly simpler, as long as it represents
identical functionality.  in short, don't use "_append" unless it's
actually necessary.  which brings us to my second suggestion.

  use actual OE/yocto code to explain features.  from the bitbake user
manual, remember this snippet explaining how to use overrides and
appending:

===== start =====

OVERRIDES = "foo"
A_foo_append = "X"
In this case, X is unconditionally appended to the variable A_foo.
Since foo is an override, A_foo would then replace A.

OVERRIDES = "foo"
A = "X"
A_append_foo = "Y"
In this case, only when foo is in OVERRIDES, Y is appended to the
variable A so the value of A would become XY (NB: no spaces are
appended).

OVERRIDES = "foo"
A_foo_append = "X"
A_foo_append += "Y"

===== end =====

  but the above is not all that informative since the reader has no
clue what "A" or "foo" might represent.  so use excerpts from recipes
themselves that are immediately obvious; in fact, the above kernel
features can be used for that:

KERNEL_FEATURES += "features/netfilter"
KERNEL_FEATURES += "features/taskstats"
KERNEL_FEATURES_qemux86 += "cfg/sound"
KERNEL_FEATURES_qemux86-64 +="cfg/sound"

that at least makes it spectacularly clear that, given a particular
architecture, additional features will be selected for the kernel.
simply using "A" and "foo" and "X" and "Y" is fairly meaningless.

  i may shortly have another suggestion or two that have worked for me
in explaining stuff to students.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


