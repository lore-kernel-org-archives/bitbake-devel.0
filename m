Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1R4sdi-00086e-8A
	for bitbake-devel@lists.openembedded.org;
	Sat, 17 Sep 2011 13:00:54 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 17 Sep 2011 03:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,398,1312182000"; d="scan'208";a="54765475"
Received: from unknown (HELO helios.localnet) ([10.252.120.34])
	by fmsmga002.fm.intel.com with ESMTP; 17 Sep 2011 03:54:17 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 17 Sep 2011 11:54:16 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic-pae; KDE/4.6.2; i686; ; )
References: <cover.1316178644.git.paul.eggleton@linux.intel.com>
	<d77660aa9085af99cdb0aa4d38736b8485434697.1316178644.git.paul.eggleton@linux.intel.com>
In-Reply-To: <d77660aa9085af99cdb0aa4d38736b8485434697.1316178644.git.paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Message-Id: <201109171154.16365.paul.eggleton@linux.intel.com>
Subject: Re: [PATCH 1/1] fetch2/git: fix subpath destination directory
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
X-List-Received-Date: Sat, 17 Sep 2011 11:00:54 -0000
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hmm, this patch is broken for subpath depth > 1. Please disregard; will send a 
v2 soon.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


