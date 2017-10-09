Return-Path: <nandojve@gmail.com>
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com
	[209.85.216.179])
	by mail.openembedded.org (Postfix) with ESMTP id 58EFA77DC8
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Oct 2017 12:49:05 +0000 (UTC)
Received: by mail-qt0-f179.google.com with SMTP id k31so7412219qta.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Oct 2017 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=xHlcFbCxhYi9iCvTQk3dtihDqv4oPK6zIL4Eo7xg9g4=;
	b=Ar66tsYmcRp/xi6cwlkjEDmMYZXbqfCNWoo/wM10XvZmKcFp7EmuI2UBuZ0qBL7YKl
	JD2g5CjnHAYDN/uMBoXCw2NO4z5Ah3vGn4+ShsSYAi5U4caMWOo+AIM8Exc6vEzvlGgb
	7O7t+riK8IJueUmA6l4BeY2vzmyTBLeP9dD2OAsLI16a7iIwqUpgReJFn1oe4STg/Fpn
	oNo9WKpTdObPLtPFLZgZmOx9hNNHPdJBUVKV52sC1XxuEuf75wa4V9FTe9Hg5/2M36RJ
	3wI0zr20v4urCGtX+zb5paapeJkK3+3b4QOA0Bm5U1hpCYVDe9eGRklwiEz6D4tbX/eV
	/LiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=xHlcFbCxhYi9iCvTQk3dtihDqv4oPK6zIL4Eo7xg9g4=;
	b=HwmnsBQSHTqoUjMUTNfeVKIx7Y6iyy29kluTrL2dvxGlQuHXAHMY9SE3EZDieSUud3
	Oc1ScVL8TcqdF/A/zlUdWUU+ZUjZ8jn9BH93AqaSXsr5xckBrKR8XzDzWPLYhoHFGn6J
	WbSz7bOtJnxCn6F0CLI8cr9mubVyE1a2DGEV7tVT3RLPsLwPoxy/DQDi779PRHihPeDq
	BiAOOdyuG4plhgr77oghe9mJZqI/0wmTZTCAxPoxaLqgcjbg9J4Wziz97lIeIKxTgYVl
	jE+HP/bhLwkXLF+4Qji76yM7b6utjUN6fI+IIwyTX/4O2N+o7T46sQTBZa0b8NRZQYwU
	S+lQ==
X-Gm-Message-State: AMCzsaXeMqtgm4moWQ04Hm5gb96i+K81Xn8tPm7/736HQP+5AjvN0XnP
	+k+bIEGiVLIu8WTvZKdJsgwYYDiJeXiS3AGxYrp8Wg==
X-Google-Smtp-Source: AOwi7QCsih+OYRjG2u3WWE8vCuqfilDf621tuKqO9kHS72r/59hHRUBoo9M8SR4KN3U83YBESpBP0oA0D0pgWKe3OMk=
X-Received: by 10.37.39.68 with SMTP id n65mr8325947ybn.90.1507553346721; Mon,
	09 Oct 2017 05:49:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.163.38 with HTTP; Mon, 9 Oct 2017 05:49:06 -0700 (PDT)
From: Gerson Fernando Budke <nandojve@gmail.com>
Date: Mon, 9 Oct 2017 09:49:06 -0300
Message-ID: <CABOv41NE7a0+ib2f9NchT=9bJVthSZdxjetwnJfoxdNVDk+hVA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Server timeout after codeparser.py: support deeply nested tokens
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
X-List-Received-Date: Mon, 09 Oct 2017 12:49:06 -0000
Content-Type: multipart/alternative; boundary="94eb2c134f8ab61aba055b1c9d32"

--94eb2c134f8ab61aba055b1c9d32
Content-Type: text/plain; charset="UTF-8"

I've been facing the "WARNING: Timeout while attempting to communicate with
bitbake server"
after the patch "codeparser.py: support deeply nested tokens" has been
added in morty branch.
As I'm using cache the problem is recorrent.

I've been suspected that 'self.process_tokens(tokens)' is more time
consuming:

-        for token in tokens:
-            self.process_tokens(token)
+        self.process_tokens(tokens)

So, I fixed the server timeout value, as follow,

From 26e253c9f1d8767cad0ddc2fd556314c726d725d Mon Sep 17 00:00:00 2001
From: Gerson Fernando Budke <gerson.budke@intelbras.com.br>
Date: Mon, 9 Oct 2017 08:25:08 -0300
Subject: [PATCH] process.py: Update timeout from 5 to 30s

As codeparser support deeply nested tokens and this operation is more
time consuming the server timeout should be increased to avoid errors
while attempting to communicate with bitbake server. This increase
the value from 5 to 30 seconds.

Signed-off-by: Gerson Fernando Budke <gerson.budke@intelbras.com.br>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 982fcf7..bcd40bf 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -54,7 +54,7 @@ class ServerCommunicator():
             # don't let the user ctrl-c while we're waiting for a response
             try:
                 for idx in range(0,4): # 0, 1, 2, 3
-                    if self.connection.poll(5):
+                    if self.connection.poll(30):
                         return self.connection.recv()
                     else:
                         bb.warn("Timeout while attempting to communicate
with bitbake server")
-- 
2.7.4

Could this be the final solution?

--94eb2c134f8ab61aba055b1c9d32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I&#39;ve been facing the &quot;WARNING: Timeout =
while attempting to communicate with bitbake server&quot;</div><div>after t=
he patch &quot;codeparser.py: support deeply nested tokens&quot; has been a=
dded in morty branch.</div><div>As I&#39;m using cache the problem is recor=
rent.</div><div><br></div><div>I&#39;ve been suspected that &#39;self.proce=
ss_tokens(tokens)&#39; is more time consuming:</div><div><br></div><div>-=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for token in tokens:</div><div>-=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.process_tokens(token)</div><div>+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 self.process_tokens(tokens)</div><div><br></div><div>S=
o, I fixed the server timeout value, as follow,=C2=A0</div></div><div><br><=
/div><div><div>From 26e253c9f1d8767cad0ddc2fd556314c726d725d Mon Sep 17 00:=
00:00 2001</div><div>From: Gerson Fernando Budke &lt;<a href=3D"mailto:gers=
on.budke@intelbras.com.br">gerson.budke@intelbras.com.br</a>&gt;</div><div>=
Date: Mon, 9 Oct 2017 08:25:08 -0300</div><div>Subject: [PATCH] process.py:=
 Update timeout from 5 to 30s</div><div><br></div><div>As codeparser suppor=
t deeply nested tokens and this operation is more</div><div>time consuming =
the server timeout should be increased to avoid errors</div><div>while atte=
mpting to communicate with bitbake server. This increase</div><div>the valu=
e from 5 to 30 seconds.</div><div><br></div><div>Signed-off-by: Gerson Fern=
ando Budke &lt;<a href=3D"mailto:gerson.budke@intelbras.com.br">gerson.budk=
e@intelbras.com.br</a>&gt;</div><div>---</div><div>=C2=A0lib/bb/server/proc=
ess.py | 2 +-</div><div>=C2=A01 file changed, 1 insertion(+), 1 deletion(-)=
</div><div><br></div><div>diff --git a/lib/bb/server/process.py b/lib/bb/se=
rver/process.py</div><div>index 982fcf7..bcd40bf 100644</div><div>--- a/lib=
/bb/server/process.py</div><div>+++ b/lib/bb/server/process.py</div><div>@@=
 -54,7 +54,7 @@ class ServerCommunicator():</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0# don&#39;t let the user ctrl-c while we&#39;re =
waiting for a response</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0try:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0for idx in range(0,4): # 0, 1, 2, 3</div><div>-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.connection.pol=
l(5):</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if self.connection.poll(30):</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 self.connection.recv()</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.warn(&=
quot;Timeout while attempting to communicate with bitbake server&quot;)</di=
v><div>--=C2=A0</div><div>2.7.4</div></div><div><br></div><div>Could this b=
e the final solution?<br></div></div>

--94eb2c134f8ab61aba055b1c9d32--
