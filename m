Return-Path: <ben.shelton@ni.com>
X-Greylist: delayed 2272 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 26 Sep 2014 22:39:45 UTC
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
	by mail.openembedded.org (Postfix) with ESMTP id C05A860809
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Sep 2014 22:39:45 +0000 (UTC)
Received: from us-aus-mgwout1.amer.corp.natinst.com (nb-chan1-1338.natinst.com
	[130.164.19.134])
	by us-aus-skprod2.natinst.com (8.14.5/8.14.5) with ESMTP id
	s8QM1shq015300 for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Sep 2014 17:01:54 -0500
Received: from localhost ([130.164.14.198])
	by us-aus-mgwout1.amer.corp.natinst.com (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2014092617015433-292224 ;
	Fri, 26 Sep 2014 17:01:54 -0500 
Date: Fri, 26 Sep 2014 17:01:53 -0500
From: Ben Shelton <ben.shelton@ni.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20140926220153.GA29668@bshelton-desktop>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-MIMETrack: Itemize by SMTP Server on US-AUS-MGWOut1/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 09/26/2014 05:01:54 PM,
	Serialize by Router on US-AUS-MGWOut1/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 09/26/2014 05:01:54 PM,
	Serialize complete at 09/26/2014 05:01:54 PM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.12.52, 1.0.28,
	0.0.0000
	definitions=2014-09-26_07:2014-09-26, 2014-09-26,
	1970-01-01 signatures=0
Subject: Getting bitbake_prserv database contents to persist across power loss
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
X-List-Received-Date: Fri, 26 Sep 2014 22:39:48 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

We're currently running a shared PR server that is used by all the
OpenEmbedded build machines on our intranet (both for developers'
machines and for nightly build machines).

We recently ran into an issue where the blade that the shared PR server
runs on was shut down unexpectedly and the PR history since the PR
server was last restarted was not committed to disk.  Looking at the
commit 'prserv: Ensure data is committed', it looks like the only times
the transactions are committed is when the PR server process is shut
down.

What would be your guidance in this case?  Should we just shut down /
restart the PR server nightly to save off the data?  If we wrote a patch
to the PR server to commit the data to the database at runtime-specified
intervals, would that be something we could upstream?

Thanks,
Ben

