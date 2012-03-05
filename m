Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S4gaY-00081t-Ez
	for bitbake-devel@lists.openembedded.org;
	Mon, 05 Mar 2012 23:41:06 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 05 Mar 2012 14:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="125342544"
Received: from pgsmsx102.gar.corp.intel.com ([10.221.44.80])
	by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2012 14:32:30 -0800
Received: from pgsmsx103.gar.corp.intel.com (10.221.44.82) by
	PGSMSX102.gar.corp.intel.com (10.221.44.80) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Tue, 6 Mar 2012 06:32:28 +0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	PGSMSX103.gar.corp.intel.com (10.221.44.82) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Tue, 6 Mar 2012 06:32:29 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Tue, 6 Mar 2012 06:32:28 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 4/6] ui/crumbs/imageconfigurationpage:
	make	use of the HobInfoButton
Thread-Index: AQHM+NYmP1einjo2gUeA9aNHpwoZE5ZcTfDA
Date: Mon, 5 Mar 2012 22:32:27 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AE1B7B@SHSMSX102.ccr.corp.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
	<4994d44f42e195fe92f75e9f562eb9de0d974371.1330734444.git.josh@linux.intel.com>
In-Reply-To: <4994d44f42e195fe92f75e9f562eb9de0d974371.1330734444.git.josh@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] ui/crumbs/imageconfigurationpage: make	use of the HobInfoButton
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
X-List-Received-Date: Mon, 05 Mar 2012 22:41:06 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-03-02:

> Use the new HobInfoButton widget in place of the existing gtk.Image with
> tooltip.
>=20
> Modify the markup of the tooltip so that the link to the reference manual
> is a clickable hyperlink.
>=20
> Signed-off-by: Joshua Lock <josh@linux.intel.com>

ACK

--
Shane


