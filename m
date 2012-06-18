Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rep.dot.nop@gmail.com>) id 1SgaI2-0007pV-By
	for bitbake-devel@lists.openembedded.org;
	Mon, 18 Jun 2012 13:38:38 +0200
Received: by wgbdr1 with SMTP id dr1so4645779wgb.24
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jun 2012 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=kvvKD7wY+wkSMEbSb0rDjhe53hxnHQMasD66Cx4NrbU=;
	b=DApgGC+0TfEpFi+TXn5kY7C6+PJ+EXa28eiVVJcazMydKBIrSELfbbHOc+aO6sNB8q
	pHgyd54ykBkxDy58iuhDAN8Jn0bdJ0neTMC9/gSXC/+iThehITCjOBUzPpqMWgOQQwUQ
	MaFGfDFb4P+Swqh8pJmLExIrVMdVJPGaB+CtpgO8HvInSYGv18dU4YZjmX/LDVAseEuR
	DhDs8Twgk9ooUdDIzvxmi6gv+KyqKjD+KVP7/CqnbrCsMBoly6mb0fX091tPBlCSehhU
	oJ58rvqr93/Jj5Z4Rsbgaf07k4XYuh1HUVeX0A17LHyrdkErFyt8W5FeTxaDrzzQtmSx
	RQ4g==
MIME-Version: 1.0
Received: by 10.180.92.65 with SMTP id ck1mr23392356wib.14.1340018876363; Mon,
	18 Jun 2012 04:27:56 -0700 (PDT)
Received: by 10.216.234.92 with HTTP; Mon, 18 Jun 2012 04:27:56 -0700 (PDT)
Date: Mon, 18 Jun 2012 13:27:56 +0200
Message-ID: <CAC1BbcQxj0ibOuwejR67UVR7VHV0AVpxRbnY97qrCsYcde4yNw@mail.gmail.com>
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: failures with current master
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
X-List-Received-Date: Mon, 18 Jun 2012 11:38:38 -0000
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Trying to use bitbake master to bake me oe-core master (using v1.15.2
works i think).

1) checksum error (for socket)
$ ls -ltn /scratch/src/uClibc/test/inet/socktest
srwxr-xr-x 1 1000 1000 0 Jun 16 14:44 /scratch/src/uClibc/test/inet/socktest

ERROR: Running idle function
Traceback (most recent call last):
  File "/scratch/src/oe/bitbake/build/lib/bb/siggen.py", line 172, in
SignatureGeneratorOEBasic.get_taskhash(fn='/scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc_git.bb',
task='do_fetch', deps=[], dataCache=<bb.cache.CacheData object at
0xd95890>):
             if task in dataCache.file_checksums[fn]:
    >            checksums =
bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task],
recipename)
                 for (f,cs) in checksums:
  File "/scratch/src/oe/bitbake/build/lib/bb/fetch2/__init__.py", line
627, in get_file_checksums(filelist='/scratch/src/uClibc/
/scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc-git/uClibc.machine
/scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc-git/uClibc.distro',
pn='uclibc'):
                         fullpth = os.path.join(root, name)
    >                    checksum = checksum_file(fullpth)
                         if checksum:
  File "/scratch/src/oe/bitbake/build/lib/bb/fetch2/__init__.py", line
605, in checksum_file(f='/scratch/src/uClibc/test/inet/socktest'):
             try:
    >            checksum = _checksum_cache.get_checksum(f)
             except OSError as e:
  File "/scratch/src/oe/bitbake/build/lib/bb/checksum.py", line 78, in
FileChecksumCache.get_checksum(f='/scratch/src/uClibc/test/inet/socktest'):

    >        hashval = bb.utils.md5_file(f)
             self.cachedata_extras[0][f] = (cmtime, hashval)
  File "/scratch/src/oe/bitbake/build/lib/bb/utils.py", line 362, in
md5_file(filename='/scratch/src/uClibc/test/inet/socktest'):

    >    for line in open(filename):
             m.update(line)
IOError: [Errno 6] No such device or address:
'/scratch/src/uClibc/test/inet/socktest'

NOTE: Preparing runqueue
ERROR: Running idle function
Traceback (most recent call last):
  File "/scratch/src/oe/bitbake/build/lib/bb/server/process.py", line
122, in ProcessServer.idle_commands(delay=0.1):
                 try:
    >                retval = function(self, data, False)
                     if retval is False:
  File "/scratch/src/oe/bitbake/build/lib/bb/cooker.py", line 1134, in
buildTargetsIdle(server=<ProcessServer(ProcessServer-1, started)>,
rq=<bb.runqueue.RunQueue instance at 0xab73758>, abort=False):
                 try:
    >                retval = rq.execute_runqueue()
                 except runqueue.TaskFailure as exc:
  File "/scratch/src/oe/bitbake/build/lib/bb/runqueue.py", line 862,
in RunQueue.execute_runqueue():
                 self.rqexe = RunQueueExecuteDummy(self)
    >            if self.rqdata.prepare() == 0:
                     self.state = runQueueComplete
  File "/scratch/src/oe/bitbake/build/lib/bb/runqueue.py", line 541,
in RunQueueData.prepare():
             for task in xrange(len(self.runq_fnid)):
    >            if len(runq_recrdepends[task]) > 0:
                     taskfnid = self.runq_fnid[task]
IndexError: list index out of range

NOTE: Preparing runqueue


