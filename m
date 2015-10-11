Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 97FE9760F4
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Oct 2015 04:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9B4Mijk008915; Sun, 11 Oct 2015 05:22:44 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fjCVeW8ttZba; Sun, 11 Oct 2015 05:22:44 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9B4MK5q008912
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 11 Oct 2015 05:22:41 +0100
Message-ID: <1444537330.14364.5.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Elliot Smith <elliot.smith@intel.com>, "Bartosh, Eduard"
	<eduard.bartosh@intel.com>
Date: Sun, 11 Oct 2015 05:22:10 +0100
In-Reply-To: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
References: <cover.1444038048.git.elliot.smith@intel.com>
	<04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/6] event: add new property to BuildBase class
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
X-List-Received-Date: Sun, 11 Oct 2015 04:22:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-10-05 at 10:43 +0100, Elliot Smith wrote:
> From: Ed Bartosh <ed.bartosh@linux.intel.com>
> 
> Added 'task' property to the base class of BuildStarted and
> BuildCompleted classes to store bitbake task if it's specified.
> 
> This is done as without task Build* events can't fully represent
> bitbake build. Task information is needed by UI classes to properly
> show or process Build* events.

This doesn't make sense I'm afraid. There is no one "task" which a build
start/complete event can correspond to. Consider something like:

"bitbake A:do_fetch B:do_rootfs"

There would be one BuildStarted event but task doesn't have a singular
value. We therefore don't want to add task information to these events
as it will ultimately mislead anything building on top of this
information.

I appreciate there is the -c option, but that just means "if there is no
specific task specified, use this", i.e. its a default.

Cheers,

Richard


