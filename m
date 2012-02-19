Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Rz91s-0000ro-F7; Sun, 19 Feb 2012 16:50:24 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1JFg8eX024429;
	Sun, 19 Feb 2012 15:42:08 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 24165-01; Sun, 19 Feb 2012 15:42:04 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1JFfvED024423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 19 Feb 2012 15:41:59 GMT
Message-ID: <1329666117.7006.23.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Date: Sun, 19 Feb 2012 15:41:57 +0000
In-Reply-To: <1329640476.2591.149.camel@x121e.pbcl.net>
References: <1329608182.4436.48.camel@ted> <1329620128.7006.8.camel@ted>
	<1329640476.2591.149.camel@x121e.pbcl.net>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] Bitbake Memory Usage
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
X-List-Received-Date: Sun, 19 Feb 2012 15:50:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-02-19 at 08:34 +0000, Phil Blundell wrote:
> On Sun, 2012-02-19 at 02:55 +0000, Richard Purdie wrote:
> > The problem is then going to be memory fragmentation since whilst we can
> > free the memory used by the objects, its extremely unlikely everything
> > to the end of the data segment is likely to be free so sbrk() cannot be
> > rolled backwards to free memory.
> 
> Sounds like it.  Have you tried running python with a lower
> MMAP_THRESHOLD?

I just did (to 4k) and it drops the overall RSS from 150M to 143M but
otherwise no significant difference. For the record in the archives, the
rather nasty hacky code I used was:

from ctypes import *
cdll.LoadLibrary("libc.so.6") 
libc = CDLL("libc.so.6") 
print libc.mallopt(-3, 4*1024)

I just looked at the caches in question again and I now suspect the
strings are under the 256b limit, I was thinking the data was slightly
different.

If that is the case, it means the memory is being returned to python's
pool allocator. Unfortunately that will suffer the same fragmentation
problem described above.

Either way, I'm pretty sure memory fragmentation is the problem here.
One solution we might consider putting the codeparser into a separate
process accessed over a socket. At the (mostly) face to face TSC meeting
earlier in the week I did briefly touch on the future with bitbake. I'm
planning to summarise this on the mailing list when I get a chance but
one of the ideas discussed was putting the data store into a separate
process accessed over sockets as a solution to some of the memory use
issues. There are problems with this such as the anonymous python
functions and where in the system these would run but its certainly
worth thinking along those lines. It would solve some of the nasty cache
issues we currently have with the interaction between multiple parsing
threads and the codeparser cache needing to get "merged" at the end of
parsing.

Cheers,

Richard



