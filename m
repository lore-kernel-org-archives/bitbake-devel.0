Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1ShgTU-0001ds-8c for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 14:27:00 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LCGDlD022112;
	Thu, 21 Jun 2012 13:16:13 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 21414-07; Thu, 21 Jun 2012 13:16:09 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LCG5Tc022106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2012 13:16:06 +0100
Message-ID: <1340280968.1640.96.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Thu, 21 Jun 2012 13:16:08 +0100
In-Reply-To: <1340018907-8814-1-git-send-email-rep.dot.nop@gmail.com>
References: <1340018907-8814-1-git-send-email-rep.dot.nop@gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: do not try to checksum a socket
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
X-List-Received-Date: Thu, 21 Jun 2012 12:27:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-06-18 at 13:28 +0200, Bernhard Reutner-Fischer wrote:
> computing the md5 of a socket does not work too well.
> 
> Traceback (most recent call last):
>   File "/scratch/src/oe/bitbake/build/lib/bb/siggen.py", line 172, in SignatureGeneratorOEBasic.get_taskhash(fn='/scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc_git.bb', task='do_fetch', deps=[], dataCache=<bb.cache.CacheData object at 0xd95890>):
>              if task in dataCache.file_checksums[fn]:
>     >            checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
>                  for (f,cs) in checksums:
>   File "/scratch/src/oe/bitbake/build/lib/bb/fetch2/__init__.py", line 627, in get_file_checksums(filelist='/scratch/src/uClibc/ /scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc-git/uClibc.machine /scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc-git/uClibc.distro', pn='uclibc'):
>                          fullpth = os.path.join(root, name)
>     >                    checksum = checksum_file(fullpth)
>                          if checksum:
>   File "/scratch/src/oe/bitbake/build/lib/bb/fetch2/__init__.py", line 605, in checksum_file(f='/scratch/src/uClibc/test/inet/socktest'):
>              try:
>     >            checksum = _checksum_cache.get_checksum(f)
>              except OSError as e:
>   File "/scratch/src/oe/bitbake/build/lib/bb/checksum.py", line 78, in FileChecksumCache.get_checksum(f='/scratch/src/uClibc/test/inet/socktest'):
> 
>     >        hashval = bb.utils.md5_file(f)
>              self.cachedata_extras[0][f] = (cmtime, hashval)
>   File "/scratch/src/oe/bitbake/build/lib/bb/utils.py", line 362, in md5_file(filename='/scratch/src/uClibc/test/inet/socktest'):
> 
>     >    for line in open(filename):
>              m.update(line)
> IOError: [Errno 6] No such device or address: '/scratch/src/uClibc/test/inet/socktest'

Can you give some details on how to reproduce this? I'm guessing this is
due to some kind of proxy configuration?

What is worrying me a bit is that we shouldn't be calling the checksum
code for git repositories at all. Whilst this fix no doubt avoids the
problem, I'm worried there might be something deeper going on...

Cheers,

Richard

> Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
> ---
>  lib/bb/fetch2/__init__.py |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 324eef2..0c0d60d 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -601,6 +601,7 @@ def get_file_checksums(filelist, pn):
>      """
>  
>      def checksum_file(f):
> +        if not os.path.isfile(f): return None
>          try:
>              checksum = _checksum_cache.get_checksum(f)
>          except OSError as e:




