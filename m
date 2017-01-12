Return-Path: <Javier.Viguera@digi.com>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
	[216.82.251.13])
	by mail.openembedded.org (Postfix) with ESMTP id F1B0671C1A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2017 18:16:21 +0000 (UTC)
Received: from [216.82.249.131] by server-13.bemta-12.messagelabs.com id
	55/F5-07319-5F7C7785; Thu, 12 Jan 2017 18:16:21 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRWlGSWpSXmKPExsXi5LtOQPfr8fI
	Igx/T1S2uHw21+PFsIqsDk8f+uWvYPc5tXMEYwBTFmpmXlF+RwJqx/PlC9oLljBXfbrazNDAu
	Yexi5OIQEljFKHF21W0WCGcJo8TM5/dZuxg5OdgEDCUmfPrEBmKLCLQzSixcVQViCws4SSzZ+
	gCogQMo7iyx4nkgRImVxJJ3e8BaWQRUJT5eXs4IYvMK+Ep0zOpmAbGFBOokTj2bzARicwrYSF
	xdMxGshlFAVuJL42pmEJtZQFzi1pP5YDUSAgISS/acZ4awRSVePv7HCmHLS0z5cJERwjaUWDX
	tAAuELS3xpmcdG8hpzAKaEut36UOMVJSY0v2QHeIcQYmTM59AnaMiseHGb6YJjGKzkGyehdA9
	C0n3LCTdCxhZVjFqFKcWlaUW6RqZ6CUVZaZnlOQmZuboGhoa6eWmFhcnpqfmJCYV6yXn525iB
	EZVPQMD4w7GhdO9DjFKcjApifLKbCmPEOJLyk+pzEgszogvKs1JLT7EKMPBoSTB+/oYUE6wKD
	U9tSItMwcY3zBpCQ4eJRHezSBp3uKCxNzizHSI1ClGY45DN06+ZOI49enCSyYhlrz8vFQpcV5
	9YOIQEgApzSjNgxsESzuXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzVoIs5MnMK4Hb9wro
	FCagUy7agJ1SkoiQkmpgXHlb5nbt433WjB55u0K8NBNXaLTUcsX0T0jureqsema2eprw7aOrr
	Yu2vp85uSD699IZDId379p8yiz1eO+2T3c7F2ZIMP+8vkcio8rUoqn3tsTOZ5/+HxJcrzFFxP
	PDGzuDs/diq99UzV4l0HIn/eNqyScxoh9FNgSpV6ysDJP4nN+g+dxjohJLcUaioRZzUXEiAHP
	howc2AwAA
X-Env-Sender: Javier.Viguera@digi.com
X-Msg-Ref: server-6.tower-28.messagelabs.com!1484244981!54198362!1
X-Originating-IP: [66.77.174.16]
X-StarScan-Received: 
X-StarScan-Version: 9.1.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23220 invoked from network); 12 Jan 2017 18:16:21 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
	by server-6.tower-28.messagelabs.com with SMTP;
	12 Jan 2017 18:16:21 -0000
Received: from DOR-VMS-XCH01.digi.com (10.49.8.98) by MCL-VMS-XCH01.digi.com
	(10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.319.2;
	Thu, 12 Jan 2017 12:16:17 -0600
Received: from DOR-SMS-XCH01.digi.com ([fe80::894b:3bdc:74ae:6efc]) by
	DOR-VMS-XCH01.digi.com ([::1]) with mapi id 14.03.0319.002;
	Thu, 12 Jan 2017 19:16:16 +0100
From: "Viguera, Javier" <Javier.Viguera@digi.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Backport git submodules fetcher fixes
Thread-Index: AdJs9b1OSD/106AjT+abjXpMveSR3///++8A///n8IA=
Date: Thu, 12 Jan 2017 18:16:15 +0000
Message-ID: <DA8287CC96892A4EB4FCF4FB3FBDA1AB01414ABE@dor-sms-xch01.digi.com>
References: <DA8287CC96892A4EB4FCF4FB3FBDA1AB01414A8E@dor-sms-xch01.digi.com>
	<1484243312.4367.220.camel@linuxfoundation.org>
In-Reply-To: <1484243312.4367.220.camel@linuxfoundation.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.101.2.55]
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean
MIME-Version: 1.0
Subject: Re: Backport git submodules fetcher fixes
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
X-List-Received-Date: Thu, 12 Jan 2017 18:16:29 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SXQncyB3b3JraW5nIGZpbmUgbm93Lg0KDQpUaGFua3MgUmljaGFyZC4NCg0KLS0NCkphdmllciBW
aWd1ZXJhDQpTb2Z0d2FyZSBFbmdpbmVlcg0KRGlnaSBJbnRlcm5hdGlvbmFswq4gU3BhaW4gUy5B
LlUuDQoNCg==

