Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mx.groups.io with SMTP id smtpd.web09.1898.1613617673947860227
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Feb 2021 19:07:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qq.com header.s=s201512 header.b=DLQMvPVY;
 spf=pass (domain: qq.com, ip: 52.59.177.22, mailfrom: ideamark@qq.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1613617668; bh=D/rSS/eaTYXz9fz2BUdxuboivkEEsGMUDM2fo3rvxAM=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=DLQMvPVYXzBL3QHbMlLWM0x7TPDdffiaerPbD5iCvTlx36j4l+SHHNYvbfQ0O2TAu
	 V3MzbhVbLZeXtgA45OhGX1MsvcwbIu5f9gVER6duSsEZEafsembXzcpZ06b6UpKe9f
	 J/4Rb0r3tIGsCtlsY+ajriGjUoLmJmnPeJT2YjVk=
X-QQ-FEAT: YuwbzFVdD1jUdotILI7UMbjEXHGobE/uj8nCoO7ejEidQSxQsKO7c4WqNGdSE
	ZJ8ZjSeoQ/S8X+Oj07Ez6XsNrTbZuEGe4/dOnqPNfrR36mXUCaPSmuB2XGs5eUNVpPwia6Q
	5meiyAs3NnlCzP4CTSorq9Fk5RpAfWJPQG23xn9oicwXhZtgAMvR5e8oTJb5crfD431u61a
	J7AyZ1sfwqAwR4uiN8vOK2EWX43M0KmSTvk+UZRPqZZU/K/4izyQ1jYC/P1usZ9canJEvIq
	4KasNvKeTJ26w83/9co46s364=
X-QQ-SSF: 00000000000000F0
X-QQ-XMAILINFO: Oah5jeaK2MF3D8yQ9kdu1qciTpnRDM3KevRc6GqpgJvfgKeMXSRFlpkB8VsdD1
	 +kTsCBW5UlcBxp1FwTN/EC9eO0P4oXtBml/2Z+ecGG8S5birqmFhb8mHMJF+cucpjgwQdsOj6QXSQ
	 CfGvjW3TwT9o5X1zTmcO2KDxCCL2twX8CbwvHCH/PTzQ+P2zy/RVf5f7Nh9JgAIsz+x/UA+L42NRU
	 MaOjmi2A+8ZW8qmGxlWOQwSHg8ZTYBqjC2QOTe+S0OD/0GpEJ1ffjEY5hIzhJSIHZlAhJKYLxGrUC
	 FfCNzBLZGUSgJQ9i7BXKvsVmdquHmJdnRdDR0b+sT0bbqwfSqsT+2+LrJ0IYMwtpZrqVXcafWTxwa
	 ddYG5eI6SVE2e0s7gso5/g7btejvitNAHU30bQNQAL6Qb4eitr1Le3DKtDDeawaXlebd9gGl/bIll
	 rHUQfs/DKojVjtKZA+7w/xOllNOmDvkAcmHW4z+agdlVEsGIbh5RnchbGmBqfuVgEvcq2qbRNmML3
	 N7zGzIUJDiAbhkiN/8EdPSeLOSDaxM3mo1X2/fBDfSi/NJFWyMAuRQj2m1LUw1zIs2ntQiFUut798
	 wQ1NUm4lFaNY+iJRL481KDebvokQC8ph3vjpNYf/u7E3BKC5yKkLGsrQ8y15ncqQ6o0McUD1F5P9d
	 CrmEM41DAwPAaDAkotjltV7KKT/EdM/+wDZBhbPfHVB9qlM1lpHZcE6aEVlG0tf8E4DOZh5JKGKlr
	 zFGDIN/FjPS7KQQ==
X-QQ-WAPMAIL: 1
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 221.12.147.114
References: <tencent_F9A9D7345356CA6F9BEFD1A3CC9C89212808@qq.com>
X-QQ-STYLE: 
X-QQ-mid: riamail30t1613617667t2961208
From: ideamark@qq.com
To: "=?utf-8?B?Yml0YmFrZS1kZXZlbA==?=" <bitbake-devel@lists.openembedded.org>
Subject: Re: How to use AUTOREV
Mime-Version: 1.0
Date: Thu, 18 Feb 2021 11:07:46 +0800
X-Priority: 3
Message-ID: <tencent_DC6A44B97FB3251A859926910785FBDA6F05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 23405415
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 18 Feb 2021 11:07:48 +0800 (CST)
Feedback-ID: riamail:qq.com:bgforeign:bgforeign12
X-QQ-Bgrelay: 1
Content-Type: multipart/alternative;
	boundary="----=_NextPart_602DDA02_1053A740_3D478D6E"
Content-Transfer-Encoding: 8Bit

------=_NextPart_602DDA02_1053A740_3D478D6E
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCg0KQ291bGQgeW91IGhlbHAgdG8gdGVhY2ggaG93IHRvIHVzZSB0aGUgQVVUT1JF
ViBwYXJhbWV0ZXIgaW4gYml0YmFrZSBiYiBmaWxlPw0KSSB0cmllZCBzb21lIGZvcm1hdHMg
ZnJvbSB0aGUgZG9jdW1lbnQgYnV0IGZhaWxlZC4NClRoYW5rIHlvdS4NCg0KDQpCUnMNCk1h
cms=

------=_NextPart_602DDA02_1053A740_3D478D6E
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNo
YXJzZXQ9VVRGLTgiPjxkaXYgc3R5bGU9Im1pbi1oZWlnaHQ6MjJweDttYXJnaW4tYm90dG9t
OjhweDsiPkhpLDwvZGl2PjxkaXYgaWQ9Im9yaWdpbmFsLWNvbnRlbnQiPjxkaXYgc3R5bGU9
Im1pbi1oZWlnaHQ6MjJweDttYXJnaW4tYm90dG9tOjhweDsiPjxicj48L2Rpdj48ZGl2IHN0
eWxlPSJtaW4taGVpZ2h0OjIycHg7bWFyZ2luLWJvdHRvbTo4cHg7Ij5Db3VsZCB5b3UgaGVs
cCB0byB0ZWFjaCBob3cgdG8gdXNlIHRoZSBBVVRPUkVWIHBhcmFtZXRlciBpbiBiaXRiYWtl
IGJiIGZpbGU/PC9kaXY+PGRpdiBzdHlsZT0ibWluLWhlaWdodDoyMnB4O21hcmdpbi1ib3R0
b206OHB4OyI+SSB0cmllZCBzb21lIGZvcm1hdHMgZnJvbSB0aGUgZG9jdW1lbnQgYnV0IGZh
aWxlZC48L2Rpdj48ZGl2IHN0eWxlPSJtaW4taGVpZ2h0OjIycHg7bWFyZ2luLWJvdHRvbTo4
cHg7Ij5UaGFuayB5b3UuPC9kaXY+PGRpdiBzdHlsZT0ibWluLWhlaWdodDoyMnB4O21hcmdp
bi1ib3R0b206OHB4OyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9Im1pbi1oZWlnaHQ6MjJweDtt
YXJnaW4tYm90dG9tOjhweDsiPkJSczwvZGl2PjxkaXYgc3R5bGU9Im1pbi1oZWlnaHQ6MjJw
eDttYXJnaW4tYm90dG9tOjhweDsiPk1hcms8L2Rpdj48ZGl2IHN0eWxlPSJtaW4taGVpZ2h0
OjIycHg7bWFyZ2luLWJvdHRvbTo4cHg7Ij48YnI+PC9kaXY+PGRpdiBpZD0ib3JpZ2luYWwt
Y29udGVudCI+PC9kaXY+PC9kaXY+

------=_NextPart_602DDA02_1053A740_3D478D6E--
