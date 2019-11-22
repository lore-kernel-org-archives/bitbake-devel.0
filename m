Return-Path: <raj.khem@gmail.com>
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
	[209.85.160.176])
	by mail.openembedded.org (Postfix) with ESMTP id E1ECC7FC77
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2019 00:38:42 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id 59so359413qtg.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 16:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=5ptekI4Lz3pMT0Q4EMpeVVM3VDlawcbVlqVX3LC9Ehs=;
	b=rlOz5hXX6U+lfXFneb5sFawOgPXAARDJTqZOLd6QvKJqKGv5ggMfWkEWaNkUwp/4+n
	MyEl8cegoa3/epfb/ZoTmIk1eYVW/wLqRWFbYwHx8D6TXysEdFapAYnsV8RiVf7kjY+C
	ZCltZANg5sqrfiA4cTnd0YtMxnnJhtk/VeGnEtsjm6gNb2F4lgk8L1eiUickMY3YOsaa
	ehNMOI3qhxPIEofhD8wRKabUS3mHwxA1GEGT1bwbfuwes6qc81hem4Ey9dkLv3fVvrja
	+3Q1pG+hpRbPpA6XxsH7890+2wmsoz3lX8YXCPDgjLdTD8p4tARzV6pHYmikTf7zs61+
	kQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=5ptekI4Lz3pMT0Q4EMpeVVM3VDlawcbVlqVX3LC9Ehs=;
	b=udMpUnyTKN+8fiLnI3vpSTasgwNE+0BpQqWtAVutOHhpJTYD2/mG6LIGwv+3YAgn+1
	hcVcM3v3Y1yYF7A26jZ0yPVRD8biMziPbB3XbQPRTFvx+0iT9C3FNM5TKib9iK2r+YBZ
	P0i3c7ns604cpUQsLKvKK175bqFd8Bqrldxcz7v81NS8cceYNQboiZN/f0/JbfbJD+LD
	1tEkaIbeAXM7I99jhZe9CN6d4BwZElscNly3syntG5p31R5bX1vwCjJoCwyh9ioeaWk+
	mHfQmWLi/XaQcPBZBsTjnjT8Z0JXLDHn9yF6H5FS++s01XL2JEryEZJ72//xasaqvD5E
	mYbA==
X-Gm-Message-State: APjAAAVrWTphMIgTpIMtAnXztCX5eoit3HBMVRjRGouVCwD6D6PytKsK
	YMTs8KdXIp4rvOFs6w8LCGmnTXwQfAvbFnO4Vlo=
X-Google-Smtp-Source: APXvYqx9rOuRKAm2uFDFOp4gy8VbNWSzp7jiahqSxT1PPB6NsS0t03eBhV9zGQRILrcMDaoqaoZNjwuLRCCegA/Fc/Y=
X-Received: by 2002:ac8:2ddc:: with SMTP id q28mr3398564qta.88.1574383123495; 
	Thu, 21 Nov 2019 16:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20191121205415.25946-1-richard.purdie@linuxfoundation.org>
	<20191121205415.25946-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20191121205415.25946-2-richard.purdie@linuxfoundation.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Nov 2019 16:38:16 -0800
Message-ID: <CAMKF1sqZFNWQKAyK3sz5Hk32o55OeLPgsmhWGK0FLc1v=5W-bQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/5] opkg-utils: Fix silent empty/broken opkg package creation
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
X-List-Received-Date: Fri, 22 Nov 2019 00:38:43 -0000
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 21, 2019 at 12:54 PM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> opkg-build was failing on hosts where tar < 1.28 and reproducibile builds
> were enabled but it was doing this silently and generating corrupted
> (empty) ipk files. Add a fix for this (submitted upstream).
>
> The fix requires bash but if you're building ipk files this shoudn't be
> a problem.

is the problem similar to this one

http://cfajohnson.com/shell/cus-faq-2.html#Q11

does it impact build times when default shell is not bash ?

>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  .../opkg-utils/opkg-utils/pipefail.patch      | 31 +++++++++++++++++++
>  .../opkg-utils/opkg-utils_0.4.1.bb            |  3 ++
>  2 files changed, 34 insertions(+)
>  create mode 100644 meta/recipes-devtools/opkg-utils/opkg-utils/pipefail.patch
>
> diff --git a/meta/recipes-devtools/opkg-utils/opkg-utils/pipefail.patch b/meta/recipes-devtools/opkg-utils/opkg-utils/pipefail.patch
> new file mode 100644
> index 00000000000..55ddcc1fd20
> --- /dev/null
> +++ b/meta/recipes-devtools/opkg-utils/opkg-utils/pipefail.patch
> @@ -0,0 +1,31 @@
> +We need opkg-build to fail if for example the tar command is passed invalid
> +options. Without this, we see silently created empty packaged where data.tar
> +is zero bytes in size. This creates hard to debug problems.
> +
> +An example is when reproducible builds are enabled and run on old hosts like
> +centos7 which has tar < 1.28:
> +
> +Subprocess output:tar: unrecognized option '--clamp-mtime'
> +Try `tar --help' or `tar --usage' for more information.
> +
> +Upstream-Status: Pending
> +Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> +
> +Index: opkg-utils-0.4.1/opkg-build
> +===================================================================
> +--- opkg-utils-0.4.1.orig/opkg-build
> ++++ opkg-utils-0.4.1/opkg-build
> +@@ -1,4 +1,4 @@
> +-#!/bin/sh
> ++#!/bin/bash
> +
> + : <<=cut
> + =head1 NAME
> +@@ -12,6 +12,7 @@ opkg-build - construct an .opk from a di
> + #   Updated to work on Familiar Pre0.7rc1, with busybox tar.
> + #   Note it Requires: binutils-ar (since the busybox ar can't create)
> + set -e
> ++set -o pipefail
> +
> + version=1.0
> +
> diff --git a/meta/recipes-devtools/opkg-utils/opkg-utils_0.4.1.bb b/meta/recipes-devtools/opkg-utils/opkg-utils_0.4.1.bb
> index cf1e4670c65..eb6c7a3a6ad 100644
> --- a/meta/recipes-devtools/opkg-utils/opkg-utils_0.4.1.bb
> +++ b/meta/recipes-devtools/opkg-utils/opkg-utils_0.4.1.bb
> @@ -10,6 +10,7 @@ PROVIDES += "${@bb.utils.contains('PACKAGECONFIG', 'update-alternatives', 'virtu
>  SRC_URI = "http://git.yoctoproject.org/cgit/cgit.cgi/${BPN}/snapshot/${BPN}-${PV}.tar.gz \
>             file://0001-Switch-all-scripts-to-use-Python-3.x.patch \
>             file://0001-opkg-build-clamp-mtimes-to-SOURCE_DATE_EPOCH.patch \
> +           file://pipefail.patch \
>  "
>  UPSTREAM_CHECK_URI = "http://git.yoctoproject.org/cgit/cgit.cgi/opkg-utils/refs/"
>
> @@ -19,6 +20,8 @@ SRC_URI[sha256sum] = "9ea9efdd9fe13661ad251e3a2860c1c93045adcfaa6659c3e86d9748ec
>
>  TARGET_CC_ARCH += "${LDFLAGS}"
>
> +RDEPENDS_${PN} += "bash"
> +
>  # For native builds we use the host Python
>  PYTHONRDEPS = "python3 python3-shell python3-io python3-math python3-crypt python3-logging python3-fcntl python3-pickle python3-compression python3-stringold"
>  PYTHONRDEPS_class-native = ""
> --
> 2.20.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

