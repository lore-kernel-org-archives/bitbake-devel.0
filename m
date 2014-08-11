Return-Path: <rpjday@crashcourse.ca>
Received: from smtp484.redcondor.net (smtp484.redcondor.net [208.80.204.84])
	by mail.openembedded.org (Postfix) with ESMTP id 39D9065E03
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Aug 2014 19:12:13 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp484.redcondor.net ({c48374e7-08df-40d9-a0de-96cc9883a037})
	via TCP (outbound) with ESMTPS id 20140811191213597
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Aug 2014 19:12:13 +0000
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [99.240.204.5] (port=57701 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1XGv0q-0000qw-Ix for bitbake-devel@lists.openembedded.org;
	Mon, 11 Aug 2014 15:12:08 -0400
Date: Mon, 11 Aug 2014 15:12:04 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1408111504230.9626@localhost>
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
X-MAG-OUTBOUND: ccj.redcondor.net@64.235.106.9/32
Subject: some (admittedly dopey) questions about dependencies
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
X-List-Received-Date: Mon, 11 Aug 2014 19:12:21 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  digging thru bitbake manual, as well as the code in runqueue.py, so
some questions about the niggling details regarding dependencies.

  first, what does "recrdeptask" stand for? yes, i realize it refers
to "recursive" dependencies, but what's with the leading "recr"? does
that represent recursive "recr" deptasks, or recursive "rec"
rdeptasks? or what? knowing what it's short for always helps.

  next, i see five types of dependencies being processed in that code
in the prepare() method:

  * tdepends: internal task dependencies (based on addtask)
  * deptask: build-time dependencies
  * rdeptask: run-time dependencies
  * idepends: inter-task dependencies
  * recrdeptask: recursive dependencies

and i am still unclear on what recrdeptask represents: the comment in
that file reads:

  # e.g. do_sometask[recrdeptask] = "do_someothertask"
  # (makes sure sometask runs after someothertask of all DEPENDS,
    RDEPENDS and intertask dependencies, recursively)

is that description correct? how does it relate to inter-task
dependencies, which explicitly list the name of the other task?
anyway, if someone can clarify that, that would be ducky.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


