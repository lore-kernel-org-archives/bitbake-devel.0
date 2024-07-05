Return-Path: <yang-mark.zhang@nokia-sbell.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485BBC30653
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 01:42:34 +0000 (UTC)
Subject: patch to fix wrong http response for sstate cache checkstatus
To: bitbake-devel@lists.openembedded.org
From: "Yang-Mark Zhang (NSB)" <yang-mark.zhang@nokia-sbell.com>
X-Originating-Location: Hangzhou, Zhejiang, CN (124.160.72.160)
X-Originating-Platform: Windows Chrome 126
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 04 Jul 2024 18:42:27 -0700
Message-ID: <iqRH.1720058591230617209.hhMB@lists.openembedded.org>
X-Old-Date: Wed, 03 Jul 2024 19:03:11 -0700
Content-Type: multipart/mixed; boundary="kkfIYPVMqcB89L5FIVWn"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jul 2024 01:42:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16385
Message-ID: <20240705014227.z0dqjduxiekQ-SnsRHnyaFgw6ehYubYLmy-zStBCF5Y@z>

--kkfIYPVMqcB89L5FIVWn
Content-Type: multipart/related; boundary="kFQxXGhSxEMW1Jh0O5hY"

--kFQxXGhSxEMW1Jh0O5hY
Content-Type: multipart/alternative; boundary="bQtaNoeT73fmPMoF5ve7"

--bQtaNoeT73fmPMoF5ve7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

the issue is in sstate-cache checkstatus() for http mirrors
A request expired 30s timeout and released the connection,
B request took the connection into use and get the wrong response(meant to =
response A request and late than 30s)
details can be found here:

* how to reproduce:
modify /usr/lib64/python3.10/http/client.py like this to fake timeout event
you will find that some sstate files with 200 response in fact do not exist=
s in remote http server
=E2=80=94 a/client.py
+++ b/client.py
@@ -68,6 +68,7 @@ Req-started-unread-response =C2=A0 =C2=A0_CS_REQ_STARTED =
=C2=A0 =C2=A0<response_class>
Req-sent-unread-response =C2=A0 =C2=A0 =C2=A0 _CS_REQ_SENT =C2=A0 =C2=A0 =
=C2=A0 <response_class>
"""

+import random
import email.parser
import email.message
import errno
@@ -1370,6 +1371,8 @@ class HTTPConnection:
else:
response =3D self.response_class(self.sock, method=3Dself._method)

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if random.choice([False, False, False, False, =
False, False, False, True]):
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise TimeoutError('timed out te=
st')
try:
try:
response.begin()

patch content:

From 76bc06e823d67e4eecaf7f2c7be0b67e405b1f76 Mon Sep 17 00:00:00 2001
From: y75zhang <yang-mark.zhang@nokia-sbell.com>
Date: Wed, 3 Jul 2024 08:20:34 +0300
Subject: [PATCH] bitbake: checkstatus: drop shared connecton when catch
Timeout error
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

* to avoid wrong http response in checkstatus function:
in wget checkstatus() we are using 'HTTPConnectionCache' to share connectio=
ns
1. state_file1(exists on http server) use shared connection <shared1> to se=
nd request
2. http_server recieved request of state_file1, but delayed by some reason =
to sent respone
3. state_file1 checkstatus() failed by timeout and drop shared connection <=
shared1>
4. state_file2(not exists on http server) get shared connection <shared1> a=
nd send request
5. http_server finally send 200 response for state_file1
6. state_file2 recived 200 response and thought it was exists on http_serve=
r

* how to reproduce:
modify /usr/lib64/python3.10/http/client.py like this to fake timeout event
you will find that some sstate files with 200 response in fact do not exist=
s in remote http server
=E2=80=94 a/client.py
+++ b/client.py
@@ -68,6 +68,7 @@ Req-started-unread-response =C2=A0 =C2=A0_CS_REQ_STARTED =
=C2=A0 =C2=A0<response_class>
Req-sent-unread-response =C2=A0 =C2=A0 =C2=A0 _CS_REQ_SENT =C2=A0 =C2=A0 =
=C2=A0 <response_class>
"""

+import random
import email.parser
import email.message
import errno
@@ -1370,6 +1371,8 @@ class HTTPConnection:
else:
response =3D self.response_class(self.sock, method=3Dself._method)

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if random.choice([False, False, False, False, =
False, False, False, True]):
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise TimeoutError('timed out te=
st')
try:
try:
response.begin()

Signed-off-by: y75zhang <yang-mark.zhang@nokia-sbell.com>
---
bitbake/lib/bb/fetch2/wget.py | 9 +++++++--
1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 2e92117..56caf92 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -244,7 +244,12 @@ class Wget(FetchMethod):
fetch.connection_cache.remove_connection(h.host, h.port)
raise urllib.error.URLError(err)
else:
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =
=3D h.getresponse()
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0r =3D h.getresponse()
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exce=
pt TimeoutError as e:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if fetch.connection_cache:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0fetch.connection_cache.remove_connection(h.host, h.=
port)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0raise TimeoutError(e)

# Pick apart the HTTPResponse object to get the addinfourl
# object initialized properly.
@@ -496,7 +501,7 @@ class Wget(FetchMethod):
valid =3D 1
elif self._vercmp(version, newver) < 0:
version =3D newver
-
+
pupver =3D re.sub('_', '.', version[1])

bb.debug(3, "*** %s -> UpstreamVersion =3D %s (CurrentVersion =3D %s)" %
-- --

*Yang zhang*

yang-mark.zhang@nokia-sbell.com

--bQtaNoeT73fmPMoF5ve7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p class=3D"DefangedMsoNormal"><span lang=3D"EN-US">the issue is in sstate-=
cache checkstatus() for http mirrors<br /></span><span lang=3D"EN-US" style=
=3D"font-family: -apple-system; color: #172b4d; background: white;">A reque=
st expired 30s timeout and released the connection,<br />B request took the=
 connection into use and get the wrong response(meant to response A request=
 and late than 30s)<br /></span><span lang=3D"EN-US">details can be found h=
ere:</span></p>
<p class=3D"DefangedMsoNormal"><span lang=3D"EN-US"><img src=3D"cid:attach_=
0_17DEE02CEB94289E_15012@groups.io" /></span></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp; &nbsp; * how to reproduce:<br />&nbsp; &nbsp; &nbsp; &nbsp;modify=
 /usr/lib64/python3.10/http/client.py like this to fake timeout event<br />=
&nbsp; &nbsp; &nbsp; &nbsp;you will find that some sstate files with 200 re=
sponse in fact do not exists in remote http server<br />&nbsp; &nbsp; &mdas=
h; a/client.py<br />&nbsp; &nbsp; +++ b/client.py<br />&nbsp; &nbsp; @@ -68=
,6 +68,7 @@ Req-started-unread-response &nbsp; &nbsp;_CS_REQ_STARTED &nbsp;=
 &nbsp;&lt;response_class&gt;<br />&nbsp; &nbsp; &nbsp;Req-sent-unread-resp=
onse &nbsp; &nbsp; &nbsp; _CS_REQ_SENT &nbsp; &nbsp; &nbsp; &lt;response_cl=
ass&gt;<br />&nbsp; &nbsp; &nbsp;"""<br /><br />&nbsp; &nbsp; +import rando=
m<br />&nbsp; &nbsp; &nbsp;import email.parser<br />&nbsp; &nbsp; &nbsp;imp=
ort email.message<br />&nbsp; &nbsp; &nbsp;import errno<br />&nbsp; &nbsp; =
@@ -1370,6 +1371,8 @@ class HTTPConnection:<br />&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;else:<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;response =3D self.response_class(self.sock, method=3Dse=
lf._method)<br /><br />&nbsp; &nbsp; + &nbsp; &nbsp; &nbsp; &nbsp;if random=
.choice([False, False, False, False, False, False, False, True]):<br />&nbs=
p; &nbsp; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;raise TimeoutError('ti=
med out test')<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;try:<br=
 />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;try:<br />=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;response.begin()</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>patch content:</p>
<p>&nbsp;</p>
<p>From 76bc06e823d67e4eecaf7f2c7be0b67e405b1f76 Mon Sep 17 00:00:00 2001<b=
r />From: y75zhang &lt;yang-mark.zhang@nokia-sbell.com&gt;<br />Date: Wed, =
3 Jul 2024 08:20:34 +0300<br />Subject: [PATCH] bitbake: checkstatus: drop =
shared connecton when catch<br />&nbsp;Timeout error<br />MIME-Version: 1.0=
<br />Content-Type: text/plain; charset=3DUTF-8<br />Content-Transfer-Encod=
ing: 8bit<br /><br />* to avoid wrong http response in checkstatus function=
:<br />&nbsp; &nbsp;in wget checkstatus() we are using 'HTTPConnectionCache=
' to share connections<br />&nbsp; &nbsp;1. state_file1(exists on http serv=
er) use shared connection &lt;shared1&gt; to send request<br />&nbsp; &nbsp=
;2. http_server recieved request of state_file1, but delayed by some reason=
 to sent respone<br />&nbsp; &nbsp;3. state_file1 checkstatus() failed by t=
imeout and drop shared connection &lt;shared1&gt;<br />&nbsp; &nbsp;4. stat=
e_file2(not exists on http server) get shared connection &lt;shared1&gt; an=
d send request<br />&nbsp; &nbsp;5. http_server finally send 200 response f=
or state_file1<br />&nbsp; &nbsp;6. state_file2 recived 200 response and th=
ought it was exists on http_server<br /><br />* how to reproduce:<br />&nbs=
p; &nbsp;modify /usr/lib64/python3.10/http/client.py like this to fake time=
out event<br />&nbsp; &nbsp;you will find that some sstate files with 200 r=
esponse in fact do not exists in remote http server<br />&mdash; a/client.p=
y<br />+++ b/client.py<br />@@ -68,6 +68,7 @@ Req-started-unread-response &=
nbsp; &nbsp;_CS_REQ_STARTED &nbsp; &nbsp;&lt;response_class&gt;<br />&nbsp;=
Req-sent-unread-response &nbsp; &nbsp; &nbsp; _CS_REQ_SENT &nbsp; &nbsp; &n=
bsp; &lt;response_class&gt;<br />&nbsp;"""<br /><br />+import random<br />&=
nbsp;import email.parser<br />&nbsp;import email.message<br />&nbsp;import =
errno<br />@@ -1370,6 +1371,8 @@ class HTTPConnection:<br />&nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;else:<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;response =3D self.response_class(self.sock, method=3Dself._method)<br />=
<br />+ &nbsp; &nbsp; &nbsp; &nbsp;if random.choice([False, False, False, F=
alse, False, False, False, True]):<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;raise TimeoutError('timed out test')<br />&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;try:<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;try:<br =
/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;response.be=
gin()<br /><br />Signed-off-by: y75zhang &lt;yang-mark.zhang@nokia-sbell.co=
m&gt;<br />---<br />&nbsp;bitbake/lib/bb/fetch2/wget.py | 9 +++++++--<br />=
&nbsp;1 file changed, 7 insertions(+), 2 deletions(-)<br /><br />diff --git=
 a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py<br />index=
 2e92117..56caf92 100644<br />--- a/bitbake/lib/bb/fetch2/wget.py<br />+++ =
b/bitbake/lib/bb/fetch2/wget.py<br />@@ -244,7 +244,12 @@ class Wget(FetchM=
ethod):<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;fetch.connection_cache.remove_connection(h.host=
, h.port)<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;raise urllib.error.URLError(err)<br />&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;else:<br />- &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r =3D h.getresponse()<br />=
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;try:=
<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;r =3D h.getresponse()<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;except TimeoutError as e:<br />+ &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;if fetch.connection_cache:<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fetch.connecti=
on_cache.remove_connection(h.host, h.port)<br />+ &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;raise TimeoutErro=
r(e)<br />&nbsp;<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;# Pick apart the HTTPResponse object to get the addinfourl<br />&n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# object initia=
lized properly.<br />@@ -496,7 +501,7 @@ class Wget(FetchMethod):<br />&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;val=
id =3D 1<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;elif self._vercmp(version, newver) &lt; 0:<br />&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;version =3D newver<br />-=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br />+<br />&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;pupver =3D re.sub('_', '.', version[1])<br />&n=
bsp;<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bb.debug(3, "*** %s -&gt; Upstr=
eamVersion =3D %s (CurrentVersion =3D %s)" %<br />--&nbsp;<span lang=3D"EN-=
US" style=3D"font-size: 10.0pt; color: #0c64c0;"></span>--</p>
<p class=3D"DefangedMsoNormal" style=3D"margin: 0px;"><strong><span lang=3D=
"EN-US" style=3D"font-size: 10.0pt; color: #0c64c0;">Yang zhang</span></str=
ong><span lang=3D"EN-US" style=3D"font-size: 10.0pt; color: #0c64c0;"></spa=
n></p>
<p class=3D"DefangedMsoNormal" style=3D"margin: 0px;"><span lang=3D"EN-US" =
style=3D"font-size: 10.0pt; color: #0c64c0;">yang-mark.zhang@nokia-sbell.co=
m</span></p>

--bQtaNoeT73fmPMoF5ve7--

--kFQxXGhSxEMW1Jh0O5hY
Content-Id: <attach_0_17DEE02CEB94289E_15012@groups.io>
X-Attachment-Id: attach_0_17DEE02CEB94289E_15012@groups.io
Content-Type: image/png; name="dummyfile.0.part"
Content-Disposition: inline; filename="dummyfile.0.part"
Content-Transfer-Encoding: base64

groupsio/67608/107031353/16385/0
{"ID":0,"Created":1720058591255271086,"Updated":1720058591255271086,"Version":0,"UserID":0,"GroupID":67608,"Name":"dummyfile.0.part","NameLower":"dummyfile.0.part","Desc":"","MediaType":"image/png","Width":1009,"Height":481,"Size":98899,"Format":"png","AlbumID":0,"FocalLength":0,"ISO":0,"Aperture":0,"ShutterSpeed":0,"Taken":0,"Make":"","Model":""}

--kFQxXGhSxEMW1Jh0O5hY--

--kkfIYPVMqcB89L5FIVWn
Content-Type: application/octet-stream; name="0001-bitbake-checkstatus-drop-shared-connecton-when-catch.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-bitbake-checkstatus-drop-shared-connecton-when-catch.patch"

groupsio/67608/107031353/16385/1

--kkfIYPVMqcB89L5FIVWn--

