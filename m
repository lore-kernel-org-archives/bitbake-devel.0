Return-Path: <hcu5555@gmail.com>
Received: from mail-yh0-f65.google.com (mail-yh0-f65.google.com
	[209.85.213.65])
	by mail.openembedded.org (Postfix) with ESMTP id 1F60D73B90
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Jun 2015 03:27:51 +0000 (UTC)
Received: by yhab6 with SMTP id b6so615522yha.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Jun 2015 20:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=D6ZshD/1PRFNbapf4ceX89KZb62KJ7PcD/dxB4txnKE=;
	b=fvE5t3SjqpXerDG1/elqmrwsj9NzpJYkjFl7YCN2ldzbfy0CJOUaEwryt75NUrAhl7
	LTN4CC0oWf6IyCbWA2kqKARIrtewVdwCFQrTtxMMwYq6Hhefai8C30bnLLfEIue/qeDp
	rfRS+YXSZgyUANuNfH55SkSW3cxF3GOkmrkOGcaxXu65yyLWRENQpvbB2R1z6ONj/SAd
	ONNSuWDNfOCpsQfWTAwTUTNGIQftouN96auaYAmjaYh/XOQ5tmtDEsUKHO6G2/C6eLWp
	Q7NQ4kdt/L4XrjC+C7DgKZFNvgqjF8VW6m1R/zHLXpIOsD8CZEK6aXu/J8hHJ+zQV+uJ
	4xQQ==
MIME-Version: 1.0
X-Received: by 10.129.99.193 with SMTP id x184mr19871117ywb.34.1433820473072; 
	Mon, 08 Jun 2015 20:27:53 -0700 (PDT)
Received: by 10.37.224.85 with HTTP; Mon, 8 Jun 2015 20:27:53 -0700 (PDT)
Date: Tue, 9 Jun 2015 11:27:53 +0800
Message-ID: <CAD5oO7mM0cuEU9eJ7oyG2ieMy1m5-Vb-KOKnFhpfvwagmmoebQ@mail.gmail.com>
From: issta Hu <hcu5555@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: build yocto error
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
X-List-Received-Date: Tue, 09 Jun 2015 03:27:53 -0000
Content-Type: multipart/alternative; boundary=001a1147399af8233e05180d57a3

--001a1147399af8233e05180d57a3
Content-Type: text/plain; charset=UTF-8

chunyun@ubuntu:~/share/yocto/ZC702$ bitbake core-image-minimal
Loading cache: 100%
|#################################################################################################|
ETA:  00:00:00
Loaded 1303 entries from dependency cache.
Parsing recipes: 100%
|###############################################################################################|
Time: 00:00:00
Parsing of 896 .bb files complete (894 cached, 2 parsed). 1303 targets, 58
skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        = "1.27.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "arm-poky-linux-gnueabi"
MACHINE           = "zc702-zynq7"
DISTRO            = "poky"
DISTRO_VERSION    = "1.8+snapshot-20150609"
TUNE_FEATURES     = "arm armv7a vfp neon cortexa9"
TARGET_FPU        = "vfp-neon"
meta              = "fido:b5ba70b47fff227e4381fcac93defccb79e3d8f1"
meta-xilinx       = "fido:5aa58bbbf8ddcc59f8746805d62fd156d7cff461"
meta-yocto
meta-yocto-bsp    = "fido:b5ba70b47fff227e4381fcac93defccb79e3d8f1"

NOTE: Preparing RunQueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
ERROR: Function failed: write_specfile
ERROR: Logfile of failure stored in:
/home/chunyun/share/yocto/ZC702/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/init-ifupdown/1.0-r7/temp/log.do_package_write_rpm.8848
Log data follows:
| DEBUG: Executing python function sstate_task_prefunc
| DEBUG: Python function sstate_task_prefunc finished
| DEBUG: Executing python function do_package_write_rpm
| DEBUG: Executing python function read_subpackage_metadata
| DEBUG: Python function read_subpackage_metadata finished
| DEBUG: Executing python function do_package_rpm
| DEBUG: Executing python function write_specfile
| DEBUG: Python function write_specfile finished
| DEBUG: Python function do_package_rpm finished
| DEBUG: Python function do_package_write_rpm finished
| ERROR: Function failed: write_specfile
ERROR: Task 833
(/home/chunyun/share/yocto/poky/meta/recipes-core/init-ifupdown/
init-ifupdown_1.0.bb, do_package_write_rpm) failed with exit code '1'
NOTE: Tasks Summary: Attempted 1396 tasks of which 1395 didn't need to be
rerun and 1 failed.
No currently running tasks (1395 of 1889)

Summary: 1 task failed:
  /home/chunyun/share/yocto/poky/meta/recipes-core/init-ifupdown/
init-ifupdown_1.0.bb, do_package_write_rpm
Summary: There was 1 ERROR message shown, returning a non-zero exit code.

--001a1147399af8233e05180d57a3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>chunyun@ubuntu:~/share/yocto/ZC702$ bitbake core-imag=
e-minimal</div><div>Loading cache: 100% |##################################=
###############################################################| ETA: =C2=
=A000:00:00</div><div>Loaded 1303 entries from dependency cache.</div><div>=
Parsing recipes: 100% |####################################################=
###########################################| Time: 00:00:00</div><div>Parsi=
ng of 896 .bb files complete (894 cached, 2 parsed). 1303 targets, 58 skipp=
ed, 0 masked, 0 errors.</div><div>NOTE: Resolving any missing task queue de=
pendencies</div><div><br></div><div>Build Configuration:</div><div>BB_VERSI=
ON =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;1.27.0&quot;</div><div>BUILD_SYS =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;x86_64-linux&quot;</div><div>NATIVELS=
BSTRING =C2=A0 =3D &quot;Ubuntu-14.04&quot;</div><div>TARGET_SYS =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D &quot;arm-poky-linux-gnueabi&quot;</div><div>MACHINE =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;zc702-zynq7&quot;</div><div>DI=
STRO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;poky&quot;</div><di=
v>DISTRO_VERSION =C2=A0 =C2=A0=3D &quot;1.8+snapshot-20150609&quot;</div><d=
iv>TUNE_FEATURES =C2=A0 =C2=A0 =3D &quot;arm armv7a vfp neon cortexa9&quot;=
</div><div>TARGET_FPU =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;vfp-neon&quot;</=
div><div>meta =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;fid=
o:b5ba70b47fff227e4381fcac93defccb79e3d8f1&quot;</div><div>meta-xilinx =C2=
=A0 =C2=A0 =C2=A0 =3D &quot;fido:5aa58bbbf8ddcc59f8746805d62fd156d7cff461&q=
uot;</div><div>meta-yocto =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>meta-yocto-=
bsp =C2=A0 =C2=A0=3D &quot;fido:b5ba70b47fff227e4381fcac93defccb79e3d8f1&qu=
ot;</div><div><br></div><div>NOTE: Preparing RunQueue</div><div>NOTE: Execu=
ting SetScene Tasks</div><div>NOTE: Executing RunQueue Tasks</div><div>ERRO=
R: Function failed: write_specfile</div><div>ERROR: Logfile of failure stor=
ed in: /home/chunyun/share/yocto/ZC702/tmp/work/cortexa9-vfp-neon-poky-linu=
x-gnueabi/init-ifupdown/1.0-r7/temp/log.do_package_write_rpm.8848</div><div=
>Log data follows:</div><div>| DEBUG: Executing python function sstate_task=
_prefunc</div><div>| DEBUG: Python function sstate_task_prefunc finished</d=
iv><div>| DEBUG: Executing python function do_package_write_rpm</div><div>|=
 DEBUG: Executing python function read_subpackage_metadata</div><div>| DEBU=
G: Python function read_subpackage_metadata finished</div><div>| DEBUG: Exe=
cuting python function do_package_rpm</div><div>| DEBUG: Executing python f=
unction write_specfile</div><div>| DEBUG: Python function write_specfile fi=
nished</div><div>| DEBUG: Python function do_package_rpm finished</div><div=
>| DEBUG: Python function do_package_write_rpm finished</div><div>| ERROR: =
Function failed: write_specfile</div><div>ERROR: Task 833 (/home/chunyun/sh=
are/yocto/poky/meta/recipes-core/init-ifupdown/<a href=3D"http://init-ifupd=
own_1.0.bb">init-ifupdown_1.0.bb</a>, do_package_write_rpm) failed with exi=
t code &#39;1&#39;</div><div>NOTE: Tasks Summary: Attempted 1396 tasks of w=
hich 1395 didn&#39;t need to be rerun and 1 failed.</div><div>No currently =
running tasks (1395 of 1889)</div><div><br></div><div>Summary: 1 task faile=
d:</div><div>=C2=A0 /home/chunyun/share/yocto/poky/meta/recipes-core/init-i=
fupdown/<a href=3D"http://init-ifupdown_1.0.bb">init-ifupdown_1.0.bb</a>, d=
o_package_write_rpm</div><div>Summary: There was 1 ERROR message shown, ret=
urning a non-zero exit code.</div><div><br></div></div>

--001a1147399af8233e05180d57a3--
