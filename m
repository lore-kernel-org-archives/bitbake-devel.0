Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S9afB-0005Ux-39
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 12:22:09 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 19 Mar 2012 04:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120574485"
Received: from unknown (HELO helios.localnet) ([10.252.123.198])
	by azsmga001.ch.intel.com with ESMTP; 19 Mar 2012 04:13:03 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Mon, 19 Mar 2012 11:13:02 +0000
Message-ID: <2690603.YoofdHq7la@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.0 (Linux/3.0.0-16-generic-pae; KDE/4.8.1; i686; ; )
In-Reply-To: <alpine.DEB.2.02.1203190704390.20606@oneiric>
References: <alpine.DEB.2.02.1203190704390.20606@oneiric>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: "bitbake-layers show-overlayed" generates python traceback
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
X-List-Received-Date: Mon, 19 Mar 2012 11:22:09 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 19 March 2012 07:07:18 Robert P. J. Day wrote:
>   just goofing around with a utility i'd never noticed before,
> bitbake-layers, and tested it on a simple qemux86 configuration:
> 
> $ bitbake-layers show-overlayed
> Parsing recipes..done.
> Traceback (most recent call last):
>   File "/home/rpjday/oe/oe-core/bitbake/bin/bitbake-layers", line 593, in
> <module> sys.exit(main(sys.argv[1:]) or 0)
>   File "/home/rpjday/oe/oe-core/bitbake/bin/bitbake-layers", line 47, in
> main cmds.onecmd(' '.join(args))
>   File "/usr/lib/python2.7/cmd.py", line 219, in onecmd
>     return func(arg)
>   File "/home/rpjday/oe/oe-core/bitbake/bin/bitbake-layers", line 216, in
> do_show_overlayed logger.note('No overlayed files found')
> AttributeError: 'BBLogger' object has no attribute 'note'
> $
> 
>   is there a special context i need to run this in?

No, this is a bug. Looking at a fix now.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


