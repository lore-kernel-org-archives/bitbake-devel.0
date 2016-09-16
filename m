Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
	[209.85.218.66])
	by mail.openembedded.org (Postfix) with ESMTP id E504F731D3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 20:01:52 +0000 (UTC)
Received: by mail-oi0-f66.google.com with SMTP id w11so7644187oia.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=CUIaQC2kqEWE8fkniBv7KeGXK/xswbDWqCi4b/0fQ8Y=;
	b=uc4PDHFQwMBgQq7qqBc5sJxrl+fq2uTZjTZwdxSskejUn5Fhs62gF2LiXTe3BSsPY7
	uzLeAkQQBIYzx9iZkVqoUjn+3zQncZUyxricLzqtrqUkvSBXH5QUnQdlmrUXE4LSpMS+
	arQMFxhUn3W8HxL15uoRJtYwjIywdAXmN8uR5NT5yGTD88bbOq47Cm9GpKLp24fZltn2
	T/obS9vfSuG7Y1BKbOTgA3+wtLmQgf3SlDItWjfMEvcRTEGatIkM4WMkbC0gHRdLq9k/
	7zQ/hXzWI66JX3lRhJPcQpZ1DdfVfBngyudA7r9NVyKSpkbMSiEI5RyqiCF2n3IINLjo
	DFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=CUIaQC2kqEWE8fkniBv7KeGXK/xswbDWqCi4b/0fQ8Y=;
	b=GB5d4bwyg1mvAnPoimC9QZHevvLCBht/RGt5zPYERapidT32PLkeYaxczxELJNOpTB
	Xa9V8V/GoXb1UIi1Sd3dPIvbkPZfqozIihiZup/2RtFH+LA1PQXMB9H3uzf9SZfnHQPd
	HLB5lQf0tyG9EKdHcXF373BWnzjQZEIWtDsWGL6Brx+HQt9GlYg3Mtg1XdRdCJHmd6p0
	MTYSIz6vnWErngpF/A40w28FSIDESsjzBulzwvmHzpFOIZAoPrRoURi+57/87VnXgEOy
	hY8iAGzP6baX34lC3TsjaSWC5kYg7AzWn5kQVGVVl9E5xXaWms4aeacZnvLkBOA065BN
	NbEg==
X-Gm-Message-State: AE9vXwPzYcp8eEnvbZgrbYM5pdWEPg2NwU0fIDzGN4BWHTwRMZIKCZ83ENtsy7sXqXGNj/oz7bOKyluaRO3iag==
X-Received: by 10.202.91.85 with SMTP id p82mr8218426oib.99.1474056113191;
	Fri, 16 Sep 2016 13:01:53 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Fri, 16 Sep 2016 13:01:32 -0700 (PDT)
In-Reply-To: <1474056041-11200-1-git-send-email-kergoth@gmail.com>
References: <1474056041-11200-1-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Fri, 16 Sep 2016 13:01:32 -0700
X-Google-Sender-Auth: fVfNAmMwuwBM6nfGZQYb_GQi46g
Message-ID: <CABcZANkJmsD1OfPDu0B1nnLBxH+U8S5O2h5pzXDSij3gdG3aoA@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH] bb.build: in _exec_task, catch errors from TaskStarted
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
X-List-Received-Date: Fri, 16 Sep 2016 20:01:54 -0000
Content-Type: multipart/alternative; boundary=001a113d5d4a0181ce053ca56fef

--001a113d5d4a0181ce053ca56fef
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2016 at 1:00 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> We want any exceptions raised by the TaskStarted event handlers to be
> caught
> rather than unconditionally hitting the exception formatting + traceback =
in
> exec_task, otherwise we can't cleanly exit the task with a nice message
> from
> such a handler.
>
> This is done via a separate try/catch block, to avoid firing TaskFailed i=
f
> all
> the TaskStarted event handlers didn't complete, otherwise the bitbake UIs
> get
> unhappy.
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>

This supercedes 'bb.build: in _exec_task, catch BBHandledException=E2=80=99=
.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113d5d4a0181ce053ca56fef
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Sep 16, 2016 at 1:00 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div id=3D"gmail-:m1" class=3D"gmail=
-a3s gmail-aXjCH gmail-m15734963f9bcb450">From: Christopher Larson &lt;<a h=
ref=3D"mailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
We want any exceptions raised by the TaskStarted event handlers to be caugh=
t<br>
rather than unconditionally hitting the exception formatting + traceback in=
<br>
exec_task, otherwise we can&#39;t cleanly exit the task with a nice message=
 from<br>
such a handler.<br>
<br>
This is done via a separate try/catch block, to avoid firing TaskFailed if =
all<br>
the TaskStarted event handlers didn&#39;t complete, otherwise the bitbake U=
Is get<br>
unhappy.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;</div></blockquote></div><br>This supe=
rcedes &#39;bb.build: in _exec_task, catch BBHandledException=E2=80=99.<br>=
-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Christopher Larson<b=
r>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<b=
r>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div></di=
v>
</div></div>

--001a113d5d4a0181ce053ca56fef--
