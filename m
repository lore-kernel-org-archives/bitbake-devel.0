Return-Path: <ross.burton@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id B1EEE6FFCE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Oct 2016 15:23:59 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id r30so54138688ioi.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Oct 2016 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=dxnXMfExU0xv/3bmLCBNcoOX3rQO9wUWxWijoYdUelg=;
	b=mN4Q+LtnlMEiDp0dW7e74O5etg21U3vKh+82MhzG6xuThKqDFxJ7LUJIhHec8zhTHn
	qp4khBAC01yY9eE/pr9AIcYgn6LjkLI86WdsjfCuidZzo2bDApwXtTNZRJiYwWFJjBJ7
	HfPhg8lilNVkiSSwmt9skXOSC7q17e0TtmQw3SXX+toz16q7XCDnsXyso9qduep5+y7G
	18s6kE4mzO0FwtRbBWB4DeDCHQOibnkZ9gpANGT7UcHVkF09FW1o3Ddz3q4TGf4xPDdE
	seuyXRY2cWgx8mNgYS8BA3kS/yeQUqLEvFeFa2uHGdjDf20SVJM6XHs10vhQl9eaVhqA
	+VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=dxnXMfExU0xv/3bmLCBNcoOX3rQO9wUWxWijoYdUelg=;
	b=Xh2xd83txbvKvOnki+KTX2xK6y+wl995wmSTICjtQfEUgBUGePdyoYFR0w8d5ckvc0
	XSFQBo0hU/HXRtYJwjmWA1fLx1MxbipAkaxRc8JV5PjuvTS71q+nTzhorkoBLGm1K0lK
	8zzGnrqBJSvEi9rHm/ts2h5XuW9cqAkzBEKSWXZRQr73WK6ZXZL4Cp+SQze0o/BR9voI
	PfwAduvnKR1/eA+KNyE9Fx2KrKNJH++0dd46RfLtK0RFyOei2hrkpLYxfa2rnfagSMUu
	kCzM026eaKsdusO29PZ/YxziLLPULKBcvColGKq8ZUNhTmUmCyCVha4DYb/8nKQDgRNm
	7sFQ==
X-Gm-Message-State: AA6/9RmBGiTZnnISwZ1HVNR1F1OM4LUJFmdgRUO7MjodIBdh4LBfhiRqsOUb/PBxV3i22h+DgUpixpNRlWYO1a+m
X-Received: by 10.107.17.32 with SMTP id z32mr1995344ioi.1.1476285840843; Wed,
	12 Oct 2016 08:24:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.155.66 with HTTP; Wed, 12 Oct 2016 08:23:40 -0700 (PDT)
In-Reply-To: <CABh+foZtU_KQ0+2WUC0J=oef-EcbKHH60Fc+yDqGtW79Jc7tBQ@mail.gmail.com>
References: <CABh+foZtU_KQ0+2WUC0J=oef-EcbKHH60Fc+yDqGtW79Jc7tBQ@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 12 Oct 2016 16:23:40 +0100
Message-ID: <CAJTo0Lb2Wh9Godxx2tDOGxbpm3OjMzdnvmv_=Rt2N7z0vvqN2w@mail.gmail.com>
To: nitish jha <nitishjha16@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: changing content of configuration parameters of Cmakelist file from .bb file
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
X-List-Received-Date: Wed, 12 Oct 2016 15:24:01 -0000
Content-Type: multipart/alternative; boundary=001a113f2676217daf053eac9537

--001a113f2676217daf053eac9537
Content-Type: text/plain; charset=UTF-8

On 12 October 2016 at 12:33, nitish jha <nitishjha16@gmail.com> wrote:

> do_configure_append() {
>     cmake -INSTALL_LIB_DIR=/usr/lib64
> }
>

http://www.yoctoproject.org/docs/2.1/ref-manual/ref-manual.html#ref-classes-cmake
covers this.

Use EXTRA_OECMAKE to pass your extra options to cmake, i.e.

EXTRA_OECMAKE = "-DINSTALL_LIB_DIR=${libdir}"

Ross

--001a113f2676217daf053eac9537
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 12 October 2016 at 12:33, nitish jha <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:nitishjha16@gmail.com" target=3D"_blank">nitishjha16@gmail.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-=
left-style:solid;padding-left:1ex"><div>do_configure_append() {
<br>=C2=A0=C2=A0=C2=A0 cmake -INSTALL_LIB_DIR=3D/usr/lib64
<br>}
</div></blockquote></div><br></div><div class=3D"gmail_extra"><a href=3D"ht=
tp://www.yoctoproject.org/docs/2.1/ref-manual/ref-manual.html#ref-classes-c=
make">http://www.yoctoproject.org/docs/2.1/ref-manual/ref-manual.html#ref-c=
lasses-cmake</a> covers this.</div><div class=3D"gmail_extra"><br></div><di=
v class=3D"gmail_extra">Use EXTRA_OECMAKE to pass your extra options to cma=
ke, i.e.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extr=
a">EXTRA_OECMAKE =3D &quot;-DINSTALL_LIB_DIR=3D${libdir}&quot;</div><div cl=
ass=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross</div></div>

--001a113f2676217daf053eac9537--
