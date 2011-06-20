Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1QYW8V-0007i7-6o
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 Jun 2011 06:30:55 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 19 Jun 2011 21:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,391,1304319600"; d="scan'208";a="18225021"
Received: from pgsmsx602.gar.corp.intel.com ([10.221.43.81])
	by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2011 21:27:21 -0700
Received: from pgsmsx509.gar.corp.intel.com (172.30.13.17) by
	pgsmsx602.gar.corp.intel.com (10.221.43.81) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 20 Jun 2011 12:26:50 +0800
Received: from shsmsx602.ccr.corp.intel.com (10.239.4.104) by
	PGSMSX509.gar.corp.intel.com (172.30.13.17) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 20 Jun 2011 12:26:50 +0800
Received: from shsmsx502.ccr.corp.intel.com ([10.239.4.96]) by
	SHSMSX602.ccr.corp.intel.com ([10.239.4.104]) with mapi;
	Mon, 20 Jun 2011 12:26:50 +0800
From: "Cui, Dexuan" <dexuan.cui@intel.com>
To: 'Paul Eggleton' <paul.eggleton@linux.intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jun 2011 12:26:48 +0800
Thread-Topic: [bitbake-devel] [PATCH 1/1] bitbake-layers: stop the warning
	"not been run using the bitbake wrapper..."
Thread-Index: AcwnbEC8dl8NRDalS+2327vqc6C1/QHjX4mg
Message-ID: <1865303E0DED764181A9D882DEF65FB6997B5E7671@shsmsx502.ccr.corp.intel.com>
References: <cover.1307693771.git.dexuan.cui@intel.com>
	<6439f6f95ef1157063276692bcf2adfebb7597eb.1307693771.git.dexuan.cui@intel.com>
	<1307708964.15712.210.camel@rex>
	<201106101345.11050.paul.eggleton@linux.intel.com>
In-Reply-To: <201106101345.11050.paul.eggleton@linux.intel.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: zh-CN, en-US
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] bitbake-layers: stop the warning "not been run using the bitbake wrapper..."
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
X-List-Received-Date: Mon, 20 Jun 2011 04:30:55 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Paul Eggleton wrote:
> On Friday 10 June 2011 13:29:24 Richard Purdie wrote:
>> We can't add implementation specific information to bitbake I'm
>> afraid so we'll need to find a different way to handle this...
>=20
> Perhaps we could just change sanity.bbclass to check argv[0] somehow
> (or some equivalent way to get the current process name) and skip the
> check if it isn't "bitbake"? This would have the added bonus of
> solving the problem for future tools that use bitbake code in a
> similar way to bitbake-layers.=20
(sorry for the late reply!)=20
Thanks a lot for Paul's good suggestion!
I sent the new patch to oe-core mailing list just now.

Thanks,
-- Dexuan=


