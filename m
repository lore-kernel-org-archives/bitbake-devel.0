Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3324171A8C
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Mar 2017 12:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2QCKB0E026242; Sun, 26 Mar 2017 13:20:11 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id U73Uv3nTRJp9; Sun, 26 Mar 2017 13:20:11 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2QCK6ZK026233
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 26 Mar 2017 13:20:08 +0100
Message-ID: <1490530806.13980.251.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jussi Kukkonen <jussi.kukkonen@intel.com>, daniel@lublin.se
Date: Sun, 26 Mar 2017 13:20:06 +0100
In-Reply-To: <CAHiDW_Ewz6TjRW5A7V31U9128cA65EAepYoVcKHxJN43AyyD8g@mail.gmail.com>
References: <CAHiDW_Ewz6TjRW5A7V31U9128cA65EAepYoVcKHxJN43AyyD8g@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [1.32][PATCH 1/1] bitbake: Fix imports from html5lib >= 0.9999999/1.0b8
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
X-List-Received-Date: Sun, 26 Mar 2017 12:20:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2017-03-23 at 10:39 +0200, Jussi Kukkonen wrote:
> On 5 December 2016 at 19:42, <daniel@lublin.se> wrote:
> > From: Daniel Lublin <daniel@lublin.se>
> > 
> > As of html5lib 0.9999999/1.0b8 (released on July 14, 2016), some
> > modules
> > have moved from _base to base. Handle this, while staying
> > compatible
> > with earlier versions.
> This fixes a build breaking bug on newish host OSes and should be
> cherry-picked to supported releases. I've tested 1.32: applies
> cleanly and fixes the issue.

Done, thanks.

Richard

