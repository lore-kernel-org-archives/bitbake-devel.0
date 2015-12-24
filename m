Return-Path: <just4tech83@gmail.com>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
	[209.85.218.49])
	by mail.openembedded.org (Postfix) with ESMTP id AF2C56FF7F;
	Thu, 24 Dec 2015 08:10:28 +0000 (UTC)
Received: by mail-oi0-f49.google.com with SMTP id l9so107066195oia.2;
	Thu, 24 Dec 2015 00:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=FTZZ0rhjoD1+ZvOD2hupLe7UKJQyGiIL0BhzeFMfLd0=;
	b=A1KzVL3wKV0LFU+VWZbVQDkxPQlMYkKdnON7uVkPn8vwm0qoAjZy7JIraCVy9D+lLH
	HASU609Jry1fwvbdUoyIXoAurJoieyQ9yx5fH+D+coJN4Net8aGVejHs80xAu0CY9ZvZ
	XOeqb4fTTboR5qFwhc3i00jkj6Gunw34dS9cxZsyL87gbh6kSHIoO/USRA16dJ8nf6YD
	yHSqhcjIKdfvhT673yK33v4nxW7p8jqg8xbkkBmWAhoyYVo9MxTQoB694xQBYSG7IrUH
	3EuHZE3QyQJ2HIMHmod7IvGUeZBiQ0wz2+yaXau3LtoMgV0RxzT0liC2ZEqU8sJXUZ09
	N5Fw==
MIME-Version: 1.0
X-Received: by 10.202.79.5 with SMTP id d5mr13342441oib.121.1450944628710;
	Thu, 24 Dec 2015 00:10:28 -0800 (PST)
Received: by 10.202.71.10 with HTTP; Thu, 24 Dec 2015 00:10:28 -0800 (PST)
Received: by 10.202.71.10 with HTTP; Thu, 24 Dec 2015 00:10:28 -0800 (PST)
In-Reply-To: <CAD2C2VSOXLTPM-yu6JFajf0LMHoE1t3utWG0vLFUzERcZs+7HA@mail.gmail.com>
References: <CAD2C2VSOXLTPM-yu6JFajf0LMHoE1t3utWG0vLFUzERcZs+7HA@mail.gmail.com>
Date: Thu, 24 Dec 2015 13:40:28 +0530
Message-ID: <CAD2C2VTmyKj=T_F-DHrxNzW4d4gEDJ3=EaZFtQnF4m0in6C2Yg@mail.gmail.com>
From: Bryan <just4tech83@gmail.com>
To: openembedded-core@lists.openembedded.org
Cc: bitbake-devel@lists.openembedded.org, poky@yoctoproject.org,
	linux-yocto@yoctoproject.org, openembedded-devel@lists.openembedded.org
Subject: Re: korean/chinese keyboard layout support on yocto
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
X-List-Received-Date: Thu, 24 Dec 2015 08:10:29 -0000
Content-Type: multipart/alternative; boundary=001a113d70a02ee3db0527a05f81

--001a113d70a02ee3db0527a05f81
Content-Type: text/plain; charset=UTF-8

On Dec 18, 2015 1:03 PM, "Bryan" <just4tech83@gmail.com> wrote:
>
> Hi,
>     I am working on yocto poky-dizzy 1.7.1 and have developed some
application on top of customized os image. I have a reqirement to support
korean/chinese keyboard layout for application.
> I have added cross complied libraries for  ibus-hangul pckages. Can
somebody suggest me how can i add support for keyboart layout and how to
enable automatically.
>
> Is there any bitbake recipe available to support these keyboard layout.
>
>
> regards
> Bryan

--001a113d70a02ee3db0527a05f81
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Dec 18, 2015 1:03 PM, &quot;Bryan&quot; &lt;<a href=3D"mailto:just4tech8=
3@gmail.com">just4tech83@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi, <br>
&gt; =C2=A0=C2=A0=C2=A0 I am working on yocto poky-dizzy 1.7.1 and have dev=
eloped some application on top of customized os image. I have a reqirement =
to support korean/chinese keyboard layout for application. <br>
&gt; I have added cross complied libraries for=C2=A0 ibus-hangul pckages. C=
an somebody suggest me how can i add support for keyboart layout and how to=
 enable automatically.<br>
&gt;<br>
&gt; Is there any bitbake recipe available to support these keyboard layout=
.<br>
&gt;<br>
&gt;<br>
&gt; regards<br>
&gt; Bryan</p>

--001a113d70a02ee3db0527a05f81--
