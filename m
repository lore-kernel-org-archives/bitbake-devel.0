Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>)
	id 1R8uLC-0005vu-Sr; Wed, 28 Sep 2011 15:38:27 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 28 Sep 2011 06:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="57540815"
Received: from unknown (HELO helios.localnet) ([10.252.120.159])
	by orsmga002.jf.intel.com with ESMTP; 28 Sep 2011 06:32:58 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Dmitry Eremin-Solenikov" <dbaryshkov@gmail.com>
Date: Wed, 28 Sep 2011 14:32:57 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic-pae; KDE/4.6.2; i686; ; )
References: <CALT56yN5hXMLBhHVLKyHbNb=7WDb3pZUB0Q+HNKc-2t+g6M58A@mail.gmail.com>
	<201109281116.00890.paul.eggleton@linux.intel.com>
	<4E831868.4090603@gmail.com>
In-Reply-To: <4E831868.4090603@gmail.com>
MIME-Version: 1.0
Message-Id: <201109281432.57331.paul.eggleton@linux.intel.com>
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
X-List-Received-Date: Wed, 28 Sep 2011 13:38:27 -0000
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Wednesday 28 September 2011 13:51:52 Dmitry Eremin-Solenikov wrote:
> If you wish, I can retry this with smaller layer set. But if the bug
> will still arise, I simply have no knowledge/time to look deeper into bb
> without additional input/pointers from bb gurus.

That's OK, I can spend time looking into it. It sounds like a bug in bitbake 
if metadata can influence it to behave this way. If we can produce a simplified 
test case I think it will be easier to fix.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


