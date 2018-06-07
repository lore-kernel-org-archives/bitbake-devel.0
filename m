Return-Path: <bela@becker.rocks>
Received: from becker.rocks (catv-188-142-200-211.catv.broadband.hu
	[188.142.200.211])
	by mail.openembedded.org (Postfix) with ESMTP id 28A6C7881D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Jun 2018 14:22:14 +0000 (UTC)
Received: from maxion.localnet (catv-80-98-81-78.catv.broadband.hu
	[80.98.81.78]) by becker.rocks (Postfix) with ESMTPSA id 4F2F4E0693;
	Thu,  7 Jun 2018 16:22:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=becker.rocks; s=mail;
	t=1528381334; bh=ch5yVYhtjGqz3xl3jGYKhFfFh6IiQP0towxdww/vcH8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TNJCScyCspaercpyTaWFoWVQIsaQIz9JeQkjsv3V/b7Mbx1dTiL8kw150TWGB1rWn
	MW5sQIkZ0AuK57BiDwRonuc/QzCfHDqC4HK35jZEdRVb3IZU1Rf1f+0DXis/i19CR1
	0HKOw/7AC4txVl25cDfrfV4Y6LH9VxP2guY5k5GA=
From: Becker =?ISO-8859-1?Q?B=E9la?= <bela@becker.rocks>
To: bitbake-devel@lists.openembedded.org,
	Ugesh Reddy <kumar.ugesh003@yahoo.com>
Date: Thu, 07 Jun 2018 16:22:13 +0200
Message-ID: <1733334.CK9QxPupN9@maxion>
In-Reply-To: <341002747.6964097.1527612755247@mail.yahoo.com>
References: <341002747.6964097.1527612755247.ref@mail.yahoo.com>
	<341002747.6964097.1527612755247@mail.yahoo.com>
MIME-Version: 1.0
Subject: Re: Enabling the Macro in .bb
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
X-List-Received-Date: Thu, 07 Jun 2018 14:22:14 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On 2018. m=E1jus 29., kedd 18:52:35 CEST Ugesh Reddy via bitbake-devel wrot=
e:
> Hello,  I have the source code were the part of the code kept inside the =
#ifdef SOME_MACRO  and what would be the correct place to define SOME_MACRO=
  this macro?note: This define is specific to the recipe.
> Regrds,Ugesh

I'd add it to TARGET_CFLAGS.
I.e TARGET_CFLAGS +=3D "-DSOME_MACRO"



