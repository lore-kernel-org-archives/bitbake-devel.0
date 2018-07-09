Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by mail.openembedded.org (Postfix) with ESMTP id D9913744DA
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Jul 2018 15:53:14 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Jul 2018 08:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; d="scan'208";a="55117096"
Received: from pcolalon-mobl.ger.corp.intel.com (HELO localhost.localdomain)
	([10.252.36.118])
	by orsmga007.jf.intel.com with ESMTP; 09 Jul 2018 08:53:10 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 09 Jul 2018 17:53:09 +0200
Message-ID: <13922122.yNMeuHNp9m@localhost.localdomain>
Organization: Intel Corporation
In-Reply-To: <20180706154200.28769-4-JPEWhacker@gmail.com>
References: <20180706154200.28769-1-JPEWhacker@gmail.com>
	<20180706154200.28769-4-JPEWhacker@gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] runqueue: Stop on first unsatisfied dependency
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
X-List-Received-Date: Mon, 09 Jul 2018 15:53:15 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Joshua

On Friday, 6 July 2018 5:42:00 PM CEST Joshua Watt wrote:
> runqueue: Stop on first unsatisfied dependency

Richard merged this already, but for future non-trivial patches could you 
please include a commit message that explains the change (particularly why the 
change is being made, rather than just restating what's been changed).

Thanks,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre



