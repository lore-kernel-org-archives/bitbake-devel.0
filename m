Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 056E671ABC
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Aug 2017 18:06:41 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 03 Aug 2017 11:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,317,1498546800"; d="scan'208";a="1158840029"
Received: from valeriof-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.52.220])
	by orsmga001.jf.intel.com with ESMTP; 03 Aug 2017 11:06:41 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Thu, 03 Aug 2017 20:06:40 +0200
Message-ID: <7053389.oLP1XTmJTf@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <1501256242-37784-5-git-send-email-mark.hatle@windriver.com>
References: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
	<1501256242-37784-5-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, toaster@yoctoproject.org
Subject: Re: [PATCH 4/5] toaster/orm/management/commands/lsupdates.py: Use new layerindex module
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
X-List-Received-Date: Thu, 03 Aug 2017 18:06:42 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 28 July 2017 5:37:21 PM CEST Mark Hatle wrote:
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>

Missing a commit message - and you wrote the book on proper commit messages :p

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

