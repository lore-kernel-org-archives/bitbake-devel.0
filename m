Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QSXRB-0005ul-CQ
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 Jun 2011 18:41:29 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 03 Jun 2011 09:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,315,1304319600"; 
   d="scan'208";a="9014205"
Received: from unknown (HELO [10.255.12.196]) ([10.255.12.196])
	by orsmga001.jf.intel.com with ESMTP; 03 Jun 2011 09:38:12 -0700
From: Joshua Lock <josh@linux.intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 03 Jun 2011 09:38:06 -0700
In-Reply-To: <201106031051.12212.paul.eggleton@linux.intel.com>
References: <cover.1306947210.git.paul.eggleton@linux.intel.com>
	<1cd9d0b284c1cd1966b0c2c1ea9fbad15c5ed5fc.1306947210.git.paul.eggleton@linux.intel.com>
	<1307044917.2050.15.camel@scimitar>
	<201106031051.12212.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.0.1 (3.0.1-1.fc15) 
Message-ID: <1307119092.2042.13.camel@scimitar>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/2] bitbake: track skipped packages
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
X-List-Received-Date: Fri, 03 Jun 2011 16:41:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-06-03 at 10:51 +0100, Paul Eggleton wrote:
> On Thursday 02 June 2011 21:01:52 Joshua Lock wrote:
> > This doesn't seem very Pythonic. I think you should just be able to do:
> > bb.data.setVar("__SKIPPED", e, d)
> > or possibly:
> > bb.data.setVar("__SKIPPED", str(e), d)
> 
> Why is accessing args[0] un-Pythonic? As I understand it, args is provided 
> (and documented) as the way to get access to the arguments to the exception, 
> and the first argument is being used by us for the reason in the case of 
> SkipPackage. At the moment e or str(e) will accomplish the same thing, but 
> were we to add another argument then it seems to me that the results would be 
> different.
> 
> Now I'm not a Python expert by any stretch of the imagination but I'd like to 
> understand the reason why this usage might be considered undesirable.
> 

Caveat: also not a Python expert!

I raised the comment as it's a pattern I've not seen often in Python
code I've interacted with. Therefore it stood out/didn't look quite
right.

You are correct that if another argument were added the results would be
different: "If str() or unicode() is called on an instance of this
class, the representation of the argument(s) to the instance are
returned, or the empty string when there were no arguments."
http://docs.python.org/library/exceptions.htm

Happy to retract my nit picking,
Joshua
-- 
Joshua Lock
        Yocto Build System Monkey
        Intel Open Source Technology Centre



