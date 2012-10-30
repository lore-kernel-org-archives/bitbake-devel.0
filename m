Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bue@praqma.net>) id 1TT6ns-0000vS-LC
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Oct 2012 09:04:04 +0100
Received: by mail-ob0-f175.google.com with SMTP id eq6so5413165obc.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Oct 2012 00:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type
	:x-gm-message-state;
	bh=1WvVx0d8GdYHQ0PMcQOuB7PmFrAqo98kyadlTSYZZaY=;
	b=a1sHqP9J0+HH6JaKhPwrcK9ry3KWrcb+gB82mUBq3i0yTp/qZyrjk+yTGr634drFmA
	6BezoznIRX5l+iaQhd1IV4ivQubdpI0sa/t7QqPXAKZL4IZel2ezYOJHuRKF43Bitgmq
	itiVqCcKQuNRKSZlAjkc6weFXYT34w7oNN/ZJG4Z5SCXpXtDTgYUrwHrm+UNL8AeDCc/
	2dNg3CXh3SVPoZypDeRoZG0+PCaqsAMl137+QpcZ4SpE36tA3iJjQeiouNYZh62PhTCU
	tAKKzqskQFBrg3PIUs0GeefZUafAF3aPr3ERaHqhnEX/61XUW2h0b8RwPnOpMgFwauh1
	GroQ==
MIME-Version: 1.0
Received: by 10.60.27.166 with SMTP id u6mr27663546oeg.86.1351583429040; Tue,
	30 Oct 2012 00:50:29 -0700 (PDT)
Received: by 10.60.12.161 with HTTP; Tue, 30 Oct 2012 00:50:29 -0700 (PDT)
Date: Tue, 30 Oct 2012 08:50:29 +0100
Message-ID: <CAJB+B4Xwq+O6pPr34ufVQ0Jnpis1gfxbVAyWWF+5eLin8CQ_-Q@mail.gmail.com>
From: Bue Petersen <bue@praqma.net>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQkfFJI2A6t5VGYV1+YjLIQsde+AulQZqGNX3/tjZcqAdj0yOdfbyoC5pFNbyDvP2A8Rqofi
Subject: SDK install path and versioning
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 30 Oct 2012 08:04:04 -0000
Content-Type: text/plain; charset=UTF-8

Hi,

We are using bitbake + openembedded to build a custom linux platform
with an image and a SDK for Qt development.
I have some questions on how to achive some goals regarding automated
testing. Really hope you can help.

1) how can we "stamp" a version number in the image? I found
IMAGE_BASENAME for changing the filename, but I would like also to
leave some kind of version number that can be checked on the running
system. What is best practice there?
2) Regarding the SDK I would like to install it on a custom path. The
normal setup is system-wide on /usr/local/ as I can see. I need to be
able to install several at different locations. Maybee even just in
the workspace where we develop the Qt-application so I always know
exactly which is used for the test. I found the SDKPATH and
SDKNATIVEPATH to change this, but do we really need to set the exact
path at build time?

I have done a lot of research and googled intensively, but still not
solved the problem so I really hope someone can help. Any hints will
be mostly appreciated.

Thanks.
Best regards,
Bue Petersen


