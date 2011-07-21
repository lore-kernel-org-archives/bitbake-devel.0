Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qk0ll-0003uo-R8 for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 23:26:57 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6LLMoId007472;
	Thu, 21 Jul 2011 22:22:50 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04336-06; Thu, 21 Jul 2011 22:22:46 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6LLMgrY007466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jul 2011 22:22:42 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1311028023.git.josh@linux.intel.com>
References: <cover.1311028023.git.josh@linux.intel.com>
Date: Thu, 21 Jul 2011 22:22:39 +0100
Message-ID: <1311283359.2344.87.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 0/1] Save the initial environment
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
X-List-Received-Date: Thu, 21 Jul 2011 21:26:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-07-18 at 15:33 -0700, Joshua Lock wrote:
> Both Chris' terminal work and my reparse command will benefit from a saved
> copy of the initial enviornment. The Python docs indicate that the os.environ
> map is captured when the os module is first imported
> http://docs.python.org/library/os.html#os.environ) so this patch adds a
> variable to the bb namespace (bb.initial_environ) that is an early copy of
> the environment.
> 
> I put the variable here so that a) it's easily accessible and b) we can take
> the copy pretty early on.
> 
> Any thoughts on this? Note the RFC prefix. :-)

Sorry I didn't reply earlier.

I'd really this the environment storage to be something we do explicitly
in bin/bitbake alongside:

    # Clear away any spurious environment variables. But don't wipe the
    # environment totally. This is necessary to ensure the correct operation
    # of the UIs (e.g. for DISPLAY, etc.)
    bb.utils.clean_environment()

I'd suggest we create a copy there, then pass it into cooker and its
cooker which actually stores the copy for future reference. We may then
need to find a way to get to that at the metadata level and from the UIs
but what shouldn't be too difficult.

Cheers,

Richard



