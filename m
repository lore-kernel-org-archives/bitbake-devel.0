Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 9497565CAC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Apr 2015 14:29:56 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 27 Apr 2015 07:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,657,1422950400"; d="scan'208";a="486198871"
Received: from dmoore26-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.4.219])
	by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2015 07:29:57 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Mon, 27 Apr 2015 15:29:56 +0100
Message-ID: <16827531.iyLDU4dcLN@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.4 (Linux/3.18.9-200.fc21.x86_64; KDE/4.14.6; x86_64; ; )
In-Reply-To: <1430144665-17540-1-git-send-email-alexandru.damian@intel.com>
References: <1430144665-17540-1-git-send-email-alexandru.damian@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] Revert "toaster: add layer source in admin throws an error"
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
X-List-Received-Date: Mon, 27 Apr 2015 14:29:58 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Alex,

On Monday 27 April 2015 15:24:25 Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> This reverts commit 4de721aa75a4aaad186312443726e6daa764934b.
> ---

When we revert patches, we need something in the message explaining why we are 
doing the revert.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

