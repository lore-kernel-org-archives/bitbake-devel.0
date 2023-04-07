Return-Path: <contrib@zhengqiu.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D76EC6FD1D
	for <webhook@archiver.kernel.org>; Fri,  7 Apr 2023 23:03:10 +0000 (UTC)
Received: from qs51p00im-qukt01071701.me.com (qs51p00im-qukt01071701.me.com [17.57.155.6])
 by mx.groups.io with SMTP id smtpd.web10.309.1680908583099566605
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Apr 2023 16:03:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zhengqiu.net header.s=sig1 header.b=hl1FzUzh;
 spf=pass (domain: zhengqiu.net, ip: 17.57.155.6, mailfrom: contrib@zhengqiu.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhengqiu.net;
	s=sig1; t=1680908582;
	bh=5ZWiHw2MMVzmAQ4OtVRIlS6LEpKmGmHb5YZsX9+mwb8=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
	b=hl1FzUzh0oBnC8zcj9tHgXCjdsDb7ypdu0y+YIesAWzmfk5U/yxWn9yUdgOT82UAi
	 IuzCioGYPixnrDJ3smDmjGyrH3dRcWuxaIujJm9yxJ6nk8TskN1GGMf7C5BrV4YLis
	 zwpI4Qv1S2UDUFo71GQsru3i3dsU4zj/LDKapNbGmforWQd4LoVLX3cXqrmsdBHAxN
	 WI+7ciuQGnZxnOtbBEHARc1xZfmV/wBwSXs3MfRLjcuYoD0bvV1s5alCfYADk/sWZn
	 zcfLIwb2z7XjMW48YZroT4Bc9Um+RR3ub92B3eGGNXrwNNRDwG3KrPvnwRrRclBNm1
	 jVXT48HMPUyOA==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071701.me.com (Postfix) with ESMTPSA id 8F2524D003E2;
	Fri,  7 Apr 2023 23:02:48 +0000 (UTC)
From: contrib@zhengqiu.net
Message-Id: <DE8932AE-1432-43DF-9C50-48F76D6E8EE3@zhengqiu.net>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_4F749F15-E026-424E-A83C-28D4D9E7403E"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [bitbake-devel][PATCH 1/2] runqueue: fix PSI check calculation
Date: Fri, 7 Apr 2023 19:02:30 -0400
In-Reply-To: <d5f4e8e3-53c2-ab85-be64-78252a4e356d@windriver.com>
Cc: Qi.Chen@windriver.com,
 bitbake-devel@lists.openembedded.org
To: Randy MacLeod <Randy.MacLeod@windriver.com>
References: <20230407030715.4394-1-Qi.Chen@windriver.com>
 <d5f4e8e3-53c2-ab85-be64-78252a4e356d@windriver.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-Proofpoint-GUID: wpbL7XAszwwcxXR_T-4G8qwHc1dFYR9h
X-Proofpoint-ORIG-GUID: wpbL7XAszwwcxXR_T-4G8qwHc1dFYR9h
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304070208
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Apr 2023 23:03:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14686


--Apple-Mail=_4F749F15-E026-424E-A83C-28D4D9E7403E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On Apr 7, 2023, at 11:02 AM, Randy MacLeod =
<Randy.MacLeod@windriver.com> wrote:
>=20
> On 2023-04-06 23:07, Chen Qi via lists.openembedded.org =
<http://lists.openembedded.org/> wrote:
>> The current PSI check calculation does not take into consideration
>> the possibility of the time interval between last check and current
>> check being much larger than 1s. In fact, the current behavior does
>> not match what the manual says about BB_PRESSURE_MAX_XXX, even if
>> the value is set to upper limit, 1000000, we still get many blocks
>> on new task launch. The difference between 'total' should be divided
>> by the time interval if it's larger than 1s.

Some ideas about this:

The original 1-second interval is to prevent the time interval between =
two pressure checks too
large, but now we can detect longer time intervals and act accordingly, =
we probably can do
the same thing for short time intervals.

This may also reduce the build time a bit while having similar CPU =
pressure - a lot of half a
second can stack up significantly.

It might be worth testing both solutions.

Zheng
>=20
> Yes!
> I had a patch  to do this but wanted to write a test case using stress =
.
>=20
> Anyway, it's clearly better and won't allow the occasional new job to
> slip in when the time diff is small and the pressure hasn't been =
recalculated
> by the kernel. It will mean that pressure regulated builds may be a =
bit slower
> but I doubt we'll even be able to measure that.
>=20
> Thanks Qi,
>=20
> ../Randy
>=20
>=20
>=20
>> Signed-off-by: Chen Qi <Qi.Chen@windriver.com> =
<mailto:Qi.Chen@windriver.com>
>> ---
>>  bitbake/lib/bb/runqueue.py | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>> index e629ab7e7b..02f1474540 100644
>> --- a/bitbake/lib/bb/runqueue.py
>> +++ b/bitbake/lib/bb/runqueue.py
>> @@ -198,15 +198,20 @@ class RunQueueScheduler(object):
>>                  curr_cpu_pressure =3D =
cpu_pressure_fds.readline().split()[4].split("=3D")[1]
>>                  curr_io_pressure =3D =
io_pressure_fds.readline().split()[4].split("=3D")[1]
>>                  curr_memory_pressure =3D =
memory_pressure_fds.readline().split()[4].split("=3D")[1]
>> -                exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure =
and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > =
self.rq.max_cpu_pressure
>> -                exceeds_io_pressure =3D  self.rq.max_io_pressure and =
(float(curr_io_pressure) - float(self.prev_io_pressure)) > =
self.rq.max_io_pressure
>> -                exceeds_memory_pressure =3D =
self.rq.max_memory_pressure and (float(curr_memory_pressure) - =
float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
>>                  now =3D time.time()
>> -                if now - self.prev_pressure_time > 1.0:
>> +                tdiff =3D now - self.prev_pressure_time
>> +                if tdiff > 1.0:
>> +                    exceeds_cpu_pressure =3D  =
self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - =
float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
>> +                    exceeds_io_pressure =3D  self.rq.max_io_pressure =
and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > =
self.rq.max_io_pressure
>> +                    exceeds_memory_pressure =3D =
self.rq.max_memory_pressure and (float(curr_memory_pressure) - =
float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
>>                      self.prev_cpu_pressure =3D curr_cpu_pressure
>>                      self.prev_io_pressure =3D curr_io_pressure
>>                      self.prev_memory_pressure =3D =
curr_memory_pressure
>>                      self.prev_pressure_time =3D now
>> +                else:
>> +                    exceeds_cpu_pressure =3D  =
self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - =
float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
>> +                    exceeds_io_pressure =3D  self.rq.max_io_pressure =
and (float(curr_io_pressure) - float(self.prev_io_pressure)) > =
self.rq.max_io_pressure
>> +                    exceeds_memory_pressure =3D =
self.rq.max_memory_pressure and (float(curr_memory_pressure) - =
float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
>>              return (exceeds_cpu_pressure or exceeds_io_pressure or =
exceeds_memory_pressure)
>>          return False
>> =20
>>=20
>>=20
>=20
> --=20
> # Randy MacLeod
> # Wind River Linux
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14684): =
https://lists.openembedded.org/g/bitbake-devel/message/14684
> Mute This Topic: https://lists.openembedded.org/mt/98118922/7355053
> Group Owner: bitbake-devel+owner@lists.openembedded.org =
<mailto:bitbake-devel+owner@lists.openembedded.org>
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub =
[contrib@zhengqiu.net <mailto:contrib@zhengqiu.net>]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Apple-Mail=_4F749F15-E026-424E-A83C-28D4D9E7403E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><meta =
http-equiv=3D"content-type" content=3D"text/html; charset=3Dus-ascii"><div=
 style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br><div><br><blockquote =
type=3D"cite"><div>On Apr 7, 2023, at 11:02 AM, Randy MacLeod =
&lt;Randy.MacLeod@windriver.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><div =
class=3D"moz-cite-prefix" style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">On 2023-04-06 23:07, Chen Qi via<span =
class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"http://lists.openembedded.org/">lists.openembedded.org</a><span =
class=3D"Apple-converted-space">&nbsp;</span>wrote:<br></div><blockquote =
type=3D"cite" cite=3D"mid:20230407030715.4394-1-Qi.Chen@windriver.com" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><pre =
class=3D"moz-quote-pre" wrap=3D"">The current PSI check calculation does =
not take into consideration
the possibility of the time interval between last check and current
check being much larger than 1s. In fact, the current behavior does
not match what the manual says about BB_PRESSURE_MAX_XXX, even if
the value is set to upper limit, 1000000, we still get many blocks
on new task launch. The difference between 'total' should be divided
by the time interval if it's larger than =
1s.</pre></blockquote></div></blockquote><div><br></div>Some ideas about =
this:</div><div><br></div><div>The original 1-second interval is to =
prevent the time interval between two pressure checks =
too</div><div>large, but now we can detect longer time intervals and act =
accordingly, we probably can do</div><div>the same thing for short time =
intervals.</div><div><br></div><div>This may also reduce the build time =
a bit while having similar CPU pressure - a lot of half =
a</div><div>second can stack up =
significantly.</div><div><br></div><div>It might be worth testing both =
solutions.</div><div><br></div><div>Zheng</div><div><blockquote =
type=3D"cite"><div><p style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br></p><p style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;">Yes!<br>I had a patch&nbsp; to do this but wanted to write a test =
case using stress .<br></p><p style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Anyway, it's clearly better and won't allow the =
occasional new job to<br>slip in when the time diff is small and the =
pressure hasn't been recalculated<br>by the kernel. It will mean that =
pressure regulated builds may be a bit slower<br>but I doubt we'll even =
be able to measure that.</p><p style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Thanks Qi,<br></p><p style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">../Randy</p><p style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br></p><blockquote type=3D"cite" =
cite=3D"mid:20230407030715.4394-1-Qi.Chen@windriver.com" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><pre =
class=3D"moz-quote-pre" wrap=3D"">Signed-off-by: Chen Qi <a =
class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>
---
 bitbake/lib/bb/runqueue.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index e629ab7e7b..02f1474540 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -198,15 +198,20 @@ class RunQueueScheduler(object):
                 curr_cpu_pressure =3D =
cpu_pressure_fds.readline().split()[4].split("=3D")[1]
                 curr_io_pressure =3D =
io_pressure_fds.readline().split()[4].split("=3D")[1]
                 curr_memory_pressure =3D =
memory_pressure_fds.readline().split()[4].split("=3D")[1]
-                exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure and =
(float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) &gt; =
self.rq.max_cpu_pressure
-                exceeds_io_pressure =3D  self.rq.max_io_pressure and =
(float(curr_io_pressure) - float(self.prev_io_pressure)) &gt; =
self.rq.max_io_pressure
-                exceeds_memory_pressure =3D self.rq.max_memory_pressure =
and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) =
&gt; self.rq.max_memory_pressure
                 now =3D time.time()
-                if now - self.prev_pressure_time &gt; 1.0:
+                tdiff =3D now - self.prev_pressure_time
+                if tdiff &gt; 1.0:
+                    exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure =
and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff =
&gt; self.rq.max_cpu_pressure
+                    exceeds_io_pressure =3D  self.rq.max_io_pressure =
and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff =
&gt; self.rq.max_io_pressure
+                    exceeds_memory_pressure =3D =
self.rq.max_memory_pressure and (float(curr_memory_pressure) - =
float(self.prev_memory_pressure)) / tdiff &gt; =
self.rq.max_memory_pressure
                     self.prev_cpu_pressure =3D curr_cpu_pressure
                     self.prev_io_pressure =3D curr_io_pressure
                     self.prev_memory_pressure =3D curr_memory_pressure
                     self.prev_pressure_time =3D now
+                else:
+                    exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure =
and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) &gt; =
self.rq.max_cpu_pressure
+                    exceeds_io_pressure =3D  self.rq.max_io_pressure =
and (float(curr_io_pressure) - float(self.prev_io_pressure)) &gt; =
self.rq.max_io_pressure
+                    exceeds_memory_pressure =3D =
self.rq.max_memory_pressure and (float(curr_memory_pressure) - =
float(self.prev_memory_pressure)) &gt; self.rq.max_memory_pressure
             return (exceeds_cpu_pressure or exceeds_io_pressure or =
exceeds_memory_pressure)
         return False
=20
</pre><br><fieldset class=3D"moz-mime-attachment-header"></fieldset><pre =
class=3D"moz-quote-pre" wrap=3D""></pre></blockquote><p =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br></p><pre =
class=3D"moz-signature" cols=3D"72" style=3D"caret-color: rgb(0, 0, 0); =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;">--=20
# Randy MacLeod
# Wind River Linux</pre><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Links: You receive all messages sent to =
this group.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">View/Reply Online =
(#14684):<span class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://lists.openembedded.org/g/bitbake-devel/message/14684" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: =
0px;">https://lists.openembedded.org/g/bitbake-devel/message/14684</a><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Mute This Topic:<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://lists.openembedded.org/mt/98118922/7355053" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: =
0px;">https://lists.openembedded.org/mt/98118922/7355053</a><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Group Owner:<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"mailto:bitbake-devel+owner@lists.openembedded.org" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: =
0px;">bitbake-devel+owner@lists.openembedded.org</a><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Unsubscribe:<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://lists.openembedded.org/g/bitbake-devel/unsub" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: =
0px;">https://lists.openembedded.org/g/bitbake-devel/unsub</a><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;"><span =
class=3D"Apple-converted-space">&nbsp;</span>[</span><a =
href=3D"mailto:contrib@zhengqiu.net" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">contrib@zhengqiu.net</a><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">]</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-</span></div></b=
lockquote></div><br></div></body></html>=

--Apple-Mail=_4F749F15-E026-424E-A83C-28D4D9E7403E--

