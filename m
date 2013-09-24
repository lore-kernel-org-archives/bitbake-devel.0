Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1C5306C994
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 17:14:59 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 10:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="408456211"
Received: from unknown (HELO helios.localnet) ([10.252.120.52])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 10:14:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Tue, 24 Sep 2013 18:14:47 +0100
Message-ID: <1730576.5aMD7QhvXQ@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-30-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/94] Webhob patches for DSI and Web modules
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 24 Sep 2013 17:15:00 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Alex,

On Tuesday 24 September 2013 17:52:50 Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> Patches for the DSI and Web modules of Webhob, in the order of development.

I hate to be a pain, but apart from the commits that change existing modules 
e.g. cooker, all of these commits need to be squashed into one commit that 
simply adds Web Hob to bitbake - we don't need the full incremental 
development history. 

(Of course we do want to preserve the list of bug IDs / contributors from the 
commit messages, though.)

Thanks,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

