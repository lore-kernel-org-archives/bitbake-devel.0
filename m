Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id CBFB6706D9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Jun 2015 08:40:15 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP; 16 Jun 2015 01:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,625,1427785200"; d="scan'208";a="509018727"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.252.25.227])
	by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2015 01:40:16 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Tue, 16 Jun 2015 09:40:15 +0100
Message-ID: <1946263.B0TEDLLAIC@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.7 (Linux/4.0.4-202.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <1FDE9321-AA20-49D9-A4BE-A4B4514439DB@gmail.com>
References: <1429121824-31200-2-git-send-email-Liam.Howlett@WindRiver.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB123798D203356@ORSMSX101.amr.corp.intel.com>
	<1FDE9321-AA20-49D9-A4BE-A4B4514439DB@gmail.com>
MIME-Version: 1.0
Cc: "Howlett, Liam \(Wind River\)" <liam.howlett@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Gary Thomas <gary@mlbassoc.com>
Subject: Re: [PATCH v3] fetch2: Add	BB_ALLOWED_NETWORKS	support
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
X-List-Received-Date: Tue, 16 Jun 2015 08:40:16 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 15 June 2015 23:47:29 Bernhard Reutner-Fischer wrote:
> On June 15, 2015 4:03:11 PM GMT+02:00, "Rifenbark, Scott M" 
<scott.m.rifenbark@intel.com> wrote:
> >Hi,
> >
> >Here is a first draft of documenting the BB_ALLOWED_NETWORKS variable
> >in the BitBake User Manual.  I re-wrote the original text to be active
> >voice and applied some different organization of the facts to help the
> >flow out.  Regarding Gary's input about BB_NO_NETWORK..... I took a
> >half guess at incorporating it.  Please look this new description over
> >and let me know of any corrections I need to make.
> >http://www.yoctoproject.org/docs/1.9/bitbake-user-manual/bitbake-user-manua
> >l.html#var-BB_ALLOWED_NETWORKS.
> Was the v3 fixed / extended to allow for netmasks, btw?
> Think
> /etc/hosts
> foo.example.com 10.0.0.1
> bar.example.com 10.0.0.254
> baz.example.com ::1
> 
> BB_ALLOWED_NETWORKS = 10.0.0.0/24 1.1.1.1/31 ::1/127

I don't believe so. You can see what actually went in here:

http://git.yoctoproject.org/cgit/cgit.cgi/poky/commit/?id=59ce7d02a57e0a642d839ab48677f6ac1886180f

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

