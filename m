Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>)
	id 1R8rGg-0008KK-K1; Wed, 28 Sep 2011 12:21:36 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 28 Sep 2011 03:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,454,1312182000"; d="scan'208";a="68222735"
Received: from unknown (HELO helios.localnet) ([10.252.120.175])
	by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2011 03:16:01 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Dmitry Eremin-Solenikov" <dbaryshkov@gmail.com>
Date: Wed, 28 Sep 2011 11:16:00 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic-pae; KDE/4.6.2; i686; ; )
References: <CALT56yN5hXMLBhHVLKyHbNb=7WDb3pZUB0Q+HNKc-2t+g6M58A@mail.gmail.com>
In-Reply-To: <CALT56yN5hXMLBhHVLKyHbNb=7WDb3pZUB0Q+HNKc-2t+g6M58A@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201109281116.00890.paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] meta-micro problems
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 28 Sep 2011 10:21:36 -0000
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On Friday 16 September 2011 19:17:17 Dmitry Eremin-Solenikov wrote:
> While trying to use a meta-micro, I've stumbled upon a problem.
> Each run, bitbake keeps running all tasks over and over. Sometimes
> this leads to failures (http://bugs.lumag.spb.ru/show_bug.cgi?id=33).
> Sometimes it doesn't. I've narrowed a simple test case. Attached
> the log of one of the executions of bitbake quilt-native. stamps dir
> has all necessary stamps, but tasks keep being executed over and over.
> 
> Layers enabled:
> meta-micro
> meta-handhelds
> meta-opie
> openembedded-core/meta

Did you manage to figure out the cause of this? Does it still happen when meta-
opie is removed? It would be useful to try to narrow down what causes the 
problem as I'd be surprised if all of these layers need to be present to 
trigger the bug.

Also, did you not have the meta-oe layer enabled? Both meta-opie and meta-
handheld normally require it...

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


