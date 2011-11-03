Received: from vms173001pub.verizon.net ([206.46.173.1])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <denis@denix.org>) id 1RLmFT-0006sS-TR
	for bitbake-devel@lists.openembedded.org;
	Thu, 03 Nov 2011 02:37:44 +0100
Received: from gandalf.denix.org ([unknown] [96.240.135.93])
	by vms173001.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0LU200JN66RFNUZ0@vms173001.mailsrvcs.net> for
	bitbake-devel@lists.openembedded.org;
	Wed, 02 Nov 2011 19:30:56 -0500 (CDT)
Received: by gandalf.denix.org (Postfix, from userid 1000)	id DEF7414AF5D; Wed,
	02 Nov 2011 20:30:50 -0400 (EDT)
Date: Wed, 02 Nov 2011 20:30:50 -0400
From: Denys Dmytriyenko <denis@denix.org>
To: Daniel Lazzari <dlazzari@leapfrog.com>
Message-id: <20111103003050.GZ15391@denix.org>
References: <E7A9054A5ACABE48B0E540E46E862B0F042412CE@NAEMMAIL01.na.leapfrog.com>
MIME-version: 1.0
In-reply-to: <E7A9054A5ACABE48B0E540E46E862B0F042412CE@NAEMMAIL01.na.leapfrog.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Cc: "'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Bug with task variable overrides
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
X-List-Received-Date: Thu, 03 Nov 2011 01:37:44 -0000
Content-type: text/plain; charset=us-ascii
Content-disposition: inline

On Wed, Nov 02, 2011 at 10:54:31PM +0000, Daniel Lazzari wrote:
> I recently tried to use per task overrides for several variables and ran 
> into a bug. If the task name has an underscore in it, the overrides won't 
> work properly. Here's a quick test case I did using Angstrom oe-core:
> 
> MYVAR = "apples"
> MYVAR_task-my_task = "oranges"
> 
> LICENSE = ""
> 
> do_my_task() {
>                 echo ${MYVAR}
> }
> 
> addtask my_task before do_fetch
> 
> After running the task, the log for the task shows "apples" when it should 
> show "oranges". My work around so far is not to use underscores in my task 
> name, but that makes the task name look pretty unreadable. I tried to see if 
> I could figure out a quick fix but the data_smart stuff looks pretty 
> complicated and I don't have a lot of time to spend on this. If there's a 
> place where you want me to file a proper bug report, just let me know.

Daniel,

As far as I know, it's a known limitation and was there for many years. It's 
not straightforward to parse override names with underscores, as you can 
combine multiple overrides, plus there are additional keywords like append and 
prepend, that are used the same way. E.g. MYVAR_append_distro_arch_soc_mach_pn.
It's recommended to use dashes instead of underscores for variable values, 
such as DISTRO="angstrom-2010.x", MACHINE="am37x-evm", PN="linux-libc-headers" 
etc., so they are safe to use as overrides. Not with task/function names, 
though.

-- 
Denys


