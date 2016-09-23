Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 11D6960938
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Sep 2016 14:01:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8NE1Eh5018025; Fri, 23 Sep 2016 15:01:14 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nxKrsnyaCQ9T; Fri, 23 Sep 2016 15:01:14 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8NE1Ang018018
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 23 Sep 2016 15:01:11 +0100
Message-ID: <1474639270.7207.367.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Roman Savchenko <gmstima@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2016 15:01:10 +0100
In-Reply-To: <CAGpdKUJ0sctyDhyzSQq3wBCSG3T5ioRETApT7OzdvAvV4U5Xhg@mail.gmail.com>
References: <1474388588-1111-1-git-send-email-gmstima@gmail.com>
	<1474616753-26510-1-git-send-email-gmstima@gmail.com>
	<CAGpdKUJ0sctyDhyzSQq3wBCSG3T5ioRETApT7OzdvAvV4U5Xhg@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: Re: [PATCH] bitbake: Correct broken symlink behaviour
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
X-List-Received-Date: Fri, 23 Sep 2016 14:01:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Roman,

On Fri, 2016-09-23 at 10:55 +0300, Roman Savchenko wrote:
> I adjusted commit message and function description. but I do not
> agree with proposed
> function name `create_valid_symlink`, becasue link creation could
> fail - so I left `try_symlink`
> to point this behaviour.

I don't agree with "try_symlink" though, sorry.

Link creation can fail but that is like any other function which can
also fail. We don't prefix all function names with try_ because they
can fail.

We need a better name.

Cheers,

Richard

