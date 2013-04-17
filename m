Received: from mail-db8lp0185.outbound.messaging.microsoft.com
	([213.199.154.185] helo=db8outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B43198@freescale.com>) id 1USPrv-000263-FX
	for bitbake-devel@lists.openembedded.org;
	Wed, 17 Apr 2013 12:45:57 +0200
Received: from mail159-db8-R.bigfish.com (10.174.8.248) by
	DB8EHSOBE018.bigfish.com (10.174.4.81) with Microsoft SMTP Server id
	14.1.225.23; Wed, 17 Apr 2013 09:42:52 +0000
Received: from mail159-db8 (localhost [127.0.0.1])	by
	mail159-db8-R.bigfish.com (Postfix) with ESMTP id 0B0D7E054F	for
	<bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2013 09:42:52 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: -7
X-BigFish: VS-7(zz1431J11f6Nzz1f42h1fc6h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ahzzz2dh2a8h668h839h8e2h8e3h944hd25hf0ah1220h1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh15d0h162dh1631h1758h18e1h1946h19b5h1ad9h1b0ahbe9i1155h)
Received: from mail159-db8 (localhost.localdomain [127.0.0.1]) by mail159-db8
	(MessageSwitch) id 1366191769460814_7981;
	Wed, 17 Apr 2013 09:42:49 +0000 (UTC)
Received: from DB8EHSMHS018.bigfish.com (unknown [10.174.8.245])	by
	mail159-db8.bigfish.com (Postfix) with ESMTP id 64F86C007A	for
	<bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2013 09:42:49 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by DB8EHSMHS018.bigfish.com
	(10.174.4.28) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Wed, 17 Apr 2013 09:42:49 +0000
Received: from 039-SN2MPN1-021.039d.mgd.msft.net ([169.254.1.128]) by
	039-SN1MMR1-004.039d.mgd.msft.net ([::1]) with mapi id 14.02.0328.011;
	Wed, 17 Apr 2013 09:42:47 +0000
From: Purcareata Bogdan-B43198 <B43198@freescale.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: bitbake clean / cleanall / cleansstate not working
Thread-Index: Ac47T+pIaPJdHV4DTyGjcsswekyYHw==
Date: Wed, 17 Apr 2013 09:42:47 +0000
Message-ID: <E7E317BD5B5D764682EEAC13B01676E2650BB2@039-SN2MPN1-021.039d.mgd.msft.net>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.171.74.6]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
X-Mailman-Approved-At: Fri, 19 Apr 2013 15:41:32 +0200
Subject: bitbake clean / cleanall / cleansstate not working
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
X-List-Received-Date: Wed, 17 Apr 2013 10:46:00 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I am using Yocto with BB_VERSION =3D "1.18.0" and the commands in the subje=
ct do not seem to work - they don't do anything. The image has the packages=
 built.

$ bitbake -c cleanall gcc
[ ... ]
NOTE: Tasks Summary: Attempted 3 tasks of which 0 didn't need to be rerun a=
nd all succeeded.

$ bitbake -c clean gcc
[ ... ]
NOTE: Tasks Summary: Attempted 1 tasks of which 0 didn't need to be rerun a=
nd all succeeded.

$ bitbake -c cleansstate gcc
[ ... ]
NOTE: Tasks Summary: Attempted 2 tasks of which 0 didn't need to be rerun a=
nd all succeeded.

The information in [ ... ] is not really relevant. I just wanted to give th=
e output message. I know the error description is vague, but so is this beh=
avior. I don't know what it could be further related to.

Thank you very much,
Bogdan P.





