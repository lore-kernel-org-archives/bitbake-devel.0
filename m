Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 35416770E7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 13:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9GDA86U008374; Fri, 16 Oct 2015 14:10:08 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fK7XYfQ0mSg0; Fri, 16 Oct 2015 14:10:08 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9GD9uPa008360
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 16 Oct 2015 14:10:07 +0100
Message-ID: <1445000996.17974.15.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ed Bartosh <ed.bartosh@linux.intel.com>, "toaster@yoctoproject.org"
	<toaster@yoctoproject.org>
Date: Fri, 16 Oct 2015 14:09:56 +0100
In-Reply-To: <1444898260-19877-1-git-send-email-ed.bartosh@linux.intel.com>
References: <CABcZANmHoWBvfF0JKMt4SCVef5-qgGvF+OJ+or6-Pu5pgpz46w@mail.gmail.com>
	<1444898260-19877-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] bitbake: normalize build targets
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
X-List-Received-Date: Fri, 16 Oct 2015 13:10:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-10-15 at 11:37 +0300, Ed Bartosh wrote:
> BuildStarted event not fully represents build tasks for
> the targets. If -c option is used to specify default task
> it's not included into the event.
> 
> Made build targets to always look as <target>:do_<task>.
> Consider default task (do_build or specified by -c command
> line option) when normalizing.
> 
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>

The correct prefix for the commit shortlog is "cooker:". I'd really like
to see toaster becoming a little more specific too such as
"toaster/xxxx:" instead of the usual "toaster:".

Cheers,

Richard


