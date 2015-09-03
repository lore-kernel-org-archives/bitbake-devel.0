Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DE41577009
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 15:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t83FmsnL007059; Thu, 3 Sep 2015 16:48:54 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3U_I3jusngJd; Thu,  3 Sep 2015 16:48:54 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t83FmgHG007040
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 3 Sep 2015 16:48:53 +0100
Message-ID: <1441295322.24871.122.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alexander.kanavin@linux.intel.com>
Date: Thu, 03 Sep 2015 16:48:42 +0100
In-Reply-To: <6cc60f518992d5c20164cde35a3862edebdab385.1441294533.git.alexander.kanavin@linux.intel.com>
References: <cover.1441294533.git.alexander.kanavin@linux.intel.com>
	<6cc60f518992d5c20164cde35a3862edebdab385.1441294533.git.alexander.kanavin@linux.intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] wget.py: use BPN when parsing upstream directory paths
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
X-List-Received-Date: Thu, 03 Sep 2015 15:49:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-09-03 at 18:37 +0300, Alexander Kanavin wrote:
> PN in this context may contain bogus suffixes like -native etc.

This is not that simple sadly. Bitbake has no knowledge of BPN, not
should it have really :/. This suggests we have a bit of an API
problem...

At the very least we should fallback to PN here is BPN isn't set.

Cheers,

Richard


