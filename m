Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SynVr-0000GM-IV
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 Aug 2012 19:24:11 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 07 Aug 2012 10:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="177070893"
Received: from unknown (HELO helios.localnet) ([10.252.121.56])
	by orsmga001.jf.intel.com with ESMTP; 07 Aug 2012 10:12:23 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Tue, 07 Aug 2012 18:12:22 +0100
Message-ID: <16599840.OqlgMUDr4l@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9 (Linux/3.2.0-27-generic-pae; KDE/4.9.0; i686; ; )
In-Reply-To: <cover.1344346253.git.liezhi.yang@windriver.com>
References: <cover.1344346253.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/1] bitbake-whatchanged: print what is about to happen
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
X-List-Received-Date: Tue, 07 Aug 2012 17:24:11 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 07 August 2012 23:48:55 Robert Yang wrote:
> The following changes since commit c86d26cb976e665b1516e72153f3f686f62dedf9:
> 
>   subversion: Add missing build dependency on sqlite3 (2012-08-06 16:14:06
> +0100)
> 
> are available in the git repository at:
> 
>   git://git.pokylinux.org/poky-contrib robert/whatchanged
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/whatchanged
> 
> Robert Yang (1):
>   bitbake-whatchanged: print what is about to happen
> 
>  bitbake/bin/bitbake-whatchanged | 334
> ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 334 insertions(+)
>  create mode 100755 bitbake/bin/bitbake-whatchanged

I tried this on top of latest master, unfortunately what I got was the
following:

-------------- snip ----------------
Figuring out the TMPDIR ...
Moving the stamps to stamps.old ...
Generating the new stamps ... (need several minutes)
ERROR occurred!!! Recovering the stamps dir ...
Removing the newly generated stamps ...
Moving the stamps.old back to stamps ...
Traceback (most recent call last):
  File "/home/paul/poky/poky/bitbake/bin/bitbake-whatchanged", line 333, in <module>
    sys.exit(main())
  File "/home/paul/poky/poky/bitbake/bin/bitbake-whatchanged", line 291, in main
    old_recon = recon_dict(old_dict)
  File "/home/paul/poky/poky/bitbake/bin/bitbake-whatchanged", line 82, in recon_dict
    full_path_pre = "%s/%s" % (dict_in.get(dict_out.get(pn_task).get(fn)).get('path'), k)
NameError: global name 'fn' is not defined
-------------- snip ----------------

A couple of other things:

1) We ought to be able to assume that TMPDIR is the same regardless of 
the recipe specified; this avoids having to parse all of the recipes just to
get the value of this variable.

2) I'm a little concerned with the general approach - is there no way of
avoiding having to copy and move around the stamps directory? It seems
a little risky if nothing else.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


