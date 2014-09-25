Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 5D07A60144
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 16:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 263BE2E411
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 18:05:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id gCUESvJvVeba for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 18:05:00 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 995852E2AD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 18:05:00 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 77C0C123A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 18:05:00 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 69F47122A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 18:05:00 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 67E113E048
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 18:05:00 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Thu, 25 Sep 2014
	18:05:00 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 3915C9C554; 
	Thu, 25 Sep 2014 18:05:00 +0200 (CEST)
Date: Thu, 25 Sep 2014 18:05:00 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Message-ID: <20140925160500.GG21392@axis.com>
References: <1411655511-11479-1-git-send-email-ross.burton@intel.com>
MIME-Version: 1.0
In-Reply-To: <1411655511-11479-1-git-send-email-ross.burton@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Subject: Re: [PATCH] monitordisk: don't log when not monitoring a filesystem for inodes
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
X-List-Received-Date: Thu, 25 Sep 2014 16:05:18 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 14-09-25 16:31 +0200, Ross Burton wrote:
> Writing a log that the filesystem isn't being monitored for inode usage just
> confuses users who are not aware about the nature of inodes in their filesystem,
> so don't say anything, just silently disable the monitor.  In general this only
> happens on filesystems which don't have a limit on inodes.

+1

It used to be a warning, but somebody on irc wanted it to remain
a notice when I sent the patch to lower it. But indeed, it's just
noise.

-- 
olofjn

