Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7D27360E24
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Jun 2014 10:59:19 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s5RAx9do025457; Fri, 27 Jun 2014 11:59:09 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CVIBVuEM791T; Fri, 27 Jun 2014 11:59:09 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s5RAx36v025453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 27 Jun 2014 11:59:05 +0100
Message-ID: <1403866737.28648.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Dr. Markus Eich" <markus.eich@dfki.de>
Date: Fri, 27 Jun 2014 11:58:57 +0100
In-Reply-To: <53AD22C1.8010602@dfki.de>
References: <53AD22C1.8010602@dfki.de>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake: error in cachedpath.py
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
X-List-Received-Date: Fri, 27 Jun 2014 10:59:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2014-06-27 at 09:52 +0200, Dr. Markus Eich wrote:
> Dear all,
> 
> I am setting up Yocto to compile my kernel for odroid xu. During the 
> package phase of building the kernel, I get an error in cachedpath.py
> 
> ================
> 
> DEBUG: Executing python function sstate_task_prefunc
> DEBUG: Python function sstate_task_prefunc finished
> DEBUG: Executing python function do_package
> DEBUG: Executing python function package_get_auto_pr
> DEBUG: Python function package_get_auto_pr finished
> DEBUG: Executing python function perform_packagecopy
> DEBUG: Python function perform_packagecopy finished
> DEBUG: Executing python function split_and_strip_files
> ERROR: Error executing a python function in 
> /home/eich/yocto/poky/meta-odroid/recipes-kernel/linux/linux-hardkernel_3.4.bb:
> 
> The stack trace of python calls that resulted in this exception/failure 
> was:
> File: 'split_and_strip_files', lineno: 222, function: <module>
>       0218:    # End of strip
>       0219:    #
>       0220:
>       0221:
>   *** 0222:split_and_strip_files(d)
>       0223:
> File: 'split_and_strip_files', lineno: 85, function: split_and_strip_files
>       0081:                if debugdir and debugdir in 
> os.path.dirname(file[len(dvar):]):
>       0082:                    continue
>       0083:
>       0084:                try:
>   *** 0085:                    ltarget = cpath.realpath(file, dvar, False)
>       0086:                    s = cpath.lstat(ltarget)
>       0087:                except OSError as e:
>       0088:                    (err, strerror) = e.args
>       0089:                    if err != errno.ENOENT:
> File: '/home/eich/yocto/poky/meta/lib/oe/cachedpath.py', lineno: 229, 
> function: realpath
>       0225:                # be printed a backtrace with 100s of OSError 
> exceptions
>       0226:                # else
>       0227:                raise OSError(errno.ELOOP,
>       0228:                              "too much recursions while 
> resolving '%s'; loop in '%s'" %
>   *** 0229:                              (file, e.strerror))
>       0230:
>       0231:            raise
>       0232:
>       0233:        return file
> Exception: OSError: [Errno 40] too much recursions while resolving 
> '/home/eich/odroid/build/tmp/work/odroid_xu-poky-linux-gnueabi/linux-hardkernel/3.4-r0/package/usr/src/kernel/drivers/gpu/arm/mali400/ump/arch/arch-release'; 
> loop in 
> '/home/eich/odroid/build/tmp/work/odroid_xu-poky-linux-gnueabi/linux-hardkernel/3.4-r0/package/usr/src/kernel/drivers/gpu/arm/mali400/ump/arch/arch-release'
> 
> DEBUG: Python function split_and_strip_files finished
> DEBUG: Python function do_package finished
> ERROR: Function failed: split_and_strip_files
> 
> ====================
> 
> Seems that the path is to deep?
> 
> To track the error, I have attached my kernel.bb
> 
> 
> ==================
> require recipes-kernel/linux/linux-yocto.inc
> 
> KERNEL_IMAGETYPE = "uImage"
> 
> COMPATIBLE_MACHINE = "odroid-xu"
> 
> LINUX_VERSION = "3.4.91"
> LINUX_VERSION_EXTENSION = "-custom"
> 
> FILESEXTRAPATHS_prepend := "${THISDIR}/linux-hardkernel-3.4:"
> 
> S = "${WORKDIR}/git"
> 
> # from where to fetch the kernel
> KERNEL_REPO_OWNER ??= "hardkernel"
> KERNEL_REPO_URI ??= "git://github.com/${KERNEL_REPO_OWNER}/linux.git"
> KBRANCH = "odroidxu-3.4.y"
> 
> SRCREV = "${AUTOREV}"
> 
> SRC_URI = " \
>    ${KERNEL_REPO_URI};nocheckout=1;branch=${KBRANCH} \
> file://defconfig \
> "
> 
> 
> Any ideas ?

It sounds like you have recursive symlinks which just loop between each
other...

Cheers,

Richard


