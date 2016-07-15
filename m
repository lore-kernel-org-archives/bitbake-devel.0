Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 1721B731A2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jul 2016 23:08:16 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga104.fm.intel.com with ESMTP; 15 Jul 2016 16:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,370,1464678000"; d="scan'208";a="1022691063"
Received: from njaafar1-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.147.71])
	by fmsmga002.fm.intel.com with ESMTP; 15 Jul 2016 16:08:15 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 16 Jul 2016 11:08:12 +1200
Message-ID: <11213377.AP4gMkxMt0@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.5.7-202.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <1468578442-23552-1-git-send-email-ross.burton@intel.com>
References: <1468578442-23552-1-git-send-email-ross.burton@intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH] lib/bb/build.py: decode the command as UTF-8
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
X-List-Received-Date: Fri, 15 Jul 2016 23:08:17 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Fri, 15 Jul 2016 11:27:22 Ross Burton wrote:
> The messaging FIFO is UTF-8, so decode the command as UTF-8 as well as the
> value as otherwise "bberror" != b("bberror") and none of the messages from
> shell functions are ever displayed.
> 
> Also add an else to the command parser so unhandled commands are noticed.

Thanks. Ideally this should be marked as "Fixes [YOCTO #9947]" when it gets 
merged.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

