Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id A7D796A58B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2013 15:47:17 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r4SFlJan019237
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2013 08:47:19 -0700 (PDT)
Received: from Marks-MacBook-Pro.local (172.25.36.233) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.342.3; Tue, 28 May 2013 08:47:18 -0700
Message-ID: <51A4D192.1@windriver.com>
Date: Tue, 28 May 2013 10:47:30 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8;
	rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <tencent_46D42C6E52FC9B0E66414E4E@qq.com>
In-Reply-To: <tencent_46D42C6E52FC9B0E66414E4E@qq.com>
Subject: Re: Unpack failure for URL: 'http://zlib.net/pigz/pigz-2.3.tar.gz
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 28 May 2013 15:47:17 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/13 11:52 PM, lee wrote:
> Hi all:
> I build a project according to the yocto project quit start guide as follows:
>
>   $ wget http://downloads.yoctoproject.org/releases/yocto/yocto-1.4/poky-dylan-9.0.tar.bz2
>   $ tar xjf poky-dylan-9.0.tar.bz2
>   $ cd poky-dylan-9.0
>   $ source oe-init-build-env
>
> $ bitbake -k core-image-sato
>
> the result failed ,and print the following error log, can you give some suggestion to resolve this issue? thanks
>
> Pseudo is not present but is required, building this first before the main build
> Loading cache: 100% |###########################################| ETA:  00:00:00
> Loaded 1121 entries from dependency cache.
>
> Build Configuration:
> BB_VERSION        = "1.18.0"
> BUILD_SYS         = "i686-linux"
> NATIVELSBSTRING   = "Ubuntu-10.04"
> TARGET_SYS        = "i586-poky-linux"
> MACHINE           = "qemux86"
> DISTRO            = "poky"
> DISTRO_VERSION    = "1.4"
> TUNE_FEATURES     = "m32 i586"
> TARGET_FPU        = ""
> meta
> meta-yocto
> meta-yocto-bsp    = "<unknown>:<unknown>"
>
> NOTE: Resolving any missing task queue dependencies
> NOTE: Preparing runqueue
> NOTE: Executing SetScene Tasks
> NOTE: Executing RunQueue Tasks
> ERROR: Function failed: Unpack failure for URL: 'http://zlib.net/pigz/pigz-2.3.tar.gz'. Unpack command PATH="/home/lijilong/poky-dylan-9.0.0/scripts/native-intercept:/home/lijilong/poky-dylan-9.0.0/scripts:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux/usr/bin/i586-linux:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux/usr/bin:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux/usr/sbin:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux/usr/bin:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux/sbin:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux//bin:/home/lijilong/poky-dylan-9.0.0/bitbake/bin:/home/lijilong/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games" tar xz --no-same-owner -f /home/lijilong/poky-dylan-9.0.0/build/downloads/pigz-2.3.tar.gz failed with return value 2
> ERROR: Logfile of failure stored in: /home/lijilong/poky-dylan-9.0.0/build/tmp/work/i686-linux/pigz-native/2.3-r1/temp/log.do_unpack.6223
> Log data follows:
> | DEBUG: Executing python function do_unpack
> | DEBUG: Executing python function base_do_unpack
> | NOTE: Unpacking /home/lijilong/poky-dylan-9.0.0/build/downloads/pigz-2.3.tar.gz to /home/lijilong/poky-dylan-9.0.0/build/tmp/work/i686-linux/pigz-native/2.3-r1/
> |
> | gzip: stdin: invalid compressed data--crc error
> | tar: Child returned status 1
> | tar: Error is not recoverable: exiting now
> | DEBUG: Python function base_do_unpack finished
> | DEBUG: Python function do_unpack finished
> | ERROR: Function failed: Unpack failure for URL: 'http://zlib.net/pigz/pigz-2.3.tar.gz'. Unpack command PATH="/home/lijilong/poky-dylan-9.0.0/scripts/native-intercept:/home/lijilong/poky-dylan-9.0.0/scripts:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux/usr/bin/i586-linux:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux/usr/bin:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux/usr/sbin:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux/usr/bin:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux/sbin:/home/lijilong/poky-dylan-9.0.0/build/tmp/sysroots/i686-linux//bin:/home/lijilong/poky-dylan-9.0.0/bitbake/bin:/home/lijilong/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games" tar xz --no-same-owner -f /home/lijilong/poky-dylan-9.0.0/build/downloads/pigz-2.3.tar.gz failed with return value 2
> ERROR: Task 112 (virtual:native:/home/lijilong/poky-dylan-9.0.0/meta/recipes-extended/pigz/pigz_2.3.bb, do_unpack) failed with exit code '1'
> NOTE: Tasks Summary: Attempted 58 tasks of which 57 didn't need to be rerun and 1 failed.
> No currently running tasks (58 of 119)

Either the download is corrupted, you are having disk errors -- or more likely 
the gzip on your system is old and causing some kind of incompatibility with the 
system.

What version of gzip are you running and what host OS are you using?

--Mark

> Summary: 1 task failed:
>    virtual:native:/home/lijilong/poky-dylan-9.0.0/meta/recipes-extended/pigz/pigz_2.3.bb, do_unpack
> Summary: There was 1 ERROR message shown, returning a non-zero exit code.
>
>
>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


