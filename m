Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1UXAPY-0004Aq-RO
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Apr 2013 15:16:23 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 30 Apr 2013 05:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,580,1363158000"; d="scan'208";a="326528595"
Received: from unknown (HELO helios.localnet) ([10.255.12.98])
	by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2013 05:57:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 30 Apr 2013 13:57:42 +0100
Message-ID: <20732985.qIsTObyanK@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.2 (Linux/3.8.0-19-generic; KDE/4.10.2; i686; ; )
In-Reply-To: <1367319160-19785-1-git-send-email-Martin.Jansa@gmail.com>
References: <1367319160-19785-1-git-send-email-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC] git: add BB_FETCH_PREMIRROR_READONLY option
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
X-List-Received-Date: Tue, 30 Apr 2013 13:16:28 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 30 April 2013 12:52:40 Martin Jansa wrote:
> * just RFC, because I haven't even tested this change,
>   use it only to describe the issue and discuss it
> 
> * remove symlink to ud.fullmirror when BB_FETCH_PREMIRROR_READONLY is set
> 
> * with read-only PREMIRROR (e.g. mounted over NFS or CIFS
>   and referenced as file:///mnt/premirror) we cannot use
>   BB_GENERATE_MIRROR_TARBALLS because all git2_abc.git.tar.gz
>   files later became just symlinks to read-only location in PREMIRROR
>   (it works fine on first build and for new components, because
>   at that time there isn't tarball on PREMIRROR yet).
> 
>   ERROR: Fetcher failure: Fetch command failed with exit code 141, output:
>   tar (child): /build/downloads/git2_abc.git.tar.gz: Cannot open: Read-only
> file system tar (child): Error is not recoverable: exiting now
> 
> * maybe we can change the default behavior and always remove symlink
>   without introducing new option

Personally I think it would be better to do the latter.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


