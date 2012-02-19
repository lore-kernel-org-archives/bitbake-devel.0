Received: from mail.pbcl.net ([88.198.119.4] helo=hetzner.pbcl.net)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <philb@gnu.org>) id 1Rz2mT-00048E-H7
	for bitbake-devel@lists.openembedded.org;
	Sun, 19 Feb 2012 10:10:05 +0100
Received: from blundell.swaffham-prior.co.uk ([91.216.112.25]
	helo=[192.168.114.6])
	by hetzner.pbcl.net with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72) (envelope-from <philb@gnu.org>)
	id 1Rz2EU-00023m-B3; Sun, 19 Feb 2012 09:34:58 +0100
Message-ID: <1329640476.2591.149.camel@x121e.pbcl.net>
From: Phil Blundell <philb@gnu.org>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Date: Sun, 19 Feb 2012 08:34:36 +0000
In-Reply-To: <1329620128.7006.8.camel@ted>
References: <1329608182.4436.48.camel@ted> <1329620128.7006.8.camel@ted>
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
X-List-Received-Date: Sun, 19 Feb 2012 09:10:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-02-19 at 02:55 +0000, Richard Purdie wrote:
> The problem is then going to be memory fragmentation since whilst we can
> free the memory used by the objects, its extremely unlikely everything
> to the end of the data segment is likely to be free so sbrk() cannot be
> rolled backwards to free memory.

Sounds like it.  Have you tried running python with a lower
MMAP_THRESHOLD?

p.




