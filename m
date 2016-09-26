Return-Path: <sdishu20@gmail.com>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
	[209.85.218.52])
	by mail.openembedded.org (Postfix) with ESMTP id B263860079
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 04:05:29 +0000 (UTC)
Received: by mail-oi0-f52.google.com with SMTP id t83so194263309oie.3
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Sep 2016 21:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to;
	bh=wgPzE9zH11ECibBqWooqnlKaO5FfVzIL4fobClVsK+Q=;
	b=J18qBsWD/YnVgmDQAO9dr4nvIDHqsiv6gGHvMqH0oK9z6+/mmNGMmLF+qo50jAF28Q
	byvf0LO2Pr1JUIgubH01VtIsZFfnLiN5IeIro0jisqhndvxlgs1dSBImToMSQW4Qv9+N
	GT+vSMhAKaHfud+AJPfRl0nqR6mdgwPZGVqjvCe93oep1b4obiY0hOzD1Ik5WuKgeahN
	XLB1JsMJe1s0qXqULs7dUGlxrdYQhpygTVNoYfSYDp+jwv5DOTsigYxfVLHk1/OaoJmd
	HSvhmNjdw+eXuzojdvECy+TYjDyf0CR6uK4YUEffWpNu6U4/y752NftzImp0k8eaAjkw
	Axgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=wgPzE9zH11ECibBqWooqnlKaO5FfVzIL4fobClVsK+Q=;
	b=gRedMryV2U00VwG/2FB6RX8KL1DClz4yYo1w4EBQo5xZNkbDMbAKyJ501R/9+xtqwQ
	jPse0jxSy0CrukEfTgAvVsF+Q5dd5zji0plWoVTO6jYEQ56XdNMulHkZmoiCYhUTF5W1
	0c9cN5g8U7wJ70C1dofGlGhwXJboSER5w3fDPtWRDpbNeSuqa8EJmpdCIy/3AwCY+ZCx
	4Ek6ZBRG8nzHXe/kDI0EAbV9FvdVd4ANzucWzrdIX5SDyjof6NKBzK+w6f0vM7gGwdTP
	RRzvzWYT1nlnL2v6eWuecLIGrM4Fs/hMgU7o7hMzcQprjVCUKcWdmYMsfn23GCGBe7Ua
	k1YQ==
X-Gm-Message-State: AE9vXwO+gypU5hKtZlOzm8349i79s+QwoCGEJoYtcCayFQPJ/rrVXL0SX+jvsM0gZRDDFHBc686fCg/0zB11Jg==
X-Received: by 10.202.94.86 with SMTP id s83mr24568173oib.18.1474862730508;
	Sun, 25 Sep 2016 21:05:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.80.229 with HTTP; Sun, 25 Sep 2016 21:05:30 -0700 (PDT)
From: Dishu Sharma <sdishu20@gmail.com>
Date: Mon, 26 Sep 2016 09:35:30 +0530
Message-ID: <CAPPN1iEXQ7w__pFUeOhX1Hzunc6hJXmDNLQChfboeV3F+kxMEg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Tue, 27 Sep 2016 07:54:57 +0000
Subject: do_configure failure in dbus recipe
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
X-List-Received-Date: Mon, 26 Sep 2016 04:05:31 -0000
Content-Type: multipart/alternative; boundary=001a113d514424fe60053d613d60

--001a113d514424fe60053d613d60
Content-Type: text/plain; charset=UTF-8

Hello Sir,

I'm working on yocto and I m getting do_configure failure in dbus_1.8.10.bb
 .
Could you please help me in debugging the error.

Thankyou,
Priyanshu Sharma

--001a113d514424fe60053d613d60
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">Hello Sir,</span><div sty=
le=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8px">I&#39;m w=
orking on yocto and I m getting do_configure failure in=C2=A0<a href=3D"htt=
p://dbus_1.8.10.bb/" target=3D"_blank">dbus_1.8.10.bb</a>=C2=A0.<br>Could y=
ou please help me in debugging the error.</div><div style=3D"font-size:12.8=
px"><br></div><div style=3D"font-size:12.8px">Thankyou,</div><div style=3D"=
font-size:12.8px">Priyanshu Sharma</div></div>

--001a113d514424fe60053d613d60--
