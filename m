Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 13107607A4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jul 2016 11:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6TBuWKk021855; Fri, 29 Jul 2016 12:56:32 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dbrljZU0zInG; Fri, 29 Jul 2016 12:56:32 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6TBuTF4021852
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 29 Jul 2016 12:56:30 +0100
Message-ID: <1469793389.9142.59.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Maxin B. John" <maxin.john@intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Fri, 29 Jul 2016 12:56:29 +0100
In-Reply-To: <1469780615-1657-1-git-send-email-maxin.john@intel.com>
References: <1469780615-1657-1-git-send-email-maxin.john@intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [RFC][PATCH] bitbake: fetch2: fix warning while switching from master to krogoth
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
X-List-Received-Date: Fri, 29 Jul 2016 11:56:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2016-07-29 at 11:23 +0300, Maxin B. John wrote:
> While switching from master to krogoth build with a common download
> directory,
> got a large number of warnings like the one listed below:
> 
> WARNING: freetype-2.6.3-r0 do_fetch: Couldn't load checksums from
> donestamp /home/maxin/downloads/freetype-2.6.3.tar.bz2.done:
> ValueError
> (msg: unsupported pickle protocol: 4)
> 
> These warnings are caused by the difference in pickle module
> implementation in python3(master) and python2(krogoth). Python2
> supports
> 3 different protocols (0, 1, 2) and pickle.HIGHEST_PROTOCOL is 2
> where as
> Python3 supports 5 different protocols (0, 1, 2, 3, 4) and
> pickle.HIGHEST_PROTOCOL is obviously 4.
> 
> My suggestion is to use 2 since it is backward compatible with
> python2
> (all the supported distros for krogoth provides python2 which
> supports
> pickle protocol version 2)

This looks good to me, well spotted. I've merged it since the
autobuilder is likely spending a lot of time churning sources around at
the moment due to this.

Ideally we'd use a better data format in these files so I'd welcome
other improvements but this fixes the immediate problem.

Cheers,

Richard

