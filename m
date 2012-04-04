Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SFN60-0002zt-23
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 12:05:44 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 04 Apr 2012 02:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="85147955"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 04 Apr 2012 02:56:32 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 4 Apr 2012 02:56:32 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Wed, 4 Apr 2012 17:56:30 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Barros Pena, Belen" <belen.barros.pena@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/4] Hob: log for Hob and allow users
	to show logs after successful build
Thread-Index: AQHNEXuqvL9V9zqiakyA1EedJdujqZaKbwfQ
Date: Wed, 4 Apr 2012 09:56:30 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23B11E92@SHSMSX102.ccr.corp.intel.com>
References: <1b154fde4b6b403c8cea5b473baa029f9f264281.1333379931.git.shane.wang@intel.com>
	<CBA07EE5.C28E%belen.barros.pena@intel.com>
In-Reply-To: <CBA07EE5.C28E%belen.barros.pena@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: Giulia Piu <giulia@closertag.com>
Subject: Re: [PATCH 2/4] Hob: log for Hob and allow users to show logs after successful build
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
X-List-Received-Date: Wed, 04 Apr 2012 10:05:44 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Do you mean the image details screen is too busy with "View logs"? It was d=
esigned by Giulia.

Retrieving the packages build log in the packages screen is not good becaus=
e the log is also for "build image"

--
Shane

Barros Pena, Belen wrote on=A02012-04-03:

> Sorry: this was an omission on the design side. If deemed appropriate, we
> can incorporate an option to retrieve the packages build log in the
> Packages screen. I'll leave it to Jessica, who reported 1991, to decide i=
f
> this is something we should provide.
>=20
> Cheers
>=20
> Belen
>=20


