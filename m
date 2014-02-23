Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
	by mail.openembedded.org (Postfix) with ESMTP id E8A736EAFA;
	Sun, 23 Feb 2014 09:06:03 +0000 (UTC)
Received: by mail-ee0-f42.google.com with SMTP id e53so909053eek.15
	for <multiple recipients>; Sun, 23 Feb 2014 01:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=olrToCFOPVyIxnmnEtuJIYj95c+kNhSQZ2f37guQMQ4=;
	b=H7OYQsaIixnVE06d1/K8z6Cn/8YZVMKzb9Z15EPRbltLqxgFrN9IhJibaWz1fx0wLV
	o5q5b7u2QSBAeDmnh00T697IiJ1f6uJPdsXXPTYXIC9GoL92tXfzxLQz7ueRZKkn9N9M
	qGvAMCHFRY0qrV7DHYAlTWKdAUX4gxo63e1/5QWtotNQF3i9yuvikvcCLt7mSI6NxW7r
	qNTvfEm+bBS4uGoa9xXRAlP7rrcRCFzWQu53FrlLJD146AoPfjYD6LIiWfnaXMQ1H6Vh
	UkdAGi7Jeux+dyU8xgtXmkCZZP9CTLCtQp8BTKQvXIz07hno/pl3LegkZhXwKmlW95o1
	0+QQ==
X-Received: by 10.15.76.135 with SMTP id n7mr3468741eey.36.1393146364769;
	Sun, 23 Feb 2014 01:06:04 -0800 (PST)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	g1sm48742089eet.6.2014.02.23.01.06.02 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 23 Feb 2014 01:06:03 -0800 (PST)
Date: Sun, 23 Feb 2014 10:06:40 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Message-ID: <20140223090640.GR3854@jama>
References: <20140222120736.GN3854@jama>
MIME-Version: 1.0
In-Reply-To: <20140222120736.GN3854@jama>
User-Agent: Mutt/1.5.22 (2013-10-16)
Subject: Re: ValueError: insecure string pickle with latest bitbake
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
X-List-Received-Date: Sun, 23 Feb 2014 09:06:08 -0000
X-Groupsio-MsgNum: 4414
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hw0FrjWlp+qkNlJP"
Content-Disposition: inline

--Hw0FrjWlp+qkNlJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2014 at 01:07:36PM +0100, Martin Jansa wrote:
> Hi,
>=20
> last couple of days many of my jenkins builds failed with exception like
> this:
>=20
> ERROR: An uncaught exception occured in runqueue, please see the failure =
below:
> ERROR: Running idle function
> Traceback (most recent call last):
>   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/cooker=
=2Epy", line 1182, in buildTargetsIdle(server=3D<ProcessServer(ProcessServe=
r-2, started)>, rq=3D<bb.runqueue.RunQueue instance at 0x16a95d40>, abort=
=3DFalse):
>                  try:
>     >                retval =3D rq.execute_runqueue()
>                  except runqueue.TaskFailure as exc:
>   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runque=
ue.py", line 1093, in RunQueue.execute_runqueue():
>                  try:
>     >                self.teardown_workers()
>                  except:
>   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runque=
ue.py", line 925, in RunQueue.teardown_workers():
>              self.workerpipe =3D None
>     >        self._teardown_worker(self.fakeworker, self.fakeworkerpipe)
>              self.fakeworker =3D None
>   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runque=
ue.py", line 906, in RunQueue._teardown_worker(worker=3D<subprocess.Popen o=
bject at 0xcb4e690>, workerpipe=3D<bb.runqueue.runQueuePipe instance at 0x1=
1c17710>):
>              while worker.returncode is None:
>     >            workerpipe.read()
>                  worker.poll()
>   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runque=
ue.py", line 2095, in runQueuePipe.read():
>                  while index !=3D -1 and self.queue.startswith("<event>"):
>     >                event =3D pickle.loads(self.queue[7:index])
>                      bb.event.fire_from_worker(event, self.d)
> ValueError: insecure string pickle
>=20
> and it repeats the same exception very quickly (generated 3GB log in ~ ho=
ur)
>=20
> It doesn't happen always, it seems to be triggered in different places in=
 build.
>=20
> Anyone else seeing this as well?
>=20
> I'll add some debug output around it and wait for it to happen again.

I got one example now (not sure if this is the only one):

Because it shows runrpmdeps and I'm the only one so far seeing this, I gues=
s it's caused by:
http://lists.openembedded.org/pipermail/openembedded-core/2014-February/089=
632.html
I'll try to revert that one from my builds

NOTE: recipe binutils-2.24-r0: task do_configure: Started
ERROR: failed load pickle 'ccopy_reg
_reconstructor
p1
(clogging
LogRecord
p2
c__builtin__
object
p3
NtRp4
(dp5
S'taskpid'
p6
I10922
sS'threadName'
p7
S'MainThread'
p8
sS'name'
p9
S'BitBake'
p10
sS'thread'
p11
I139823574271744
sS'created'
p12
F1393145646.5582349
sS'process'
p13
I11633
sS'processName'
p14
S'PoolWorker-11'
p15
sS'args'
p16
(tsS'module'
p17
S'__init__'
p18
sS'filename'
p19
'__init__.py'
p20
sS'levelno'
p21
I10
sS'exc_text'
p22
NsS'pathname'
p23
S'/OE/build/shr-core/bitbake/lib/bb/__init__.py'
p24
sS'lineno'
p25
I58
sS'msg'
p26
S"runrpmdeps: /OE/build/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/lib/r=
pm/bin/rpmdeps-oecore --macros /OE/build/shr-core/tmp-eglibc/sysroots/x86_6=
4-linux/usr/lib/rpm/macros --define '_rpmfc_magic_path /OE/build/shr-core/t=
mp-eglibc/sysroots/x86_64-linux/usr/share/misc/magic.mgc' --rpmpopt /OE/bui=
ld/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/lib/rpm/rpmpopt /OE/build/=
shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-sp=
lit/libstdc++-dev/usr/include/c++/debug/forward_list /OE/build/shr-core/tmp=
-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc+=
+-dev/usr/include/c++/debug/multimap.h /OE/build/shr-core/tmp-eglibc/work/c=
ore2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/incl=
ude/c++/debug/multiset.h /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-lin=
ux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/debug/=
safe_local_iterator.tcc /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linu=
x/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/debug/s=
afe_sequence.tcc /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-r=
untime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/debug/safe_uno=
rdered_container.h /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc=
-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/debug/string=
 /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/=
packages-split/libstdc++-dev/usr/include/c++/debug/array /OE/build/shr-core=
/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libs=
tdc++-dev/usr/include/c++/debug/safe_sequence.h /OE/build/shr-core/tmp-egli=
bc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev=
/usr/include/c++/backward/strstream /OE/build/shr-core/tmp-eglibc/work/core=
2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include=
/c++/backward/hash_fun.h /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-lin=
ux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/backwa=
rd/hash_set /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtim=
e/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/backward/auto_ptr.h=
 /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/=
packages-split/libstdc++-dev/usr/include/c++/backward/hashtable.h /OE/build=
/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-s=
plit/libstdc++-dev/usr/include/c++/backward/binders.h /OE/build/shr-core/tm=
p-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc=
++-dev/usr/include/c++/backward/backward_warning.h /OE/build/shr-core/tmp-e=
glibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-=
dev/usr/include/c++/backward/hash_map /OE/build/shr-core/tmp-eglibc/work/co=
re2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/inclu=
de/c++/tr1/exp_integral.tcc /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-=
linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1=
/float.h /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4=
=2E8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/limits.h /OE/bui=
ld/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages=
-split/libstdc++-dev/usr/include/c++/tr1/hypergeometric.tcc /OE/build/shr-c=
ore/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/l=
ibstdc++-dev/usr/include/c++/tr1/cfenv /OE/build/shr-core/tmp-eglibc/work/c=
ore2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/incl=
ude/c++/tr1/random.tcc /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux=
/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/fenv=
=2Eh /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2=
-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/gamma.tcc /OE/build/sh=
r-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-spli=
t/libstdc++-dev/usr/include/c++/tr1/wchar.h /OE/build/shr-core/tmp-eglibc/w=
ork/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr=
/include/c++/tr1/math.h /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linu=
x/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/fun=
ctional_hash.h /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-run=
time/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/riemann_zeta=
=2Etcc /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8=
=2E2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/inttypes.h /OE/bui=
ld/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages=
-split/libstdc++-dev/usr/include/c++/tr1/cctype /OE/build/shr-core/tmp-egli=
bc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev=
/usr/include/c++/tr1/cstdio /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-=
linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1=
/shared_ptr.h /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runt=
ime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/cinttypes /OE=
/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/pack=
ages-split/libstdc++-dev/usr/include/c++/tr1/unordered_set.h /OE/build/shr-=
core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/=
libstdc++-dev/usr/include/c++/tr1/ccomplex /OE/build/shr-core/tmp-eglibc/wo=
rk/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/=
include/c++/tr1/poly_hermite.tcc /OE/build/shr-core/tmp-eglibc/work/core2-6=
4-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c+=
+/tr1/random.h /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-run=
time/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/unordered_se=
t /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0=
/packages-split/libstdc++-dev/usr/include/c++/tr1/ctgmath /OE/build/shr-cor=
e/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/lib=
stdc++-dev/usr/include/c++/tr1/random /OE/build/shr-core/tmp-eglibc/work/co=
re2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/inclu=
de/c++/tr1/complex /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc=
-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/utility =
/OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/p=
ackages-split/libstdc++-dev/usr/include/c++/tr1/functional /OE/build/shr-co=
re/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/li=
bstdc++-dev/usr/include/c++/tr1/modified_bessel_func.tcc /OE/build/shr-core=
/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libs=
tdc++-dev/usr/include/c++/tr1/cstdbool /OE/build/shr-core/tmp-eglibc/work/c=
ore2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/incl=
ude/c++/tr1/type_traits /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linu=
x/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/cwc=
type /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2=
-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/wctype.h /OE/build/shr=
-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/package
s-split/libstdc++-dev/usr/include/c++/tr1/stdlib.h /OE/build/shr-core/tmp-e=
glibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-=
dev/usr/include/c++/tr1/poly_laguerre.tcc /OE/build/shr-core/tmp-eglibc/wor=
k/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/i=
nclude/c++/tr1/cfloat /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/=
gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/speci=
al_function_util.h /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc=
-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/cstdarg =
/OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/p=
ackages-split/libstdc++-dev/usr/include/c++/tr1/beta_function.tcc /OE/build=
/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-s=
plit/libstdc++-dev/usr/include/c++/tr1/unordered_map.h /OE/build/shr-core/t=
mp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstd=
c++-dev/usr/include/c++/tr1/unordered_map /OE/build/shr-core/tmp-eglibc/wor=
k/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/i=
nclude/c++/tr1/memory /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/=
gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/regex=
 /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/=
packages-split/libstdc++-dev/usr/include/c++/tr1/hashtable.h /OE/build/shr-=
core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/=
libstdc++-dev/usr/include/c++/tr1/stdio.h /OE/build/shr-core/tmp-eglibc/wor=
k/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/i=
nclude/c++/tr1/climits /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux=
/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/comp=
lex.h /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.=
2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/legendre_function.tcc=
 /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/=
packages-split/libstdc++-dev/usr/include/c++/tr1/bessel_function.tcc /OE/bu=
ild/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/package=
s-split/libstdc++-dev/usr/include/c++/tr1/hashtable_policy.h /OE/build/shr-=
core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/=
libstdc++-dev/usr/include/c++/tr1/cstdlib /OE/build/shr-core/tmp-eglibc/wor=
k/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/i=
nclude/c++/tr1/tuple /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/g=
cc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/cwchar=
 /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/=
packages-split/libstdc++-dev/usr/include/c++/tr1/cmath /OE/build/shr-core/t=
mp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstd=
c++-dev/usr/include/c++/tr1/ctype.h /OE/build/shr-core/tmp-eglibc/work/core=
2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include=
/c++/tr1/ell_integral.tcc /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-li=
nux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/t=
gmath.h /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.=
8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/stdarg.h /OE/build/=
shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-sp=
lit/libstdc++-dev/usr/include/c++/tr1/stdbool.h /OE/build/shr-core/tmp-egli=
bc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev=
/usr/include/c++/tr1/cstdint /OE/build/shr-core/tmp-eglibc/work/core2-64-oe=
-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr=
1/ctime /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.=
8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr1/stdint.h /OE/build/=
shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-sp=
lit/libstdc++-dev/usr/include/c++/tr1/array /OE/build/shr-core/tmp-eglibc/w=
ork/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr=
/include/c++/tr2/ratio /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux=
/gcc-runtime/4.8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr2/bool=
_set.tcc /OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4=
=2E8.2-r0/packages-split/libstdc++-dev/usr/include/c++/tr2/dynamic_bitset /=
OE/build/shr-core/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/pa=
ckages-split/libstdc++-dev/usr/include/c++/tr2/type_traits /OE/build/shr-co=
re/tmp-eglibc/work/core2-64-oe-linux/gcc-runtime/4.8.2-r0/packages-split/li=
bstdc++-dev/usr/include/c++/tr2/bool_set /OE/build/shr-core/tmp-eglibc/work=
/c<event>ccopy_reg
p1
(clogging
LogRecord
p2
c__builtin__
object
p3
NtRp4
(dp5
S'taskpid'
p6
I10922
sS'threadName'
p7
S'MainThread'
p8
sS'name'
p9
S'BitBake'
p10
sS'thread'
p11
I139823574271744
sS'created'
p12
F1393145646.558748
sS'process'
p13
I11662
sS'processName'
p14
S'PoolWorker-13'
p15
sS'args'
p16
(tsS'module'
p17
S'__init__'
p18
sS'filename'
p19
S'__init__.py'
p20
sS'levelno'
p21
I10
sS'exc_text'
p22
NsS'pathname'
p23
S'/OE/build/shr-core/bitbake/lib/bb/__init__.py'
p24
sS'lineno'
p25
I58
sS'msg'
p26

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--Hw0FrjWlp+qkNlJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlMJuiAACgkQN1Ujt2V2gByB3gCdFtV8XUageXAS+GbD5NpJULWc
7CIAn31fXudje2NFpXEFn731lbkzcblw
=HdfN
-----END PGP SIGNATURE-----

--Hw0FrjWlp+qkNlJP--
