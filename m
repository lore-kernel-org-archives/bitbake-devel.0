Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id A20137D44D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 19:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 553C89C01CD;
	Fri, 17 May 2019 15:18:35 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 4iNSKA1xTKo9; Fri, 17 May 2019 15:18:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1D2159C0323;
	Fri, 17 May 2019 15:18:32 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id S7u7A6vOsg_d; Fri, 17 May 2019 15:18:32 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F0ED59C01CD;
	Fri, 17 May 2019 15:18:31 -0400 (EDT)
Date: Fri, 17 May 2019 15:18:31 -0400 (EDT)
From: Jean-marie Lemetayer <jean-marie.lemetayer@savoirfairelinux.com>
To: akuster <akuster@mvista.com>
Message-ID: <575051071.4784041.1558120711945.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <7ae99b0a-258f-9f52-265a-a9b2de251774@mvista.com>
References: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
	<7ae99b0a-258f-9f52-265a-a9b2de251774@mvista.com>
MIME-Version: 1.0
X-Mailer: Zimbra 8.8.11_GA_3737 (ZimbraWebClient - GC74 (Linux)/8.8.11_GA_3737)
Thread-Topic: NPM fixes
Thread-Index: lM2/+ABEIVRrdPKvxFnwcv1TLJLK/g==
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/4] NPM fixes
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
X-List-Received-Date: Fri, 17 May 2019 19:18:35 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Yes, I have tagged the patches but forgot to add a global explanation. Here it is:

 - PATCH 1/4: fix the bug:
     https://bugzilla.yoctoproject.org/show_bug.cgi?id=13344
 - PATCH 2/4: fix an extra case of the bug:
     https://bugzilla.yoctoproject.org/show_bug.cgi?id=12534
 - PATCH 3/4: fix the bug:
     https://bugzilla.yoctoproject.org/show_bug.cgi?id=13349
 - PATCH 4/4: initiate fix for the bug:
     https://bugzilla.yoctoproject.org/show_bug.cgi?id=11028


----- Original Message -----
From: "akuster" <akuster@mvista.com>
To: "Jean-Marie LEMETAYER" <jean-marie.lemetayer@savoirfairelinux.com>, bitbake-devel@lists.openembedded.org
Sent: Friday, May 17, 2019 5:32:44 PM
Subject: Re: [bitbake-devel] [PATCH 0/4] NPM fixes

On 5/17/19 8:14 AM, Jean-Marie LEMETAYER wrote:
> Hi folks,
>
> I have recently integrated a nodejs server with an angular application using
> poky and meta-openembedded (thud branch). Some fixes were needed to make it
> work.

Is this fixing YP bug:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=13344 ?

- armin
> Best regards,
> Jean-Marie
>
> Jean-Marie LEMETAYER (4):
>   bitbake: fetch2/npm: fix npw view parsing
>   npm: get npm package name from npm pack
>   npm: fix node and npm default directory conflict
>   npm: remove some temporary build files
>
>  bitbake/lib/bb/fetch2/npm.py | 19 +++++--------------
>  meta/classes/npm.bbclass     | 11 +++++++----
>  2 files changed, 12 insertions(+), 18 deletions(-)
>
> --
> 2.20.1
>

