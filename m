Return-Path: <markus.eich@dfki.de>
Received: from sea-mail.dfki.de (sea-mail.dfki.de [134.96.191.185])
	by mail.openembedded.org (Postfix) with ESMTP id 5A1C465DB1
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Jul 2014 14:18:58 +0000 (UTC)
Received: from sea-mail.dfki.de (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id
	A8376C846B_3B414D2B; Wed,  2 Jul 2014 14:18:58 +0000 (GMT)
Received: from mail.dfki.de (lnv-104.sb.dfki.de [134.96.191.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by sea-mail.dfki.de (Sophos Email Appliance) with ESMTPS id
	74F83C846A_3B414D2F; Wed,  2 Jul 2014 14:18:58 +0000 (GMT)
Received: from [10.250.7.83] (unknown [10.250.7.83])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.dfki.de (Postfix) with ESMTPSA id 5AE873110A;
	Wed,  2 Jul 2014 16:18:58 +0200 (CEST)
Message-ID: <53B414D2.8080309@dfki.de>
Date: Wed, 02 Jul 2014 16:18:58 +0200
From: "Dr. Markus Eich" <markus.eich@dfki.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <53AD22C1.8010602@dfki.de> <1403866737.28648.6.camel@ted>
In-Reply-To: <1403866737.28648.6.camel@ted>
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
X-List-Received-Date: Wed, 02 Jul 2014 14:19:04 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I have analyzed the issue further. In the kernel source code, (taken 
from git://github.com/hardkernel/linux.git"

there is no symlink loop in the git sources. While calling

bitbake linux-hardkernel

the command do_package somehow creates a recursive symlink in the folder

==
build/tmp/work/odroid_xu-poky-linux-gnueabi/linux-hardkernel/3.4-r0/package/usr/src/kernel/drivers/gpu/arm/mali400/ump/arch/arch-release
==


arch-release is a symlink to arch-release. I have removed the link with 
rm -rf arch-release

after I call "bitbake -c package linux-hardkernel" the recursive link is 
there again causing the error again? Why does do_package create this 
link? Black magic?


Cheers,

Markus





On 27.06.2014 12:58, Richard Purdie wrote:
> On Fri, 2014-06-27 at 09:52 +0200, Dr. Markus Eich wrote:
>> Dear all,
>>
>> I am setting up Yocto to compile my kernel for odroid xu. During the
>> package phase of building the kernel, I get an error in cachedpath.py
>>
>> ================
>>
>> DEBUG: Executing python function sstate_task_prefunc
>> DEBUG: Python function sstate_task_prefunc finished
>> DEBUG: Executing python function do_package
>> DEBUG: Executing python function package_get_auto_pr
>> DEBUG: Python function package_get_auto_pr finished
>> DEBUG: Executing python function perform_packagecopy
>> DEBUG: Python function perform_packagecopy finished
>> DEBUG: Executing python function split_and_strip_files
>> ERROR: Error executing a python function in
>> /home/eich/yocto/poky/meta-odroid/recipes-kernel/linux/linux-hardkernel_3.4.bb:
>>
>> The stack trace of python calls that resulted in this exception/failure
>> was:
>> File: 'split_and_strip_files', lineno: 222, function: <module>
>>        0218:    # End of strip
>>        0219:    #
>>        0220:
>>        0221:
>>    *** 0222:split_and_strip_files(d)
>>        0223:
>> File: 'split_and_strip_files', lineno: 85, function: split_and_strip_files
>>        0081:                if debugdir and debugdir in
>> os.path.dirname(file[len(dvar):]):
>>        0082:                    continue
>>        0083:
>>        0084:                try:
>>    *** 0085:                    ltarget = cpath.realpath(file, dvar, False)
>>        0086:                    s = cpath.lstat(ltarget)
>>        0087:                except OSError as e:
>>        0088:                    (err, strerror) = e.args
>>        0089:                    if err != errno.ENOENT:
>> File: '/home/eich/yocto/poky/meta/lib/oe/cachedpath.py', lineno: 229,
>> function: realpath
>>        0225:                # be printed a backtrace with 100s of OSError
>> exceptions
>>        0226:                # else
>>        0227:                raise OSError(errno.ELOOP,
>>        0228:                              "too much recursions while
>> resolving '%s'; loop in '%s'" %
>>    *** 0229:                              (file, e.strerror))
>>        0230:
>>        0231:            raise
>>        0232:
>>        0233:        return file
>> Exception: OSError: [Errno 40] too much recursions while resolving
>> '/home/eich/odroid/build/tmp/work/odroid_xu-poky-linux-gnueabi/linux-hardkernel/3.4-r0/package/usr/src/kernel/drivers/gpu/arm/mali400/ump/arch/arch-release';
>> loop in
>> '/home/eich/odroid/build/tmp/work/odroid_xu-poky-linux-gnueabi/linux-hardkernel/3.4-r0/package/usr/src/kernel/drivers/gpu/arm/mali400/ump/arch/arch-release'
>>
>> DEBUG: Python function split_and_strip_files finished
>> DEBUG: Python function do_package finished
>> ERROR: Function failed: split_and_strip_files
>>
>> ====================
>>
>> Seems that the path is to deep?
>>
>> To track the error, I have attached my kernel.bb
>>
>>
>> ==================
>> require recipes-kernel/linux/linux-yocto.inc
>>
>> KERNEL_IMAGETYPE = "uImage"
>>
>> COMPATIBLE_MACHINE = "odroid-xu"
>>
>> LINUX_VERSION = "3.4.91"
>> LINUX_VERSION_EXTENSION = "-custom"
>>
>> FILESEXTRAPATHS_prepend := "${THISDIR}/linux-hardkernel-3.4:"
>>
>> S = "${WORKDIR}/git"
>>
>> # from where to fetch the kernel
>> KERNEL_REPO_OWNER ??= "hardkernel"
>> KERNEL_REPO_URI ??= "git://github.com/${KERNEL_REPO_OWNER}/linux.git"
>> KBRANCH = "odroidxu-3.4.y"
>>
>> SRCREV = "${AUTOREV}"
>>
>> SRC_URI = " \
>>     ${KERNEL_REPO_URI};nocheckout=1;branch=${KBRANCH} \
>> file://defconfig \
>> "
>>
>>
>> Any ideas ?
> It sounds like you have recursive symlinks which just loop between each
> other...
>
> Cheers,
>
> Richard
>

-- 
Dr.-Ing. Markus Eich

  Senior Researcher
  Marine Inspection Robotics
  Space Robotics
  
  Besuchsadresse der Nebengeschäftstelle:
  DFKI GmbH
  Robotics Innovation Center
  Robert-Hooke-Straße 5
  28359 Bremen, Germany
  
  Postadresse der Hauptgeschäftsstelle Standort Bremen:
  DFKI GmbH
  Robotics Innovation Center
  Robert-Hooke-Straße 1
  28359 Bremen, Germany

  Tel.:     +49 421 178 45-4105
  Zentrale: +49 421 178 45-0
  Fax:      +49 421 178 45-4150 (Faxe bitte namentlich kennzeichnen)
  E-Mail:   markus.eich@dfki.de

  Weitere Informationen: http://www.dfki.de/robotik
  -----------------------------------------------------------------------
  Deutsches Forschungszentrum fuer Kuenstliche Intelligenz GmbH
  Firmensitz: Trippstadter Straße 122, D-67663 Kaiserslautern
  Geschaeftsfuehrung: Prof. Dr. Dr. h.c. mult. Wolfgang Wahlster
  (Vorsitzender) Dr. Walter Olthoff
  Vorsitzender des Aufsichtsrats: Prof. Dr. h.c. Hans A. Aukes
  Amtsgericht Kaiserslautern, HRB 2313
  Sitz der Gesellschaft: Kaiserslautern (HRB 2313)
  USt-Id.Nr.:    DE 148646973
  Steuernummer:  19/673/0060/3
  -----------------------------------------------------------------------


