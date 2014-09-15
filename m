Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (unknown [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CB85B6FC4C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Sep 2014 10:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8FAF2Y5009560; Mon, 15 Sep 2014 11:15:02 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id b9Nd1LfwNyKe; Mon, 15 Sep 2014 11:15:02 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8FAEu6e009556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 15 Sep 2014 11:14:58 +0100
Message-ID: <1410776098.14624.19.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Burton, Ross" <ross.burton@intel.com>
Date: Mon, 15 Sep 2014 11:14:58 +0100
In-Reply-To: <CAJTo0LYab+y-sTjj414sR3LCW49bK2LLE1c67OYV23Q_8TW_pQ@mail.gmail.com>
References: <1410594626.14624.2.camel@ted>
	<CAJTo0LYab+y-sTjj414sR3LCW49bK2LLE1c67OYV23Q_8TW_pQ@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data_smart: Fix remove operator and its interaction with data expansion
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
X-List-Received-Date: Mon, 15 Sep 2014 10:15:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2014-09-14 at 21:17 +0100, Burton, Ross wrote:
> On 13 September 2014 08:50, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > If you have:
> >
> > FOO = "${bindir}/X Y"
> > FOO_remove = "${bindir}/X"
> >
> > the expected result is "Y". Currently this doesn't work since the removed
> > expressions are not expanded first. This patch adjusts things so the
> > expressions are expanded before being processed for removal.
> 
> Whilst the actual expansion works as expected now (consider this a
> tested-by), the output in bitbake -e doesn't make sense:
> 
> i.e. with PACKAGES_remove = "${PN}-staticdev ${PN}-locale" in a distro config:
> 
> # $PACKAGES [5 operations]
> #   set /home/ross/foo/poky/meta/conf/bitbake.conf:264
> #     "${PN}-dbg ${PN}-staticdev ${PN}-dev ${PN}-doc ${PN}-locale
> ${PACKAGE_BEFORE_PN} ${PN}"
> #   _remove /home/ross/foo/meta-foo/conf/distro/foo.conf:201
> #     "${PN}-staticdev ${PN}-locale"
> #   set /home/ross/foo/poky/meta/conf/documentation.conf:308
> #     [doc] "The list of packages to be created from the recipe."
> #   prepend /home/ross/foo/poky/meta/recipes-support/curl/curl_7.37.1.bb:43
> #     "lib${BPN} lib${BPN}-dev lib${BPN}-staticdev lib${BPN}-doc"
> #   _remove /home/ross/foo/meta-foo/recipes-support/curl/curl_%.bbappend:1
> #     "${PN}-dev"
> # computed:
> #   "lib${BPN} lib${BPN}-dev lib${BPN}-staticdev lib${BPN}-doc
> ${PN}-dbg ${PN}-staticdev ${PN}-dev ${PN}-doc ${PN}-locale
> ${PACKAGE_BEFORE_PN} ${PN}"
> PACKAGES="libcurl libcurl-dev libcurl-staticdev libcurl-doc curl-dbg
> curl-doc  curl"
> 
> The PACKAGES value is right, but the "computed" value displayed by -e isn't.

This is the "pre expansion" value, so its right but the comment needs
improving...

Cheers,

Richard



