Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TyNmv-00034n-3X
	for bitbake-devel@lists.openembedded.org;
	Thu, 24 Jan 2013 15:28:26 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 24 Jan 2013 06:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,529,1355126400"; d="scan'208";a="277909026"
Received: from unknown (HELO helios.localnet) ([10.252.123.150])
	by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2013 06:12:43 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: ml@communistcode.co.uk, bitbake-devel@lists.openembedded.org
Date: Thu, 24 Jan 2013 14:12:42 +0000
Message-ID: <2882957.uUmHZcLWSa@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9.4 (Linux/3.5.0-22-generic; KDE/4.9.4; i686; ; )
In-Reply-To: <51011737.8020501@communistcode.co.uk>
References: <51011737.8020501@communistcode.co.uk>
MIME-Version: 1.0
Subject: Re: Graphviz folder
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
X-List-Received-Date: Thu, 24 Jan 2013 14:28:28 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 24 January 2013 11:12:55 Jack Mitchell wrote:
> I was wondering if there would be support or interest for a patch which
> puts generated graphviz and dependancy files into their own folder.
> 
> Currently bitbake -g image creates a multitude of files in the root
> folder and I feel it just gets a bit messy. I think a better solution
> would either be to put the files in their own folder e.g. graphviz (name
> to be decided) or in tmp/graphviz.

This doesn't seem unreasonable, although I've never been too bothered with it 
writing to the current directory myself.

> On the topic of graphviz I can't seem to find a supported application
> for viewing the files as a nice graph, is this format still relevant
> these days?

Well, graphviz itself is the tool usually used to process these files (e.g. the 
"dot" command which graphviz provides) however the image files it produces can 
be somewhat large. My tool of choice however is xdot 
(http://code.google.com/p/jrfonseca/wiki/XDot), which seems to handle large 
graphs fairly well.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


