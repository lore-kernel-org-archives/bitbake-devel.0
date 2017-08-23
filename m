Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 762966FFD8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Aug 2017 10:22:32 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7NAMUf2012143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 23 Aug 2017 11:22:31 +0100
Message-ID: <1503483750.32591.142.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Wed, 23 Aug 2017 11:22:30 +0100
In-Reply-To: <20170821165708.13223-1-kergoth@gmail.com>
References: <20170821163741.28301-2-kergoth@gmail.com>
	<20170821165708.13223-1-kergoth@gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Wed, 23 Aug 2017 11:22:32 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCHv2] fetch2/gitsm: copy submodules from DL_DIR in unpack
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
X-List-Received-Date: Wed, 23 Aug 2017 10:22:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2017-08-21 at 21:57 +0500, Christopher Larson wrote:
> From: Christopher Larson <chris_larson@mentor.com>
> 
> Revert "fetch2/gitsm: Fix when repository change submodules"
> 
> This reverts commit 12f6c0651af8bd5d6efb751690571cf2fcd3eeb0.
> 
> This commit caused the gitsm fetcher to download submodules from
> upstream in
> do_unpack, rather than using the previously fetched submodules from
> DL_DIR.
> Also drop the pointless checkout, as Git.unpack() already handles
> this
> correctly.
> 
> [YOCTO #11830]
> 
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> ---
>  lib/bb/fetch2/gitsm.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 0aff1008..ed94c3d7 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -131,5 +131,6 @@ class GitSM(Git):
>          Git.unpack(self, ud, destdir, d)
>  
>          if self.uses_submodules(ud, d, ud.destdir):
> -            runfetchcmd(ud.basecmd + " checkout " +
> ud.revisions[ud.names[0]], d, workdir=ud.destdir)
> +            if not ud.shallow or ud.localpath != ud.fullshallow:
> +                runfetchcmd('cp -fpPRH "%s/modules" "%s/"' %
> (ud.clonedir, os.path.join(ud.destdir, '.git')), d)
>              runfetchcmd(ud.basecmd + " submodule update --init --
> recursive", d, workdir=ud.destdir)

With these two patches applied (as in master-next), I'm seeing:

$ oe-selftest -r devtool.DevtoolTests.test_devtool_add_fetch_git
2017-08-23 11:19:39,203 - oe-selftest - INFO - Adding layer libraries:
2017-08-23 11:19:39,204 - oe-selftest - INFO - 	/media/build1/poky/meta/lib
2017-08-23 11:19:39,204 - oe-selftest - INFO - 	/media/build1/poky/meta-yocto-bsp/lib
2017-08-23 11:19:39,204 - oe-selftest - INFO - 	/media/build1/poky/meta-selftest/lib
2017-08-23 11:19:39,204 - oe-selftest - INFO - Running bitbake -p
2017-08-23 11:19:41,433 - oe-selftest - INFO - Running tests...----------------------------------------------------------------------
2017-08-23 11:19:41,433 - oe-selftest - INFO - Adding: "include selftest.inc" in /media/build1/poky/build/conf/local.conf
2017-08-23 11:19:42,989 - oe-selftest - INFO -   test_devtool_add_fetch_git (devtool.DevtoolTests)
2017-08-23 11:20:14,813 - oe-selftest - WARNING - tearDown commands have failed: bitbake -c cleansstate mraa
2017-08-23 11:20:14,815 - oe-selftest - INFO -  ... FAIL (31.826s)
2017-08-23 11:20:14,819 - oe-selftest - INFO - ======================================================================
2017-08-23 11:20:14,819 - oe-selftest - INFO - FAIL [31.826s]: test_devtool_add_fetch_git (devtool.DevtoolTests)
2017-08-23 11:20:14,819 - oe-selftest - INFO - ----------------------------------------------------------------------
2017-08-23 11:20:14,819 - oe-selftest - INFO - Traceback (most recent call last):
  File "/media/build1/poky/meta/lib/oeqa/core/decorator/__init__.py", line 32, in wrapped_f
    return func(*args, **kwargs)
  File "/media/build1/poky/meta/lib/oeqa/selftest/cases/devtool.py", line 392, in test_devtool_add_fetch_git
    result = runCmd('devtool add %s %s -f "%s" -V 1.5' % (testrecipe, srcdir, url_rev))
  File "/media/build1/poky/meta/lib/oeqa/utils/commands.py", line 191, in runCmd
    raise AssertionError("Command '%s' returned non-zero exit status %d:\n%s" % (command, result.status, exc_output))
AssertionError: Command 'devtool add mraa /tmp/devtoolqa9peegimn/mraa -f "gitsm://git.yoctoproject.org/mraa;rev=ae127b19a50aa54255e4330ccfdd9a5d058e581d" -V 1.5' returned non-zero exit status 1:
NOTE: Starting bitbake server...
WARNING: -f/--fetch option is deprecated - you can now simply specify the URL to fetch as a positional argument instead
NOTE: Starting bitbake server...
NOTE: Fetching gitsm://git.yoctoproject.org/mraa;rev=ae127b19a50aa54255e4330ccfdd9a5d058e581d;nobranch=1...
NOTE: Starting bitbake server...
Loading cache...done.
Loaded 1292 entries from dependency cache.
Parsing recipes...done.
Parsing of 835 .bb files complete (834 cached, 1 parsed). 1290 targets, 74 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        = "1.35.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "universal"
TARGET_SYS        = "mips-poky-linux"
MACHINE           = "qemumips"
DISTRO            = "poky"
DISTRO_VERSION    = "2.3"
TUNE_FEATURES     = "o32 bigendian fpu-hard mips32r2"
TARGET_FPU        = ""
meta              
meta-poky         
meta-yocto-bsp    = "wip:fb706fa5934fab53c0858d7e9a36c07e3fb7bb65"
meta-mingw        = "master:0679d2a91575bd7f3efd0973aa99d7ee681e9395"
meta-selftest     
workspace         = "wip:fb706fa5934fab53c0858d7e9a36c07e3fb7bb65"

Initialising tasks...done.
NOTE: Executing RunQueue Tasks
ERROR: Fetcher failure: Fetch command export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"; export PATH="/media/build1/poky/build/tmp/sysroots-uninative/x86_64-linux/usr/bin:/media/build1/poky/scripts:/media/build1/poky/build/tmp/work/recipetool-1fxlbrau/work/recipe-sysroot-native/usr/bin/mips-poky-linux:/media/build1/poky/build/tmp/work/recipetool-1fxlbrau/work/recipe-sysroot/usr/bin/crossscripts:/media/build1/poky/build/tmp/work/recipetool-1fxlbrau/work/recipe-sysroot-native/usr/sbin:/media/build1/poky/build/tmp/work/recipetool-1fxlbrau/work/recipe-sysroot-native/usr/bin:/media/build1/poky/build/tmp/work/recipetool-1fxlbrau/work/recipe-sysroot-native/sbin:/media/build1/poky/build/tmp/work/recipetool-1fxlbrau/work/recipe-sysroot-native/bin:/media/build1/poky/bitbake/bin:/media/build1/poky/build/tmp/hosttools"; export HOME="/home/richard"; git -c core.fsyncobjectfiles=0 submodule update --init --recursive failed with exit code 1, output:
Submodule 'doxygen2jsdoc' (https://github.com/arfoll/doxygen2jsdoc.git) registered for path 'doxygen2jsdoc'
error: no such remote ref 9cc90b7976252b2d14b7956230c5870097e1f008
Fetched in submodule path 'doxygen2jsdoc', but it did not contain 9cc90b7976252b2d14b7956230c5870097e1f008. Direct fetching of that commit failed.

ERROR: Function failed: base_do_unpack
NOTE: Tasks Summary: Attempted 2 tasks of which 0 didn't need to be rerun and 1 failed.
ERROR: Failed to fetch URL gitsm://git.yoctoproject.org/mraa;rev=ae127b19a50aa54255e4330ccfdd9a5d058e581d;nobranch=1
ERROR: Command 'recipetool --color=auto create --devtool -o /tmp/devtoolqzsczjvq 'gitsm://git.yoctoproject.org/mraa;rev=ae127b19a50aa54255e4330ccfdd9a5d058e581d'  -x /tmp/devtoolqa9peegimn/mraa -N mraa -V 1.5' failed
----------------------------------------------------------------------
2017-08-23 11:20:14,819 - oe-selftest - INFO - Ran 1 test in 33.385s
2017-08-23 11:20:14,819 - oe-selftest - INFO - FAILED
2017-08-23 11:20:14,819 - oe-selftest - INFO -  (failures=1)
2017-08-23 11:20:14,824 - oe-selftest - INFO - RESULTS:
2017-08-23 11:20:14,824 - oe-selftest - INFO - RESULTS - devtool.DevtoolTests.test_devtool_add_fetch_git - Testcase 1161: FAILED
2017-08-23 11:20:14,824 - oe-selftest - INFO - SUMMARY:
2017-08-23 11:20:14,824 - oe-selftest - INFO - oe-selftest () - Ran 1 test in 33.391s
2017-08-23 11:20:14,824 - oe-selftest - INFO - oe-selftest - FAIL - Required tests failed

Could you take a look at that test case and see what the issue is please?

Cheers,

Richard

