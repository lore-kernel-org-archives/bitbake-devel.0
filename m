Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QrexR-00069w-2q for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 01:46:37 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7BNg3k7003051;
	Fri, 12 Aug 2011 00:42:03 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02427-05; Fri, 12 Aug 2011 00:41:59 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7BNfunW003045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Aug 2011 00:41:56 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <1313103490.2506.2.camel@vorpal.jf.intel.com>
References: <cover.1313025215.git.josh@linux.intel.com>
	<1313103490.2506.2.camel@vorpal.jf.intel.com>
Date: Fri, 12 Aug 2011 00:41:18 +0100
Message-ID: <1313106078.14274.476.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/4] Bug fixing and code clarity
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
X-List-Received-Date: Thu, 11 Aug 2011 23:46:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-08-11 at 15:58 -0700, Joshua Lock wrote:
> On Wed, 2011-08-10 at 18:19 -0700, Joshua Lock wrote:
> > The following series addresses some thinko/typo's I'd introduced to hob, by
> > using variable names which are too similar, as well as adding some changes
> > to increase clarity in various places.
> 
> This series rolled into a new series submitted just now, please ignore
> this series.

I've actually already merged this series. Was there any change in the
newer version I should be looking for?

Cheers,

Richard



