Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S3ShR-0003WB-JM
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 14:39:09 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 05:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113828015"
Received: from pgsmsx101.gar.corp.intel.com ([10.221.44.78])
	by orsmga001.jf.intel.com with ESMTP; 02 Mar 2012 05:29:16 -0800
Received: from pgsmsx152.gar.corp.intel.com (172.30.236.43) by
	PGSMSX101.gar.corp.intel.com (10.221.44.78) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 21:29:15 +0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	PGSMSX152.gar.corp.intel.com (172.30.236.43) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 21:29:15 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Fri, 2 Mar 2012 21:29:13 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 28/32] Hob: allow users to setup the proxy
Thread-Index: AQHM9ylBol7XcyLMkEmsMu9L0qHHOJZXANIA
Date: Fri, 2 Mar 2012 13:29:13 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AE014B@SHSMSX102.ccr.corp.intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<0e99d291a8d3e9ad49ba82d5c30591322e958511.1330523904.git.shane.wang@intel.com>
	<4F4E98B4.70303@linux.intel.com>
In-Reply-To: <4F4E98B4.70303@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Wold, Saul" <saul.wold@intel.com>
Subject: Re: [PATCH 28/32] Hob: allow users to setup the	proxy
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
X-List-Received-Date: Fri, 02 Mar 2012 13:39:09 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-03-01:

> On 29/02/12 06:15, Shane Wang wrote:
>> This patch is to set os.environ to allow users to set the environment
> variables for http_proxy, https_proxy and ftp_proxy.
>=20
> I think this needs more work, I have a text entry with an attached
> button that spawns a file chooser. What file would I choose here?
Josh, I don't understand why this is related to a file chooser.

>=20
> What about if my http, ftp and socks proxy are different?
Yes, the patch doesn't work for this case. I admit the proxy patch needs mo=
re work.
Again, this patch doesn't support git, either.
The initial requirement is from Saul and from build appliance for users beh=
ind a firewall to use proxy.
For what you mentioned to set up different proxies, it is easy to fix.
But for git, I also need to investigate, do you have more hints?

--
Shane

>=20
> Cheers,
> Joshua
>=20


