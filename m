Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C229E60670
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 22:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4GM64KB021247; Mon, 16 May 2016 23:06:04 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LAsXb1JKRdFj; Mon, 16 May 2016 23:06:04 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4GM62Zi021243
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 16 May 2016 23:06:03 +0100
Message-ID: <1463436362.4578.4.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Mon, 16 May 2016 23:06:02 +0100
In-Reply-To: <b5acd266233c34a439097e8024ab8cbcb7e1e77c.1462041562.git.chris_larson@mentor.com>
References: <4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
	<b5acd266233c34a439097e8024ab8cbcb7e1e77c.1462041562.git.chris_larson@mentor.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [RFC master][PATCH 4/4] bitbake-layers: convert to plugin-based
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
X-List-Received-Date: Mon, 16 May 2016 22:06:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2016-04-30 at 12:41 -0700, Christopher Larson wrote:
> From: Christopher Larson <chris_larson@mentor.com>
> 
> This uses bb.utils.load_plugins, based on the plugin handling in
> recipetool
> and devtool in oe-core.
> 
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> ---
>  bin/bitbake-layers                 | 1065 ++------------------------
> ----------
>  bitbake/lib/bblayers/__init__.py   |    2 +
>  bitbake/lib/bblayers/action.py     |  233 ++++++++
>  bitbake/lib/bblayers/common.py     |   33 ++
>  bitbake/lib/bblayers/layerindex.py |  270 +++++++++
>  bitbake/lib/bblayers/query.py      |  499 +++++++++++++++++

Sorry, one other question. Did you mean to create a bitbake/lib within
the bitbake repo or should this just be lib/ ? I'm guessing the latter
and have queued it in -next with that.

Cheers,

Richard




