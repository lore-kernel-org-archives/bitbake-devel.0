Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F56C4706C
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 22:08:43 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web10.30603.1704838113317065320
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 14:08:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jn9cEIF1;
 spf=pass (domain: gmail.com, ip: 209.85.210.177, mailfrom: kergoth@gmail.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6db05618c1fso1594855b3a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 14:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704838113; x=1705442913; darn=lists.openembedded.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O5qxueeosmTe+uDxirHZzkPTXedkygvX6NjJ5CDGReM=;
        b=jn9cEIF1d15zLLIQTRkn0uEZgmUA4g4X/S6XLOKJCOzAEtVAPknjC6/ag7wTBuZr2X
         eSE4dNan5ituHOtthCQQPfRAuxlM4lE5HlbCbi4WfZ/CkQTdX68lx+xxn39ChyX0rQzd
         1xwrwM+HJ4IlHvi+/wRJiyKhVlkiX52rokstnUq35eG+muEbf39YT9tEPVW/gUuJy5rL
         bEgZPmOkU5oc1RvGD78FnktGo9M7VekCskwNrTR+NRZMSIdZ9UYUaR6BIKjjZ1TjMoJm
         2HVDwXO9+paKau6N3QRZvMHSJGlwLQjt10d4gzseX1Lp1F1g/2wl28UxGsypt9vaqeM9
         Vj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704838113; x=1705442913;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5qxueeosmTe+uDxirHZzkPTXedkygvX6NjJ5CDGReM=;
        b=NzlZzyCkJEVh1zUY2qpplpMwVK4cPk6u0D+As1kIB+OG7ih/W8mIEamLSGtfyVS1co
         MkQmYsJXXsnF2x/jRsagbrRoEDtYZM9Xkt3fxk42wxBlwPpNoi82CMZGEPY92A9IKyk3
         GOP8Li5bQs0APYJDJSQlmDmZhgE9FdrPe9GU9LxbtkhEffVv5r3KYJIpZvB7nnpHK1cI
         8Gr4gE4gOS64YmT91izE14Z1Akb1l6diBGBny3JQYNMghhK0ycflzZ8X2oPsRkj0ymuw
         7aVoDMwZQeq67Z83onpu+ojrE3FijIcphsX874KQGx22hvAjXOOIxZQSmsa3GAj9nW9k
         6VFg==
X-Gm-Message-State: AOJu0YwdoDy42B5BDvyigcaIdjXKwE7Mb6uEMB5B/1+RRgVzff2VSOP8
	mLX1R1xmZoSLD+PK3CUuvNY=
X-Google-Smtp-Source: AGHT+IHm2EeYLgkIJTn4A9mr0w0+qdXoHzBAKUXQTo9MvX31YGZ0ZIyBCzRRbckp8j9Hiy72clymlg==
X-Received: by 2002:a05:6a00:23d5:b0:6d9:bf35:768f with SMTP id g21-20020a056a0023d500b006d9bf35768fmr157383pfc.46.1704838112636;
        Tue, 09 Jan 2024 14:08:32 -0800 (PST)
Received: from smtpclient.apple ([2600:8800:6cc0:300::100b])
        by smtp.gmail.com with ESMTPSA id fa38-20020a056a002d2600b006d0a29ad0aasm2130591pfb.5.2024.01.09.14.08.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2024 14:08:31 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
Message-Id: <53989CDF-1F8C-4FD7-B2D7-45FD5629903A@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_CF8F5A96-1E88-48B2-8BE3-1983789F94B7"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [bitbake-devel] [PATCH v4 2/2] bitbake: tests/event: Add
 test_lineno_in_eventhandler
Date: Tue, 9 Jan 2024 15:08:20 -0700
In-Reply-To: <4034b4a24d9ac56b13163ba2decff83a5f41be7f.1704786173.git.liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
To: liezhi.yang@windriver.com
References: <cover.1704786173.git.liezhi.yang@windriver.com>
 <4034b4a24d9ac56b13163ba2decff83a5f41be7f.1704786173.git.liezhi.yang@windriver.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 22:08:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15775


--Apple-Mail=_CF8F5A96-1E88-48B2-8BE3-1983789F94B7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

This does look like a good idea, though I wonder if injecting newlines =
is truly the best approach. SyntaxError is a bit of a special case, =
since it occurs before we have the ast to adjust the lineno, but it can =
be corrected without string manipulation if you catch and re-raise =
SyntaxError. Ex:

def _syntaxerror_offset(value, lineoffset):
    """Adjust the line number in a SyntaxError exception"""
    if lineoffset:
        msg, (efname, elineno, eoffset, badline) =3D value.args
        value.args =3D (msg, (efname, elineno + lineoffset, eoffset, =
badline))
        value.lineno =3D elineno + lineoffset

=E2=80=94=20
Christopher Larson
chris_larson@mentor.com, chris.larson@siemens.com, kergoth@gmail.com
Principal Software Engineer, Embedded Linux Solutions, Siemens Digital =
Industries Software

> On Jan 9, 2024, at 12:45=E2=80=AFAM, Robert Yang via =
lists.openembedded.org =
<liezhi.yang=3Dwindriver.com@lists.openembedded.org> wrote:
>=20
> From: Robert Yang <liezhi.yang@windriver.com>
>=20
> Add test_lineno_in_eventhandler to test lineno in eventhandler.
>=20
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
> bitbake/lib/bb/tests/event.py | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)
>=20
> diff --git a/bitbake/lib/bb/tests/event.py =
b/bitbake/lib/bb/tests/event.py
> index d959f2d95db..ef61891d302 100644
> --- a/bitbake/lib/bb/tests/event.py
> +++ b/bitbake/lib/bb/tests/event.py
> @@ -13,6 +13,7 @@ import pickle
> import threading
> import time
> import unittest
> +import tempfile
> from unittest.mock import Mock
> from unittest.mock import call
>=20
> @@ -468,6 +469,8 @@ class EventClassesTest(unittest.TestCase):
>=20
>     def setUp(self):
>         bb.event.worker_pid =3D EventClassesTest._worker_pid
> +        self.d =3D bb.data.init()
> +        bb.parse.siggen =3D bb.siggen.init(self.d)
>=20
>     def test_Event(self):
>         """ Test the Event base class """
> @@ -950,3 +953,24 @@ class EventClassesTest(unittest.TestCase):
>         event =3D bb.event.FindSigInfoResult(result)
>         self.assertEqual(event.result, result)
>         self.assertEqual(event.pid, EventClassesTest._worker_pid)
> +
> +    def test_lineno_in_eventhandler(self):
> +        # The error lineno is 5, not 4 since the first line is '\n'
> +        error_line =3D """
> +# Comment line1
> +# Comment line2
> +python test_lineno_in_eventhandler() {
> +    This is an error line
> +}
> +addhandler test_lineno_in_eventhandler
> +test_lineno_in_eventhandler[eventmask] =3D "bb.event.ConfigParsed"
> +"""
> +
> +        with self.assertLogs() as logs:
> +            f =3D tempfile.NamedTemporaryFile(suffix =3D '.bb')
> +            f.write(bytes(error_line, "utf-8"))
> +            f.flush()
> +            d =3D bb.parse.handle(f.name, self.d)['']
> +
> +        output =3D "".join(logs.output)
> +        self.assertTrue(" line 5\n" in output)
> --=20
> 2.35.5
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15756): =
https://lists.openembedded.org/g/bitbake-devel/message/15756
> Mute This Topic: https://lists.openembedded.org/mt/103616263/3617123
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub =
[kergoth@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


--Apple-Mail=_CF8F5A96-1E88-48B2-8BE3-1983789F94B7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;">This does look =
like a good idea, though I wonder if injecting newlines is truly the =
best approach. SyntaxError is a bit of a special case, since it occurs =
before we have the ast to adjust the lineno, but it can be corrected =
without string manipulation if you catch and re-raise SyntaxError. =
Ex:<div><br></div><div><div>def _syntaxerror_offset(value, =
lineoffset):</div><div>&nbsp; &nbsp; """Adjust the line number in a =
SyntaxError exception"""</div><div>&nbsp; &nbsp; if =
lineoffset:</div><div>&nbsp; &nbsp; &nbsp; &nbsp; msg, (efname, elineno, =
eoffset, badline) =3D value.args</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
value.args =3D (msg, (efname, elineno + lineoffset, eoffset, =
badline))</div><div>&nbsp; &nbsp; &nbsp; &nbsp; value.lineno =3D elineno =
+ lineoffset</div><div><br></div><div>=E2=80=94&nbsp;</div><div>
<meta charset=3D"UTF-8"><div>Christopher =
Larson<br>chris_larson@mentor.com,&nbsp;chris.larson@siemens.com,&nbsp;ker=
goth@gmail.com<br>Principal Software Engineer,&nbsp;Embedded Linux =
Solutions,&nbsp;Siemens&nbsp;Digital Industries Software</div>
</div>
<div><br><blockquote type=3D"cite"><div>On Jan 9, 2024, at 12:45=E2=80=AFA=
M, Robert Yang via lists.openembedded.org =
&lt;liezhi.yang=3Dwindriver.com@lists.openembedded.org&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div><div>From: =
Robert Yang &lt;liezhi.yang@windriver.com&gt;<br><br>Add =
test_lineno_in_eventhandler to test lineno in =
eventhandler.<br><br>Signed-off-by: Robert Yang =
&lt;liezhi.yang@windriver.com&gt;<br>---<br> =
bitbake/lib/bb/tests/event.py | 24 ++++++++++++++++++++++++<br> 1 file =
changed, 24 insertions(+)<br><br>diff --git =
a/bitbake/lib/bb/tests/event.py b/bitbake/lib/bb/tests/event.py<br>index =
d959f2d95db..ef61891d302 100644<br>--- =
a/bitbake/lib/bb/tests/event.py<br>+++ =
b/bitbake/lib/bb/tests/event.py<br>@@ -13,6 +13,7 @@ import pickle<br> =
import threading<br> import time<br> import unittest<br>+import =
tempfile<br> from unittest.mock import Mock<br> from unittest.mock =
import call<br><br>@@ -468,6 +469,8 @@ class =
EventClassesTest(unittest.TestCase):<br><br> &nbsp;&nbsp;&nbsp;&nbsp;def =
setUp(self):<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bb.event.worker_pid =3D =
EventClassesTest._worker_pid<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;self.d =3D bb.data.init()<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bb.parse.siggen =3D =
bb.siggen.init(self.d)<br><br> &nbsp;&nbsp;&nbsp;&nbsp;def =
test_Event(self):<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;""" Test the Event base =
class """<br>@@ -950,3 +953,24 @@ class =
EventClassesTest(unittest.TestCase):<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;event =3D =
bb.event.FindSigInfoResult(result)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;self.assertEqual(event.res=
ult, result)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;self.assertEqual(event.pid=
, EventClassesTest._worker_pid)<br>+<br>+ &nbsp;&nbsp;&nbsp;def =
test_lineno_in_eventhandler(self):<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# The error lineno is 5, not 4 =
since the first line is '\n'<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_line =3D """<br>+# =
Comment line1<br>+# Comment line2<br>+python =
test_lineno_in_eventhandler() {<br>+ &nbsp;&nbsp;&nbsp;This is an error =
line<br>+}<br>+addhandler =
test_lineno_in_eventhandler<br>+test_lineno_in_eventhandler[eventmask] =3D=
 "bb.event.ConfigParsed"<br>+"""<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;with self.assertLogs() as =
logs:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;f =3D =
tempfile.NamedTemporaryFile(suffix =3D '.bb')<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;f.write(=
bytes(error_line, "utf-8"))<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;f.flush(=
)<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d =3D =
bb.parse.handle(f.name, self.d)['']<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;output =3D =
"".join(logs.output)<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;self.assertTrue(" line 5\n" in =
output)<br>-- <br>2.35.5<br><br><br>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-<br>Links: You receive all messages sent to this =
group.<br>View/Reply Online (#15756): =
https://lists.openembedded.org/g/bitbake-devel/message/15756<br>Mute =
This Topic: https://lists.openembedded.org/mt/103616263/3617123<br>Group =
Owner: bitbake-devel+owner@lists.openembedded.org<br>Unsubscribe: =
https://lists.openembedded.org/g/bitbake-devel/unsub =
[kergoth@gmail.com]<br>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br><b=
r></div></div></blockquote></div><br></div></body></html>=

--Apple-Mail=_CF8F5A96-1E88-48B2-8BE3-1983789F94B7--

