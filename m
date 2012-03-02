Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S3N8J-0000yL-3u
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 08:42:31 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 01 Mar 2012 23:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="72677941"
Received: from pgsmsx101.gar.corp.intel.com ([10.221.44.78])
	by AZSMGA002.ch.intel.com with ESMTP; 01 Mar 2012 23:33:58 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	PGSMSX101.gar.corp.intel.com (10.221.44.78) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 15:31:38 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Fri, 2 Mar 2012 15:31:37 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 10/32] Hob: add ignore_all_errors to
	avoid showing error dialog multiple times
Thread-Index: AQHM9yk3dI5smctKcE6UIg9yq3K8rZZWnF2Q
Date: Fri, 2 Mar 2012 07:31:37 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23ADFD38@SHSMSX102.ccr.corp.intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<36bbfae6e2a84015b39e4a7fa4ed6e0aff5036c0.1330523904.git.shane.wang@intel.com>
	<4F4E98AD.6080008@linux.intel.com>
In-Reply-To: <4F4E98AD.6080008@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 10/32] Hob: add ignore_all_errors to avoid showing error dialog multiple times
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
X-List-Received-Date: Fri, 02 Mar 2012 07:42:31 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-03-01:

>=20
>=20
> On 29/02/12 06:15, Shane Wang wrote:
>> when parsing recipes, if there are some errors, the error dialog will be
> shown again and again for each error, add "Ignore All" to allow users to
> ignore those errors.
>=20
> I'm not so sure about this. I don't think ignoring all parse errors is
> the right thing, collecting them up into one dialogue seems like a
> better first step.
OK, UX improvement.

>=20
> What if I add some layers which introduce different parsing errors after
> I've clicked 'Ignore All' once?
"Ignore All" can't be reset. It only takes effect on the parsing this time.
That is: if you change layers which causes different parsing errors, and yo=
u ignore all.
Next time, if you change some layers which also causes some parsing errors,=
 the dialog will also show until you click "ignore all".

--
Shane

>=20
> Cheers,
> Joshua




