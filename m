Return-Path: <brian.avery@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 0CE3975D4A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 14:59:02 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 27 Oct 2015 07:59:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,205,1444719600"; d="scan'208";a="836185483"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
	by orsmga002.jf.intel.com with ESMTP; 27 Oct 2015 07:59:03 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.3.250]) by
	ORSMSX109.amr.corp.intel.com ([169.254.2.99]) with mapi id
	14.03.0248.002; Tue, 27 Oct 2015 07:59:01 -0700
From: "Avery, Brian" <brian.avery@intel.com>
To: Scott Rifenbark <srifenbark@gmail.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Thread-Topic: [PATCH] build/utils: Add BB_TASK_IONICE_LEVEL support
Thread-Index: AQHRDkV0rzRTp+XFjECKid/5KgYLgZ5/0RsA//+iXoA=
Date: Tue, 27 Oct 2015 14:59:00 +0000
Message-ID: <D254DE63.4385C%brian.avery@intel.com>
References: <1445681946.21913.52.camel@linuxfoundation.org>
	<CAFNP8Ou+cT0_-AHbwOf2s-HgZgL8TWbx-_JpdxNLqJZ+n2HYQw@mail.gmail.com>
In-Reply-To: <CAFNP8Ou+cT0_-AHbwOf2s-HgZgL8TWbx-_JpdxNLqJZ+n2HYQw@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.64.129]
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 28 Oct 2015 20:40:56 +0000
Cc: "Witt, Randy E" <randy.e.witt@intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>, "Graydon,
	Tracy" <tracy.graydon@intel.com>
Subject: Re: [PATCH] build/utils: Add BB_TASK_IONICE_LEVEL support
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
X-List-Received-Date: Tue, 27 Oct 2015 14:59:04 -0000
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9C1361BF109A1D41B8713E514AD5DD06@intel.com>
Content-Transfer-Encoding: quoted-printable

Hi,

It mostly appears as CFQ scheduler (Completely Fair Queuing).  Since we tel=
l them to set it to cfq, it might be nice to tell them to do this by doing =
sudo sh -c =93echo cfq > /sys/block/<device>/queu/scheduler; where device i=
s the backing block device e.g. sda,sdb,=85

-b

From: Scott Rifenbark <srifenbark@gmail.com<mailto:srifenbark@gmail.com>>
Date: Tuesday, October 27, 2015 at 6:34 AM
To: Richard Purdie <richard.purdie@linuxfoundation.org<mailto:richard.purdi=
e@linuxfoundation.org>>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org<mailto:bitbake-deve=
l@lists.openembedded.org>>, Brian Avery <brian.avery@intel.com<mailto:brian=
.avery@intel.com>>, "Witt, Randy E" <randy.e.witt@intel.com<mailto:randy.e.=
witt@intel.com>>, "Flanagan, Elizabeth" <elizabeth.flanagan@intel.com<mailt=
o:elizabeth.flanagan@intel.com>>, "Graydon, Tracy" <tracy.graydon@intel.com=
<mailto:tracy.graydon@intel.com>>, Michael Halstead <michael@yoctoproject.o=
rg<mailto:michael@yoctoproject.org>>
Subject: Re: [PATCH] build/utils: Add BB_TASK_IONICE_LEVEL support

Hi,

See http://www.yoctoproject.org/docs/2.0/bitbake-user-manual/bitbake-user-m=
anual.html#var-BB_TASK_IONICE_LEVEL for the new variable description in the=
 BitBake User Manual.  Note that I did not include the future implementatio=
n information at the bottom of Richard's explanation.  Also, there is a bit=
 about the 'cfq scheduler' near the end.  I did not know how to properly fo=
rmat this string (e.g. CFG Scheduler).

Let me know of any changes or fixes.

Thanks,
Scott

On Sat, Oct 24, 2015 at 3:19 AM, Richard Purdie <richard.purdie@linuxfounda=
tion.org<mailto:richard.purdie@linuxfoundation.org>> wrote:
Similarly to BB_TASK_NICE_LEVEL, add BB_TASK_IONICE_LEVEL which allows the =
ioprio
of tasks to be adjusted. This is in response to various qemu runtime timeou=
ts
which have been witnessed on the autobuilder, seemingly due to IO starvatio=
n (we
already use NICE_LEVEL to adjust tasks). This has a fairly urgent need to d=
eal
with certain 'random' failures we're seeing on the autobuilders in testing.

The format of the data in the variable is BB_TASK_IONICE_LEVEL =3D "<class>=
.<prio>".

For <class>, 2 is best effort (the default), 1 is real time and 3 is idle. =
You'd
need superuser privileges to use realtime. The <prio> value is a default of=
 4,
and can be set between 0 and 7 with 7 being lowest priority and 0 the highe=
st.
The user can set this freely with normal privileges

Note that in order for this to take effect, you need the cfq scheduler sele=
cted
for the backing block device.

We could use nice wrapper functions for ioprio from modules like psutil how=
ever
that would complicate bitbake dependencies. This version has some magic num=
bers
but works on the main 32 and 64 bit x86 build architectures and can easily =
be
extended if ever needed. When we move to python 3.x, we can likely replace =
this
with standard calls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org<mailto:ri=
chard.purdie@linuxfoundation.org>>

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 948c395..22428a6 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -413,6 +413,13 @@ def _exec_task(fn, task, d, quieterr):
         nice =3D int(nice) - curnice
         newnice =3D os.nice(nice)
         logger.debug(1, "Renice to %s " % newnice)
+    ionice =3D localdata.getVar("BB_TASK_IONICE_LEVEL", True)
+    if ionice:
+        try:
+            cls, prio =3D ionice.split(".", 1)
+            bb.utils.ioprio_set(os.getpid(), int(cls), int(prio))
+        except:
+            bb.warn("Invalid ionice level %s" % ionice)

     bb.utils.mkdirhier(tempdir)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index eb219c1..86a5328 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1310,3 +1310,27 @@ def signal_on_parent_exit(signame):
     result =3D cdll['libc.so.6'].prctl(PR_SET_PDEATHSIG, signum)
     if result !=3D 0:
         raise PrCtlError('prctl failed with error code %s' % result)
+
+#
+# Manually call the ioprio syscall. We could depend on other libs like psu=
til
+# however this gets us enough of what we need to bitbake for now without t=
he
+# dependency
+#
+_unamearch =3D os.uname()[4]
+IOPRIO_WHO_PROCESS =3D 1
+IOPRIO_CLASS_SHIFT =3D 13
+
+def ioprio_set(who, cls, value):
+    NR_ioprio_set =3D None
+    if _unamearch =3D=3D "x86_64":
+      NR_ioprio_set =3D 251
+    elif _unamearch[0] =3D=3D "i" and _unamearch[2:3] =3D=3D "86":
+      NR_ioprio_set =3D 289
+
+    if NR_ioprio_set:
+        ioprio =3D value | (cls << IOPRIO_CLASS_SHIFT)
+        rc =3D cdll['libc.so.6'].syscall(NR_ioprio_set, IOPRIO_WHO_PROCESS=
, who, ioprio)
+        if rc !=3D 0:
+            raise ValueError("Unable to set ioprio, syscall returned %s" %=
 rc)
+    else:
+        bb.warn("Unable to set IO Prio for arch %s" % _unamearch)




