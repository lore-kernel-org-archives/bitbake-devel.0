Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1ShhZ3-0005rh-EO for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 15:36:49 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LDQ3mT022842;
	Thu, 21 Jun 2012 14:26:03 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22780-01; Thu, 21 Jun 2012 14:25:59 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LDPsuS022836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2012 14:25:55 +0100
Message-ID: <1340285156.1640.114.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Thu, 21 Jun 2012 14:25:56 +0100
In-Reply-To: <CAC1BbcSr8K79m6idqVvDDrYG1KxgrMEVwmDVb2KWZ8xrUC0Z9Q@mail.gmail.com>
References: <1340018907-8814-1-git-send-email-rep.dot.nop@gmail.com>
	<1340280968.1640.96.camel@ted>
	<CAC1BbcSr8K79m6idqVvDDrYG1KxgrMEVwmDVb2KWZ8xrUC0Z9Q@mail.gmail.com>
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
X-List-Received-Date: Thu, 21 Jun 2012 13:36:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-06-21 at 15:08 +0200, Bernhard Reutner-Fischer wrote:
> On 21 June 2012 14:16, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > On Mon, 2012-06-18 at 13:28 +0200, Bernhard Reutner-Fischer wrote:
> >> computing the md5 of a socket does not work too well.
> >>
> >> Traceback (most recent call last):
> >>   File "/scratch/src/oe/bitbake/build/lib/bb/siggen.py", line 172, in SignatureGeneratorOEBasic.get_taskhash(fn='/scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc_git.bb', task='do_fetch', deps=[], dataCache=<bb.cache.CacheData object at 0xd95890>):
> >>              if task in dataCache.file_checksums[fn]:
> >>     >            checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
> >>                  for (f,cs) in checksums:
> >>   File "/scratch/src/oe/bitbake/build/lib/bb/fetch2/__init__.py", line 627, in get_file_checksums(filelist='/scratch/src/uClibc/ /scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc-git/uClibc.machine /scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc-git/uClibc.distro', pn='uclibc'):
> >>                          fullpth = os.path.join(root, name)
> >>     >                    checksum = checksum_file(fullpth)
> >>                          if checksum:
> >>   File "/scratch/src/oe/bitbake/build/lib/bb/fetch2/__init__.py", line 605, in checksum_file(f='/scratch/src/uClibc/test/inet/socktest'):
> >>              try:
> >>     >            checksum = _checksum_cache.get_checksum(f)
> >>              except OSError as e:
> >>   File "/scratch/src/oe/bitbake/build/lib/bb/checksum.py", line 78, in FileChecksumCache.get_checksum(f='/scratch/src/uClibc/test/inet/socktest'):
> >>
> >>     >        hashval = bb.utils.md5_file(f)
> >>              self.cachedata_extras[0][f] = (cmtime, hashval)
> >>   File "/scratch/src/oe/bitbake/build/lib/bb/utils.py", line 362, in md5_file(filename='/scratch/src/uClibc/test/inet/socktest'):
> >>
> >>     >    for line in open(filename):
> >>              m.update(line)
> >> IOError: [Errno 6] No such device or address: '/scratch/src/uClibc/test/inet/socktest'
> >
> > Can you give some details on how to reproduce this? I'm guessing this is
> > due to some kind of proxy configuration?
> 
> I'm using an rsync of my local clone, like (The only change i have in
> an otherwise pristine oe-core):
> $ sed -e "/#/d;/^[[:space:]]*$/d" meta/recipes-core/uclibc/uclibc_git.bb
> require uclibc.inc
> DEFAULT_PREFERENCE = "9"
> PV = "0.9.33+git0"
> PR = "${INC_PR}.1"
> PROVIDES += "virtual/${TARGET_PREFIX}libc-for-gcc"
> FILESPATH = "${@base_set_filespath([ '${FILE_DIRNAME}/uclibc-git' ], d)}"
> SRC_URI = "file:///scratch/src/uClibc/;branch=master;protocol=rsync;rebaseable=1
> \
> 	file://uClibc.machine \
> 	file://uClibc.distro \
> 	"
> S = "${WORKDIR}/uClibc"

Ah, this makes more sense now. For what its worth, the "file://" url
handler will simply strip off everything including and after the ";" so
all it really sees is "file:///scratch/src/uClibc/" but this works since
it will just copy that directory whole.

It will then attempt to checksum everything in a file:// url which is
why it finds the socket and then fails. So your change does point at a
potentially valid issue. Paul might have a better idea on which level we
might want to fix this at?

> > What is worrying me a bit is that we shouldn't be calling the checksum
> > code for git repositories at all. Whilst this fix no doubt avoids the
> > problem, I'm worried there might be something deeper going on...
> 
> Could it be that the logic to deduce the fetcher is somehow broken?
> 
> Indeed, this was failing for me a couple of weeks ago with a similar SRC_URI.
> Back then i could not use file:///mydir;protocol=git (i.e. create a
> clone from a clone living on the local filesystem) so had to resort
> back to protocol=rsync.
> There was a socket lying around in that directory, a leftover from
> some testsuite run.

FWIW, the url you want is git:///mydir;protocol=file which should work.
As of the patches today, this also works as mirror syntax so you could
even add this in local.conf as a PREMIRROR and leave the recipe
pristine.

Cheers,

Richard







