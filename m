Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id B173B6059A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Jun 2014 03:38:13 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s5U3cCqS015887
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 29 Jun 2014 20:38:12 -0700 (PDT)
Received: from [128.224.162.181] (128.224.162.181) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.174.1;
	Sun, 29 Jun 2014 20:38:11 -0700
Message-ID: <53B0DBA2.3010307@windriver.com>
Date: Mon, 30 Jun 2014 11:38:10 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Amit Chaudhuri <amit.k.chaudhuri@gmail.com>,
	<bitbake-devel@lists.openembedded.org>
References: <CAH=VbNfK1qPSY3bBK-T4S9PheUj-P+KLRZMS6ewWGZxkpET5JA@mail.gmail.com>
In-Reply-To: <CAH=VbNfK1qPSY3bBK-T4S9PheUj-P+KLRZMS6ewWGZxkpET5JA@mail.gmail.com>
Subject: Re: AttributeError: 'SignatureGenerator' object has no attribute 'file_checksum_values'
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
X-List-Received-Date: Mon, 30 Jun 2014 03:38:15 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit


Hello,

What's version of bitbake are you using, please ?

$ bitbake --version

Have you set BB_SIGNATURE_HANDLER ? You can try to add:

BB_SIGNATURE_HANDLER = 'OEBasicHash'

to con/local.conf.

I think that this has been fixed even if you don't set the
BB_SIGNATURE_HANDLER which means 'noop' in the latest bitbake.

// Robert

On 06/29/2014 05:17 PM, Amit Chaudhuri wrote:
> Hi all,
>
> I am following the "Hello World" example from
> yoctoproject.org/docs/1.6/bitbake-user-manual/bitbake-user-manual.html#the-hello-world-example.
>
> I have sourced the oe-init-build-env script.
>
> I get an error message when trying to execute the bitbake printhello
> command from my project dir.  Command and output here:
>
> amit@linux-erag:~/hello> bitbake printhello
> Parsing recipes: 100%
> |##############################################################################################|
> Time: 00:00:00
> Parsing of 1 .bb files complete (0 cached, 1 parsed). 1 targets, 0
> skipped, 0 masked, 0 errors.
> NOTE: Resolving any missing task queue dependencies
> NOTE: Preparing runqueue
> ERROR: An uncaught exception occured in runqueue, please see the failure below:
> ERROR: Running idle function
> Traceback (most recent call last):
>    File "/home/amit/poky/bitbake/lib/bb/cooker.py", line 1169, in
> buildTargetsIdle(server=<ProcessServer(ProcessServer-2, started)>,
> rq=<bb.runqueue.RunQueue instance at 0x1941050>, abort=False):
>                   try:
>      >                retval = rq.execute_runqueue()
>                   except runqueue.TaskFailure as exc:
>    File "/home/amit/poky/bitbake/lib/bb/runqueue.py", line 1065, in
> RunQueue.execute_runqueue():
>               try:
>      >            return self._execute_runqueue()
>               except bb.runqueue.TaskFailure:
>    File "/home/amit/poky/bitbake/lib/bb/runqueue.py", line 1020, in
> RunQueue._execute_runqueue():
>                   else:
>      >                self.start_worker()
>                       self.rqexe = RunQueueExecuteScenequeue(self)
>    File "/home/amit/poky/bitbake/lib/bb/runqueue.py", line 898, in
> RunQueue.start_worker():
>                   self.teardown_workers()
>      >        self.worker, self.workerpipe = self._start_worker()
>
>    File "/home/amit/poky/bitbake/lib/bb/runqueue.py", line 864, in
> RunQueue._start_worker(fakeroot=False, rqexec=None):
>                   "hash_deps" : self.rqdata.hash_deps,
>      >            "sigchecksums" : bb.parse.siggen.file_checksum_values,
>                   "runq_hash" : self.rqdata.runq_hash,
> AttributeError: 'SignatureGenerator' object has no attribute
> 'file_checksum_values'
>
> NOTE: Tasks Summary: Attempted 0 tasks of which 0 didn't need to be
> rerun and all succeeded.
>
> Summary: There were 2 ERROR messages shown, returning a non-zero exit code.
>
> Bitbake version is:
>
> BitBake Build Tool Core version 1.20.0, bitbake version 1.20.0
>
> OS details:
>
> cat /etc/os-release
> NAME=openSUSE
> VERSION="13.1 (Bottle)"
> VERSION_ID="13.1"
> PRETTY_NAME="openSUSE 13.1 (Bottle) (x86_64)"
> ID=opensuse
> ANSI_COLOR="0;32"
> CPE_NAME="cpe:/o:opensuse:opensuse:13.1"
> BUG_REPORT_URL="https://bugs.opensuse.org"
> HOME_URL="https://opensuse.org/"
> ID_LIKE="suse"
>
> The only difference I can see between example and my attempt is the
> layer name (testlayer vs mylayer) and I've checked that I am being
> consistent.
>
> The error message suggests to me that there's a versioning problem on
> the SignatureGenerator.
>
> Can anyone point me in the right direction here?
> Happy to provide additional info (e.g. strace).
>
> Regards,
> Amit
>

