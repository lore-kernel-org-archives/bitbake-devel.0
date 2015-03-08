Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 5C4606AC36
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  8 Mar 2015 09:12:12 +0000 (UTC)
Received: from [99.240.204.5] (port=46373 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1YUXFv-0000KF-Mr for bitbake-devel@lists.openembedded.org;
	Sun, 08 Mar 2015 05:12:15 -0400
Date: Sun, 8 Mar 2015 05:12:11 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@Device-040570
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1503080507510.16693@Device-040570>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: i think "bitbake -c" needs to be explained more thoroughly
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
X-List-Received-Date: Sun, 08 Mar 2015 09:12:13 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  not sure it's entirely clear from the docs that, if one runs
"bitbake -c <task>", it is entirely possible that dependent tasks
might also be run.

  for instance, "bitbake -h" describes it as:

  -c CMD, --cmd=CMD     Specify the task to execute. The exact options
                        available depend on the metadata. Some examples might
                        be 'compile' or 'populate_sysroot' or 'listtasks' may
                        give a list of the tasks available.

and the bitbake user manual, section 1.5.2.2, reads:

"This next example "PROVIDES" the package name and also uses the "-c"
option to tell BitBake to just execute the do_clean task:

     $ bitbake -c clean foo

  both of these kind of suggest that *only* that task will be run, but
recently, darren hart explained it more clearly on the YP list:

https://lists.yoctoproject.org/pipermail/yocto/2015-February/023822.html


"It will run everything necessary up to and including that task. If
everything, including that task, have already been run, it will run only
the specified task again.

You can verify this with:

1 $ bitbake virtual/kernel
2 $ bitbake virtual/kernel -c kernel_configme -f
3 $ bitbake virtual/kernel -c cleansstate
4 $ bitbake virtual/kernel -c kernel_configme -f"

and i don't think that's necessarily clear from the current docs.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

