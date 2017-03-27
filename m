Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2E8F177B60
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Mar 2017 10:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v2RAExd0021037; 
	Mon, 27 Mar 2017 11:15:46 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FM2a3iw5Gjqv; Mon, 27 Mar 2017 11:15:46 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2RAEsLx021016
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 27 Mar 2017 11:15:45 +0100
Message-ID: <1490609694.13980.255.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Diana Thayer <garbados@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 27 Mar 2017 11:14:54 +0100
In-Reply-To: <CA++8a_CFVb+=mHSH5x45Fg==D5pG-Ja=OiAiNpd2H4gvD3zSjA@mail.gmail.com>
References: <1490128025-7864-1-git-send-email-garbados@gmail.com>
	<CA++8a_CFVb+=mHSH5x45Fg==D5pG-Ja=OiAiNpd2H4gvD3zSjA@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] bug 9962: improve -v, -D documentation
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
X-List-Received-Date: Mon, 27 Mar 2017 10:15:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2017-03-21 at 13:33 -0700, Diana Thayer wrote:
> Hi!
> 
> I did my best to follow patch submission guidelines and code
> styleguide but this is my very first patch to anything in the Yocto
> project. Please let me know if and how I can improve future patch
> submissions! I figured since it's my first time, I would follow up
> and say hello :)
> 
> This patch addresses bug 9962 by updating the documentation of
> bitbake's -v and -D CLI options. I copied the updated text directly
> from the bug report, and changed it both in the code and in the user
> manual.
> 
> Anyway hi! I hope to contribute more soon :)

Hi!

Thanks for taking the time to submit the patch and sorry for the delay
in getting back to you. I've just queued this in master-next for
further testing. The patch itself is great, I did have to tweak the
commit message a bit. In particular:

I added "main: " as a prefix to the shortlog since this indicates there
the change was made. I also changed the bug reference to our standard
form [YOCTO #XXXX] so that when we search commits for bug references,
its in a standard form. The commit message needs to stand alone without
someone needing to read the bug, that is there just as a useful link
for more information. All just minor formatting tweaks really though.

Cheers,

Richard

