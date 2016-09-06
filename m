Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0547977532
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Sep 2016 13:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u86DI8Qj025601; Tue, 6 Sep 2016 14:19:23 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AGA7OxypvYdi; Tue,  6 Sep 2016 14:19:23 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u86DJHj8025890
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 6 Sep 2016 14:19:18 +0100
Message-ID: <1473167957.20226.44.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 06 Sep 2016 14:19:17 +0100
In-Reply-To: <1473162780-11643-1-git-send-email-nicolas.dechesne@linaro.org>
References: <1473162780-11643-1-git-send-email-nicolas.dechesne@linaro.org>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: Re: [PATCH] lib/bb/build: create .old symlink for run.do_xx and log.do_xx
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
X-List-Received-Date: Tue, 06 Sep 2016 13:19:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2016-09-06 at 12:53 +0100, Nicolas Dechesne wrote:
> When they exist, keep a reference to the 'previous' (or old) build
> for run.do_xx
> and log.do_xx files, which can be useful when debugging. The symlink
> are created
> as run.do_xx.old and log.do_xx.old.
> 
> Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> ---
>  lib/bb/build.py | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

We keep the old logfiles around and "ls -t" is comparatively straight
forward. Do we really need this extra complexity?

Cheers,

Richard

