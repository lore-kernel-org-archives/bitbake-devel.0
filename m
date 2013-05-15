Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <fgretief@gmail.com>) id 1UcgBu-00047P-Lx
	for bitbake-devel@lists.openembedded.org;
	Wed, 15 May 2013 20:12:45 +0200
Received: by mail-lb0-f176.google.com with SMTP id x10so2164230lbi.21
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 May 2013 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:date:message-id:subject:from:to
	:content-type; bh=zx4V+6oXtmMvm7XOCWcNCyALXW9l+xWCefbW2qcXDvw=;
	b=hGUVq+aXGtpU+D3apDnD2o9gOus5YDrEIB4fUrWODZHe1A3Lf7KJrPYNaIvXBMaQ06
	YSUrY3vzGOmNT4KNSb2XY7vww17D4EJL4eyUVbEF90OxilFkGRjkTQyAq4HqQabbDG4z
	0xNdZMjsB+9j+5NT2bS9xWnYtZPCGqvFenIj1wGf43BLXEkwIz9Q674rbS7lDKooCE3J
	CCKpjHI1mK2PLdLbxAOCKEXN9XMWcue9b2qR8QFdO4ACB1BrsTAEGVfKOv/NzThbAXq5
	HRQBCE26N26flZUBySPuvmEHV6ETRsOrzhB09g0Y0Dy6+vr+vcdCvkE8fuLY50l1W1OZ
	5OgA==
MIME-Version: 1.0
X-Received: by 10.112.184.226 with SMTP id ex2mr2995389lbc.33.1368640469411;
	Wed, 15 May 2013 10:54:29 -0700 (PDT)
Received: by 10.152.29.225 with HTTP; Wed, 15 May 2013 10:54:29 -0700 (PDT)
Date: Wed, 15 May 2013 19:54:29 +0200
Message-ID: <CAFpw0gLkmOEVbXdVz8ihKNaqaHKSfghYuLo4CjqZUEDmKKwTtQ@mail.gmail.com>
From: Francois Retief <fgretief@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: How to determine a flowId for log messages?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 15 May 2013 18:12:46 -0000
X-Groupsio-MsgNum: 3453
Content-Type: multipart/mixed; boundary=001a11c31310012d5c04dcc571e8

--001a11c31310012d5c04dcc571e8
Content-Type: multipart/alternative; boundary=001a11c31310012d5604dcc571e6

--001a11c31310012d5604dcc571e6
Content-Type: text/plain; charset=ISO-8859-1

Hi,

At work we use TeamCity [1] as our CI server.  I have written a small patch
(attached to email) to extend bitbake to output log messages in TeamCity's
Service Message format [2]. This allow us to better communicate warnings
and errors to the server.

I did this by overriding the BBLogFormatter class in knotty.py. The output
is formatted with timestamp, text, errorDetails and status fields so that
the TeamCity server can augment the logs with color and terminate if errors
occur.

TeamCity also has a *flowId* field that is used as a unique identifier to
distinguish between separate processes running in parallel. On the server,
all messages with the same *flowId* is grouped together. I would like to
use it with bitbake.

What bitbake logging attribute do I need to monitor to determine the *flowId
* of a message?

I tried to use the taskId attribute in the logging record, but most of the
time it is set to either zero or not there at all.

        if hasattr(record, 'taskpid') and record.taskpid != 0:
            msg += " flowId='%s'" % record.taskpid

Are there any other way to identify log messages for grouping them together?

Or any alternative methods? Am I on the right track,
or do I need to write a whole new ui for this?

Cheers,
  Francois

[1] http://www.jetbrains.com/teamcity
[2]
http://confluence.jetbrains.com/display/TCD7/Build+Script+Interaction+with+TeamCity

--001a11c31310012d5604dcc571e6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi,<br><br></div>At work we use TeamCi=
ty [1] as our CI server.=A0 I have written a small patch (attached to email=
) to extend bitbake to output log messages in TeamCity&#39;s Service Messag=
e format [2]. This allow us to better communicate warnings and errors to th=
e server.<br>
<br></div>I did this by overriding the BBLogFormatter class in knotty.py. T=
he output is formatted with timestamp, text, errorDetails and status fields=
 so that the TeamCity server can augment the logs with color and terminate =
if errors occur.<br>
<br></div>TeamCity also has a <b>flowId</b> field that is used as a unique =
identifier to distinguish between separate processes running in parallel. O=
n the server, all messages with the same <b>flowId</b> is grouped together.=
 I would like to use it with bitbake.<br>
<br></div><div>What bitbake logging attribute do I need to monitor to deter=
mine the <b>flowId</b> of a message?<br><br></div><div>I tried to use the t=
askId attribute in the logging record, but most of the time it is set to ei=
ther zero or not there at all. <br>
<br></div>=A0=A0=A0=A0=A0=A0=A0 if hasattr(record, &#39;taskpid&#39;) and r=
ecord.taskpid !=3D 0:<br><div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msg +=3D &q=
uot; flowId=3D&#39;%s&#39;&quot; % record.taskpid<br></div><div><br></div><=
div>Are there any other way to identify log messages for grouping them toge=
ther?<br>
</div><div><br>Or any alternative methods? Am I on the right track, <br>or =
do I need to write a whole new ui for this?<br></div><div><div><div></div><=
br><div></div><div>Cheers,<br></div><div>=A0 Francois<br></div><div><br>[1]=
 <a href=3D"http://www.jetbrains.com/teamcity">http://www.jetbrains.com/tea=
mcity</a><br>
[2] <a href=3D"http://confluence.jetbrains.com/display/TCD7/Build+Script+In=
teraction+with+TeamCity">http://confluence.jetbrains.com/display/TCD7/Build=
+Script+Interaction+with+TeamCity</a><br><br></div></div></div></div>

--001a11c31310012d5604dcc571e6--

--001a11c31310012d5c04dcc571e8
Content-Type: application/octet-stream; 
	name="bitbake-ui-changes-for-teamcity.patch"
Content-Disposition: attachment; 
	filename="bitbake-ui-changes-for-teamcity.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgqrcobl0

ZGlmZiAtLWdpdCBhL2xpYi9iYi91aS9rbm90dHkucHkgYi9saWIvYmIvdWkva25vdHR5LnB5Cmlu
ZGV4IDM3OTkwMTguLjcwZDdkZjUgMTAwNjQ0Ci0tLSBhL2xpYi9iYi91aS9rbm90dHkucHkKKysr
IGIvbGliL2JiL3VpL2tub3R0eS5weQpAQCAtMzEsMTEgKzMxLDU2IEBAIGltcG9ydCB0aW1lCiBp
bXBvcnQgZmNudGwKIGltcG9ydCBzdHJ1Y3QKIGltcG9ydCBjb3B5CitpbXBvcnQgZGF0ZXRpbWUK
IGZyb20gYmIudWkgaW1wb3J0IHVpaGVscGVyCiAKIGxvZ2dlciA9IGxvZ2dpbmcuZ2V0TG9nZ2Vy
KCJCaXRCYWtlIikKIGludGVyYWN0aXZlID0gc3lzLnN0ZG91dC5pc2F0dHkoKQogCitjbGFzcyBU
ZWFtQ2l0eUxvZ0Zvcm1hdHRlcihiYi5tc2cuQkJMb2dGb3JtYXR0ZXIpOgorICAgICIiIkZvcm1h
dHRlciB0aGF0IG91dHB1dHMgVGVhbUNpdHkgY29tcGF0aWJsZSBtZXNzYWdlcyIiIgorCisgICAg
bGV2ZWxuYW1lcyA9IHsKKyAgICAgICAgIyBUZWFtQ2l0eTogTk9STUFMLCBXQVJOSU5HLCBGQUlM
VVJFLCBFUlJPUgorICAgICAgICBiYi5tc2cuQkJMb2dGb3JtYXR0ZXIuREVCVUczICA6ICdOT1JN
QUwnLAorICAgICAgICBiYi5tc2cuQkJMb2dGb3JtYXR0ZXIuREVCVUcyICA6ICdOT1JNQUwnLAor
ICAgICAgICBiYi5tc2cuQkJMb2dGb3JtYXR0ZXIuREVCVUcgICA6ICdOT1JNQUwnLAorICAgICAg
ICBiYi5tc2cuQkJMb2dGb3JtYXR0ZXIuVkVSQk9TRSA6ICdOT1JNQUwnLAorICAgICAgICBiYi5t
c2cuQkJMb2dGb3JtYXR0ZXIuTk9URSAgICA6ICdOT1JNQUwnLAorICAgICAgICBiYi5tc2cuQkJM
b2dGb3JtYXR0ZXIuUExBSU4gICA6ICdOT1JNQUwnLAorICAgICAgICBiYi5tc2cuQkJMb2dGb3Jt
YXR0ZXIuV0FSTklORyA6ICdXQVJOSU5HJywKKyAgICAgICAgYmIubXNnLkJCTG9nRm9ybWF0dGVy
LkVSUk9SICAgOiAnRVJST1InLAorICAgICAgICBiYi5tc2cuQkJMb2dGb3JtYXR0ZXIuQ1JJVElD
QUw6ICdFUlJPUicsCisgICAgfQorCisgICAgcXVvdGUgPSB7IiciOiAifCciLCAifCI6ICJ8fCIs
ICJcbiI6ICJ8biIsICJcciI6ICJ8ciIsICddJzogJ3xdJ30KKworICAgIGRlZiBlc2NhcGVWYWx1
ZShzZWxmLCB2YWx1ZSk6CisgICAgICAgIHJldHVybiAiIi5qb2luKFtzZWxmLnF1b3RlLmdldCh4
LCB4KSBmb3IgeCBpbiB2YWx1ZV0pCisKKyAgICBkZWYgZ2V0TGV2ZWxOYW1lKHNlbGYsIGxldmVs
bm8pOgorICAgICAgICB0cnk6CisgICAgICAgICAgICByZXR1cm4gc2VsZi5sZXZlbG5hbWVzW2xl
dmVsbm9dCisgICAgICAgIGV4Y2VwdCBLZXlFcnJvcjoKKyAgICAgICAgICAgIHNlbGYubGV2ZWxu
YW1lc1tsZXZlbG5vXSA9IHZhbHVlID0gJ0ZBSUxVUkUnCisgICAgICAgICAgICByZXR1cm4gdmFs
dWUKKworICAgIGRlZiBmb3JtYXQoc2VsZiwgcmVjb3JkKToKKyAgICAgICAgcmVjb3JkLmxldmVs
bmFtZSA9IHNlbGYuZ2V0TGV2ZWxOYW1lKHJlY29yZC5sZXZlbG5vKQorCisgICAgICAgIG1zZyA9
ICJ0aW1lc3RhbXA9JyVzJyIgJSBkYXRldGltZS5kYXRldGltZS5ub3coKS5pc29mb3JtYXQoKVs6
LTNdCisgICAgICAgIG1zZyArPSAiIHRleHQ9JyVzJyIgJSBzZWxmLmVzY2FwZVZhbHVlKHJlY29y
ZC5nZXRNZXNzYWdlKCkpCisKKyAgICAgICAgaWYgaGFzYXR0cihyZWNvcmQsICdiYl9leGNfaW5m
bycpOgorICAgICAgICAgICAgZXR5cGUsIHZhbHVlLCB0YiA9IHJlY29yZC5iYl9leGNfaW5mbwor
ICAgICAgICAgICAgZm9ybWF0dGVkID0gYmIuZXhjZXB0aW9ucy5mb3JtYXRfZXhjZXB0aW9uKGV0
eXBlLCB2YWx1ZSwgdGIsIGxpbWl0PTUpCisgICAgICAgICAgICBtc2cgKz0gIiBlcnJvckRldGFp
bHM9JyVzJyIgJSBzZWxmLmVzY2FwZVZhbHVlKCcnLmpvaW4oZm9ybWF0dGVkKSkKKyAgICAgICAg
ICAgIG1zZyArPSAiIHN0YXR1cz0nRVJST1InIgorICAgICAgICBlbGlmIHJlY29yZC5sZXZlbG5h
bWUgIT0gIk5PUk1BTCI6CisgICAgICAgICAgICBtc2cgKz0gIiBzdGF0dXM9JyVzJyIgJSByZWNv
cmQubGV2ZWxuYW1lCisKKyAgICAgICAgcmV0dXJuICIjI3RlYW1jaXR5W21lc3NhZ2UgIiArIG1z
ZyArICJdIgorCiBjbGFzcyBCQlByb2dyZXNzKHByb2dyZXNzYmFyLlByb2dyZXNzQmFyKToKICAg
ICBkZWYgX19pbml0X18oc2VsZiwgbXNnLCBtYXh2YWwpOgogICAgICAgICBzZWxmLm1zZyA9IG1z
ZwpAQCAtMjI4LDcgKzI3MywxMCBAQCBkZWYgbWFpbihzZXJ2ZXIsIGV2ZW50SGFuZGxlciwgdGYg
PSBUZXJtaW5hbEZpbHRlcik6CiAgICAgaGVscGVyID0gdWloZWxwZXIuQkJVSUhlbHBlcigpCiAK
ICAgICBjb25zb2xlID0gbG9nZ2luZy5TdHJlYW1IYW5kbGVyKHN5cy5zdGRvdXQpCi0gICAgZm9y
bWF0ID0gYmIubXNnLkJCTG9nRm9ybWF0dGVyKCIlKGxldmVsbmFtZSlzOiAlKG1lc3NhZ2UpcyIp
CisgICAgaWYgIlRFQU1DSVRZX1ZFUlNJT04iIGluIG9zLmVudmlyb246CisgICAgICAgIGZvcm1h
dCA9IFRlYW1DaXR5TG9nRm9ybWF0dGVyKCIlKG1lc3NhZ2UpcyIpCisgICAgZWxzZToKKyAgICAg
ICAgZm9ybWF0ID0gYmIubXNnLkJCTG9nRm9ybWF0dGVyKCIlKGxldmVsbmFtZSlzOiAlKG1lc3Nh
Z2UpcyIpCiAgICAgYmIubXNnLmFkZERlZmF1bHRsb2dGaWx0ZXIoY29uc29sZSkKICAgICBjb25z
b2xlLnNldEZvcm1hdHRlcihmb3JtYXQpCiAgICAgbG9nZ2VyLmFkZEhhbmRsZXIoY29uc29sZSkK

--001a11c31310012d5c04dcc571e8--
