Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QbBbA-0003ex-Hx
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Jun 2011 15:11:33 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 27 Jun 2011 06:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,432,1304319600"; d="scan'208";a="23341114"
Received: from unknown (HELO helios.localnet) ([10.255.17.113])
	by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2011 06:06:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "'Martin Jansa'" <martin.jansa@gmail.com>
Date: Mon, 27 Jun 2011 14:06:45 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic-pae; KDE/4.6.2; i686; ; )
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
In-Reply-To: <1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
MIME-Version: 1.0
Message-Id: <201106271406.45596.paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] die if a .bbappend file matches no existing .bb recipe
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
X-List-Received-Date: Mon, 27 Jun 2011 13:11:33 -0000
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Martin Jansa wrote:
> Imagine the case when you enable some layer managed by someone else
> (lets call it LS) and you're using different oe-core revision, maybe
> current HEAD and that LS wasn't updated for that or vice versa you're
> using some oe-core release version and you want to reuse some recipes
> from LS in current version.
> 
> I think that big fat warning that some .bbappends does not match
> should be enough to decide if it's fatal for me (and I'll kill that
> build) or that's fine (when I'm not interested in those .bbappends
> from LS and I'm using only some other .bb files from LS).
> 
> If we make it fatal then I would be forced to remove unmatched
> .bbappends from LS before build which can be difficult to share
> (unless I create own LS branch and use it in my distro).

I see what you're saying, but I'm worried about the visiblity (or lack 
thereof) of these warnings.  If you start a build, go off somewhere and come 
back when the build is part way through or finished, you may be oblivious to 
the fact that there might be a serious problem - i.e. the customisations you 
expected to be applied haven't been.

It all depends on whether the bbappends are supposed to apply to recipes that 
are to be used in the build you're doing - if they are, then IMHO the error 
should be fatal. I wonder if it's practical to make it work that way...?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


