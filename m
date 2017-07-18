Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D51AC77A63
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jul 2017 22:02:59 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6IM2wfj015415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 18 Jul 2017 23:02:59 +0100
Message-ID: <1500415378.22282.22.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jul 2017 23:02:58 +0100
In-Reply-To: <de6e4eb7-a4ea-5d4f-77ac-e8f2035f8f45@windriver.com>
References: <cover.1499768495.git.liezhi.yang@windriver.com>
	<868892a60e4f6888b29455b40de5b16d6cc7ec9c.1499768495.git.liezhi.yang@windriver.com>
	<1499813798.30311.101.camel@linuxfoundation.org>
	<3e7d971c-6183-487d-9a68-56b9e7212f5c@windriver.com>
	<1499974474.30311.134.camel@linuxfoundation.org>
	<1d8d85a1-1d6f-cd49-dc0a-d0d6bf6c3193@windriver.com>
	<a49aec94-1145-c020-4d90-c42095f9a386@windriver.com>
	<de6e4eb7-a4ea-5d4f-77ac-e8f2035f8f45@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 18 Jul 2017 23:02:59 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: [RFC PATCH 1/3] bitbake: knotty.py: add MonitorDiskEvent and RecipeTaskPreProcess
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
X-List-Received-Date: Tue, 18 Jul 2017 22:03:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Robert,

Thanks for these. I've queued some of this, I fixed some things
differently and I have a request for some tweaks please! :)

For: http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rbt/ma
ster-next-memres&id=1d7df2f917cbcfa5f21c437ba2f0cc656e256eaa could you
please leave pid in the lockfile. We are going to likely need an easier
way to find the server in future so I'd like to have that there.

With oe-init-build-env-memres, I'm simply planning to delete this. If
someone wants to start a standalone server over xmlrpc, they still can
but going forward most people will just set BB_SERVER_TIMEOUT=X. We can
therefore drop that script (patch queued).

For: http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rbt/ma
ster-next-memres&id=78333885f4117e4586336c7aff6b5a9e3a6378b8
could you rename the "server_only" parameter in ProcessServer to
stay_resident please?

I've queued everything in bitbake master-next, I can't update poky
master-next at the moment as a build is in progress.

I'm hopeful the patches are becoming more stable now, not sure how many
of your other issues remain if we remove the memres init script and use
BB_SERVER_TIMEOUT as the preferred way to enable memres?

Cheers,

Richard


