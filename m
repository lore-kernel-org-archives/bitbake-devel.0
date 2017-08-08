Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B24EA700F3
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Aug 2017 12:50:23 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v78CoMVN018441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 8 Aug 2017 13:50:24 +0100
Message-ID: <1502196622.18633.246.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 08 Aug 2017 13:50:22 +0100
In-Reply-To: <53074458ae150fc7544b02f5c3e37ff49257cb27.1502183410.git.liezhi.yang@windriver.com>
References: <cover.1502183410.git.liezhi.yang@windriver.com>
	<53074458ae150fc7544b02f5c3e37ff49257cb27.1502183410.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 08 Aug 2017 13:50:24 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: [WIP][RFC PATCH 5/5] bitbake: main: make observe-only work without --bind
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
X-List-Received-Date: Tue, 08 Aug 2017 12:50:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2017-08-08 at 02:12 -0700, Robert Yang wrote:
> The bitbake --server-only can work without --bind, so --observe-only
> should also
> can work without --bind or --remote-server.
> 
> And also allow the connection all the time, otherwise --observe-only
> doesn't
> work.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/main.py           | 4 ----
>  bitbake/lib/bb/server/process.py | 8 ++------
>  2 files changed, 2 insertions(+), 10 deletions(-)

The other patches look ok but I worry a bit about this one since the
code isn't really set up to handle multiple potentially competing
connections right now. If something is an observer, we need to ensure
its marked as such and can't send control commands...

Cheers,

Richard

