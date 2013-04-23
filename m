Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <peter.kjellerstedt@axis.com>) id 1UUYk7-0000uR-Jr
	for bitbake-devel@lists.openembedded.org;
	Tue, 23 Apr 2013 10:38:31 +0200
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id C5F8119E00;
	Tue, 23 Apr 2013 10:13:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zcRvDzTCQnul; Tue, 23 Apr 2013 10:13:03 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by anubis.se.axis.com (Postfix) with ESMTP id 1A43019DFC;
	Tue, 23 Apr 2013 10:13:02 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by thoth.se.axis.com (Postfix) with ESMTP id BDCB934184;
	Tue, 23 Apr 2013 10:13:02 +0200 (CEST)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
	([10.0.5.75]) with mapi; Tue, 23 Apr 2013 10:13:02 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <rpurdie@rpsys.net>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Tue, 23 Apr 2013 10:13:01 +0200
Thread-Topic: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
Thread-Index: Ac4/ZB1MRTxoKiGmSUugNMiaT6QPHQAk+/EA
Message-ID: <A612847CFE53224C91B23E3A5B48BAC79861BB305B@xmail3.se.axis.com>
References: <1366640172.23738.12.camel@ted>
In-Reply-To: <1366640172.23738.12.camel@ted>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
MIME-Version: 1.0
Cc: openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 23 Apr 2013 08:38:36 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: openembedded-core-bounces@lists.openembedded.org
> [mailto:openembedded-core-bounces@lists.openembedded.org] On Behalf Of
> Richard Purdie
> Sent: den 22 april 2013 16:16
> To: bitbake-devel
> Cc: openembedded-core
> Subject: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
>=20
> I've been giving some thought to where BitBake needs to go in the
> future in order to deliver for its users. It started life as a=20
> commandline utility and its grown a lot since it was first created.=20
> I think there are some key decisions that need to be taken to=20
> ensure its future growth.
>=20
> The first proposal is that we should change the BitBake server so=20
> it becomes memory resident. This means that the first time you run
> "bitbake X", the server loads into memory, then subsequent BitBake=20
> commands would just connect to the server and do things. We'd add=20
> in some kind of timeout of say 15 minutes so that it would=20
> gracefully exit.
>=20
> The reason for doing this is simple, it would allow commands to be=20
> much more responsive rather than having the cache/configuration=20
> loading each time which is where our current overhead is. Obviously=20
> it would detect changes to things like MACHINE setting, local.conf=20
> and re-parse as normal in those cases. The intent would be to speed=20
> up the interaction with the system so you don't have the annoying=20
> delays/lag.

How will a bitbake command know which server to connect to in case=20
of multiple concurrent builds of different products on the same=20
computer? Or do you intend for one server to keep track of all builds?

[cut]

> These changes should also be in keeping with the expanded UI work=20
> and options such as WebHob and allowing remote use of multiple UIs
> connected to servers.

How should a remote UI know which server to connect to (if there=20
are multiple ones)?

> Feedback/comments/suggestions etc./ welcome as always.
>=20
> I've cc'd the OE-Core list but further discussion should be taken to
> bitbake-devel.
>=20
> Cheers,
>=20
> Richard

//Peter



