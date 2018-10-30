Return-Path: <madhu1313b@gmail.com>
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
	[209.85.222.181])
	by mail.openembedded.org (Postfix) with ESMTP id D4BF2605BA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Oct 2018 06:02:30 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id f18-v6so6530485qkm.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Oct 2018 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=U2C6qrRfDSeW/T1B6eMaNt5x03siTcW4TOGTI3kiBKg=;
	b=ncedNHtptE3ucB85qIspoyJHe+FBpt4i5l4GiaNTb5GohEwMV713BsIuV9I/dtacTZ
	RW8XTwHQormqc1C+DjVXSoGJpJfhbb8zxgNiQXXhVDzAzaUZ7oUxR3BpiEVpNcHJIlPA
	I0K2/j6e4j437Sq0NdJy7Z0f566WRuwa4O+ge+h3Lgk2kHnId6n2fFSFAOC3fjuHAC+n
	Cz9Mh2e6wI/AqsEqt0FWIZMB+JQqw7zcutpyrx8bSUN6jpsvv11E5B85JdfS9JwtKlBe
	orVwJhqshETc3KYUAEvNR7ciCz3qWNMP6TXSP7MQDjcH3s1X1HI8F+yp6gWfHi5aLTtd
	P3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=U2C6qrRfDSeW/T1B6eMaNt5x03siTcW4TOGTI3kiBKg=;
	b=p0V/8TdYhhcjuW9N1hm2PF0Dpxl4As85wszc9m29fV9ND0o0zbvPCIhT8P5t/jZz2G
	shFvo4epqG4yEBXlmnHSdwyhuGlOzQxmgb4K8pamN7uwUgFEauSYQ6inXFpf/McyQ34x
	OChZzN/JsKHRXIn7SWdcc0n4+99rRcyJKCoYOaEPxFBWIpFtIgLGxP7P0XYSIZAJT+Cq
	XIZFyhhPC/HC0ntJ1ptCNRUzOlz+zXCHYUssXJMRFrNg2GyTq3lq6FieSWl4/jFHJuJE
	wJ+7FEf2tvQ+BZJhuTZZ8nEn3qHkHlQbjW8p7xxk+YIiVmX4WRyMXm+gv9HIr810bdI6
	3RBQ==
X-Gm-Message-State: AGRZ1gIbETG6p6VH4dWE9vCU9uCeUEeyhmoX0YBrOC/eS7XHZnZtoOm6
	FzMez+tthWy2hDpN0YZtOAiFz42Bv5+FP74mdizt4w==
X-Google-Smtp-Source: AJdET5dKNby4T/H+QtgljzweCFvl78haV8UtO4pJ61bUxdeJuP/eVLT6VGb0t5X0Iqho7Q2YxEjd8uZzOzkVyM38jxI=
X-Received: by 2002:a37:a614:: with SMTP id p20mr14501636qke.266.1540879351568;
	Mon, 29 Oct 2018 23:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAH5YvUu49bAofSQRq+tS66MjbmOWFRoE5uYqMDqQY3NO78gnOg@mail.gmail.com>
In-Reply-To: <CAH5YvUu49bAofSQRq+tS66MjbmOWFRoE5uYqMDqQY3NO78gnOg@mail.gmail.com>
From: Madhu B <madhu1313b@gmail.com>
Date: Tue, 30 Oct 2018 11:32:19 +0530
Message-ID: <CAH5YvUv8QvB9ymLVU7Lp8C3xxgOyijpMZ8xbKgA+FkYm6cG=nw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Tue, 30 Oct 2018 13:59:13 +0000
Subject: Re: How to add an image file to a meta layer using bbappend file
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
X-List-Received-Date: Tue, 30 Oct 2018 06:02:31 -0000
Content-Type: multipart/alternative; boundary="000000000000645cea05796bee5a"

--000000000000645cea05796bee5a
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 30, 2018 at 11:19 AM Madhu B <madhu1313b@gmail.com> wrote:

> Hi all,
>          I want know, how to copy an image file to a meta layer's source
> code using *.bbappend file(Without git commit). Is there any way to do that?
>
> Regards,
> -Madhu.
>

--000000000000645cea05796bee5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Tue, Oct 30, 2018 at 11:19 AM Madhu B &lt;<a href=3D"mailto:madhu1313b@g=
mail.com">madhu1313b@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div dir=3D"ltr"><div>Hi all,</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 I want know, how to copy an image file to a meta l=
ayer&#39;s source code using *.bbappend file(Without git commit). Is there =
any way to do that?</div><div><br></div><div>Regards,</div><div>-Madhu.<br>=
</div></div>
</blockquote></div>

--000000000000645cea05796bee5a--
