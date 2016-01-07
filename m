Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7A4A76B6EA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Jan 2016 13:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u07DuOgx027248; Thu, 7 Jan 2016 13:56:45 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Zj-dey9afspX; Thu,  7 Jan 2016 13:56:45 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u07DufUL027307
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Jan 2016 13:56:42 GMT
Message-ID: <1452175001.7598.117.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 07 Jan 2016 13:56:41 +0000
In-Reply-To: <60b4483fa1dfbd45dc1835dca1759ee5f6a27f4f.1452152302.git.liezhi.yang@windriver.com>
References: <cover.1452152302.git.liezhi.yang@windriver.com>
	<60b4483fa1dfbd45dc1835dca1759ee5f6a27f4f.1452152302.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] fetch2/git.py:_latest_revision: respect BB_FETCH_PREMIRRORONLY
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
X-List-Received-Date: Thu, 07 Jan 2016 13:56:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-01-06 at 23:38 -0800, Robert Yang wrote:
> Fixed when use a local BB_FETCH_PREMIRRORONLY for AUTOREV recipes:
> SRCREV = "${AUTOREV}"
> BB_NO_NETWORK = "1"
> For example, the refpolicy-mls from meta-selinux:
> $ bitbake refpolicy-mls -ccleanall/fetch


This test case is incorrect, you shouldn't set BB_NO_NETWORK if you
want to BB_FETCH_PREMIRRORONLY...

Cheers,

Richard

