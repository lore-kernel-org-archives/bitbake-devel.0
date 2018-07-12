Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id D478574C39
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 10:50:48 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 Jul 2018 03:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,342,1526367600"; d="scan'208";a="54484732"
Received: from wgerner-mobl2.ger.corp.intel.com (HELO localhost.localdomain)
	([10.252.50.188])
	by fmsmga008.fm.intel.com with ESMTP; 12 Jul 2018 03:50:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: developer_agl@xtev.cn
Date: Thu, 12 Jul 2018 12:50:47 +0200
Message-ID: <1993940.Xc2Spn7Ep9@localhost.localdomain>
Organization: Intel Corporation
In-Reply-To: <009001d419c9$35c39cc0$a14ad640$@xtev.cn>
References: <008601d419c8$61a20a30$24e61e90$@xtev.cn>
	<009001d419c9$35c39cc0$a14ad640$@xtev.cn>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: =?UTF-8?B?UmU6IOi9rOWPkTogQWJvdXQgYml0YmFrZSB0YXNrcw==?=
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
X-List-Received-Date: Thu, 12 Jul 2018 10:50:49 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, 12 July 2018 12:15:07 PM CEST developer_agl@xtev.cn wrote:
> I=E2=80=99m new to bitbake. And I have some questions about bitbake tasks=
 mechanism
> and inherit mechanism. If a xxx.bb recipe content like this :
>=20
> ##start
>=20
> DESCRIPTION =3D =E2=80=9Dxxxxxxxxx=E2=80=9D
>=20
> XXX_XXXX =3D =E2=80=9C${XXXXXXXX}=E2=80=9D
>=20
> inherit some_guys
>=20
> ##end
>=20
> And Bitbake User Manual said that =E2=80=98The minimally required class f=
or BitBake
> is the classes/base.bbclass file. The base class is implicitly inherited =
by
> every recipe.=E2=80=99 So which .bbclass should be parsed first, some_guy=
s.bbclass
> or base.bbclass? I=E2=80=99m really confused about that.

Effectively, base.bbclass will be parsed first, then the lines in the recip=
e=20
up to inherit some_guys, then some_guys.bbclass, and then the lines in the=
=20
recipe that follow (in this case just a comment).

Cheers,
Paul

=2D-=20

Paul Eggleton
Intel Open Source Technology Centre



