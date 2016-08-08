Return-Path: <tobias.hagelborn@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0A9EE7680A
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 12:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 5F3DD18108;
	Mon,  8 Aug 2016 14:54:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id ttBU+rFsi1HB; Mon,  8 Aug 2016 14:54:32 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id E4CBA18107;
	Mon,  8 Aug 2016 14:54:31 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id A58FC1B92;
	Mon,  8 Aug 2016 14:54:31 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 9A9018C3;
	Mon,  8 Aug 2016 14:54:31 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
	by seth.se.axis.com (Postfix) with ESMTP id 98BC140E;
	Mon,  8 Aug 2016 14:54:31 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX03.axis.com (10.0.5.17) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Mon, 8 Aug 2016 14:54:31 +0200
Received: from XBOX02.axis.com ([fe80::d00f:cb52:1b56:20d]) by XBOX02.axis.com
	([fe80::d00f:cb52:1b56:20d%21]) with mapi id 15.00.1156.000;
	Mon, 8 Aug 2016 14:54:31 +0200
From: Tobias Hagelborn <tobias.hagelborn@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] BB_NO_NETWORK: Fallback to local source
	for git lsremote
Thread-Index: AQHR2F1GRHAIjfzM60eL99EqiTAysKA+47mAgABR+RE=
Date: Mon, 8 Aug 2016 12:54:31 +0000
Message-ID: <1470660871158.8123@axis.com>
References: <1470645281559.73326@axis.com>,
	<1470650127.8166.40.camel@linuxfoundation.org>
In-Reply-To: <1470650127.8166.40.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Subject: Re: [PATCH] BB_NO_NETWORK: Fallback to local source for git lsremote
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
X-List-Received-Date: Mon, 08 Aug 2016 12:54:36 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Richard,=0A=
=0A=
I think I understand your concern. This patch takes whatever is available l=
ocally and that means it is a side-effect compared to not setting BB_NO_NET=
WORK. Something the user might not expect.=0A=
=0A=
I don't know if you would accept the use of a new  flag that the user can s=
et to agree with this side effect.=0A=
=0A=
Something along the lines of "FORCE_LOCAL_TAGS". =0A=
Then the user would have given some consent on that side-affect.=0A=
We think it is still very useful to us to be able to build locally with wha=
tever you have fetched in cases where no NW is available and you basically =
know that few/no tags have moved.=0A=
=0A=
=0A=
Regards=0A=
Tobias=0A=
=0A=
=0A=
________________________________________=0A=
From: Richard Purdie <richard.purdie@linuxfoundation.org>=0A=
Sent: Monday, August 8, 2016 11:55 AM=0A=
To: Tobias Hagelborn; bitbake-devel@lists.openembedded.org=0A=
Subject: Re: [bitbake-devel] [PATCH] BB_NO_NETWORK: Fallback to local sourc=
e for git lsremote=0A=
=0A=
On Mon, 2016-08-08 at 08:34 +0000, Tobias Hagelborn wrote:=0A=
> Change made to enable building offline also with git tag references=0A=
> in SRC_URI.=0A=
>=0A=
> If BB_NO_NETWORK is set, fallback to search for tags and revisions=0A=
> in local DL_DIR / GITDIR in order to avoid network access.=0A=
=0A=
I'm not sure I agree with this since you'd get different build results=0A=
depending on whether BB_NO_NETWORK is set or not.=0A=
=0A=
I think if BB_NO_NETWORK is set, its reasonable to assume that the=0A=
configuration should be locked down and that BB_NO_NETWORK should not=0A=
have other side effects like this.=0A=
=0A=
It would also make it very hard to detect unlocked configurations=0A=
during testing which currently are quite easily identified.=0A=
=0A=
Cheers,=0A=
=0A=
Richard=0A=

