Return-Path: <rpjday@crashcourse.ca>
Received: from smtp684.redcondor.net (smtp684.redcondor.net [208.80.206.84])
	by mail.openembedded.org (Postfix) with ESMTP id 9543460C19
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Aug 2014 13:06:34 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp684.redcondor.net ({700db0a8-6fb7-4c8b-9b2a-6812225182d8})
	via TCP (outbound) with ESMTPS id 20140810130630804
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Aug 2014 13:06:30 +0000
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [99.240.204.5] (port=35443 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1XGSpN-00049o-PR for bitbake-devel@lists.openembedded.org;
	Sun, 10 Aug 2014 09:06:25 -0400
Date: Sun, 10 Aug 2014 09:06:21 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1408100858280.28636@localhost>
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
Subject: sadly, confused about recursive "recrdeptask" dependencies
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
X-List-Received-Date: Sun, 10 Aug 2014 13:06:38 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  first, reading bitbake user manual and, in the section on dependency
task flags, i see nothing about the "recideptask" flag, which i only
tripped over recently while perusing oe-core:

distrodata.bbclass:do_distrodataall[recideptask] = "do_${BB_DEFAULT_TASK}"
distrodata.bbclass:do_checkpkgall[recideptask] = "do_${BB_DEFAULT_TASK}"
distrodata.bbclass:do_distro_checkall[recideptask] = "do_${BB_DEFAULT_TASK}"
distrodata.bbclass:do_checklicenseall[recideptask] = "do_${BB_DEFAULT_TASK}"
utility-tasks.bbclass:do_checkuriall[recideptask] = "do_${BB_DEFAULT_TASK}"
utility-tasks.bbclass:do_fetchall[recideptask] = "do_${BB_DEFAULT_TASK}"

should that be documented?

  and as for "recrdeptask", well, i'm pretty sure i understand
build-time dependencies, and run-time dependencies, but does
recrdeptask correspond only to recursive run-time dependencies, or
*both* types of dependencies (as well as inter-task dependencies)? i'm
reading section 3.9.4 in the bitbake user manual, and i'm still
confused.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


