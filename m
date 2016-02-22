Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8C8D975EE7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 20:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1MKpLsf016951; Mon, 22 Feb 2016 20:51:21 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MqoLvIbMNdp4; Mon, 22 Feb 2016 20:51:21 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1MKpIsZ016948
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 22 Feb 2016 20:51:19 GMT
Message-ID: <1456174278.28376.199.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Shashkevich <alex@stunpix.com>,
	bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 20:51:18 +0000
In-Reply-To: <1456166091-13075-1-git-send-email-alex@stunpix.com>
References: <1456166091-13075-1-git-send-email-alex@stunpix.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] bb/fetch2: broken functionality for entries like file://dir; subdir=foo in SRC_URI
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
X-List-Received-Date: Mon, 22 Feb 2016 20:51:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-02-22 at 20:34 +0200, Alexander Shashkevich wrote:
> For SRC_URI entries like file://dir1;subdir=foo1 and
> file://dir2/dir3;subdir=foo2/foo3
> subdirectories ${WORKDIR}/foo1 and ${WORKDIR}/foo2/foo3 are created,
> but dir1 and dir2/dir3 are
> only copied to ${WORKDIR}/dir1 and ${WORKDIR}/dir2/dir. Correct way:
> directories must be copied/unpacked
> into '${WORKDIR}/foo1/dir1' and '${WORKDIR}/foo2/foo3/dir2/dir'
> respectively.

Where we have cases like this, I'd ask that you add a test case to
lib/bb/tests/ which illustrates the problem and ensures we don't
regress in future. We've had far too many problems with corner cases
and the fetcher :(

I need to properly review the patch but wanted to mention this now.

Cheers,

Richard

