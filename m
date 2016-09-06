Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 77D3077230
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Sep 2016 08:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 8998D2E171;
	Tue,  6 Sep 2016 10:57:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id rf+cQg4WKfT0; Tue,  6 Sep 2016 10:57:28 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 111412E16C;
	Tue,  6 Sep 2016 10:57:28 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id EF4541A86;
	Tue,  6 Sep 2016 10:57:27 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id E46C11631;
	Tue,  6 Sep 2016 10:57:27 +0200 (CEST)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
	by thoth.se.axis.com (Postfix) with ESMTP id E2459303;
	Tue,  6 Sep 2016 10:57:27 +0200 (CEST)
Received: from xbox12.axis.com (10.0.5.26) by XBOX04.axis.com (10.0.5.18) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Tue, 6 Sep 2016 10:57:27 +0200
Received: from XBOX02.axis.com (10.0.5.16) by xbox12.axis.com (10.0.5.26) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Tue, 6 Sep 2016 10:57:27 +0200
Received: from XBOX02.axis.com ([fe80::d00f:cb52:1b56:20d]) by XBOX02.axis.com
	([fe80::d00f:cb52:1b56:20d%21]) with mapi id 15.00.1156.000;
	Tue, 6 Sep 2016 10:57:27 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Andre McCurdy <armccurdy@gmail.com>, Christopher Larson
	<clarson@kergoth.com>
Thread-Topic: [bitbake-devel] How to prevent expansion of bitbake variables
	inside tasks?
Thread-Index: AQHSAs9UfyFbim+vx0+Yv2fuIcmerqBh1nuAgApb3oA=
Date: Tue, 6 Sep 2016 08:57:27 +0000
Message-ID: <40e10e95763f4b24999d7b41f0965609@XBOX02.axis.com>
References: <CAJ86T=UnA3cUU80pdTfgAvc0Ht-Pc9sJJoUK5rjdvuoUKa+4sw@mail.gmail.com>
	<CABcZANm8Uxn=WVzgsyPimB3a-pM3_c+piVtzZVFMJLFW+THwbQ@mail.gmail.com>
	<CAJ86T=WDWXPisRh-s_09_x8UqJcHcKKpgFNJBTTEjvSy9z4y_A@mail.gmail.com>
In-Reply-To: <CAJ86T=WDWXPisRh-s_09_x8UqJcHcKKpgFNJBTTEjvSy9z4y_A@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: How to prevent expansion of bitbake variables inside tasks?
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
X-List-Received-Date: Tue, 06 Sep 2016 08:57:31 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Andre McCurdy
> Sent: den 30 augusti 2016 22:41
> To: Christopher Larson
> Cc: bitbake-devel
> Subject: Re: [bitbake-devel] How to prevent expansion of bitbake
> variables inside tasks?
>=20
> On Tue, Aug 30, 2016 at 7:59 AM, Christopher Larson
> <clarson@kergoth.com> wrote:
> >
> > On Mon, Aug 29, 2016 at 7:12 PM, Andre McCurdy <armccurdy@gmail.com>
> > wrote:
> >>
> >> Say I want to create a do_install() task which does:
> >>
> >>   do_install() {
> >>     echo '${BP} was ${BP}' > ${D}/test
> >>   }
> >>
> >> but I don't want first ${BP} bitbake variable to be expanded. ie
> >> after the task has run I want ${D}/test to contain the string=20
> >> "${BP} was foo-1.0".
> >>
> >> What's the recommended way to escape the first ${BP} in
> >> do_install()?
> >
> > Sadly this was an oversight when the file format was originally
> > created, so there's no real way to escape the variable reference=20
> > to make bitbake not expand it. There are workarounds, of course.=20
> > You could do some or all of the work in python rather than shell,=20
> > since python functions don't get their variable references of=20
> > that sort expanded, for example, or you could construct the=20
> > output / break up the reference, i.e. echo '$' >, echo '{BP}', or=20
> > easier, use printf to do it with format strings, i.e.=20
> > printf '${%s} was ${%s}\n' BP BP >${D}/test.
>=20
> My solution up to now has been:
>=20
>   echo '{BP}' | sed 's|^|$|'
>=20
> but printf looks a little cleaner. Thanks.

Why complicate it? This should work:

	echo '$''{BP} was ${BP}' > ${D}/test

//Peter


