Return-Path: <chmorgan@gmail.com>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
	[209.85.223.174])
	by mail.openembedded.org (Postfix) with ESMTP id C1F3D6CC7F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2013 13:22:36 +0000 (UTC)
Received: by mail-ie0-f174.google.com with SMTP id qd12so3367955ieb.19
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2013 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=B4dY03EcAyFSfB7Uj+fLPCvAckAU7AWYQHXRI1iHxWQ=;
	b=D4HZJunldy8L1R1seIOWt9uff3T2LO/5pi+IQJ8YXJpVa11CAqe38tHKp4qTa1JPb1
	GKNEK19Ge7rfd4GgD3WDdq3SxelUPbqrH7/JxPX38+xTYBx4Qqi/UKeiMqF/VQz1CxVK
	t90IFCtUcv1nmo4lSIHfPbpKJBh6fqa5bk8pvB/LNz/O5id0J8ZekuwLFXMEdlaNdjfU
	qcQtx65yoOuVB1T0cJLc/6pHm0XRoakYVKG35oZW2xJFZfMAJDe6eAiDq7JgdT9FeGT7
	enTB5L9T7r91/fVPSA8Jb7+Svh+2GG4dyzjCGopcrrdvcI7zTbK6/FqY/n+5A5C33Gux
	62Jg==
X-Received: by 10.43.101.138 with SMTP id da10mr242118icc.77.1381497757994;
	Fri, 11 Oct 2013 06:22:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.143.195 with HTTP; Fri, 11 Oct 2013 06:22:17 -0700 (PDT)
From: Chris Morgan <chmorgan@gmail.com>
Date: Fri, 11 Oct 2013 09:22:17 -0400
Message-ID: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Bitbake for native x86 project?
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
X-List-Received-Date: Fri, 11 Oct 2013 13:22:37 -0000
Content-Type: text/plain; charset=ISO-8859-1

Hello.

I can't be sure that I'm asking the question correctly so please
forgive me if I've gotten something wrong here.

I'm working on a project that generates several libraries and
applications. Today we build and run exclusively on x86 Linux desktop
machines and use cmake for the build system. In the future we plan to
add cross-compiling of these same libraries and applications for an
embedded arm platform, Yocto based. We would like to maintain both
types of build, for x86 and for arm.

I've seen guides on how to use Yocto (or other bitbake based
distributions) to generate x86 images but these appear to involve
building the entire x86 toolchain, kernel, all libraries, creating a
virtual root and building a root filesystem image that one would run
under an emulator.

In my case I'd like to use bitbake to build libraries and applications
and create a virtual root, but not create a kernel, toolchain and
other system provided libraries. Then, when we decide to transition
over to Yocto I'd like to leverage the recipes by plugging them into
the Yocto system somehow (I'm still starting to understand the
process).

I haven't seen any guides or information on how to use bitbake for
native desktop applications. I feel like its certainly possible but it
appears to be quite a bit of work just to proof of concept things.

Is there anything inherently wrong with what I'm proposing here with
bitbake? Does it make sense that it would save time to develop the
recipes once and use bitbake for the desktop like this?

Chris

