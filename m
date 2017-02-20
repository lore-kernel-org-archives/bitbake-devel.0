Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id C5EDB71C27
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Feb 2017 09:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 960E718176;
	Mon, 20 Feb 2017 10:01:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id cGUx8uy4T9Jq; Mon, 20 Feb 2017 10:01:01 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 7C94F18319;
	Mon, 20 Feb 2017 10:01:01 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 395991E07A;
	Mon, 20 Feb 2017 10:01:01 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E7C61E079;
	Mon, 20 Feb 2017 10:01:01 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Mon, 20 Feb 2017 10:01:01 +0100 (CET)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
	by seth.se.axis.com (Postfix) with ESMTP id 22B6A263;
	Mon, 20 Feb 2017 10:01:01 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX04.axis.com (10.0.5.18) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Mon, 20 Feb 2017 10:01:01 +0100
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1210.000; Mon, 20 Feb 2017 10:01:01 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH] runqueue: Fix collapsed setscene
	dependency	tree
Thread-Index: AQHSirrIkkz1p8KCm0yTQwbboCV71aFxmaFg
Date: Mon, 20 Feb 2017 09:01:01 +0000
Message-ID: <37597e8986434bca9d8874a4b69480ce@XBOX02.axis.com>
References: <1487513769-27354-1-git-send-email-richard.purdie@linuxfoundation.org>
In-Reply-To: <1487513769-27354-1-git-send-email-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Fix collapsed setscene dependency	tree
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
X-List-Received-Date: Mon, 20 Feb 2017 09:01:05 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Richard Purdie
> Sent: den 19 februari 2017 15:16
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] runqueue: Fix collapsed setscene
> dependency tree
>=20
> When we removed the postinst sstate dependency handling code from
> setscene_depvalid, we noticed things being installed into the old
> style sysroot for rootfs tasks which should not have been there,
> causing a performance regression.
>=20
> Analysis revealed that setscene dependencies were "bubbling" over
> sstate tasks when they should have been stopping there. The
> 'continue' added by this patch avoids this issue and eusures

Change "eusures" to "ensures".

> sstate tasks remain contained to their specific chains.
>=20
> There was another bug in the code this exposed where the acconting

Change "acconting" to "accounting".

> for tasks as they were removed from sq_revdeps was not correct. In
> fixing this, what looks like a workaround in another test can then
> be simplified.
>=20
> After this change, populate_sysroot tasks are no longer depending
> on package_write_rpm tasks for example, which would make no sense.
>=20
> A before/after analysis of image dependencies only revealed improved
> dependencies after this change.
>=20
> Recipe specific sysroots did highlight the issue here since the
> behaviour of the sysroot dependencies (and processing with depvalid)
> was not matching what bitbake itself was doing, with bitbake being
> incorrect. Failures were 'safe' in that too many dependencies would
> get installed.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

//Peter


