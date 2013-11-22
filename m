Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 98C9D6CDCB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2013 11:10:58 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Nov 2013 03:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,751,1378882800"; d="scan'208";a="439803139"
Received: from pauljbro-mobl.ger.corp.intel.com (HELO helios.localnet)
	([10.252.121.218])
	by orsmga002.jf.intel.com with ESMTP; 22 Nov 2013 03:10:57 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Udayan Bapat <uvbapat@gmail.com>
Date: Fri, 22 Nov 2013 11:10:56 +0000
Message-ID: <5269384.W1q6ZNh2rT@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-31-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <CAJ7NSKpQnuc9gco8UnrMxoJ7=5TQbCtu9bkzhobxnuB6WzM3jg@mail.gmail.com>
References: <CAJ7NSKpQnuc9gco8UnrMxoJ7=5TQbCtu9bkzhobxnuB6WzM3jg@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Doing 'oerunmake configure' verses just 'configure'
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
X-List-Received-Date: Fri, 22 Nov 2013 11:10:59 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Udayan,

On Thursday 21 November 2013 10:45:02 Udayan Bapat wrote:
> I am trying to build a custom recipe that heavily relies on autotools. Due
> to some hierarchy (one package building other), I am not able to call
> 'oe_runmake configure' and 'oe_runmake make' directly from the .bb file.
> Instead I manually cd into that directory and then issue ./configure
> followed by 'make'

This is a question for the openembedded-core mailing list since it is specific 
to OpenEmbedded.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

