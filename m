Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qk1T5-0002Yk-5G
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 00:11:43 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Jul 2011 15:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,244,1309762800"; d="scan'208";a="28727959"
Received: from vorpal.jf.intel.com (HELO [10.7.199.57]) ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 21 Jul 2011 15:07:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Thu, 21 Jul 2011 15:12:02 -0700
In-Reply-To: <1311283359.2344.87.camel@rex>
References: <cover.1311028023.git.josh@linux.intel.com>
	<1311283359.2344.87.camel@rex>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1311286322.2172.13.camel@vorpal.jf.intel.com>
Mime-Version: 1.0
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
X-List-Received-Date: Thu, 21 Jul 2011 22:11:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-07-21 at 22:22 +0100, Richard Purdie wrote:
> On Mon, 2011-07-18 at 15:33 -0700, Joshua Lock wrote:
> > Both Chris' terminal work and my reparse command will benefit from a saved
> > copy of the initial enviornment. The Python docs indicate that the os.environ
> > map is captured when the os module is first imported
> > http://docs.python.org/library/os.html#os.environ) so this patch adds a
> > variable to the bb namespace (bb.initial_environ) that is an early copy of
> > the environment.
> > 
> > I put the variable here so that a) it's easily accessible and b) we can take
> > the copy pretty early on.
> > 
> > Any thoughts on this? Note the RFC prefix. :-)
> 
> Sorry I didn't reply earlier.

No problem.

> I'd really this the environment storage to be something we do explicitly
> in bin/bitbake alongside:
> 
>     # Clear away any spurious environment variables. But don't wipe the
>     # environment totally. This is necessary to ensure the correct operation
>     # of the UIs (e.g. for DISPLAY, etc.)
>     bb.utils.clean_environment()
> 
> I'd suggest we create a copy there, then pass it into cooker and its
> cooker which actually stores the copy for future reference. We may then
> need to find a way to get to that at the metadata level and from the UIs
> but what shouldn't be too difficult.

Ah yes, that feels much nicer than doing it implicitly in the library.
Expect a v2 RFC shortly (probably in your inbox tomorrow morning ;-))

Thanks,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes Factotum"
        Intel Open Source Technology Centre



