Received: from mail.pbcl.net ([88.198.119.4] helo=hetzner.pbcl.net)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <philb@gnu.org>)
	id 1Rz9Ni-0001jS-IQ; Sun, 19 Feb 2012 17:12:59 +0100
Received: from blundell.swaffham-prior.co.uk ([91.216.112.25]
	helo=[192.168.114.6])
	by hetzner.pbcl.net with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72) (envelope-from <philb@gnu.org>)
	id 1Rz9Fk-0002OF-25; Sun, 19 Feb 2012 17:04:44 +0100
Message-ID: <1329667462.2591.153.camel@x121e.pbcl.net>
From: Phil Blundell <philb@gnu.org>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Date: Sun, 19 Feb 2012 16:04:22 +0000
In-Reply-To: <1329666117.7006.23.camel@ted>
References: <1329608182.4436.48.camel@ted> <1329620128.7006.8.camel@ted>
	<1329640476.2591.149.camel@x121e.pbcl.net>
	<1329666117.7006.23.camel@ted>
X-Mailer: Evolution 3.2.2-1 
Mime-Version: 1.0
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
X-List-Received-Date: Sun, 19 Feb 2012 16:12:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-02-19 at 15:41 +0000, Richard Purdie wrote:
> I just did (to 4k) and it drops the overall RSS from 150M to 143M but
> otherwise no significant difference. For the record in the archives, the
> rather nasty hacky code I used was:
> 
> from ctypes import *
> cdll.LoadLibrary("libc.so.6") 
> libc = CDLL("libc.so.6") 
> print libc.mallopt(-3, 4*1024)

FWIW, you can just say "export MALLOC_THRESHOLD=4096" before running
bitbake, which should achieve roughly the same thing with slightly less
typing. 

> I just looked at the caches in question again and I now suspect the
> strings are under the 256b limit, I was thinking the data was slightly
> different.
> 
> If that is the case, it means the memory is being returned to python's
> pool allocator. Unfortunately that will suffer the same fragmentation
> problem described above.

Yeah.  I guess it would be possible to make the pool allocator smarter
to cut down on or ameliorate the fragmentation.  But I don't know
whether that is feasible/straightforward without patching Python itself.
Some further investigation required I suppose.

p.




