Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TF42M-0002jr-Pz
	for bitbake-devel@lists.openembedded.org;
	Fri, 21 Sep 2012 16:16:58 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 21 Sep 2012 07:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,463,1344236400"; d="scan'208";a="225064537"
Received: from unknown (HELO helios.localnet) ([10.252.121.241])
	by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2012 07:04:11 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Sep 2012 15:04:09 +0100
Message-ID: <1381433.1b9trVnFqG@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9 (Linux/3.2.0-30-generic-pae; KDE/4.9.0; i686; ; )
In-Reply-To: <ec7f43d0fa2b9d3e276c196b4ab9e11935b315af.1348155869.git.paul.eggleton@linux.intel.com>
References: <cover.1348155869.git.paul.eggleton@linux.intel.com>
	<ec7f43d0fa2b9d3e276c196b4ab9e11935b315af.1348155869.git.paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] hob: remove confirmation dialog on close
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
X-List-Received-Date: Fri, 21 Sep 2012 14:16:59 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 20 September 2012 16:47:37 Paul Eggleton wrote:
> This is not necessary for modern applications.

So, it turns out that this confirmation dialog is currently the only thing 
standing in the way of closing the application during a build, which is also 
wrong. After discussing with Belen what it ought to be doing is doing the same 
thing as clicking the Stop button when a build is in progress.

Please ignore the whole series, since I have an additional patch to add in v2 
on top of fixing this issue.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


