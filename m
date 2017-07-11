Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B22C378195
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 22:56:40 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6BMuchg005866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 11 Jul 2017 23:56:40 +0100
Message-ID: <1499813798.30311.101.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 11 Jul 2017 23:56:38 +0100
In-Reply-To: <868892a60e4f6888b29455b40de5b16d6cc7ec9c.1499768495.git.liezhi.yang@windriver.com>
References: <cover.1499768495.git.liezhi.yang@windriver.com>
	<868892a60e4f6888b29455b40de5b16d6cc7ec9c.1499768495.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 11 Jul 2017 23:56:40 +0100 (BST)
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
X-List-Received-Date: Tue, 11 Jul 2017 22:56:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2017-07-11 at 03:27 -0700, Robert Yang wrote:
> Sometimes, we may see the errors:
> $ bitbake --observe-only
> ERROR: Unknown event: <bb.event.MonitorDiskEvent object at
> 0x7fbd2e0a8438>
> ERROR: Unknown event: <bb.event.RecipeTaskPreProcess object at
> 0x7fdc6b7e7b00>
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/ui/knotty.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/bitbake/lib/bb/ui/knotty.py
> b/bitbake/lib/bb/ui/knotty.py
> index 11afb3e7441..71ec168fa6c 100644
> --- a/bitbake/lib/bb/ui/knotty.py
> +++ b/bitbake/lib/bb/ui/knotty.py
> @@ -667,11 +667,13 @@ def main(server, eventHandler, params, tf =
> TerminalFilter):
>                                    bb.event.MultiConfigParsed,
>                                    bb.event.RecipeParsed,
>                                    bb.event.RecipePreFinalise,
> +                                  bb.event.RecipeTaskPreProcess,
>                                    bb.runqueue.runQueueEvent,
>                                    bb.event.OperationStarted,
>                                    bb.event.OperationCompleted,
>                                    bb.event.OperationProgress,
>                                    bb.event.DiskFull,
> +                                  bb.event.MonitorDiskEvent,
>                                    bb.event.HeartbeatEvent,
>                                    bb.build.TaskProgress)):
>                  continue

Do you know why we don't either always see these or always don't see
them? I'm a bit worried there may be a deeper issue lurking here. Are
those events part of the event mask being set?

For reference, I've been looking at the server abstraction in bitbake
and am close to rewriting a large part of bb.server.* and bb.main with
a view to simplifying the code structure and making things easier to
understand.

I've noticed I see some new events with my change, equally I think its
an event mask issue with my new code...

I pushed my changes onto http://git.yoctoproject.org/cgit.cgi/poky-cont
rib/commit/?h=rpurdie/wip-
rss2&id=7d970e7b9f5499f5fcdb0e73246f106844ecf09b
however I am well aware things don't work properly yet and its full of
debug. When finished I should be able to delete server/__init__.py and
server/xmlrpc.py.

Cheers,

Richard



