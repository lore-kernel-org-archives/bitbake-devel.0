Return-Path: <kergoth@gmail.com>
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com
	[209.85.217.173])
	by mail.openembedded.org (Postfix) with ESMTP id A101D77A2C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Aug 2017 15:01:54 +0000 (UTC)
Received: by mail-ua0-f173.google.com with SMTP id e28so1333508uah.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Aug 2017 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=39LNQR7Aozw5VV+QsRm0tMn1Anp6HXjJooidT2SAYIs=;
	b=bD45gmMjW8NIvYJXU+vmM8rfHTI3mjuVqELlynxqu8KtXfv8FLm32TNzOAfqAXRXXW
	ZVF6tsJ1zjQjHPl2DhmUNveNj0jeb2y3lY6yLdgsxzXMPUHRj51ow8ChgVgkKnEO/yku
	N9VyJttClpz0BhcGv+dABBi8QjnFnl3Zw+0Le13T9O+Qiyl58OBh7IPUIV+s++bCwROI
	v1ABo1sGG8pfT00OT2uxZy5JLmnf0pwFWIcriaimT/zUTa/L5zWNVsAKqhLzl4ayvMty
	ywmyZea1ys5ntq/laGDgdDlx957N19HwFeqnQ3556TRqnrR4S+Gp6qtMKEwQdHvmVQxH
	fApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=39LNQR7Aozw5VV+QsRm0tMn1Anp6HXjJooidT2SAYIs=;
	b=LXxZheRLb6QjqYkv/yVFUxSZZgdA+JXuhxnoPfS9D7alq1dqMmwDFiF4DDSX+fpH1v
	MEFhTOFKIgXoPbfxqCUuOd0TikNQ2iZIjln+mnW3pVNUAFufBjwU/O9DnKsG8jy+L+4v
	eIC8O5RhBBh55VprT34XYgt0SJwWzGf0dVbnck/jxfXtFQcIGdjh2bwYyqZAX1+jtn85
	HEiueDLvEsXzi/0666HOmcJAksYMSCprGMQ0wq4W8Lw+Gk2e/V98oV6JtQPsPnjJWMK1
	jo3hMB+vLrGrcjwTBufntc5JESqfcqlZmslPstCy5PMtlbVee3UmhQooR4Jq0NyVQHDC
	OGUQ==
X-Gm-Message-State: AHYfb5jykD8KmedHop38OEEI9+b+iATGBrQ2+qkW7RM2rhJzzl+4wZfl
	d0XkAgRjoiJm7m/fflFEmJt+IHB02g==
X-Received: by 10.159.60.162 with SMTP id s34mr1727815uai.68.1503500515248;
	Wed, 23 Aug 2017 08:01:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.16.12 with HTTP; Wed, 23 Aug 2017 08:01:34 -0700 (PDT)
In-Reply-To: <1503483750.32591.142.camel@linuxfoundation.org>
References: <20170821163741.28301-2-kergoth@gmail.com>
	<20170821165708.13223-1-kergoth@gmail.com>
	<1503483750.32591.142.camel@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 23 Aug 2017 08:01:34 -0700
Message-ID: <CABcZANmgdB1sgqceeFSLhjboeu8V+ST91qmE8vqiQsH7BeWy7g@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCHv2] fetch2/gitsm: copy submodules from DL_DIR in unpack
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
X-List-Received-Date: Wed, 23 Aug 2017 15:01:54 -0000
Content-Type: multipart/alternative; boundary="f403043641f021e6c505576cfe61"

--f403043641f021e6c505576cfe61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 3:22 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2017-08-21 at 21:57 +0500, Christopher Larson wrote:
> > From: Christopher Larson <chris_larson@mentor.com>
> >
> > Revert "fetch2/gitsm: Fix when repository change submodules"
> >
> > This reverts commit 12f6c0651af8bd5d6efb751690571cf2fcd3eeb0.
>
[=E2=80=A6]

> 2017-08-23 11:20:14,819 - oe-selftest - INFO - Ran 1 test in 33.385s
> 2017-08-23 11:20:14,819 - oe-selftest - INFO - FAILED
> 2017-08-23 11:20:14,819 - oe-selftest - INFO -  (failures=3D1)
> 2017-08-23 11:20:14,824 - oe-selftest - INFO - RESULTS:
> 2017-08-23 11:20:14,824 - oe-selftest - INFO - RESULTS -
> devtool.DevtoolTests.test_devtool_add_fetch_git - Testcase 1161: FAILED
> 2017-08-23 11:20:14,824 - oe-selftest - INFO - SUMMARY:
> 2017-08-23 11:20:14,824 - oe-selftest - INFO - oe-selftest () - Ran 1 tes=
t
> in 33.391s
> 2017-08-23 11:20:14,824 - oe-selftest - INFO - oe-selftest - FAIL -
> Required tests failed
>
> Could you take a look at that test case and see what the issue is please?
>

Will do, thanks, sorry about that. I ran the bitbake selftests, but didn=E2=
=80=99t
think to re-run the oe selftests. *eyeroll*

--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--f403043641f021e6c505576cfe61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Aug 23, 2017 at 3:22 AM, Richard Purdie <span dir=
=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=
=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Mon, 2017-08-21 at 21:57 =
+0500, Christopher Larson wrote:<br>
&gt; From: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor.com=
">chris_larson@mentor.com</a>&gt;<br>
&gt;<br>
&gt; Revert &quot;fetch2/gitsm: Fix when repository change submodules&quot;=
<br>
&gt;<br>
&gt; This reverts commit 12f6c0651af8bd5d6efb751690571c<wbr>f2fcd3eeb0.</di=
v></div></blockquote><div>[=E2=80=A6]=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><div class=3D"HOEnZb"><div class=3D"h5"><span style=3D"color:rgb(34,34=
,34)">2017-08-23 11:20:14,819 - oe-selftest - INFO - Ran 1 test in 33.385s<=
/span><br></div></div>
2017-08-23 11:20:14,819 - oe-selftest - INFO - FAILED<br>
2017-08-23 11:20:14,819 - oe-selftest - INFO -=C2=A0=C2=A0(failures=3D1)<br=
>
2017-08-23 11:20:14,824 - oe-selftest - INFO - RESULTS:<br>
2017-08-23 11:20:14,824 - oe-selftest - INFO - RESULTS - devtool.DevtoolTes=
ts.test_<wbr>devtool_add_fetch_git - Testcase 1161: FAILED<br>
2017-08-23 11:20:14,824 - oe-selftest - INFO - SUMMARY:<br>
2017-08-23 11:20:14,824 - oe-selftest - INFO - oe-selftest () - Ran 1 test =
in 33.391s<br>
2017-08-23 11:20:14,824 - oe-selftest - INFO - oe-selftest - FAIL - Require=
d tests failed<br>
<br>
Could you take a look at that test case and see what the issue is please?<b=
r></blockquote><div><br></div><div>Will do, thanks, sorry about that. I ran=
 the bitbake selftests, but didn=E2=80=99t think to re-run the oe selftests=
. *eyeroll*=C2=A0</div></div><br>-- <br><div class=3D"gmail_signature" data=
-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Chris=
topher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedde=
d, OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div=
></div>
</div></div>

--f403043641f021e6c505576cfe61--
