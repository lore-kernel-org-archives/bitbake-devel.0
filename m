Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 3E58F6AB50
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Jun 2014 14:50:47 +0000 (UTC)
Received: from [99.240.204.5] (port=33184 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1Wyj6V-0008Td-A3 for bitbake-devel@lists.openembedded.org;
	Sun, 22 Jun 2014 10:50:47 -0400
Date: Sun, 22 Jun 2014 10:47:01 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406221041150.4008@localhost>
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
Subject: bitbake user manual: "Variable Flags" section seems to need updating
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
X-List-Received-Date: Sun, 22 Jun 2014 14:50:48 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  the "Variable Flags" section of the bitbake user manual seems to be
incomplete:

http://www.yoctoproject.org/docs/1.6/bitbake-user-manual/bitbake-user-manual.html#variable-flags

at the very least, i see additional task flags such as "selfstamp",
"lockfiles", "stamp-base" and more, just from having stumbled across
this:

lib/toaster/orm/fixtures/orm_views_testdata.json:
"variable_value": "doc defaultval _append _prepend deps depends
lockfiles type vardepsexclude vardeps vardepvalue file-checksums
python func task export unexport noexec nostamp dirs cleandirs
sstate-lockfile-shared prefuncs postfuncs export_func deptask rdeptask
recrdeptask nodeprrecs stamp-base stamp-extra-info",

but i don't know enough about some of those flags to know what to add
for them (if anything).

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

