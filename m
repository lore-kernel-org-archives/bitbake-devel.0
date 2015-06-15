Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 15ADB71144
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 13:28:49 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 15 Jun 2015 06:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,618,1427785200"; d="scan'208";a="743676170"
Received: from sosalmel-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.29.110])
	by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2015 06:28:28 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Liam R. Howlett" <Liam.Howlett@windriver.com>
Date: Mon, 15 Jun 2015 14:28:26 +0100
Message-ID: <2131793.ifvVUYI7Oy@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.7 (Linux/4.0.4-202.fc21.x86_64; KDE/4.14.7; x86_64; ; )
In-Reply-To: <20150512142807.GB15805@yow-lhowlett-d0.wrs.com>
References: <1429121824-31200-2-git-send-email-Liam.Howlett@WindRiver.com>
	<1431429477.30971.123.camel@linuxfoundation.org>
	<20150512142807.GB15805@yow-lhowlett-d0.wrs.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v3] fetch2: Add BB_ALLOWED_NETWORKS support
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
X-List-Received-Date: Mon, 15 Jun 2015 13:28:57 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 12 May 2015 10:28:08 Liam R. Howlett wrote:
> * Richard Purdie <richard.purdie@linuxfoundation.org> [150512 07:18]:
> > On Thu, 2015-04-16 at 13:23 -0400, Liam R. Howlett wrote:
> > > BB_ALLOWED_NETWORKS is a list of hosts that the fetcher will be allowed
> > > to use when BB_NO_NETWORK is not set.
> > > 
> > > If BB_NO_NETWORK is set, then networking is still disabled.
> > > 
> > > If BB_ALLOWED_NETWORKS is not set, the behaviour remains the same as
> > > today.
> > > 
> > > If BB_NO_NETWORK is NOT set, and BB_ALLOWED_NETWORKS is configured, then
> > > only the hosts in the list are usable by the fetcher.
> > > 
> > > eg:
> > > BB_ALLOWED_NETWORKS="yoctoproject.org git.gnu.org"
> > > The fetcher will be able to download from yoctoproject.org, git.gnu.org,
> > > but not ftp.gnu.org or any other hostname that is not in the list.
> > > 
> > > There is also limited support for wildcards on the beginning of the
> > > hosts, so BB_ALLOWED_NETWORKS="*.gnu.org" with match git.gnu.org and
> > > ftp.gnu.org as well as foo.git.gnu.org
> > > 
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@WindRiver.com>
> > > ---
> > > 
> > >  lib/bb/fetch2/__init__.py | 53
> > >  +++++++++++++++++++++++++++++++++++++++++++++++ lib/bb/tests/fetch.py 
> > >     | 37 +++++++++++++++++++++++++++++++++
> > >  2 files changed, 90 insertions(+)
> > 
> > I've merged this, however, one of the things we're trying to do is
> > improve the documentation of bitbake. Would you be able to work with
> > Scott (cc'd) to ensure this is documented in the manual please?
> > 
> > Cheers,
> > 
> > Richard
> 
> Absolutely, Thanks Richard.
> 
> Hello Scott,
> 
> If you don't have anything started, we can work from the text below if
> you'd like.
> 
> --------
> 
> BB_ALLOWED_NETWORKS
> 
> Specifies a space delimited list of hosts which are allowed to be used
> by the fetcher to obtain the required source code.  This list is only
> used if BB_NO_NETWORK is not set.  Wildcard matching at the beginning of
> hosts is supported.  Mirrors that are not in the list will be skipped
> and logged in debug.  Attempts to access networks that are not in the
> BB_ALLOWED_NETWORKS will cause a failure.
> 
> --------
> 
> Thanks,
> Liam

Replying to add Scott on CC - I think he has something for review.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

