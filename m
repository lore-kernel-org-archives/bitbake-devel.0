Received: from avasout04.plus.net (avasout04.plus.net [212.159.14.19])
 by mx.groups.io with SMTP id smtpd.web10.5404.1617114652750282516
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Mar 2021 07:30:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=KbVSZrDr;
 spf=pass (domain: mcrowe.com, ip: 212.159.14.19, mailfrom: mac@mcrowe.com)
Received: from deneb.mcrowe.com ([80.229.24.9])
	by smtp with ESMTP
	id RFOLlhp5eOQhvRFOMlHCmk; Tue, 30 Mar 2021 15:30:51 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IvmFjI3g c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=JO6B_OCNNnGB970gQPsA:9 a=CjuIK1q_8ugA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	 s=20191005; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:CC:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=rTduG397h3BcHNLT7NsAUCybCCgxEUdlJoS/wY4nTjA=; b=Kb
	VSZrDrhW9OEUcXy89C7zBlCRs2Kshlp1/i53fh1Sh+qSv3j9ahiyeuA1Ij7/F+OxxHmQe51WM0T29
	gmIPtXX8+8Q71tuHFTx51ei4CI99nmacMYZv7yYqMrXs1djOG41lGSFCgF2tohQYCy9dwQN6iap++
	jXoAI9AUpmKau+/TGDuFGp+yyXEbAnBoITAXEFlow/L2GAkMKC7BbgCQztWGTcQFrYeOOt/E/msV/
	l7/Z5CjtxTd5Tc5Oi5NcI6SDHtly73vjbNAhXnRbpERydxVMSrhm+IQSwfmit9P7LF0k6Oo614azJ
	VMf1a3gm9ZuTK2yTh8uGqJeQ2zgcJtkg==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.92)
	(envelope-from <mac@mcrowe.com>)
	id 1lRFOL-0008Km-6V
	for bitbake-devel@lists.openembedded.org; Tue, 30 Mar 2021 15:30:49 +0100
Date: Tue, 30 Mar 2021 15:30:49 +0100
From: "Mike Crowe" <yocto@mac.mcrowe.com>
To: bitbake-devel@lists.openembedded.org
Subject: Three copies of output from failing task
Message-ID: <20210330143049.GA23723@mcrowe.com>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4wfOaZVCH+w7fRS2mTfiVQz8WXxMEi7cn7+LkNbilHyvtbi/aaN/BJEwx40NnLXl5jkTkKiut0lJBPqQZ5/cNjM6okG7yNmiOEceYKS659fo0z5/RnYEZF
 1bCj4Lkqupv6HJJY973LBbgaBHNLcKPS2YQnb7ecaDNSEhncKzxK/cczJhOXaQ3mGqDlARg2cDKaWA==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After upgrading from oe-core Warrior (Bitbake 1.42) to Dunfell (Bitbake
1.46), I'm seeing _three_ copies of the log output for every build failure.
I see similar when using the current state of oe-core master (along with
the new backtraces.)

To reproduce the problem, I hacked openssl_1.1.1k.bb:do_configure to insert:

 echo "an error"
 false

and ran bitbake openssl-native. The output was:

--8<--
NOTE: Executing Tasks
ERROR: openssl-native-1.1.1k-r0 do_configure: Execution of '/overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031' failed with exit code 1:
an error
WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
WARNING: Backtrace (BB generated script):
        #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
        #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221

Backtrace (metadata-relative locations):
        #1: do_configure, /overflow/mac/nobackup/git/oe-core/meta/recipes-connectivity/openssl/openssl_1.1.1k.bb, line 78
ERROR: Logfile of failure stored in: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/log.do_configure.32031
Log data follows:
| DEBUG: Executing python function extend_recipe_sysroot
| NOTE: Direct dependencies are ['/overflow/mac/nobackup/git/oe-core/meta/recipes-devtools/quilt/quilt-native_0.66.bb:do_populate_sysroot']
| NOTE: Installed into sysroot: []
| NOTE: Skipping as already exists in sysroot: ['quilt-native']
| DEBUG: Python function extend_recipe_sysroot finished
| DEBUG: Executing shell function do_configure
| an error
| WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
| WARNING: Backtrace (BB generated script):
|       #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
|       #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221
| ERROR: Execution of '/overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031' failed with exit code 1:
| an error
| WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
| WARNING: Backtrace (BB generated script):
|       #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
|       #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221
|
| Backtrace (metadata-relative locations):
|       #1: do_configure, /overflow/mac/nobackup/git/oe-core/meta/recipes-connectivity/openssl/openssl_1.1.1k.bb, line 78
ERROR: Task (virtual:native:/overflow/mac/nobackup/git/oe-core/meta/recipes-connectivity/openssl/openssl_1.1.1k.bb:do_configure) failed with exit code '1'
NOTE: Tasks Summary: Attempted 14 tasks of which 13 didn't need to be rerun and 1 failed.
-->8--

Even if I set BBINCLUDELOGS="no", I still get these three copies.

The first one (without the leading "|" characters) appears to come from
_build.py:_exec_task (around line 702) executing logger.error(str(exc)).
This line dates from 2011.

The second and third ones (with the leading "|") come from knotty.py around
line 767. They are both in log.do_configure.32031. It looks like the third
copy is coming from the same place as the first copy, but has been written
to both the console and the log file.

If I comment out the previously-mentioned call to logger.error(str(exc)) in
_build.py:_exec_task then I get the single copy of the task output as I
would expect.

Does anyone know what the proper fix for this might be?

Thanks.

Mike.
