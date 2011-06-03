Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QSR6J-0004Ky-D1
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 Jun 2011 11:55:32 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 03 Jun 2011 02:51:13 -0700
X-ExtLoop1: 1
Received: from unknown (HELO helios.localnet) ([10.255.12.215])
	by orsmga002.jf.intel.com with ESMTP; 03 Jun 2011 02:51:13 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org,
 Joshua Lock <josh@linux.intel.com>
Date: Fri, 3 Jun 2011 10:51:12 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic-pae; KDE/4.6.2; i686; ; )
References: <cover.1306947210.git.paul.eggleton@linux.intel.com>
	<1cd9d0b284c1cd1966b0c2c1ea9fbad15c5ed5fc.1306947210.git.paul.eggleton@linux.intel.com>
	<1307044917.2050.15.camel@scimitar>
In-Reply-To: <1307044917.2050.15.camel@scimitar>
MIME-Version: 1.0
Message-Id: <201106031051.12212.paul.eggleton@linux.intel.com>
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
X-List-Received-Date: Fri, 03 Jun 2011 09:55:32 -0000
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 02 June 2011 21:01:52 Joshua Lock wrote:
> This doesn't seem very Pythonic. I think you should just be able to do:
> bb.data.setVar("__SKIPPED", e, d)
> or possibly:
> bb.data.setVar("__SKIPPED", str(e), d)

Why is accessing args[0] un-Pythonic? As I understand it, args is provided 
(and documented) as the way to get access to the arguments to the exception, 
and the first argument is being used by us for the reason in the case of 
SkipPackage. At the moment e or str(e) will accomplish the same thing, but 
were we to add another argument then it seems to me that the results would be 
different.

Now I'm not a Python expert by any stretch of the imagination but I'd like to 
understand the reason why this usage might be considered undesirable.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


