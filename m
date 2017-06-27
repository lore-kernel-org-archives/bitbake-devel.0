Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 20F61771F5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 13:56:12 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 Jun 2017 06:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,399,1493708400"; d="scan'208";a="1145259760"
Received: from peggleto-mobl.ger.corp.intel.com ([10.103.239.203])
	by orsmga001.jf.intel.com with ESMTP; 27 Jun 2017 06:56:11 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jun 2017 14:56:11 +0100
Message-ID: <17430793.JkPLF4SjTM@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <CAGAhMBywmKF1GnYYsMEDoLLWJLivMrC7AmtMPh2wT6ju7RKgdQ@mail.gmail.com>
References: <CAGAhMBywmKF1GnYYsMEDoLLWJLivMrC7AmtMPh2wT6ju7RKgdQ@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake : Paginate 'bitbake -e' using less.
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
X-List-Received-Date: Tue, 27 Jun 2017 13:56:13 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 26 June 2017 10:02:20 PM BST Rob Woolley wrote:
> Feel free to grab pieces from here, if you find it useful:
> https://patchwork.openembedded.org/patch/89543/
> 
> I based it on the same logic used by git to determine whether the user had
> a pager set already and whether or not the output was going to the terminal
> or being piped to another process.
> 
> The feedback I got was that the functionality wasn't needed and users could
> just pipe it to less if they wanted a pager:
> http://lists.openembedded.org/pipermail/bitbake-devel/2015-March/005545.html

FWIW I like this feature of git and would very much like to see it implemented 
for bitbake -e.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

