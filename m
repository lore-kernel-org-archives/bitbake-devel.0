Return-Path: <amit.k.chaudhuri@gmail.com>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
	[209.85.220.171])
	by mail.openembedded.org (Postfix) with ESMTP id DF1A760889
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 29 Jun 2014 09:17:16 +0000 (UTC)
Received: by mail-vc0-f171.google.com with SMTP id id10so6510293vcb.30
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 29 Jun 2014 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=WRIWjtrsdv6is+s9b5kRExowl6hzsUVUPOotNQl1DU8=;
	b=B1pn//AxaLGgVZ/8X6hVPbVFVtupnyVa/Kk0FT0n0fqBtjjPNFCPmaR43u7n1TEM+k
	aRVNh32Lig5efTkMjRtokYQQkIvE56W0aRf7UHSgbn9rmFWbPn5O+bS6EsEnntNedicc
	HHnU6ma40epDfucM4nazIAZKA1T7bHQxkCoyMEmnHkyvLhce3+zsEdgNDH8moRVw5Xsp
	bdMs/86D0q+PBtZJAgsWsZsSsOhKHh6hS6W8XMbEuHS1kvSWBEzSHB6p+uas//6N9V4Q
	4BKoRz4BS01E9fUMQVa0RUikjAoMKeQ9AdYJlhbb7aXWVFlzYrqgVJHqOb5LfNmLwt+3
	0tfw==
MIME-Version: 1.0
X-Received: by 10.220.53.72 with SMTP id l8mr31426867vcg.16.1404033437687;
	Sun, 29 Jun 2014 02:17:17 -0700 (PDT)
Received: by 10.58.46.193 with HTTP; Sun, 29 Jun 2014 02:17:17 -0700 (PDT)
Date: Sun, 29 Jun 2014 10:17:17 +0100
Message-ID: <CAH=VbNfK1qPSY3bBK-T4S9PheUj-P+KLRZMS6ewWGZxkpET5JA@mail.gmail.com>
From: Amit Chaudhuri <amit.k.chaudhuri@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: AttributeError: 'SignatureGenerator' object has no attribute 'file_checksum_values'
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 29 Jun 2014 09:17:18 -0000
Content-Type: text/plain; charset=UTF-8

Hi all,

I am following the "Hello World" example from
yoctoproject.org/docs/1.6/bitbake-user-manual/bitbake-user-manual.html#the-hello-world-example.

I have sourced the oe-init-build-env script.

I get an error message when trying to execute the bitbake printhello
command from my project dir.  Command and output here:

amit@linux-erag:~/hello> bitbake printhello
Parsing recipes: 100%
|##############################################################################################|
Time: 00:00:00
Parsing of 1 .bb files complete (0 cached, 1 parsed). 1 targets, 0
skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies
NOTE: Preparing runqueue
ERROR: An uncaught exception occured in runqueue, please see the failure below:
ERROR: Running idle function
Traceback (most recent call last):
  File "/home/amit/poky/bitbake/lib/bb/cooker.py", line 1169, in
buildTargetsIdle(server=<ProcessServer(ProcessServer-2, started)>,
rq=<bb.runqueue.RunQueue instance at 0x1941050>, abort=False):
                 try:
    >                retval = rq.execute_runqueue()
                 except runqueue.TaskFailure as exc:
  File "/home/amit/poky/bitbake/lib/bb/runqueue.py", line 1065, in
RunQueue.execute_runqueue():
             try:
    >            return self._execute_runqueue()
             except bb.runqueue.TaskFailure:
  File "/home/amit/poky/bitbake/lib/bb/runqueue.py", line 1020, in
RunQueue._execute_runqueue():
                 else:
    >                self.start_worker()
                     self.rqexe = RunQueueExecuteScenequeue(self)
  File "/home/amit/poky/bitbake/lib/bb/runqueue.py", line 898, in
RunQueue.start_worker():
                 self.teardown_workers()
    >        self.worker, self.workerpipe = self._start_worker()

  File "/home/amit/poky/bitbake/lib/bb/runqueue.py", line 864, in
RunQueue._start_worker(fakeroot=False, rqexec=None):
                 "hash_deps" : self.rqdata.hash_deps,
    >            "sigchecksums" : bb.parse.siggen.file_checksum_values,
                 "runq_hash" : self.rqdata.runq_hash,
AttributeError: 'SignatureGenerator' object has no attribute
'file_checksum_values'

NOTE: Tasks Summary: Attempted 0 tasks of which 0 didn't need to be
rerun and all succeeded.

Summary: There were 2 ERROR messages shown, returning a non-zero exit code.

Bitbake version is:

BitBake Build Tool Core version 1.20.0, bitbake version 1.20.0

OS details:

cat /etc/os-release
NAME=openSUSE
VERSION="13.1 (Bottle)"
VERSION_ID="13.1"
PRETTY_NAME="openSUSE 13.1 (Bottle) (x86_64)"
ID=opensuse
ANSI_COLOR="0;32"
CPE_NAME="cpe:/o:opensuse:opensuse:13.1"
BUG_REPORT_URL="https://bugs.opensuse.org"
HOME_URL="https://opensuse.org/"
ID_LIKE="suse"

The only difference I can see between example and my attempt is the
layer name (testlayer vs mylayer) and I've checked that I am being
consistent.

The error message suggests to me that there's a versioning problem on
the SignatureGenerator.

Can anyone point me in the right direction here?
Happy to provide additional info (e.g. strace).

Regards,
Amit

