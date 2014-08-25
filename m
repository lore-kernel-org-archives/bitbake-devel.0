Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 756C160E49;
	Mon, 25 Aug 2014 15:24:57 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id s7PFOwUR022346
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 25 Aug 2014 08:24:59 -0700 (PDT)
Received: from Marks-MacBook-Pro.local (172.25.36.226) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.174.1; Mon, 25 Aug 2014 08:24:58 -0700
Message-ID: <53FB5549.3020504@windriver.com>
Date: Mon, 25 Aug 2014 10:24:57 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9;
	rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <D435FD3B-FAF6-4EA2-BADF-95F56CD6775F@sd-kyber.com>
In-Reply-To: <D435FD3B-FAF6-4EA2-BADF-95F56CD6775F@sd-kyber.com>
Cc: Patches and discussions about the oe-core layer
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
X-List-Received-Date: Mon, 25 Aug 2014 15:24:59 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit

First this is the wrong list.  The question should have gone to oe-core devel, 
or openembedded-devel lists.  (I have CC'd the first)

On 8/21/14, 9:59 PM, info@sd-kyber.com wrote:
> Hi,
> I’m trying to write ( and to use ) a recipe which should build a simple  .rpm,
>   which contains the /usr/lib/libaffinity.so and a  few header files within
> /usr/include/affinity/* subdir.
>
> However, it looks like bitbake is trying / “forcing” me to  build a ${PN}-dbg
> package….:
>
> I’m doing the following steps:
>
> 1. recipe:
> “
> …
> inherit  cmake pkgconfig
>
> PACKAGES = "${PN}"
> FILES_${PN} = "${libdir}/libaffinity.so /usr/include/affinity/*”
> …
> “

Just removing '${PN}-dbg' does not inform the system that you do not want debug 
information to be generated.  There is a set of standard routines, performed 
after do_install, that will generate the debug information unless disabled.

To disable the routines you set:

INHIBIT_PACKAGE_DEBUG_SPLIT = '1'
INHIBIT_PACKAGE_STRIP = '1'

There are two settings they can be used separately, but in your case you likely 
want both.

INHIBIT_PACKAGE_DEBUG_SPLIT = '1' disables the files in your package from being 
split into run-time and debug components.

INHIBIT_PACKAGE_STRIP = '1' disabled the system from attempting to strip the 
run-time components of debug information.

--Mark

> So, I assume  I’ m asking to build only 1 package.
>
> 2. During the bitbake processing, as the compilation, build,  and installation
> are over, the  files are copied into the ${D} directory, as expected:
> “
> michael@localhost image]$ pwd
> /home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/affinityng/0.1-r0/image
> [michael@localhost image]$ cd usr
> [michael@localhost usr]$ ls -la
> total 16
> drwxr-xr-x. 4 michael michael 4096 Aug 21 19:57 .
> drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 ..
> drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 include
> drwxr-xr-x. 2 michael michael 4096 Aug 21 19:57 lib
> “
> So far, everything as expected in accordance with the Yocto reference.
>
> 3. According to the manual reference  - "The |do_package| and
> |do_packagedata| tasks combine to analyze the files found in the |D|
> <http://www.yoctoproject.org/docs/current/ref-manual/ref-manual.html#var-D> directory…”,
>   I would expect that the package would be build.
> However, the  attempt to build is failing. with the error:
> “…
> ERROR: QA Issue: affinityng: Files/directories were installed but not shipped
>    /usr/src
>    /usr/lib/.debug
>    /usr/lib/.debug/libaffinity.so
>    /usr/src/debug
>    /usr/src/debug/affinityng
>    /usr/src/debug/affinityng/0.1-r0
>    /usr/src/debug/affinityng/0.1-r0/kernel
> …
> “
>
> 4. Following the reference, I checked the PKGD directory, where the files should
> be before split….
> And I noticed that there is the src directory there,  in addition to
>   directories — include and lib — the only ones I was expecting to see there.
> ( see log below ) .
>
> “
> /home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/affinityng/0.1-r0/package/usr
> ….
> [michael@localhost usr]$ ls -la
> total 20
> drwxr-xr-x. 5 michael michael 4096 Aug 21 19:57 .
> drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 ..
> drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 include
> drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 lib
> drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 src
> [michael@localhost usr]$ pwd
> /home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/affinityng/0.1-r0/package/usr
> [michael@localhost usr]$ cd src
> [michael@localhost src]$ ls -la
> total 12
> drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 .
> drwxr-xr-x. 5 michael michael 4096 Aug 21 19:57 ..
> drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 debug
> [michael@localhost src]$
> “
> 5. It looks like that as result of package split, the  include & lib directories
> are used properly to build affinityng package, at least it is shown in
> packages-split properly.
> But then ,  the content of the src directory is causing the problem with QA.
>
> 6. At the same time, if I ask to build  ${PN}-dbg package in addition - both
> packages are build, no QA complains, and all src/debug/* are going into the -dbg
> package…
>
> I wonder,
> - why does the src directory appear within  PKGD/usr? ( If there is no such
> directory within the ${D} directory...)
> - where is the definition for  -dbg package is coming from, and is it possible
> to disable it?
>
> May be somebody have the answer or suggestion what to check next….
>
> Thanks for a kind attention to the matter.
>
> Have a great day,
> Michael.
>
>
>


