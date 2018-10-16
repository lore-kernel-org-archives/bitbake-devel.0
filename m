Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 084A479894
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Oct 2018 20:19:52 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	w9GKJoDm001847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Tue, 16 Oct 2018 21:19:51 +0100
Message-ID: <f8a9b0cd632c8561496b3928b3b2e49775063ae4.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Tue, 16 Oct 2018 21:19:50 +0100
In-Reply-To: <20181015134255.4634-1-urs.fassler@bbv.ch>
References: <20181015134255.4634-1-urs.fassler@bbv.ch>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.1 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH 0/7] Add symlinks for git (shallow) tarballs when name differs due to mirror rewrite rules
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
X-List-Received-Date: Tue, 16 Oct 2018 20:19:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2018-10-15 at 13:43 +0000, Urs Fässler wrote:
> The git (shallow) tarballs are not found when certain mirror rewrite rules are
> in use. This is due to the fact that the tarball is named according to the url
> where it is downloaded from. The error occurs in the unpack step where BitBake
> looks for a tarball named after the url as specified in the recipe. By adding
> the symlinks BitBake finds the tarballs in the unpack step.
> 
> This is an alternative to the patches "Always use the url specified in the
> recipe as a base for the git shallow tarball naming" from the 23.07.2018. This
> solution is more aligned to the current implementation of BitBake.

This patch series does look much more in keeping with the way bitbake
is written and is easier to review.

I tried it on the autobuilder and it resulted in:


https://autobuilder.yoctoproject.org/typhoon/#/builders/23/builds/120/steps/7/logs/step2b

I'm a bit nervous about accepting these in right now given we're so
close to releasing 2.6 :/.

Cheers,

Richard



