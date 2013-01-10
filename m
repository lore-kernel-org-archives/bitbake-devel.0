Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TtDiT-0005nO-Mf
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 Jan 2013 09:42:52 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 10 Jan 2013 00:27:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,443,1355126400"; d="scan'208";a="242187594"
Received: from irsmsx102.ger.corp.intel.com ([163.33.3.155])
	by azsmga001.ch.intel.com with ESMTP; 10 Jan 2013 00:27:10 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.13]) by
	IRSMSX102.ger.corp.intel.com ([169.254.2.95]) with mapi id
	14.01.0355.002; Thu, 10 Jan 2013 08:27:09 +0000
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: Peter Seebach <peter.seebach@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Variable tracking...
Thread-Index: AQHN7qQY3ptGvf2OnUei1d1J/fWe2ZhCOqWA
Date: Thu, 10 Jan 2013 08:27:09 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE193CDB63@IRSMSX101.ger.corp.intel.com>
References: <20130109122757.5c134665@e6410-2>
In-Reply-To: <20130109122757.5c134665@e6410-2>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.182]
MIME-Version: 1.0
Subject: Re: Variable tracking...
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
X-List-Received-Date: Thu, 10 Jan 2013 08:43:01 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I was looking on those patches, because I really needed them to assure cons=
istency between hob and bitbake settings.
I know RP was looking on them, because he recommended those to me. This fun=
ctionality is very useful and I think it will be merged.

Thank you,
Cristiana

-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Peter Seebach
Sent: Wednesday, January 09, 2013 8:28 PM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] Variable tracking...

So, I sent some variable-tracking patches a while back that had been cleane=
d up in response to various feedback. And I don't think I heard back anythi=
ng about problems with them, but I don't think I heard anything positive.

Is anyone still interested in the variable-assignment-tracking stuff, other=
 than me? I maintain that it is REALLY useful when trying to track down var=
iables getting the wrong values.

-s
--
Listen, get this.  Nobody with a good compiler needs to be justified.

_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


