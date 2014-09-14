Return-Path: <ross.burton@intel.com>
Received: from mail-qa0-f53.google.com (mail-qa0-f53.google.com
	[209.85.216.53])
	by mail.openembedded.org (Postfix) with ESMTP id E466765D58
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Sep 2014 20:17:22 +0000 (UTC)
Received: by mail-qa0-f53.google.com with SMTP id n8so2971374qaq.12
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Sep 2014 13:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=WQJG6K3I/unI2TPWbslyGkEeHQ7LEy8uQ86bkdXzxsQ=;
	b=KhQqXbVPUMt0SvmPbv97RDeFEcaycXBjX0J4xLZUyzfTb1irSVxJAkHXGiSN3FOPv1
	Jtgn4rbro1QwYXviOtcIxPysEdtIm+RxGQ9q7D+feESftg6n6/4O1qcHhFo6r6S2d+Pm
	CQnsygrRe0dj+tqZ0zWK+IjWkJtSGkX5D76RZSY/pL6uluJvQ/T3LlU/XE3D0zXvlWAP
	PRyCrkcCjF4RUmBFnQxbtZQQSQ7/fnoR+NgbBwk/UtV5rRc26egirLbY29Xa4uAU7bgk
	hL1OnaYNUwSua6lRsNv1c6MKssXEgC/Wst9KremvV4It3+6boVJSdy2K4qig6+UHXyWh
	eDjg==
X-Gm-Message-State: ALoCoQnO4j13OlP53YLeJ4Uepy6rLZXAruvqBVMsGO3PcymCqEtSRLDTWiDv3Xz0ZAZ946JRQ1mk
X-Received: by 10.229.238.133 with SMTP id ks5mr30653940qcb.23.1410725843475; 
	Sun, 14 Sep 2014 13:17:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.29.183 with HTTP; Sun, 14 Sep 2014 13:17:03 -0700 (PDT)
In-Reply-To: <1410594626.14624.2.camel@ted>
References: <1410594626.14624.2.camel@ted>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Sun, 14 Sep 2014 21:17:03 +0100
Message-ID: <CAJTo0LYab+y-sTjj414sR3LCW49bK2LLE1c67OYV23Q_8TW_pQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
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
X-List-Received-Date: Sun, 14 Sep 2014 20:17:25 -0000
Content-Type: text/plain; charset=UTF-8

On 13 September 2014 08:50, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> If you have:
>
> FOO = "${bindir}/X Y"
> FOO_remove = "${bindir}/X"
>
> the expected result is "Y". Currently this doesn't work since the removed
> expressions are not expanded first. This patch adjusts things so the
> expressions are expanded before being processed for removal.

Whilst the actual expansion works as expected now (consider this a
tested-by), the output in bitbake -e doesn't make sense:

i.e. with PACKAGES_remove = "${PN}-staticdev ${PN}-locale" in a distro config:

# $PACKAGES [5 operations]
#   set /home/ross/foo/poky/meta/conf/bitbake.conf:264
#     "${PN}-dbg ${PN}-staticdev ${PN}-dev ${PN}-doc ${PN}-locale
${PACKAGE_BEFORE_PN} ${PN}"
#   _remove /home/ross/foo/meta-foo/conf/distro/foo.conf:201
#     "${PN}-staticdev ${PN}-locale"
#   set /home/ross/foo/poky/meta/conf/documentation.conf:308
#     [doc] "The list of packages to be created from the recipe."
#   prepend /home/ross/foo/poky/meta/recipes-support/curl/curl_7.37.1.bb:43
#     "lib${BPN} lib${BPN}-dev lib${BPN}-staticdev lib${BPN}-doc"
#   _remove /home/ross/foo/meta-foo/recipes-support/curl/curl_%.bbappend:1
#     "${PN}-dev"
# computed:
#   "lib${BPN} lib${BPN}-dev lib${BPN}-staticdev lib${BPN}-doc
${PN}-dbg ${PN}-staticdev ${PN}-dev ${PN}-doc ${PN}-locale
${PACKAGE_BEFORE_PN} ${PN}"
PACKAGES="libcurl libcurl-dev libcurl-staticdev libcurl-doc curl-dbg
curl-doc  curl"

The PACKAGES value is right, but the "computed" value displayed by -e isn't.

Ross

