Return-Path: <keshava.gn@gmail.com>
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com
	[209.85.213.54])
	by mail.openembedded.org (Postfix) with ESMTP id 7885D7827F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 04:56:20 +0000 (UTC)
Received: by mail-vk0-f54.google.com with SMTP id w201so8286087vkw.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jan 2018 20:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=nbRE9Gs/DiZ+ucCm/k0N9J7XZU0Fepkmv37X99AzrlE=;
	b=mWgQSM/4WPFupOUgGR4Hba99dIGNz/2nDNAZtwVCJs6/DGRg59D2SyGGRkKWo0BBC3
	J5YLOGX3PkqaHZXF+8xbXV8rmFYLFJW/HRuLK/0uosnGcWzMYRsYa52qYr5CiuHU4ihR
	evSNmic50WmeM1ct8LmUPhkBHiFoLVP7hEGSYWF/hhkvpf9yIyEm3t4GxNtcsBO9bHgg
	4K8NInOka8sn16I87YInQW+XFjbYS56fgcbnOjBRkEBcu4FNgWnfSSbotRFIFA3NTnon
	vOgIgSscehJPCgZ+0LXkIwycnu4K2KPJm4TcAswc0XIBSjzGa9j/TdlqS0eyWgwN6MDP
	/fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=nbRE9Gs/DiZ+ucCm/k0N9J7XZU0Fepkmv37X99AzrlE=;
	b=ooX5/zDZmvi20SoeY/P4wTDY4xYOagn4xNj9QYcM6Ivefwu9UskcCfxQTACcLu1dgN
	ftnK4K7NpKkm9Lp4Dfb4fLrHqimDQM+VyZSNJxkx1S9c6M5FrI5CopTG0P3O8lojTPnq
	f3VtVWGobXBItFTgULCBoDxvD8OBWyfxjEfl3UTwSV50NyYjz/iHLZz5ldmJO5K3Tjdl
	2rusIi7H6/7pZVq9+qthb3fBoaA+uYRJhTaTtcMEk6dJOdRiJNPx0BWI+vSA85qEUD06
	p43hwyo1Nxo+RjBbZfSC7eWg7xNnM75Mf2Dah28/Ycjlgtcya8eb+53HBa/U51Fp7anT
	HjaA==
X-Gm-Message-State: AKwxytfIqe1rTAtOzJFTOj8+aib/fs4zZq3ePJjNGwxaaAteGwZxVFHr
	CkxeON0xU08lezKmii+7q8CXBozeJIC3I9rG1uk=
X-Google-Smtp-Source: AH8x227NKfgzvYMUl+qENhiG2uFIPM6PhR8A32+IVt5iJ/N+Z6ST/s4ulel60Lt9KTnE6Svg+/oLYvzDdAQWv4Z4fO8=
X-Received: by 10.31.157.151 with SMTP id g145mr22931315vke.114.1517374581133; 
	Tue, 30 Jan 2018 20:56:21 -0800 (PST)
MIME-Version: 1.0
From: GN Keshava <keshava.gn@gmail.com>
Message-ID: <CABKwMdtz5kCcgjnB-s7ef4hSkFfm=T=MVK+PdGaZEUUt41o6aw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Mon, 02 Apr 2018 22:22:40 +0000
Subject: PHP in Yocto using Apache2
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
Date: Wed, 31 Jan 2018 04:56:20 -0000
X-Original-Date: Wed, 31 Jan 2018 04:56:10 +0000
X-List-Received-Date: Wed, 31 Jan 2018 04:56:20 -0000
Content-Type: multipart/alternative; boundary="001a11427948e6563d05640b4c3a"

--001a11427948e6563d05640b4c3a
Content-Type: text/plain; charset="UTF-8"

I'm working on Yocto Krogoth for iMX6.

I have successfully added Apache2 and able to access HTML page.

But I want to get and process user input from HTML. From what I understand
I need PHP for this.

But in my Yocto, I'm not able to add PHP. Below is what I tried:

Added these to local.conf:

 PACKAGECONFIG_append_pn-php = " apache2"

 IMAGE_INSTALL_append = " apache2 php php-cli php-modphp"
Tried modifying php.inc according to few answers on net.

There is some accidental bug in Krogoth PHP git code - in php.inc. Tried
using master git code changes from this. Not working. Please suggest any
other changes I need to do.

Tried removing IfDefine PHP5 from php.inc. This makes Apache2 to fail to
load. Seems like there's some dependency. Please suggest.

--001a11427948e6563d05640b4c3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;m working on Yocto Krogoth for iMX6.</div><div>=
<br></div><div>I have successfully added Apache2 and able to access HTML pa=
ge.</div><div><br></div><div>But I want to get and process user input from =
HTML. From what I understand I need PHP for this.</div><div><br></div><div>=
But in my Yocto, I&#39;m not able to add PHP. Below is what I tried:</div><=
div><br></div><div>Added these to local.conf:</div><div><br></div><div>=C2=
=A0PACKAGECONFIG_append_pn-php =3D &quot; apache2&quot;</div><div>=C2=A0</d=
iv><div>=C2=A0IMAGE_INSTALL_append =3D &quot; apache2 php php-cli php-modph=
p&quot;</div><div>Tried modifying php.inc according to few answers on net.<=
/div><div><br></div><div>There is some accidental bug in Krogoth PHP git co=
de - in php.inc. Tried using master git code changes from this. Not working=
. Please suggest any other changes I need to do.</div><div><br></div><div>T=
ried removing IfDefine PHP5 from php.inc. This makes Apache2 to fail to loa=
d. Seems like there&#39;s some dependency. Please suggest.</div></div>

--001a11427948e6563d05640b4c3a--
