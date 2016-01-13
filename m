Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 06BBF731A7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jan 2016 22:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0DMJiE7017182; Wed, 13 Jan 2016 22:19:44 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MskmDVc3c9Ma; Wed, 13 Jan 2016 22:19:44 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0DMJg4b017179
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 13 Jan 2016 22:19:43 GMT
Message-ID: <1452723582.28375.118.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andre McCurdy <armccurdy@gmail.com>
Date: Wed, 13 Jan 2016 22:19:42 +0000
In-Reply-To: <CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
References: <1452172732.7598.114.camel@linuxfoundation.org>
	<CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/git: Change to use clearer ssh url syntax for broken servers
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
X-List-Received-Date: Wed, 13 Jan 2016 22:19:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-01-13 at 13:37 -0800, Andre McCurdy wrote:
> On Thu, Jan 7, 2016 at 5:18 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > Some servers, e.g. bitbucket.org can't cope with ssh:// as part of
> > the git url syntax. git itself is happy enough with this but you
> > get server side errors when using it.
> > 
> > This changes the git fetcher to use the more common ssh url format
> > which also means we need a : before the path.
> 
> This seems to break SRC_URIs using ssh to access self hosted git
> servers setup following the process described here:
> 
>   https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Ser
> ver
> 
> An example of such a SRC_URI, which now fails to work:
> 
>   SRC_URI = "git
> ://git@mylocalserver.com:/opt/git/myrepo.git;protocol=ssh"

Does:

SRC_URI = "git://git@mylocalserver.com/opt/git/myrepo.git;protocol=ssh"

work though?

I'm not sure we ever suggested people should use ":/" in SRC_URI since
that isn't a url format the system was ever designed to cope with. It
might have happened to work but that is different...

Cheers,

Richard

