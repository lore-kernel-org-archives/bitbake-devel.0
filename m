Return-Path: <mostly.embedded@gmail.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 2534C65C7B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Mar 2015 10:34:38 +0000 (UTC)
Received: by wiwh11 with SMTP id h11so37215692wiw.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 Mar 2015 02:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=LYsqTyhqBcvkC/1fUQnEgpUWtdnZSUijon5ni8OHGzM=;
	b=CSDIh7IqexFJrg6PAs0dq1Cm15WcS593UiFWyvgVwunEY3bScnRzrSoE9s5kV5lXFj
	8RiFd+siJrY20BhHnT3C1yAt69R98rYWZLR7LpRN06LwbmkpPdpalmdt3juZpzTYWkBf
	v0bnrV53tIX94RBsd3DN8RUXRIof9HKrquPqtOTpNYyWFrphNnnsyX/BZGJg427B1fb9
	tTe/3PJygKfGwmvLm6IBSSWeJBD7BUzyVV6lrzJIdsRjdva/jvP7hrazBt7Sds9Ifd3/
	FDU6NEy8pv9xHAS4xOneidWZI+L+n3KvkwNzBqIdjMiDKWE1bWOlIySS3EbwEyCRKqc7
	lo8A==
MIME-Version: 1.0
X-Received: by 10.194.59.112 with SMTP id y16mr17702024wjq.36.1425551679476;
	Thu, 05 Mar 2015 02:34:39 -0800 (PST)
Received: by 10.195.11.100 with HTTP; Thu, 5 Mar 2015 02:34:39 -0800 (PST)
Date: Thu, 5 Mar 2015 11:34:39 +0100
Message-ID: <CAPW5atw_=g5Tgw_fOFh72zxbnjQf+wWVVWkMrJc=ihs+4Txuag@mail.gmail.com>
From: Tomasz Wozniak <mostly.embedded@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: How [autotools] configure copies items to build/
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
X-List-Received-Date: Thu, 05 Mar 2015 10:34:44 -0000
X-Groupsio-MsgNum: 5496
Content-Type: multipart/mixed; boundary=047d7ba97cc4773c810510881da2

--047d7ba97cc4773c810510881da2
Content-Type: multipart/alternative; boundary=047d7ba97cc4773c7b0510881da0

--047d7ba97cc4773c7b0510881da0
Content-Type: text/plain; charset=UTF-8

Hi there,

I am relatively new to yocto/bitbake (less than a week in total spent in
this environment), and need help.
I am trying to get the mono build on yocto - guides are out there,
resulting in helloworld being runnable on target platform. When I however
try to add mono-basic component, the build process stops at compile stage,
due to build/ being empty.
The configure step might be to blame, as it - bitbake-wise - succeeds, but
in fact fails.
The reason is that configure mono-basic does not support some (all?) of the
options supplied, AND the build/config.make does not exist.

The .bb file looks almost the same for this package, and for
mono-hellowirld, that dos build and does have files in build/ after
configure finishes.
What should I do to:
1. Get help
2. Understand what does not happen and should
3. Fix the issue, so that mono-basic builds is a preferably kosher way

Below is the excerpt from the build console. The log.do_configure is in the
attachement.

papatom@dragoneyes:/opt/apator/yocto/fsl-community-bsp/wandboard-dual$
bitbake mono-basic -c configure
(...)
Loading cache: 100%
|############################################################| ETA:
00:00:00
Loaded 2022 entries from dependency cache.
Parsing recipes: 100%
|##########################################################| Time: 00:00:00
Parsing of 1569 .bb files complete (1567 cached, 2 parsed). 2023 targets,
124 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION        = "1.24.0"
BUILD_SYS         = "x86_64-linux"
NATIVELSBSTRING   = "Ubuntu-14.04"
TARGET_SYS        = "arm-poky-linux-gnueabi"
MACHINE           = "wandboard-dual"
DISTRO            = "poky"
DISTRO_VERSION    = "1.7.1"
TUNE_FEATURES     = "arm armv7a vfp neon callconvention-hard cortexa9"
TARGET_FPU        = "vfp-neon"
meta
meta-yocto        = "(nobranch):b630f2f53645fa8f5890b4732f251c354ad525a7"
meta-mono.git     = "mono-basic:61030792f204baa9acf08cad1cd60d389413ec42"
meta-oe
meta-multimedia   = "(nobranch):6413cdb66acf43059f94d0076ec9b8ad6a475b35"
meta-fsl-arm      = "(nobranch):a976d88ec6daeb14d32fd851655b0c3b72f1074e"
meta-fsl-arm-extra = "(nobranch):b16246a739720be98671e71fbf1793238d6b512a"
meta-fsl-demos    = "(nobranch):8088d34b4f1111c9076e3eeef67e9ae17d0b3455"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
NOTE: Tasks Summary: Attempted 1014 tasks of which 1010 didn't need to be
rerun and all succeeded.

papatom@dragoneyes:/opt/apator/yocto/fsl-community-bsp/wandboard-dual/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/mono-basic/2.10-r0$
ls -la build
total 8
drwxrwxr-x 2 papatom papatom 4096 Mar  5 11:23 .
drwxrwxr-x 5 papatom papatom 4096 Mar  5 11:24 ..


TIA
-- 
Tomasz Wozniak

--047d7ba97cc4773c7b0510881da0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi there,<br><br></div><div>I am relat=
ively new to yocto/bitbake (less than a week in total spent in this environ=
ment), and need help.<br></div>I am trying to get the mono build on yocto -=
 guides are out there, resulting in helloworld being runnable on target pla=
tform. When I however try to add mono-basic component, the build process st=
ops at compile stage, due to build/ being empty.<br></div>The configure ste=
p might be to blame, as it - bitbake-wise - succeeds, but in fact fails.<br=
></div>The reason is that configure mono-basic does not support some (all?)=
 of the options supplied, AND the build/config.make does not exist.<br><br>=
</div><div>The .bb file looks almost the same for this package, and for mon=
o-hellowirld, that dos build and does have files in build/ after configure =
finishes.<br></div><div>What should I do to:<br></div><div>1. Get help<br>2=
. Understand what does not happen and should<br></div><div>3. Fix the issue=
, so that mono-basic builds is a preferably kosher way<br></div><div><br></=
div><div>Below is the excerpt from the build console. The log.do_configure =
is in the attachement.<br></div><div><br>papatom@dragoneyes:/opt/apator/yoc=
to/fsl-community-bsp/wandboard-dual$ bitbake mono-basic -c configure<br>(..=
.)<br>Loading cache: 100% |################################################=
############| ETA:=C2=A0 00:00:00<br>Loaded 2022 entries from dependency ca=
che.<br>Parsing recipes: 100% |############################################=
##############| Time: 00:00:00<br>Parsing of 1569 .bb files complete (1567 =
cached, 2 parsed). 2023 targets, 124 skipped, 0 masked, 0 errors.<br>NOTE: =
Resolving any missing task queue dependencies<br><br>Build Configuration:<b=
r>BB_VERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;1.24.0&quo=
t;<br>BUILD_SYS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;x=
86_64-linux&quot;<br>NATIVELSBSTRING=C2=A0=C2=A0 =3D &quot;Ubuntu-14.04&quo=
t;<br>TARGET_SYS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;arm-po=
ky-linux-gnueabi&quot;<br>MACHINE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D &quot;wandboard-dual&quot;<br>DISTRO=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;poky&quot;<br=
>DISTRO_VERSION=C2=A0=C2=A0=C2=A0 =3D &quot;1.7.1&quot;<br>TUNE_FEATURES=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D &quot;arm armv7a vfp neon callconvention-hard cor=
texa9&quot;<br>TARGET_FPU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &qu=
ot;vfp-neon&quot;<br>meta=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>meta-yocto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D &quot;(nobranch):b630f2f53645fa8f5890b4732f251c354ad525a7&=
quot;<br>meta-mono.git=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;mono-basic:6103079=
2f204baa9acf08cad1cd60d389413ec42&quot;<br>meta-oe=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>meta-multimedia=C2=A0=C2=A0 =3D &q=
uot;(nobranch):6413cdb66acf43059f94d0076ec9b8ad6a475b35&quot;<br>meta-fsl-a=
rm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;(nobranch):a976d88ec6daeb14d32fd=
851655b0c3b72f1074e&quot;<br>meta-fsl-arm-extra =3D &quot;(nobranch):b16246=
a739720be98671e71fbf1793238d6b512a&quot;<br>meta-fsl-demos=C2=A0=C2=A0=C2=
=A0 =3D &quot;(nobranch):8088d34b4f1111c9076e3eeef67e9ae17d0b3455&quot;<br>=
<br>NOTE: Preparing runqueue<br>NOTE: Executing SetScene Tasks<br>NOTE: Exe=
cuting RunQueue Tasks<br>NOTE: Tasks Summary: Attempted 1014 tasks of which=
 1010 didn&#39;t need to be rerun and all succeeded.<br><br>papatom@dragone=
yes:/opt/apator/yocto/fsl-community-bsp/wandboard-dual/tmp/work/cortexa9hf-=
vfp-neon-poky-linux-gnueabi/mono-basic/2.10-r0$ ls -la build<br>total 8<br>=
drwxrwxr-x 2 papatom papatom 4096 Mar=C2=A0 5 11:23 .<br>drwxrwxr-x 5 papat=
om papatom 4096 Mar=C2=A0 5 11:24 ..<br><br><br></div><div>TIA<br>-- <br></=
div><div>Tomasz Wozniak<br></div></div>

--047d7ba97cc4773c7b0510881da0--

--047d7ba97cc4773c810510881da2
Content-Type: application/octet-stream; name="log.do_configure"
Content-Disposition: attachment; filename="log.do_configure"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i6w0epzh0

REVCVUc6IEV4ZWN1dGluZyBweXRob24gZnVuY3Rpb24gc3lzcm9vdF9jbGVhbnNzdGF0ZQpERUJV
RzogUHl0aG9uIGZ1bmN0aW9uIHN5c3Jvb3RfY2xlYW5zc3RhdGUgZmluaXNoZWQKREVCVUc6IFNJ
VEUgZmlsZXMgWydlbmRpYW4tbGl0dGxlJywgJ2JpdC0zMicsICdhcm0tY29tbW9uJywgJ2NvbW1v
bi1saW51eCcsICdjb21tb24tZ2xpYmMnLCAnYXJtLWxpbnV4JywgJ2FybS1saW51eC1nbnVlYWJp
JywgJ2NvbW1vbiddCkRFQlVHOiBFeGVjdXRpbmcgc2hlbGwgZnVuY3Rpb24gYXV0b3Rvb2xzX3By
ZWNvbmZpZ3VyZQpERUJVRzogU2hlbGwgZnVuY3Rpb24gYXV0b3Rvb2xzX3ByZWNvbmZpZ3VyZSBm
aW5pc2hlZApERUJVRzogRXhlY3V0aW5nIHB5dGhvbiBmdW5jdGlvbiBhdXRvdG9vbHNfY29weV9h
Y2xvY2FscwpERUJVRzogUHl0aG9uIGZ1bmN0aW9uIGF1dG90b29sc19jb3B5X2FjbG9jYWxzIGZp
bmlzaGVkCkRFQlVHOiBFeGVjdXRpbmcgc2hlbGwgZnVuY3Rpb24gZG9fY29uZmlndXJlCk5PVEU6
IFJ1bm5pbmcgL29wdC9hcGF0b3IveW9jdG8vZnNsLWNvbW11bml0eS1ic3Avd2FuZGJvYXJkLWR1
YWwvdG1wL3dvcmsvY29ydGV4YTloZi12ZnAtbmVvbi1wb2t5LWxpbnV4LWdudWVhYmkvbW9uby1i
YXNpYy8yLjEwLXIwL21vbm8tYmFzaWMtMi4xMC9jb25maWd1cmUgIC0tYnVpbGQ9eDg2XzY0LWxp
bnV4IAkJICAtLWhvc3Q9YXJtLXBva3ktbGludXgtZ251ZWFiaSAJCSAgLS10YXJnZXQ9YXJtLXBv
a3ktbGludXgtZ251ZWFiaSAJCSAgLS1wcmVmaXg9L3VzciAJCSAgLS1leGVjX3ByZWZpeD0vdXNy
IAkJICAtLWJpbmRpcj0vdXNyL2JpbiAJCSAgLS1zYmluZGlyPS91c3Ivc2JpbiAJCSAgLS1saWJl
eGVjZGlyPS91c3IvbGliL21vbm8tYmFzaWMgCQkgIC0tZGF0YWRpcj0vdXNyL3NoYXJlIAkJICAt
LXN5c2NvbmZkaXI9L2V0YyAJCSAgLS1zaGFyZWRzdGF0ZWRpcj0vY29tIAkJICAtLWxvY2Fsc3Rh
dGVkaXI9L3ZhciAJCSAgLS1saWJkaXI9L3Vzci9saWIgCQkgIC0taW5jbHVkZWRpcj0vdXNyL2lu
Y2x1ZGUgCQkgIC0tb2xkaW5jbHVkZWRpcj0vdXNyL2luY2x1ZGUgCQkgIC0taW5mb2Rpcj0vdXNy
L3NoYXJlL2luZm8gCQkgIC0tbWFuZGlyPS91c3Ivc2hhcmUvbWFuIAkJICAtLWRpc2FibGUtc2ls
ZW50LXJ1bGVzIAkJICAtLWRpc2FibGUtZGVwZW5kZW5jeS10cmFja2luZyAJCSAgLS13aXRoLWxp
YnRvb2wtc3lzcm9vdD0vb3B0L2FwYXRvci95b2N0by9mc2wtY29tbXVuaXR5LWJzcC93YW5kYm9h
cmQtZHVhbC90bXAvc3lzcm9vdHMvd2FuZGJvYXJkLWR1YWwgIApVbmtub3duIGFyZ3VtZW50IC0t
YnVpbGQ9eDg2XzY0LWxpbnV4ClVua25vd24gYXJndW1lbnQgLS1ob3N0PWFybS1wb2t5LWxpbnV4
LWdudWVhYmkKVW5rbm93biBhcmd1bWVudCAtLXRhcmdldD1hcm0tcG9reS1saW51eC1nbnVlYWJp
ClVua25vd24gYXJndW1lbnQgLS1leGVjX3ByZWZpeD0vdXNyClVua25vd24gYXJndW1lbnQgLS1i
aW5kaXI9L3Vzci9iaW4KVW5rbm93biBhcmd1bWVudCAtLXNiaW5kaXI9L3Vzci9zYmluClVua25v
d24gYXJndW1lbnQgLS1saWJleGVjZGlyPS91c3IvbGliL21vbm8tYmFzaWMKVW5rbm93biBhcmd1
bWVudCAtLWRhdGFkaXI9L3Vzci9zaGFyZQpVbmtub3duIGFyZ3VtZW50IC0tc3lzY29uZmRpcj0v
ZXRjClVua25vd24gYXJndW1lbnQgLS1zaGFyZWRzdGF0ZWRpcj0vY29tClVua25vd24gYXJndW1l
bnQgLS1sb2NhbHN0YXRlZGlyPS92YXIKVW5rbm93biBhcmd1bWVudCAtLWxpYmRpcj0vdXNyL2xp
YgpVbmtub3duIGFyZ3VtZW50IC0taW5jbHVkZWRpcj0vdXNyL2luY2x1ZGUKVW5rbm93biBhcmd1
bWVudCAtLW9sZGluY2x1ZGVkaXI9L3Vzci9pbmNsdWRlClVua25vd24gYXJndW1lbnQgLS1pbmZv
ZGlyPS91c3Ivc2hhcmUvaW5mbwpVbmtub3duIGFyZ3VtZW50IC0tbWFuZGlyPS91c3Ivc2hhcmUv
bWFuClVua25vd24gYXJndW1lbnQgLS1kaXNhYmxlLXNpbGVudC1ydWxlcwpVbmtub3duIGFyZ3Vt
ZW50IC0tZGlzYWJsZS1kZXBlbmRlbmN5LXRyYWNraW5nClVua25vd24gYXJndW1lbnQgLS13aXRo
LWxpYnRvb2wtc3lzcm9vdD0vb3B0L2FwYXRvci95b2N0by9mc2wtY29tbXVuaXR5LWJzcC93YW5k
Ym9hcmQtZHVhbC90bXAvc3lzcm9vdHMvd2FuZGJvYXJkLWR1YWwKL29wdC9hcGF0b3IveW9jdG8v
ZnNsLWNvbW11bml0eS1ic3Avd2FuZGJvYXJkLWR1YWwvdG1wL3dvcmsvY29ydGV4YTloZi12ZnAt
bmVvbi1wb2t5LWxpbnV4LWdudWVhYmkvbW9uby1iYXNpYy8yLjEwLXIwL21vbm8tYmFzaWMtMi4x
MC9jb25maWd1cmU6IDI5OiAvb3B0L2FwYXRvci95b2N0by9mc2wtY29tbXVuaXR5LWJzcC93YW5k
Ym9hcmQtZHVhbC90bXAvd29yay9jb3J0ZXhhOWhmLXZmcC1uZW9uLXBva3ktbGludXgtZ251ZWFi
aS9tb25vLWJhc2ljLzIuMTAtcjAvbW9uby1iYXNpYy0yLjEwL2NvbmZpZ3VyZTogY2Fubm90IGNy
ZWF0ZSBidWlsZC9jb25maWcubWFrZTogRGlyZWN0b3J5IG5vbmV4aXN0ZW50Ci9vcHQvYXBhdG9y
L3lvY3RvL2ZzbC1jb21tdW5pdHktYnNwL3dhbmRib2FyZC1kdWFsL3RtcC93b3JrL2NvcnRleGE5
aGYtdmZwLW5lb24tcG9reS1saW51eC1nbnVlYWJpL21vbm8tYmFzaWMvMi4xMC1yMC9tb25vLWJh
c2ljLTIuMTAvY29uZmlndXJlOiAzMDogL29wdC9hcGF0b3IveW9jdG8vZnNsLWNvbW11bml0eS1i
c3Avd2FuZGJvYXJkLWR1YWwvdG1wL3dvcmsvY29ydGV4YTloZi12ZnAtbmVvbi1wb2t5LWxpbnV4
LWdudWVhYmkvbW9uby1iYXNpYy8yLjEwLXIwL21vbm8tYmFzaWMtMi4xMC9jb25maWd1cmU6IGNh
bm5vdCBjcmVhdGUgYnVpbGQvY29uZmlnLm1ha2U6IERpcmVjdG9yeSBub25leGlzdGVudAovb3B0
L2FwYXRvci95b2N0by9mc2wtY29tbXVuaXR5LWJzcC93YW5kYm9hcmQtZHVhbC90bXAvd29yay9j
b3J0ZXhhOWhmLXZmcC1uZW9uLXBva3ktbGludXgtZ251ZWFiaS9tb25vLWJhc2ljLzIuMTAtcjAv
bW9uby1iYXNpYy0yLjEwL2NvbmZpZ3VyZTogMzE6IC9vcHQvYXBhdG9yL3lvY3RvL2ZzbC1jb21t
dW5pdHktYnNwL3dhbmRib2FyZC1kdWFsL3RtcC93b3JrL2NvcnRleGE5aGYtdmZwLW5lb24tcG9r
eS1saW51eC1nbnVlYWJpL21vbm8tYmFzaWMvMi4xMC1yMC9tb25vLWJhc2ljLTIuMTAvY29uZmln
dXJlOiBjYW5ub3QgY3JlYXRlIGJ1aWxkL2NvbmZpZy5tYWtlOiBEaXJlY3Rvcnkgbm9uZXhpc3Rl
bnQKL29wdC9hcGF0b3IveW9jdG8vZnNsLWNvbW11bml0eS1ic3Avd2FuZGJvYXJkLWR1YWwvdG1w
L3dvcmsvY29ydGV4YTloZi12ZnAtbmVvbi1wb2t5LWxpbnV4LWdudWVhYmkvbW9uby1iYXNpYy8y
LjEwLXIwL21vbm8tYmFzaWMtMi4xMC9jb25maWd1cmU6IDMyOiAvb3B0L2FwYXRvci95b2N0by9m
c2wtY29tbXVuaXR5LWJzcC93YW5kYm9hcmQtZHVhbC90bXAvd29yay9jb3J0ZXhhOWhmLXZmcC1u
ZW9uLXBva3ktbGludXgtZ251ZWFiaS9tb25vLWJhc2ljLzIuMTAtcjAvbW9uby1iYXNpYy0yLjEw
L2NvbmZpZ3VyZTogY2Fubm90IGNyZWF0ZSBidWlsZC9jb25maWcubWFrZTogRGlyZWN0b3J5IG5v
bmV4aXN0ZW50Ci9vcHQvYXBhdG9yL3lvY3RvL2ZzbC1jb21tdW5pdHktYnNwL3dhbmRib2FyZC1k
dWFsL3RtcC93b3JrL2NvcnRleGE5aGYtdmZwLW5lb24tcG9reS1saW51eC1nbnVlYWJpL21vbm8t
YmFzaWMvMi4xMC1yMC9tb25vLWJhc2ljLTIuMTAvY29uZmlndXJlOiAzMzogL29wdC9hcGF0b3Iv
eW9jdG8vZnNsLWNvbW11bml0eS1ic3Avd2FuZGJvYXJkLWR1YWwvdG1wL3dvcmsvY29ydGV4YTlo
Zi12ZnAtbmVvbi1wb2t5LWxpbnV4LWdudWVhYmkvbW9uby1iYXNpYy8yLjEwLXIwL21vbm8tYmFz
aWMtMi4xMC9jb25maWd1cmU6IGNhbm5vdCBjcmVhdGUgYnVpbGQvY29uZmlnLm1ha2U6IERpcmVj
dG9yeSBub25leGlzdGVudAovb3B0L2FwYXRvci95b2N0by9mc2wtY29tbXVuaXR5LWJzcC93YW5k
Ym9hcmQtZHVhbC90bXAvd29yay9jb3J0ZXhhOWhmLXZmcC1uZW9uLXBva3ktbGludXgtZ251ZWFi
aS9tb25vLWJhc2ljLzIuMTAtcjAvbW9uby1iYXNpYy0yLjEwL2NvbmZpZ3VyZTogMzQ6IC9vcHQv
YXBhdG9yL3lvY3RvL2ZzbC1jb21tdW5pdHktYnNwL3dhbmRib2FyZC1kdWFsL3RtcC93b3JrL2Nv
cnRleGE5aGYtdmZwLW5lb24tcG9reS1saW51eC1nbnVlYWJpL21vbm8tYmFzaWMvMi4xMC1yMC9t
b25vLWJhc2ljLTIuMTAvY29uZmlndXJlOiBjYW5ub3QgY3JlYXRlIGJ1aWxkL2NvbmZpZy5tYWtl
OiBEaXJlY3Rvcnkgbm9uZXhpc3RlbnQKL29wdC9hcGF0b3IveW9jdG8vZnNsLWNvbW11bml0eS1i
c3Avd2FuZGJvYXJkLWR1YWwvdG1wL3dvcmsvY29ydGV4YTloZi12ZnAtbmVvbi1wb2t5LWxpbnV4
LWdudWVhYmkvbW9uby1iYXNpYy8yLjEwLXIwL21vbm8tYmFzaWMtMi4xMC9jb25maWd1cmU6IDM1
OiAvb3B0L2FwYXRvci95b2N0by9mc2wtY29tbXVuaXR5LWJzcC93YW5kYm9hcmQtZHVhbC90bXAv
d29yay9jb3J0ZXhhOWhmLXZmcC1uZW9uLXBva3ktbGludXgtZ251ZWFiaS9tb25vLWJhc2ljLzIu
MTAtcjAvbW9uby1iYXNpYy0yLjEwL2NvbmZpZ3VyZTogY2Fubm90IGNyZWF0ZSBidWlsZC9jb25m
aWcubWFrZTogRGlyZWN0b3J5IG5vbmV4aXN0ZW50Ci9vcHQvYXBhdG9yL3lvY3RvL2ZzbC1jb21t
dW5pdHktYnNwL3dhbmRib2FyZC1kdWFsL3RtcC93b3JrL2NvcnRleGE5aGYtdmZwLW5lb24tcG9r
eS1saW51eC1nbnVlYWJpL21vbm8tYmFzaWMvMi4xMC1yMC9tb25vLWJhc2ljLTIuMTAvY29uZmln
dXJlOiAzNjogL29wdC9hcGF0b3IveW9jdG8vZnNsLWNvbW11bml0eS1ic3Avd2FuZGJvYXJkLWR1
YWwvdG1wL3dvcmsvY29ydGV4YTloZi12ZnAtbmVvbi1wb2t5LWxpbnV4LWdudWVhYmkvbW9uby1i
YXNpYy8yLjEwLXIwL21vbm8tYmFzaWMtMi4xMC9jb25maWd1cmU6IGNhbm5vdCBjcmVhdGUgYnVp
bGQvY29uZmlnLm1ha2U6IERpcmVjdG9yeSBub25leGlzdGVudAovb3B0L2FwYXRvci95b2N0by9m
c2wtY29tbXVuaXR5LWJzcC93YW5kYm9hcmQtZHVhbC90bXAvd29yay9jb3J0ZXhhOWhmLXZmcC1u
ZW9uLXBva3ktbGludXgtZ251ZWFiaS9tb25vLWJhc2ljLzIuMTAtcjAvbW9uby1iYXNpYy0yLjEw
L2NvbmZpZ3VyZTogMzc6IC9vcHQvYXBhdG9yL3lvY3RvL2ZzbC1jb21tdW5pdHktYnNwL3dhbmRi
b2FyZC1kdWFsL3RtcC93b3JrL2NvcnRleGE5aGYtdmZwLW5lb24tcG9reS1saW51eC1nbnVlYWJp
L21vbm8tYmFzaWMvMi4xMC1yMC9tb25vLWJhc2ljLTIuMTAvY29uZmlndXJlOiBjYW5ub3QgY3Jl
YXRlIGJ1aWxkL2NvbmZpZy5tYWtlOiBEaXJlY3Rvcnkgbm9uZXhpc3RlbnQKL29wdC9hcGF0b3Iv
eW9jdG8vZnNsLWNvbW11bml0eS1ic3Avd2FuZGJvYXJkLWR1YWwvdG1wL3dvcmsvY29ydGV4YTlo
Zi12ZnAtbmVvbi1wb2t5LWxpbnV4LWdudWVhYmkvbW9uby1iYXNpYy8yLjEwLXIwL21vbm8tYmFz
aWMtMi4xMC9jb25maWd1cmU6IDM4OiAvb3B0L2FwYXRvci95b2N0by9mc2wtY29tbXVuaXR5LWJz
cC93YW5kYm9hcmQtZHVhbC90bXAvd29yay9jb3J0ZXhhOWhmLXZmcC1uZW9uLXBva3ktbGludXgt
Z251ZWFiaS9tb25vLWJhc2ljLzIuMTAtcjAvbW9uby1iYXNpYy0yLjEwL2NvbmZpZ3VyZTogY2Fu
bm90IGNyZWF0ZSBidWlsZC9jb25maWcubWFrZTogRGlyZWN0b3J5IG5vbmV4aXN0ZW50Cm1vbm8t
YmFzaWMgMi4xMCBtb2R1bGUgY29uZmlndXJlIHRvIHVzZSBwcmVmaXg9L3VzcgpERUJVRzogU2hl
bGwgZnVuY3Rpb24gZG9fY29uZmlndXJlIGZpbmlzaGVkCkRFQlVHOiBFeGVjdXRpbmcgcHl0aG9u
IGZ1bmN0aW9uIGRvX3FhX2NvbmZpZ3VyZQpOT1RFOiBDaGVja2luZyBhdXRvdG9vbHMgZW52aXJv
bm1lbnQgZm9yIGNvbW1vbiBtaXNjb25maWd1cmF0aW9uCk5PVEU6IG1vbm8tYmFzaWM6IG1kNSBj
aGVja3N1bSBtYXRjaGVkIGZvciBmaWxlOi8vTElDRU5TRTttZDU9ZDhjNWRjMjJlYjZmMjU2Njdj
ZjhkOTZmNjAzNjM1ZTcKTk9URTogQ2hlY2tpbmcgY29uZmlndXJlIG91dHB1dCBmb3IgdW5yZWNv
Z25pc2VkIG9wdGlvbnMKZ3JlcDogL29wdC9hcGF0b3IveW9jdG8vZnNsLWNvbW11bml0eS1ic3Av
d2FuZGJvYXJkLWR1YWwvdG1wL3dvcmsvY29ydGV4YTloZi12ZnAtbmVvbi1wb2t5LWxpbnV4LWdu
dWVhYmkvbW9uby1iYXNpYy8yLjEwLXIwL2J1aWxkL2NvbmZpZy5sb2c6IE5vIHN1Y2ggZmlsZSBv
ciBkaXJlY3RvcnkKREVCVUc6IFB5dGhvbiBmdW5jdGlvbiBkb19xYV9jb25maWd1cmUgZmluaXNo
ZWQKREVCVUc6IEV4ZWN1dGluZyBzaGVsbCBmdW5jdGlvbiBhdXRvdG9vbHNfcG9zdGNvbmZpZ3Vy
ZQpERUJVRzogU2hlbGwgZnVuY3Rpb24gYXV0b3Rvb2xzX3Bvc3Rjb25maWd1cmUgZmluaXNoZWQK

--047d7ba97cc4773c810510881da2--
