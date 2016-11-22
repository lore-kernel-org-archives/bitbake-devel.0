Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8AF9A71996
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Nov 2016 08:07:52 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga102.jf.intel.com with ESMTP; 22 Nov 2016 00:07:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,680,1473145200"; d="scan'208";a="194356001"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2016 00:07:52 -0800
Message-ID: <1479801944.13463.18.camel@linux.intel.com>
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: akuster808 <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 22 Nov 2016 10:05:44 +0200
In-Reply-To: <6826906f-a5f8-baba-8c10-5f43424183ba@gmail.com>
References: <1479731503-12780-1-git-send-email-markus.lehtonen@linux.intel.com>
	<6826906f-a5f8-baba-8c10-5f43424183ba@gmail.com>
X-Mailer: Evolution 3.16.5 
Mime-Version: 1.0
Subject: Re: [PATCH] fetch2: obey BB_ALLOWED_NETWORKS when checking network access
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
X-List-Received-Date: Tue, 22 Nov 2016 08:07:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-11-21 at 07:47 -0800, akuster808 wrote:
> 
> On 11/21/2016 04:31 AM, Markus Lehtonen wrote:
> > [YOCTO #10508]
> 
> I take it this applies to  1.32 ( Morty) as well.

Yes, I think so.

However, it may have some side effects for users of BB_ALLOWED_NETWORKS.
Basically, after this patch git update (and mercurial and other VCSes, too)
from upstream sources stops working unless the upstream repo is trusted by
BB_ALLOWED_NETWORKS.

Thanks,
  Markus

