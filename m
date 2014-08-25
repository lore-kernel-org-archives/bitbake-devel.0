Return-Path: <raj.khem@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id 8FCF86FE3B;
	Mon, 25 Aug 2014 15:43:14 +0000 (UTC)
Received: by mail-pa0-f48.google.com with SMTP id et14so21056146pad.7
	for <multiple recipients>; Mon, 25 Aug 2014 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=mDOMxdYF5/y6tPPfki+CTEbF0sTDypPjWmKvoV8s4iM=;
	b=nEY9DU3vq4uNh1YYm2KaEHZHfKomAup/KcdstkmI3/ueRGdeHnobapa5XsGhUVWnFA
	lqrAkxfQkO5Drooj7Z86jLBxMHfDyM3Ig0Fb86hr37V+aEX4SxrjlMhwP9GzH4EHHMiP
	49QiJbBI4c/azBD6al9bWTz9RgYli9AMa1uo+KgAP0civywpxObyRdUcQEgQT5T+a8VX
	hCW8HkIDHfmRRccG/tHglipMkIz5FixFcoGvB9kUPZocle11BBsWfDdJEZAycMBCtVZT
	Ect7NYmsFxyHV+0x/z/W3ohBONVWUWw9r6GXA0UhVRxt8+ZUtxS8u4HsnflOhr3JcJ3x
	aDIQ==
X-Received: by 10.70.95.138 with SMTP id dk10mr5396604pdb.66.1408981394945;
	Mon, 25 Aug 2014 08:43:14 -0700 (PDT)
Received: from haswell ([2601:9:3580:7a5:baca:3aff:fe80:aa8f])
	by mx.google.com with ESMTPSA id zm5sm129672pbb.76.2014.08.25.08.43.13
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 25 Aug 2014 08:43:14 -0700 (PDT)
Date: Mon, 25 Aug 2014 08:46:57 -0700
From: Khem Raj <raj.khem@gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Message-ID: <20140825154657.GA21358@haswell>
References: <D435FD3B-FAF6-4EA2-BADF-95F56CD6775F@sd-kyber.com>
	<53FB5549.3020504@windriver.com>
MIME-Version: 1.0
In-Reply-To: <53FB5549.3020504@windriver.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel@lists.openembedded.org,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: *-dbg package...
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
X-List-Received-Date: Mon, 25 Aug 2014 15:43:18 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 14-08-25 10:24:57, Mark Hatle wrote:
> First this is the wrong list.  The question should have gone to oe-core
> devel, or openembedded-devel lists.  (I have CC'd the first)
> 
> On 8/21/14, 9:59 PM, info@sd-kyber.com wrote:
> >Hi,
> >I’m trying to write ( and to use ) a recipe which should build a simple  .rpm,
> >  which contains the /usr/lib/libaffinity.so and a  few header files within
> >/usr/include/affinity/* subdir.

if you install it right then you should get one rpm with library another
one ${PN}-dev which should contain the headers and all debug info will
be split out into a rpm of its own ${PN}-dbg, this is standard
packaging strategy in OE.


> >
> >However, it looks like bitbake is trying / “forcing” me to  build a ${PN}-dbg
> >package….:

Yes it will, is there any issue with that ?


> >
> >I’m doing the following steps:
> >
> >1. recipe:
> >“
> >…
> >inherit  cmake pkgconfig
> >
> >PACKAGES = "${PN}"

overriding PACKAGES will leave some unpackaged files.

> >FILES_${PN} = "${libdir}/libaffinity.so /usr/include/affinity/*”
> >…

I would suggest to use standard packaging split if thats not a big
issue.

> >“
> 
> Just removing '${PN}-dbg' does not inform the system that you do not want
> debug information to be generated.  There is a set of standard routines,
> performed after do_install, that will generate the debug information unless
> disabled.
> 
> To disable the routines you set:
> 
> INHIBIT_PACKAGE_DEBUG_SPLIT = '1'
> INHIBIT_PACKAGE_STRIP = '1'
> 
> There are two settings they can be used separately, but in your case you
> likely want both.
> 
> INHIBIT_PACKAGE_DEBUG_SPLIT = '1' disables the files in your package from
> being split into run-time and debug components.
> 
> INHIBIT_PACKAGE_STRIP = '1' disabled the system from attempting to strip the
> run-time components of debug information.
> 
> --Mark
> 
> >So, I assume  I’ m asking to build only 1 package.
> >
> >2. During the bitbake processing, as the compilation, build,  and installation
> >are over, the  files are copied into the ${D} directory, as expected:
> >“
> >michael@localhost image]$ pwd
> >/home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/affinityng/0.1-r0/image
> >[michael@localhost image]$ cd usr
> >[michael@localhost usr]$ ls -la
> >total 16
> >drwxr-xr-x. 4 michael michael 4096 Aug 21 19:57 .
> >drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 ..
> >drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 include
> >drwxr-xr-x. 2 michael michael 4096 Aug 21 19:57 lib
> >“
> >So far, everything as expected in accordance with the Yocto reference.
> >
> >3. According to the manual reference  - "The |do_package| and
> >|do_packagedata| tasks combine to analyze the files found in the |D|
> ><http://www.yoctoproject.org/docs/current/ref-manual/ref-manual.html#var-D> directory…”,
> >  I would expect that the package would be build.
> >However, the  attempt to build is failing. with the error:
> >“…
> >ERROR: QA Issue: affinityng: Files/directories were installed but not shipped
> >   /usr/src
> >   /usr/lib/.debug
> >   /usr/lib/.debug/libaffinity.so
> >   /usr/src/debug
> >   /usr/src/debug/affinityng
> >   /usr/src/debug/affinityng/0.1-r0
> >   /usr/src/debug/affinityng/0.1-r0/kernel
> >…
> >“
> >
> >4. Following the reference, I checked the PKGD directory, where the files should
> >be before split….
> >And I noticed that there is the src directory there,  in addition to
> >  directories — include and lib — the only ones I was expecting to see there.
> >( see log below ) .
> >
> >“
> >/home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/affinityng/0.1-r0/package/usr
> >….
> >[michael@localhost usr]$ ls -la
> >total 20
> >drwxr-xr-x. 5 michael michael 4096 Aug 21 19:57 .
> >drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 ..
> >drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 include
> >drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 lib
> >drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 src
> >[michael@localhost usr]$ pwd
> >/home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/affinityng/0.1-r0/package/usr
> >[michael@localhost usr]$ cd src
> >[michael@localhost src]$ ls -la
> >total 12
> >drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 .
> >drwxr-xr-x. 5 michael michael 4096 Aug 21 19:57 ..
> >drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 debug
> >[michael@localhost src]$
> >“
> >5. It looks like that as result of package split, the  include & lib directories
> >are used properly to build affinityng package, at least it is shown in
> >packages-split properly.
> >But then ,  the content of the src directory is causing the problem with QA.
> >
> >6. At the same time, if I ask to build  ${PN}-dbg package in addition - both
> >packages are build, no QA complains, and all src/debug/* are going into the -dbg
> >package…
> >
> >I wonder,
> >- why does the src directory appear within  PKGD/usr? ( If there is no such
> >directory within the ${D} directory...)
> >- where is the definition for  -dbg package is coming from, and is it possible
> >to disable it?
> >
> >May be somebody have the answer or suggestion what to check next….
> >
> >Thanks for a kind attention to the matter.
> >
> >Have a great day,
> >Michael.
> >
> >
> >
> 
> -- 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

