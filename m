Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B6C43334
	for <webhook@archiver.kernel.org>; Sat,  9 Jul 2022 11:22:46 +0000 (UTC)
Subject: Re: [PATCH v3] runqueue: add cpu/io pressure regulation
To: bitbake-devel@lists.openembedded.org
From: "Paulo Neves" <ptsneves@gmail.com>
X-Originating-Location: Szczecin, West Pomerania, PL (83.11.75.211)
X-Originating-Platform: Linux Firefox 102
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sat, 09 Jul 2022 04:22:37 -0700
References: <20220706205048.2492443-1-aryaman.gupta@windriver.com>
In-Reply-To: <20220706205048.2492443-1-aryaman.gupta@windriver.com>
Message-ID: <24475.1657365757702269187@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="amcnRzJkdlMPUSL9wmTw"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 Jul 2022 11:22:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13817

--amcnRzJkdlMPUSL9wmTw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 6, 2022 at 01:51 PM, Aryaman Gupta wrote:

>=20
> Stop the scheduler from starting new tasks if the current cpu or io
> pressure is above a certain threshold and there is at least one active
> task. This threshold can be specified through the
> "BB_PRESSURE_MAX_SOME_{CPU|IO}" variables in conf/local.conf.
>=20
> If the thresholds aren't specified, pressure is not monitored and hence
> there is no impact on build times.
> Arbitary lower limit of 1.0 results in a fatal error to avoid extremely
> long builds. If the percentage limits are higher than 100, then the
> vales are rounded down to 100 and warnings are issued to inform users
> that the specified limit is out of bounds.
>=20
> The current bitbake scheduling algorithm requires that at least one
> task be active. This means that if high pressure is seen, then new tasks
> will not be started and pressure will be checked only for as long as at
> least one task is active. When there are no active tasks, an additional
> task
> will be started and pressure checking resumed. This behaviour means that
> if an external source is causing the pressure to exceed the threshold,
> bitbake will continue to make some progress towards the requested target.
> This violates the intent of limiting pressure but, given the current
> scheduling algorithm as described above, there seems to be no other
> option.
> In the case where only one bitbake build is running, the implications of
> the scheduler requirement will likely result in pressure being higher
> than the threshold. More work would be required to ensure that
> the pressure threshold is never exceeded, for example adding pressure
> monitoring to make/ninja.
>=20
> Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
> Signed-off-by: Randy Macleod <randy.macleod@windriver.com>
> ---
> * Changes in V3:
> - Ensure that there is always at least one active task before monitoring
> pressure.
> - Fix formatting issues and make code more Pythonic.
>=20
> * Changes in V2:
> - Replace subprocess() calls with open()
> - Rename BB variables to BB_PRESSURE_MAX_SOME_{CPU|IO}
> - Skip the checking of pressure when no value is provided.
>=20
> bitbake/lib/bb/runqueue.py | 48 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 48 insertions(+)
>=20
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 1e47fe70ef..eb3bea07a9 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -159,6 +159,28 @@ class RunQueueScheduler(object):
> self.buildable.append(tid)
>=20
> self.rev_prio_map =3D None
> + # Some hosts like openSUSE have readable /proc/pressure files but throw
> errors when these files are opened
> + # and can't actually be read so don't check pressure in that case.
> + if self.rq.max_cpu_pressure or self.rq.max_io_pressure:
> + try:
> + with open("/proc/pressure/cpu") as cpu_pressure_fds,
> open("/proc/pressure/io") as io_pressure_fds:
> + cpu_pressure_fds.read()
> + io_pressure_fds.read()
> + self.check_pressure =3D True
> + except:
> + bb.warn("The /proc/pressure files can't be read. Continuing build
> without monitoring pressure")
> + self.check_pressure =3D False
> + else:
> + self.check_pressure =3D False
> +

Can you extract the check into a standalone function returning a boolean? I=
t would be more readable and maintainable.

>=20
> + def exceeds_max_pressure(self):
> + if self.check_pressure:
> + # Extract 'some avg10 percent values' from /proc/pressure/{cpu|io}
> + with open("/proc/pressure/cpu") as cpu_pressure_fds,
> open("/proc/pressure/io") as io_pressure_fds:
> + curr_cpu_pressure =3D cpu_pressure_fds.readline().split()[1].split("=3D=
")[1]
>=20
> + curr_io_pressure =3D io_pressure_fds.readline().split()[1].split("=3D")=
[1]
> + return float(curr_cpu_pressure) > self.rq.max_cpu_pressure or
> float(curr_io_pressure) > self.rq.max_io_pressure
> + return False
>=20
> def next_buildable_task(self):
> """
> @@ -172,6 +194,12 @@ class RunQueueScheduler(object):
> if not buildable:
> return None
>=20
> + # Bitbake requires that at least one task be active. Only check for
> pressure if
> + # this is the case, otherwise the pressure limitation could result in n=
o
> tasks
> + # being active and no new tasks started.
> + if self.rq.stats.active and self.exceeds_max_pressure():
> + return None
> +
> # Filter out tasks that have a max number of threads that have been
> exceeded
> skip_buildable =3D {}
> for running in self.rq.runq_running.difference(self.rq.runq_complete):
> @@ -1699,6 +1727,8 @@ class RunQueueExecute:
>=20
> self.number_tasks =3D int(self.cfgData.getVar("BB_NUMBER_THREADS") or 1)
> self.scheduler =3D self.cfgData.getVar("BB_SCHEDULER") or "speed"
> + self.max_cpu_pressure =3D self.cfgData.getVar("BB_PRESSURE_MAX_SOME_CPU=
")
> + self.max_io_pressure =3D self.cfgData.getVar("BB_PRESSURE_MAX_SOME_IO")
>=20
> self.sq_buildable =3D set()
> self.sq_running =3D set()
> @@ -1733,6 +1763,24 @@ class RunQueueExecute:
> if self.number_tasks <=3D 0:
> bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
>=20
> + lower_limit =3D 1.0
> + upper_limit =3D 100.0
> + if self.max_cpu_pressure:
> + self.max_cpu_pressure =3D float(self.max_cpu_pressure)
> + if self.max_cpu_pressure < lower_limit:
> + bb.fatal("Invalid BB_PRESSURE_MAX_SOME_CPU %s, minimum value is %s" %
> (self.max_cpu_pressure, lower_limit))
> + if self.max_cpu_pressure > upper_limit:
> + bb.warn("Percentage value of BB_PRESSURE_MAX_SOME_CPU %s rounded down t=
o
> %s" % (self.max_cpu_pressure, upper_limit))
> + self.max_cpu_pressure =3D upper_limit
> +
> + if self.max_io_pressure:
> + self.max_io_pressure =3D float(self.max_io_pressure)
> + if self.max_io_pressure < lower_limit:
> + bb.fatal("Invalid BB_PRESSURE_MAX_SOME_IO %s, minimum value is %s" %
> (self.max_io_pressure, lower_limit))
> + if self.max_io_pressure > upper_limit:
> + bb.warn("Percentage value of BB_PRESSURE_MAX_SOME_IO %s rounded down to
> %s" % (self.max_io_pressure, upper_limit))
> + self.max_io_pressure =3D upper_limit
> +
> # List of setscene tasks which we've covered
> self.scenequeue_covered =3D set()
> # List of tasks which are covered (including setscene ones)
> --
> 2.35.1

--amcnRzJkdlMPUSL9wmTw
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 6, 2022 at 01:51 PM, Aryaman Gupta wrote:<br />
<blockquote>Stop the scheduler from starting new tasks if the current cpu o=
r io<br />pressure is above a certain threshold and there is at least one a=
ctive<br />task. This threshold can be specified through the<br />"BB_PRESS=
URE_MAX_SOME_{CPU|IO}" variables in conf/local.conf.<br /><br />If the thre=
sholds aren't specified, pressure is not monitored and hence<br />there is =
no impact on build times.<br />Arbitary lower limit of 1.0 results in a fat=
al error to avoid extremely<br />long builds. If the percentage limits are =
higher than 100, then the<br />vales are rounded down to 100 and warnings a=
re issued to inform users<br />that the specified limit is out of bounds.<b=
r /><br />The current bitbake scheduling algorithm requires that at least o=
ne<br />task be active. This means that if high pressure is seen, then new =
tasks<br />will not be started and pressure will be checked only for as lon=
g as at<br />least one task is active. When there are no active tasks, an a=
dditional task<br />will be started and pressure checking resumed. This beh=
aviour means that<br />if an external source is causing the pressure to exc=
eed the threshold,<br />bitbake will continue to make some progress towards=
 the requested target.<br />This violates the intent of limiting pressure b=
ut, given the current<br />scheduling algorithm as described above, there s=
eems to be no other option.<br />In the case where only one bitbake build i=
s running, the implications of<br />the scheduler requirement will likely r=
esult in pressure being higher<br />than the threshold. More work would be =
required to ensure that<br />the pressure threshold is never exceeded, for =
example adding pressure<br />monitoring to make/ninja.<br /><br />Signed-of=
f-by: Aryaman Gupta &lt;aryaman.gupta@windriver.com&gt;<br />Signed-off-by:=
 Randy Macleod &lt;randy.macleod@windriver.com&gt;<br />---<br />* Changes =
in V3:<br />- Ensure that there is always at least one active task before m=
onitoring<br />pressure.<br />- Fix formatting issues and make code more Py=
thonic.<br /><br />* Changes in V2:<br />- Replace subprocess() calls with =
open()<br />- Rename BB variables to BB_PRESSURE_MAX_SOME_{CPU|IO}<br />- S=
kip the checking of pressure when no value is provided.<br /><br />bitbake/=
lib/bb/runqueue.py | 48 ++++++++++++++++++++++++++++++++++++++<br />1 file =
changed, 48 insertions(+)<br /><br />diff --git a/bitbake/lib/bb/runqueue.p=
y b/bitbake/lib/bb/runqueue.py<br />index 1e47fe70ef..eb3bea07a9 100644<br =
/>--- a/bitbake/lib/bb/runqueue.py<br />+++ b/bitbake/lib/bb/runqueue.py<br=
 />@@ -159,6 +159,28 @@ class RunQueueScheduler(object):<br />self.buildabl=
e.append(tid)<br /><br />self.rev_prio_map =3D None<br />+ # Some hosts lik=
e openSUSE have readable /proc/pressure files but throw errors when these f=
iles are opened<br />+ # and can't actually be read so don't check pressure=
 in that case.<br />+ if self.rq.max_cpu_pressure or self.rq.max_io_pressur=
e:<br />+ try:<br />+ with open("/proc/pressure/cpu") as cpu_pressure_fds, =
open("/proc/pressure/io") as io_pressure_fds:<br />+ cpu_pressure_fds.read(=
)<br />+ io_pressure_fds.read()<br />+ self.check_pressure =3D True<br />+ =
except:<br />+ bb.warn("The /proc/pressure files can't be read. Continuing =
build without monitoring pressure")<br />+ self.check_pressure =3D False<br=
 />+ else:<br />+ self.check_pressure =3D False<br />+</blockquote>
Can you extract the check into a standalone function returning a boolean? I=
t would be more readable and maintainable.<br /><br />
<blockquote>+ def exceeds_max_pressure(self):<br />+ if self.check_pressure=
:<br />+ # Extract 'some avg10 percent values' from /proc/pressure/{cpu|io}=
<br />+ with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pr=
essure/io") as io_pressure_fds:<br />+ curr_cpu_pressure =3D cpu_pressure_f=
ds.readline().split()[1].split("=3D")[1]<br />+ curr_io_pressure =3D io_pre=
ssure_fds.readline().split()[1].split("=3D")[1]<br />+ return float(curr_cp=
u_pressure) &gt; self.rq.max_cpu_pressure or float(curr_io_pressure) &gt; s=
elf.rq.max_io_pressure<br />+ return False<br /><br />def next_buildable_ta=
sk(self):<br />"""<br />@@ -172,6 +194,12 @@ class RunQueueScheduler(object=
):<br />if not buildable:<br />return None<br /><br />+ # Bitbake requires =
that at least one task be active. Only check for pressure if<br />+ # this =
is the case, otherwise the pressure limitation could result in no tasks<br =
/>+ # being active and no new tasks started.<br />+ if self.rq.stats.active=
 and self.exceeds_max_pressure():<br />+ return None<br />+<br /># Filter o=
ut tasks that have a max number of threads that have been exceeded<br />ski=
p_buildable =3D {}<br />for running in self.rq.runq_running.difference(self=
.rq.runq_complete):<br />@@ -1699,6 +1727,8 @@ class RunQueueExecute:<br />=
<br />self.number_tasks =3D int(self.cfgData.getVar("BB_NUMBER_THREADS") or=
 1)<br />self.scheduler =3D self.cfgData.getVar("BB_SCHEDULER") or "speed"<=
br />+ self.max_cpu_pressure =3D self.cfgData.getVar("BB_PRESSURE_MAX_SOME_=
CPU")<br />+ self.max_io_pressure =3D self.cfgData.getVar("BB_PRESSURE_MAX_=
SOME_IO")<br /><br />self.sq_buildable =3D set()<br />self.sq_running =3D s=
et()<br />@@ -1733,6 +1763,24 @@ class RunQueueExecute:<br />if self.number=
_tasks &lt;=3D 0:<br />bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.numbe=
r_tasks)<br /><br />+ lower_limit =3D 1.0<br />+ upper_limit =3D 100.0<br /=
>+ if self.max_cpu_pressure:<br />+ self.max_cpu_pressure =3D float(self.ma=
x_cpu_pressure)<br />+ if self.max_cpu_pressure &lt; lower_limit:<br />+ bb=
.fatal("Invalid BB_PRESSURE_MAX_SOME_CPU %s, minimum value is %s" % (self.m=
ax_cpu_pressure, lower_limit))<br />+ if self.max_cpu_pressure &gt; upper_l=
imit:<br />+ bb.warn("Percentage value of BB_PRESSURE_MAX_SOME_CPU %s round=
ed down to %s" % (self.max_cpu_pressure, upper_limit))<br />+ self.max_cpu_=
pressure =3D upper_limit<br />+<br />+ if self.max_io_pressure:<br />+ self=
.max_io_pressure =3D float(self.max_io_pressure)<br />+ if self.max_io_pres=
sure &lt; lower_limit:<br />+ bb.fatal("Invalid BB_PRESSURE_MAX_SOME_IO %s,=
 minimum value is %s" % (self.max_io_pressure, lower_limit))<br />+ if self=
.max_io_pressure &gt; upper_limit:<br />+ bb.warn("Percentage value of BB_P=
RESSURE_MAX_SOME_IO %s rounded down to %s" % (self.max_io_pressure, upper_l=
imit))<br />+ self.max_io_pressure =3D upper_limit<br />+<br /># List of se=
tscene tasks which we've covered<br />self.scenequeue_covered =3D set()<br =
/># List of tasks which are covered (including setscene ones)<br />-- <br /=
>2.35.1</blockquote>

--amcnRzJkdlMPUSL9wmTw--

