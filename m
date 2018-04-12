Return-Path: <jakub.debski@enigma.com.pl>
X-Greylist: delayed 317 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 12 Apr 2018 13:17:54 UTC
Received: from mail.enigma.com.pl (mail.enigma.com.pl [91.198.145.120])
	by mail.openembedded.org (Postfix) with ESMTP id E18A972EC7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Apr 2018 13:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.enigma.com.pl (Postfix) with ESMTP id 0DA7B171621C06;
	Thu, 12 Apr 2018 15:12:38 +0200 (CEST)
Received: from mail.enigma.com.pl ([127.0.0.1])
	by localhost (mail.enigma.com.pl [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id t2Y4BfMrTjW7; Thu, 12 Apr 2018 15:12:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.enigma.com.pl (Postfix) with ESMTP id 5BDAC171621C3E;
	Thu, 12 Apr 2018 15:12:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail.enigma.com.pl
Received: from mail.enigma.com.pl ([127.0.0.1])
	by localhost (mail.enigma.com.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UHJs85N1woxl; Thu, 12 Apr 2018 15:12:37 +0200 (CEST)
Received: from mail.enigma.com.pl (localhost [127.0.0.1])
	by mail.enigma.com.pl (Postfix) with ESMTP id 391A8171621C06;
	Thu, 12 Apr 2018 15:12:37 +0200 (CEST)
Date: Thu, 12 Apr 2018 15:12:36 +0200 (CEST)
From: Jakub =?utf-8?Q?D=C4=99bski?= <jakub.debski@enigma.com.pl>
To: Mikko Rapeli <Mikko.Rapeli@bmw.de>
Message-ID: <1503144441.3803647.1523538756955.JavaMail.zimbra@enigma.com.pl>
In-Reply-To: <20180412101612.GJ7593@hiutale>
References: <1523526293-14340-1-git-send-email-jdebski@enigma.com.pl>
	<20180412101612.GJ7593@hiutale>
MIME-Version: 1.0
X-Originating-IP: [10.13.11.10]
X-Mailer: Zimbra 8.6.0_GA_1200 (ZimbraWebClient - GC65 (Linux)/8.6.0_GA_1200)
Thread-Topic: fetch2/git.py: Added handling of the user's password in url
Thread-Index: AQHT0kdIZiIda1X5FUSkbv9u2CUdK15KdZOw
X-Mailman-Approved-At: Wed, 18 Apr 2018 12:11:06 +0000
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/git.py: Added handling of the user's password in url
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
X-List-Received-Date: Thu, 12 Apr 2018 13:17:55 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Maybe this is by design to prevent credentials leaking into bitbake
> recipes.
>
> Alternative is to set the usernames, passwords etc in e.g. ~/.netrc
> and ~/.ssh/config files which have the same effect.
>
> -Mikko

Certainly, credentials could be set in other ways, but there is some=20
inconsistency with other fetchers (e.g. perforce, wget, hg) which=20
use password from SRC_URI.

--
Jakub D=C4=99bski

