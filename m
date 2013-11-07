Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id E9D286D2FB
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2013 16:26:33 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 07 Nov 2013 08:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="431401485"
Received: from unknown (HELO helios.localnet) ([10.252.121.102])
	by orsmga002.jf.intel.com with ESMTP; 07 Nov 2013 08:26:34 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Thu, 07 Nov 2013 16:26:33 +0000
Message-ID: <3712809.5Iazxv3HWn@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-31-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <CAP71Wjz8DXdFYqMER6uy+7X9ic-PJmGQVp+d5ayC4TJ5Eqgozw@mail.gmail.com>
References: <1383266185-2917-1-git-send-email-nicolas.dechesne@linaro.org>
	<CAP71Wjz8DXdFYqMER6uy+7X9ic-PJmGQVp+d5ayC4TJ5Eqgozw@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH RFC] fetch2/svn.py: use log instead of info to retrieve revision
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
X-List-Received-Date: Thu, 07 Nov 2013 16:26:34 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Nicolas,

On Monday 04 November 2013 10:48:24 Nicolas Dechesne wrote:
> On Thu, Oct 31, 2013 at 5:36 PM, Nicolas Dechesne
> <nicolas.dechesne@linaro.org> wrote:
> > We have faced a corner case situation where the 'last changed
> > revision' returned from svn info is wrong. It happens when the last
> > revision is a directory move. e.g. if we assume that the svn
> > repository at revA has root/x/y/z/foo/bar and it is moved to
> > root/a/b/c/foo/bar in revB, then svn info 'last change revision' will
> > return revA. As such when using AUTOREV, we are going to attempt to
> > retrieve root/a/b/c/foo/bar (as per SRC_URI) but at revA when it did
> > not exist.
> > 
> > So this patch changes how we retrieve the latest revision and uses
> > 'svn log --limit 1' which gives correct result in all tested cases.
> 
> Richard, thanks for merging in master. any chance this can go to dora
> and dylan too, as this is a bug fix? the same patch applies in both
> branches, and we are currently using dylan and dora for our projects.

OK, I've queued it up for dylan as well.

Thanks,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

